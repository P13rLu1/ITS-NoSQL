-- Creazione della tabella Utenti
CREATE TABLE utenti (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    bio TEXT,
    num_post INT DEFAULT 0
);

-- Tabella per la relazione di amicizia tra utenti
CREATE TABLE amici (
    id_utente INT REFERENCES utenti(id) ON DELETE CASCADE,
    id_amico INT REFERENCES utenti(id) ON DELETE CASCADE,
    PRIMARY KEY (id_utente, id_amico)
);

-- Creazione della tabella Post
CREATE TABLE post (
    id SERIAL PRIMARY KEY,
    id_utente INT REFERENCES utenti(id) ON DELETE CASCADE,
    testo TEXT NOT NULL,
    data_pubblicazione TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Creazione della tabella Commenti
CREATE TABLE commenti (
    id SERIAL PRIMARY KEY,
    id_utente INT REFERENCES utenti(id) ON DELETE CASCADE,
    id_post INT REFERENCES post(id) ON DELETE CASCADE,
    testo TEXT NOT NULL,
    data TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Creazione della tabella MiPiace
CREATE TABLE mi_piace (
    id SERIAL PRIMARY KEY,
    id_utente INT REFERENCES utenti(id) ON DELETE CASCADE,
    id_post INT REFERENCES post(id) ON DELETE CASCADE
);

-- Popolamento tabelle
-- Inserimento di dati nella tabella Utenti
INSERT INTO utenti (nome, email, bio) VALUES
    ('Soxa Sorda', 'soxa@dev.it', 'Sono un architetto'),
    ('Marta Sorda', 'martasorda@linksmt.it', 'Sono una studentessa'),
    ('Giovanni Sordo', 'giovannisordo@exprivia.it', 'Sono un programmatore'),
    ('Luca Sardo', 'lucasardo@rurale.tau', 'Sono un agricoltore e pianto le pannocchie');

-- Inserimento di amicizie
INSERT INTO amici (id_utente, id_amico) VALUES
    (1, 2), (1, 3), (2, 1), (2, 3), (3, 1), (3, 2);

-- Inserimento di post
INSERT INTO post (id_utente, testo, data_pubblicazione) VALUES
    (1, 'Primo post 1, di utente 1', '2024-02-01'),
    (1, 'Secondo post 2, di utente 1', '2024-02-02'),
    (2, 'Primo post 1, di utente 2', '2024-02-03'),
    (3, 'Primo post 1, di utente 3', '2024-02-04');

-- Inserimento di commenti
INSERT INTO commenti (id_utente, id_post, testo, data) VALUES
    (2, 1, 'Primo commento di utente 2 al post 1', '2024-02-01'),
    (3, 1, 'Primo commento di utente 3 al post 1', '2024-02-02'),
    (1, 3, 'Primo commento di utente 1 al post 3', '2024-02-03'),
    (1, 2, 'Primo commento di utente 1 al post 2', '2024-02-04');

-- Inserimento di "mi piace"
INSERT INTO mi_piace (id_utente, id_post) VALUES
    (2, 1), (3, 1), (1, 3), (1, 2);


-- 1.1 Recupero del Feed di un Utente: Ottieni i post di un utente specifico con i relativi "mi piace" e commenti.
SELECT p.id AS id_post, u.nome, p.testo, COUNT(mp.id) AS numero_mi_piace
FROM post p
JOIN utenti u ON p.id_utente = u.id
LEFT JOIN mi_piace mp ON p.id = mp.id_post
WHERE u.id = 1
GROUP BY p.id, u.nome, p.testo;

-- 1.2 Amici di un Utente: Trova tutti gli amici di un utente specifico.
SELECT u2.nome, u2.email, u2.bio, u1.nome
FROM amici a
JOIN utenti u1 ON a.id_utente = u1.id
JOIN utenti u2 ON a.id_amico = u2.id
WHERE u1.id = 1;

-- 1.3 Conteggio dei Mi Piace su un Post: Conta il numero di "mi piace" per un post specifico.
SELECT p.id AS id_post, COUNT(mp.id) AS numero_mi_piace
FROM post p
LEFT JOIN mi_piace mp ON p.id = mp.id_post
WHERE p.id = 1
GROUP BY p.id;

-- 1.4 Visualizzazione dei Commenti: Ottieni tutti i commenti su un post specifico, con il nome dell'autore di ciascun commento.
SELECT c.testo AS commento, u.nome AS autore
FROM commenti c
JOIN utenti u ON c.id_utente = u.id
WHERE c.id_post = 1;

-- 1.5 Recupera gli ultimi post di un utente specifico, ordinati per data di creazione.
SELECT p.id, p.testo, p.data_pubblicazione
FROM post p
WHERE p.id_utente = 1
ORDER BY p.data_pubblicazione DESC

-- 1.6 Trova il post con il maggior numero di "mi piace" per un determinato utente.
SELECT p.id AS id_post, p.testo, COUNT(mp.id) AS numero_mi_piace
FROM post p
LEFT JOIN mi_piace mp ON p.id = mp.id_post
WHERE p.id_utente = 1
GROUP BY p.id, p.testo
ORDER BY numero_mi_piace DESC
LIMIT 1;

-- 1.7 Trova i Post Contenenti una Parola Chiave Specifica.
SELECT *
FROM post
WHERE testo ILIKE '%primo%';

-- 1.8 Trova i 3 utenti con il maggior numero di amici.
SELECT u.id, u.nome, COUNT(a.id_amico) AS numero_amici
FROM utenti u
LEFT JOIN amici a ON u.id = a.id_utente
GROUP BY u.id
ORDER BY numero_amici DESC
LIMIT 3;

-- Scrivi una transazione che gestisce la pubblicazione di un post da parte di un utente, 
-- gestendo gli aggiornamenti che ritieni necessari. 
CREATE OR REPLACE PROCEDURE social_network.pubblica_post(
    IN p_id_utente INT,        -- ID dell'utente che pubblica il post
    IN p_testo TEXT            -- Testo del post da pubblicare
)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    utente_esistente BOOLEAN;  -- Variabile per verificare se l'utente esiste
BEGIN
    -- Controlla se l'utente esiste
    SELECT EXISTS(SELECT 1 FROM social_network.Utente WHERE id = p_id_utente) INTO utente_esistente;

    IF NOT utente_esistente THEN
        RAISE EXCEPTION 'Errore: l''utente con ID % non esiste.', p_id_utente;
    END IF;

    -- Inizio transazione per la pubblicazione del post
    BEGIN
        -- Inserisce il nuovo post
        INSERT INTO social_network.Post (testo, data_pubblicazione, id_utente)
        VALUES (p_testo, CURRENT_TIMESTAMP, p_id_utente);
        
        -- Aggiorna il numero di post dell'utente
        UPDATE social_network.Utente
        SET num_post = num_post + 1
        WHERE id = p_id_utente;
    
    EXCEPTION WHEN unique_violation THEN
        ROLLBACK;
        RAISE NOTICE 'Errore: transazione annullata a causa di un errore di unicità.';
        COMMIT;
    END;
END;
$BODY$;

ALTER PROCEDURE social_network.pubblica_post(integer, text)
    OWNER TO postgres;


-- Utilizzo della procedura
CALL social_network.pubblica_post(1, 'Questo è il mio primo post!');

-- Controllo della procedura
SELECT * FROM social_network.Post

SELECT * FROM social_network.Utente