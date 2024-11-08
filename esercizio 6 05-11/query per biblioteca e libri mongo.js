use biblioteca;
db.createCollection("libri");

db.libri.insertOne(
{
    titolo: "Il signore degli anelli",
    autore: "J.R.R. Tolkien",
    anno: 1954,
    generi: ["fantasy", "avventura"],
    disponibile: true,
    pagine: 1200,
    prestiti: 6
}
)

db.libri.insertMany(
[
    {
        titolo: "Il nome della rosa",
        autore: "Umberto Eco",
        anno: 1980,
        generi: ["giallo", "storico"],
        disponibile: true,
        pagine: 600,
        prestiti: 3
    },
    {
        titolo: "Il vecchio e il mare",
        autore: "Ernest Hemingway",
        anno: 1952,
        generi: ["avventura"],
        disponibile: false,
        pagine: 100,
        prestiti: 8
    },
    {
        titolo: "Il gattopardo",
        autore: "Tomasi di Lampedusa",
        anno: 1958,
        generi: ["storico"],
        disponibile: true,
        pagine: 200,
        prestiti: 4
    },
    {
        titolo: "Il ritratto di Dorian Gray",
        autore: "Oscar Wilde",
        anno: 1890,
        generi: ["drammatico"],
        disponibile: true,
        pagine: 400,
        prestiti: 5
    },
    {
        titolo: "Il fu Mattia Pascal",
        autore: "Luigi Pirandello",
        anno: 1904,
        generi: ["drammatico"],
        disponibile: false,
        pagine: 300,
        prestiti: 2
    },
    {
        titolo: "il piccolo principe",
        autore: "Antoine de Saint-Exupéry",
        anno: 1943,
        generi: ["fantasy"],
        disponibile: true,
        pagine: 150,
        prestiti: 7
    },
]
)

// 1. query per trovare i libri disponibili
db.libri.find({disponibile: true})

// 2. query per trovare i libri pubblicati prima del 2000  e che appartengono al genere "fantasy"
db.libri.find({anno: {$lt: 2000}, generi: {$in: ["fantasy"]}});

// 3. query per trovare i primi 3 libri con il maggiore numero di prestiti, ordinati in ordine decrescente
db.libri.find().sort({prestiti: -1}).limit(3);

// 4. query per trovare il numero di libri disponibili nella biblioteca
db.libri.find({disponibile: true}).count();

// 5. calcola il numero medio di pagine dei libri per ciascun genere (usare unwind)
db.libri.aggregate([
    {$unwind: "$generi"},
    {$group: {_id: "$generi", avgPagine: {$avg: "$pagine"}}}
]);

// aggiunta 1984 per la prossima query
db.libri.insertOne(
{
    titolo: "1984",
    autore: "George Orwell",
    anno: 1949,
    generi: ["distopia"],
    disponibile: false,
    pagine: 300,
    prestiti: 9
}
)

// 6. immagina che un utente abbia restituito il libr "1984", aggiorna il campo "disponibile" a true
db.libri.updateOne({titolo: "1984"}, {$set: {disponibile: true}});

db.createCollection("prestiti");
db.prestiti.insertOne(
{
    "_id": 1,
    "id_libro": ObjectId("6729fedcea626639a2f4ff19"),
    "data_prestito": ISODate("2024-01-10"),
    "data_restituzione": ISODate("2024-02-15"),
}
);

db.prestiti.insertMany(
[
    {
        "_id": 2,
        "id_libro": ObjectId("6729ff93ea626639a2f4ff1d"),
        "data_prestito": ISODate("2024-01-15"),
        "data_restituzione": ISODate("2024-02-20"),
    },
    {
        "_id": 3,
        "id_libro": ObjectId("6729ff93ea626639a2f4ff1e"),
        "data_prestito": ISODate("2024-01-20"),
        "data_restituzione": ISODate("2024-02-25"),
    },
    {
        "_id": 4,
        "id_libro": ObjectId("6729ff93ea626639a2f4ff1f"),
        "data_prestito": ISODate("2024-01-25"),
        "data_restituzione": ISODate("2024-03-01"),
    },
    {
        "_id": 5,
        "id_libro": ObjectId("6729ff93ea626639a2f4ff20"),
        "data_prestito": ISODate("2024-02-01"),
        "data_restituzione": ISODate("2024-03-06"),
    },
    {
        "_id": 6,
        "id_libro": ObjectId("6729ff93ea626639a2f4ff21"),
        "data_prestito": ISODate("2024-02-05"),
        "data_restituzione": ISODate("2024-03-10"),
    },
    {
        "_id": 7,
        "id_libro": ObjectId("6729fedcea626639a2f4ff19"),
        "data_prestito": ISODate("2024-02-10"),
        "data_restituzione": ISODate("2024-03-15"),
    }
]
)

// 1. trovare i libri piú prestati
db.prestiti.aggregate([
    {$group: {_id: "$id_libro", count: {$sum: 1}}},
    {$sort: {count: -1}},
    {$limit: 1}
]);

// 2. calcolare la durata media dei prestiti per ciascun libro
db.prestiti.aggregate([
    {$group: {_id: "$id_libro", avgDurata: {$avg: {$subtract: ["$data_restituzione", "$data_prestito"]}}}}
]);

// 3. trovare i generi piú popolari (con piú prestiti)
db.libri.aggregate([
    {$lookup: {from: "prestiti", localField: "_id", foreignField: "id_libro", as: "prestiti"}},
    {$unwind: "$generi"},
    {$group: {_id: "$generi", count: {$sum: 1}}},
    {$sort: {count: -1}},
    {$limit: 1}
]);

// 4. trovare i libri mai prestati
db.libri.aggregate([
    {$lookup: {from: "prestiti", localField: "_id", foreignField: "id_libro", as: "prestiti"}},
    {$match: {prestiti: []}},
    {$project: {titolo: 1}}
]);

// 5. trovare i libri con prestiti scaduti (data_restituzione < data_odierna)
db.prestiti.aggregate([
    {$lookup: {from: "libri", localField: "id_libro", foreignField: "_id", as: "libri"}},
    {$match: {data_restituzione: {$lt: new Date()}}}
]);