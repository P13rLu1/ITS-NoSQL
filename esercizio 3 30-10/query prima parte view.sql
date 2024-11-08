-- Elenco Completo delle Squadre con i Giocatori Attuali
CREATE OR REPLACE VIEW dbo_fantacalcio.vw_squadre_giocatori AS
SELECT 
    s.nome AS squadra,
    s.citta AS citta,
    g.nome AS nome_giocatore,
    g.cognome AS cognome_giocatore,
    c.data AS data_inizio_carriera
FROM 
    dbo_fantacalcio."Squadra" s
JOIN 
    dbo_fantacalcio.carriera c ON s."Id" = c."Id_Squadra"
JOIN 
    dbo_fantacalcio."Giocatore" g ON g."Id" = c."Id_Giocatore"
ORDER BY 
    s.nome, g.cognome;

-- Storico Partite per Squadra
CREATE OR REPLACE VIEW dbo_fantacalcio.vw_storico_partite_squadra AS
SELECT 
    s.nome AS squadra,
    p.data AS data_partita,
    sp.data AS data_storico
FROM 
    dbo_fantacalcio."Squadra" s
JOIN 
    dbo_fantacalcio.storico_partite_squadra sp ON s."Id" = sp."Id_Squadra"
JOIN 
    dbo_fantacalcio."Partita" p ON p."Id" = sp."Id_Partita"
ORDER BY 
    s.nome, p.data;
	
-- Storico Partite per Giocatore
CREATE OR REPLACE VIEW dbo_fantacalcio.vw_storico_partite_giocatore AS
SELECT 
    g.nome AS nome_giocatore,
    g.cognome AS cognome_giocatore,
    p.data AS data_partita,
    spg.data AS data_storico
FROM 
    dbo_fantacalcio."Giocatore" g
JOIN 
    dbo_fantacalcio.storico_partite_giocatore spg ON g."Id" = spg."Id_Giocatore"
JOIN 
    dbo_fantacalcio."Partita" p ON p."Id" = spg."Id_Partita"
ORDER BY 
    g.cognome, p.data;

-- Giocatori Attivi per Ogni Partita
CREATE OR REPLACE VIEW dbo_fantacalcio.vw_giocatori_per_partita AS
SELECT 
    p.data AS data_partita,
    g.nome AS nome_giocatore,
    g.cognome AS cognome_giocatore,
    spg.data AS data_partecipazione
FROM 
    dbo_fantacalcio."Partita" p
JOIN 
    dbo_fantacalcio.storico_partite_giocatore spg ON p."Id" = spg."Id_Partita"
JOIN 
    dbo_fantacalcio."Giocatore" g ON g."Id" = spg."Id_Giocatore"
ORDER BY 
    p.data, g.cognome;

--  Elenco Completo delle Carriere dei Giocatori
CREATE OR REPLACE VIEW dbo_fantacalcio.vw_carriera_giocatori AS
SELECT 
    g.nome AS nome_giocatore,
    g.cognome AS cognome_giocatore,
    s.nome AS squadra,
    c.data AS data_inizio
FROM 
    dbo_fantacalcio."Giocatore" g
JOIN 
    dbo_fantacalcio.carriera c ON g."Id" = c."Id_Giocatore"
JOIN 
    dbo_fantacalcio."Squadra" s ON s."Id" = c."Id_Squadra"
ORDER BY 
    g.cognome, c.data;