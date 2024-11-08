// Esercizio parallelo di progettazione e interrogazione su database relazionale e non relazionale
   //Progettare un sistema di social media che consenta agli utenti di creare profili,
   //pubblicare post, aggiungere "mi piace" e commentare i post di altri utenti.
   //Implementare il sistema sia con un database relazionale (PostgreSQL) sia con un database non relazionale (MongoDB)
   // e comparare come gestiscono le strutture dati e le query.


// Specifiche:
   //
   //Profili Utente: Gli utenti hanno un profilo con un nome, un'email, una bio e un elenco di amici.
   //Aggiungi anche un contatore per i post pubblicati.
   //Post: Gli utenti possono creare post contenenti un testo e una data di pubblicazione.
   //Commenti: Gli utenti possono commentare i post, ogni commento ha un testo, una data e un riferimento all'autore.
   //"Mi Piace": Gli utenti possono mettere "mi piace" ai post di altri utenti.

use social_network

db.createCollection('utenti');
db.utenti.insertMany([
{
    "_id" : 1,
    "nome": "Soxa Sorda",
    "email": "soxa@dev.it",
    "bio": "Sono un architetto",
    "id_amici": [2, 3],
    "post": 2
},
{
    "_id" : 2,
    "nome": "Marta Sorda",
    "email": "martasorda@linksmt.it",
    "bio": "Sono una studentessa",
    "id_amici": [1, 3],
    "post": 1
},
{
    "_id" : 3,
    "nome": "Giovanni Sordo",
    "email": "giovannisordo@exprivia.it",
    "bio": "Sono un programmatore",
    "id_amici": [1, 2],
    "post": 1
},
{
    "_id" : 4,
    "nome": "Luca Sardo",
    "email": "lucasardo@rurale.tau",
    "bio": "Sono un agricoltore e pianto le pannocchie",
    "id_amici": [],
    "post": 0
}
]);

db.createCollection("post");
db.post.insertMany([
    {
        "_id" : 1,
        "id_utente": 1,
        "testo": "Primo post 1, di utente 1",
        "data_pubblicazione": ISODate("2024-02-01"),
    },
    {
        "_id" : 2,
        "id_utente": 1,
        "testo": "Secondo post 2, di utente 1",
        "data_pubblicazione": ISODate("2024-02-02"),
    },
    {
        "_id" : 3,
        "id_utente": 2,
        "testo": "Primo post 1, di utente 2",
        "data_pubblicazione": ISODate("2024-02-03"),
    },
    {
        "_id" : 4,
        "id_utente": 3,
        "testo": "Primo post 1, di utente 3",
        "data_pubblicazione": ISODate("2024-02-04"),
    }
]);

db.commenti.insertMany(
[
    {
    "_id" : 1,
    "id_utenete": 2,
    "id_post": 1,
    "testo": "Primo commento di utente 2 al post 1",
    "data": ISODate("2024-02-01")
    },
    {
    "_id" : 2,
    "id_utenete": 3,
    "id_post": 1,
    "testo": "Primo commento di utente 3 al post 1",
    "data": ISODate("2024-02-02")
    },
    {
    "_id" : 3,
    "id_utenete": 1,
    "id_post": 3,
    "testo": "Primo commento di utente 1 al post 3",
    "data": ISODate("2024-02-03")
    },
    {
    "_id" : 4,
    "id_utenete": 1,
    "id_post": 2,
    "testo": "Primo commento di utente 1 al post 2",
    "data": ISODate("2024-02-04")
    },
]
);

db.mi_piace.insertMany(
[
    {
        "_id" : 1,
        "id_utente": 2,
        "id_post": 1,
    },
    {
        "_id" : 2,
        "id_utente": 3,
        "id_post": 1,
    },
    {
        "_id" : 3,
        "id_utente": 1,
        "id_post": 3,
    },
    {
        "_id" : 4,
        "id_utente": 1,
        "id_post": 2,
    },
]
);

// QUERY

// 1.1 Recupero del Feed di un Utente: Ottieni i post di un utente specifico con i relativi "mi piace" e commenti.
db.post.aggregate([
    {
        $match: { "id_utente": 1 }
    },
    {
        $lookup: {
            from: "utenti",
            localField: "id_utente",
            foreignField: "_id",
            as: "nome_cliente"
        }
    },
    {
        $lookup: {
            from: "mi_piace",
            localField: "_id",
            foreignField: "id_post",
            as: "mi_piace"
        }
    },
    {
        $addFields:
        {
            numero_mi_piace: {$size : "$mi_piace"}
        }
    },
    {
        $project: {
            "nome_cliente.nome": 1,
            testo: 1,
            numero_mi_piace: 1,
        }
    }
]);

// 1.2 Amici di un Utente: Trova tutti gli amici di un utente specifico.
db.utenti.aggregate(
[
    {
        $match: { "_id" : 1}
    },
    {
        $unwind: "$id_amici"
    },
    {
        $lookup:
        {
            from: "utenti",
            localField: "id_amici",
            foreignField: "_id",
            as: "dettagli_amico"
        }
    },
    {
        $unwind: "$dettagli_amico"
    },
    {
        $project:
        {
            nome: 1,
            "dettagli_amico.nome": 1,
            "dettagli_amico.email": 1,
            "dettagli_amico.bio": 1,
            _id: 0
        }
    }
]
);

// 1.3 Conteggio dei Mi Piace su un Post: Conta il numero di "mi piace" per un post specifico.
db.post.aggregate(
[
    {
        $match: {"_id": 1}
    },
    {
        $lookup:
        {
        from: "mi_piace",
        localField: "_id",
        foreignField: "id_post",
        as: "mi_piace"
        }
    },
    {
        $addFields:
        {
            numero_mi_piace: {$size : "$mi_piace"}
        }
    },
    {
        $project:
        {
            _id: 1,
            numero_mi_piace: 1,
        }
    }
]
);

// 1.4 Visualizzazione dei Commenti: Ottieni tutti i commenti su un post specifico, con il nome dell'autore di ciascun commento.
db.post.aggregate(
[
    {
        $match: {"_id": 1}
    },
    {
        $lookup:
        {
            from: "commenti",
            localField: "_id",
            foreignField: "id_post",
            as: "commenti_trovati"
        }
    },
    {
        $unwind: "$commenti_trovati"
    },
    {
        $lookup:
        {
            from: "utenti",
            localField: "commenti_trovati.id_utenete",
            foreignField: "_id",
            as: "utenti_trovati"
        }
    },
    {
        $project:
        {
            "commenti_trovati.testo": 1,
            "utenti_trovati.nome": 1
        }
    }
]
)

// 1.5 Recupera gli ultimi post di un utente specifico, ordinati per data di creazione.
db.post.aggregate(
[
    {
        $match: {"id_utente": 1}
    },
    {
        $sort:
        {
            "data_pubblicazione": 1
        }
    },
    {
        $limit: 2
    }
]
)

// 1.6 Trova il post con il maggior numero di "mi piace" per un determinato utente.
db.post.aggregate(
[
    {
        $match: { "id_utente" : 1 }
    },
    {
        $lookup:
        {
            from: "mi_piace",
            localField: "_id",
            foreignField: "id_post",
            as: "mi_piace_trovati"
        }
    },
    {
        $project:
        {
            _id: 1,
            testo: 1,
            "mi_piace_trovati": { $size: "$mi_piace_trovati" }
        }
    },
    {
        $sort:
        {
            "mi_piace_trovati": -1
        }
    },
    {
        $limit: 1
    }
]
)

// 1.7 Trova i Post Contenenti una Parola Chiave Specifica.
db.post.aggregate(
[
    {
        $match: { testo: /primo/i}
    }
]
);

// 1.8 Trova i 3 utenti con il maggior numero di amici.
db.utenti.aggregate(
[
    {
        $project:
        {
            nome: 1,
            numero_amici: { $size: "$id_amici" }
        }
    },
    {
        $sort:
        {
            numero_amici: -1
        }
    },
    {
        $limit: 3
    }
]
)

// Scrivi una transazione che gestisce la pubblicazione di un post da parte di un utente, gestendo gli aggiornamenti che ritieni necessari.
const session = db.getMongo().startSession();

try {
    session.startTransaction();

    // Aggiungi un nuovo post
    const nuovoPost = {
        id_utente: 3,
        testo: "Questo è il mio nuovo post!",
        data_pubblicazione: new Date(),
    };

    const nuovoPostInserito = session.getDatabase('social_network').post.insertOne(nuovoPost);

    // Aggiorna il numero di post dell'utente
    const aggiornamentoUtente = {
        $inc: { post: 1 }
    };

    const utenteAggiornato = session.getDatabase('social_network').utenti.updateOne(
        { _id: 3 },
        aggiornamentoUtente
    );

    // Se tutto va a buon fine, commit della transazione
    session.commitTransaction();
    print("Post aggiunto e numero di post dell'utente aggiornato.");
} catch (error) {
    session.abortTransaction();
    print("Errore nella transazione: ", error);
} finally {
    session.endSession();
}