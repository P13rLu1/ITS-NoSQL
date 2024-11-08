// 1. Trova tutti i film con informazioni complete dalla collezione 'movies' che sono stati rilasciati nell'anno 2015.

db.movies.find({year : 2015},{_id:0})

// 2. trova tutti i film con infromazioni complete della collezione 'movies' che hanno una durata superiore a 120 minuti
// 2.1 estrai solo genere, titolo e cast, nascodendo l'id

db.movies.find({runtime : {$gt : 120}},{_id:0, genres: 1,  title:1, cast:1, runtime:1})

// 3. estrai i film con genere "drama"

db.movies.find({genres : "Drama"},{_id:0})

// 4. estrai i film rilasciati il 09/05/2015

db.movies.find({released : ISODate("2015-05-09")},{_id:0})

// 5. estrai i film con le info su titolo, lingua, data di rilascio, registi, writers e paesi, che hanno nel titolo la parola "Scene"

db.movies.find({title : /Scene/i},{_id:0, title:1, languages:1, released:1, directors:1, writers:1, countries:1})

// 6. estrai i film che hanno durata compresa tra 60 e 90 minuti, con titolo, lingua e runtime

db.movies.find({runtime : {$gte : 60, $lte : 90}},{_id:0, title:1, languages:1, runtime:1})

// 7. estrai i primi 5 film con rating imdb piú alto ma inferiore a 5

db.movies.find({ "imdb.rating" : {$lt : 5}},{_id:0}).sort({"imdb.rating" : -1}).limit(5)

// 8. Trova i film con il genere "Comedy" o "Drama" e un punteggio IMDb superiore a 7

db.movies.find({genres : {$in : ["Comedy", "Drama"]}, "imdb.rating" : {$gt : 7}},{_id:0})

// 9. Conta i film che hanno una durata (runtime) maggiore di 150 minuti

db.movies.find({runtime : {$gt : 150}}).count()

// 10. Trova i film in cui il paese di produzione è "Italy" e ordina i risultati in ordine alfabetico per titolo

db.movies.find({countries : "Italy"},{_id:0}).sort({title:1})

// 11. Calcola il numero medio di voti (imdb.votes) per i film rilasciati nel 2010

// per tutti i film
db.movies.aggregate([{$match : {year : 2010}},{$group : {_id : null, avgVotes : {$avg : "$imdb.votes"}}}])

// per singolo film
db.movies.aggregate([{$match : {year : 2010}},{$group : {_id : "$_id", avgVotes : {$avg : "$imdb.votes"}}}])

// 12. Trova i 5 registi che hanno diretto il maggior numero di film

db.movies.aggregate([{$unwind : "$directors"},{$group : {_id : "$directors", count : {$sum : 1}}},{$sort : {count : -1}},{$limit : 5}])

// 13. Trova la durata media dei film per ciascun genere (usare unwind)

db.movies.aggregate([{$unwind : "$genres"},{$group : {_id : "$genres", avgRuntime : {$avg : "$runtime"}}}])

// 14. Trova i film con il titolo più lungo per ogni anno

db.movies.aggregate({$group : {"_id" : "$year", "maxTitle" : {$max : {$strLenCP : "$title"}}}},{$sort : {"maxTitle" : -1}})

// 15. Trova gli attori che hanno lavorato in più di 50 film, e conta quanti film hanno fatto

db.movies.aggregate([{$unwind : "$cast"},{$group : {_id : "$cast", count : {$sum : 1}}},{$match : {count : {$gt : 50}}}])

// 16. Trova una lista di 10 film con i rispettivi commenti

db.movies.aggregate([
{
    $lookup : {
        from : "comments",
        localField : "_id",
        foreignField : "movie_id",
        as : "comments"
    }
},
{
    $project: {
        title: 1,
        released: 1,
        genres: 1,
        year: 1,
        comments: { text: 1 }
    }
},
{
    $limit : 10
}
])