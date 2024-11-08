//10. Dato il seguente scenario:
//Immagina di gestire un database per una palestra che tiene traccia dei clienti, degli
//abbonamenti e degli allenamenti. L'obiettivo è organizzare le informazioni sui membri della
//palestra, sui loro piani di allenamento e sugli istruttori.
//
//Ogni cliente ha un nome, cognome, età, email, una lista di allenamenti associati e un
//abbonamento.
//
//Ogni abbonamento include il tipo (mensile, annuale, ecc.), la data di inizio, la data di scadenza
//e il costo.
//
//Ogni allenamento ha un nome (es. "Yoga", "Sollevamento pesi"), la durata in minuti, l'istruttore
//che lo conduce e la difficoltà (principiante, intermedio, avanzato).
//
//Gli istruttori hanno un nome, un cognome, una email, una specializzazione, una data di inizio
//contratto di lavoro.

// Crea il database e le collezioni.
use palestra;

db.createCollection("clienti");
db.createCollection("allenamenti");
db.createCollection("istruttori");

// Popola le collezioni.
db.clienti.insertMany([
    {
        "_id": 1,
        "nome": "Mario",
        "cognome": "Rossi",
        "età": 30,
        "email": "mariorossi@example.it: ",
        "allenamenti": ["Yoga", "Sollevamento pesi"],
        "abbonamento": {
            "tipo": "mensile",
            "data_inizio": ISODate("2024-01-01"),
            "data_scadenza": ISODate("2024-01-31"),
            "costo": 50
        }
    },
    {
        "_id": 2,
        "nome": "Giulia",
        "cognome": "Bianchi",
        "età": 25,
        "email": "giuliabianchi@example.it",
        "allenamenti": ["Cardio", "Zumba"],
        "abbonamento": {
            "tipo": "annuale",
            "data_inizio": ISODate("2024-01-01"),
            "data_scadenza": ISODate("2025-01-01"),
            "costo": 500
        }
    },
    {
        "_id": 3,
        "nome": "Luca",
        "cognome": "Verdi",
        "età": 35,
        "email": "lucaverdi@example.it",
        "allenamenti": ["Crossfit", "Pilates"],
        "abbonamento": {
            "tipo": "mensile",
            "data_inizio": ISODate("2024-01-01"),
            "data_scadenza": ISODate("2024-01-31"),
            "costo": 60
        }
    },
    {
        "_id": 4,
        "nome": "Anna",
        "cognome": "Neri",
        "età": 28,
        "email": "annaneri@example.it",
        "allenamenti": ["Sollevamento pesi", "Cardio"],
        "abbonamento": {
            "tipo": "mensile",
            "data_inizio": ISODate("2024-01-01"),
            "data_scadenza": ISODate("2024-01-31"),
            "costo": 55
        }
    },
    {
        "_id": 5,
        "nome": "Paolo",
        "cognome": "Gialli",
        "età": 40,
        "email": "paologialli@example.it",
        "allenamenti": ["Yoga", "Crossfit"],
        "abbonamento": {
            "tipo": "mensile",
            "data_inizio": ISODate("2024-01-01"),
            "data_scadenza": ISODate("2024-01-31"),
            "costo": 50
        }
    }
]);

db.allenamenti.insertMany([
    {
        "_id": 1,
        "nome": "Yoga",
        "durata": 60,
        "id_istruttore": 1,
        "difficoltà": "principiante"
    },
    {
        "_id": 2,
        "nome": "Sollevamento pesi",
        "durata": 45,
        "id_istruttore": 2,
        "difficoltà": "intermedio"
    },
    {
        "_id": 3,
        "nome": "Cardio",
        "durata": 30,
        "id_istruttore": 3,
        "difficoltà": "avanzato"
    },
    {
        "_id": 4,
        "nome": "Zumba",
        "durata": 45,
        "id_istruttore": 4,
        "difficoltà": "principiante"
    },
    {
        "_id": 5,
        "nome": "Crossfit",
        "durata": 60,
        "id_istruttore": 5,
        "difficoltà": "intermedio"
    },
    {
        "_id": 6,
        "nome": "Pilates",
        "durata": 45,
        "id_istruttore": 6,
        "difficoltà": "principiante"
    }
]);

db.istruttori.insertMany([
    {
        "_id": 1,
        "nome": "Maria",
        "cognome": "Bianchi",
        "email": "mariabianchi@example.it",
        "specializzazione": "Yoga",
        "data_inizio_contratto": ISODate("2023-01-15")
    },
    {
        "_id": 2,
        "nome": "Luca",
        "cognome": "Verdi",
        "email": "lucaverdi@example,it",
        "specializzazione": "Sollevamento pesi",
        "data_inizio_contratto": ISODate("2023-02-20")
    },
    {
        "_id": 3,
        "nome": "Giovanni",
        "cognome": "Rossi",
        "email": "giovannirossi@example.it",
        "specializzazione": "Cardio",
        "data_inizio_contratto": ISODate("2023-03-25")
    },
    {
        "_id": 4,
        "nome": "Anna",
        "cognome": "Neri",
        "email": "annaneri@example.it",
        "specializzazione": "Zumba",
        "data_inizio_contratto": ISODate("2023-04-30")
    },
    {
        "_id": 5,
        "nome": "Paolo",
        "cognome": "Gialli",
        "email": "paologialli@example.it",
        "specializzazione": "Crossfit",
        "data_inizio_contratto": ISODate("2023-05-05")
    },
    {
        "_id": 6,
        "nome": "Giulia",
        "cognome": "Bianchi",
        "email": "giuliabianchi@example.it",
        "specializzazione": "Pilates",
        "data_inizio_contratto": ISODate("2023-06-10")
    }
]);

// Query
// 1. Trova tutti i clienti con un abbonamento attivo.
db.clienti.find({ "abbonamento.data_scadenza": { $gte: new Date() } });

// 2. Elenca tutti gli allenamenti disponibili per livello avanzato.
db.allenamenti.find(
[
    {
        $match:
        {
            difficoltà: "avanzato"
        }
    },
    {
        $project:
        {
            _id: 0,
            nome: 1,
            durata: 1,
            istruttore: 1
        }
    }
]
);

// 3. Trova tutti gli allenamenti condotti da istruttori assunti dopo il 31-12-2021.
db.allenamenti.aggregate(
[
    {
        $lookup:
        {
            from: "istruttori",
            localField: "id_istruttore",
            foreignField: "_id",
            as: "istruttore_trovato"
        }
    },
    {
        $match:
        {
            "istruttore_trovato.data_inizio_contratto": { $gt: ISODate("2021-12-31") }
        }
    },
    {
        $project:
        {
            "_id": 0,
            "nome": 1,
            "durata": 1,
            "istruttore_trovato.nome": 1,
            "istruttore_trovato.cognome": 1,
            "istruttore_trovato.data_inizio_contratto": 1
        }
    }
]
);

// 4. Trova tutti i clienti che hanno un abbonamento mensile e il cui abbonamento scade dopo una certa data.
db.clienti.find(
{
    "abbonamento.tipo": "mensile",
    "abbonamento.data_scadenza": { $gt: ISODate("2024-02-01") }
}
);

// 5. Aggiungi un nuovo allenamento a un cliente specifico.
db.clienti.updateOne(
    { "_id": 1 },
    { $push: { "allenamenti": "Pilates" } }
);

// View
// Crea una vista che mostri i dati dei clienti con gli abbonamenti associati.
db.createView("clienti_con_abbonamenti", "clienti", [
    {
        $project:
        {
            _id: 0,
        }
    }
]);

// Index
// Crea un indice composto sui document della collection clienti: compara i risultati di una query di ricerca.
db.clienti.createIndex({ "nome": 1, "cognome": 1 });
db.clienti.find({ "nome": "Mario", "cognome": "Rossi" }).explain();

// Transaction
// Scrivi una transazione che censisce un nuovo istruttore e un nuovo corso a lui assegnato.
const session = db.getMongo().startSession();
session.startTransaction();

try {
    const nuovo_istruttore = {
        "_id": 7,
        "nome": "Laura",
        "cognome": "Verdi",
        "email": "lucaverdi@example.it",
        "specializzazione": "Tonificazione",
        "data_inizio_contratto": ISODate("2024-02-01")
    };
    const istruttoreInserito = session.getDatabase("palestra").istruttori.insertOne(nuovo_istruttore);

    const nuovo_corso = {
        "_id": 7,
        "nome": "Tonificazione",
        "durata": 45,
        "id_istruttore": 7,
        "difficoltà": "principiante"
    };
    session.getDatabase("palestra").allenamenti.insertOne(nuovo_corso);

    session.commitTransaction();
    print("Transazione completata con successo.");
}
catch (error) {
    session.abortTransaction ();
    print("Transazione annullata: " + error);
}
finally {
    session.endSession();
}