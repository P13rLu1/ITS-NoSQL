-- Procedura per Aggiungere una Nuova Squadra con Giocatori
CREATE OR REPLACE PROCEDURE dbo_fantacalcio.sp_add_squadra_con_giocatori(
    IN squadra_nome VARCHAR(50),
    IN squadra_citta VARCHAR(50),
    IN giocatori JSONB
)
LANGUAGE plpgsql
AS $$
DECLARE
    squadra_id BIGINT;
    giocatore RECORD;  -- Usato per iterare sugli oggetti JSON
    giocatore_id BIGINT;
BEGIN
    -- Avvio della transazione
    BEGIN
        -- Inserimento della squadra
        INSERT INTO dbo_fantacalcio."Squadra" (nome, citta)
        VALUES (squadra_nome, squadra_citta)
        RETURNING "Id" INTO squadra_id;

        -- Inserimento dei giocatori
        FOR giocatore IN SELECT * FROM jsonb_array_elements(giocatori) LOOP
            -- Estrai i dati per nome e cognome
            INSERT INTO dbo_fantacalcio."Giocatore" (nome, cognome)
            VALUES (giocatore->>'nome', giocatore->>'cognome')
            RETURNING "Id" INTO giocatore_id;

            -- Collegamento del giocatore alla squadra nella tabella carriera
            INSERT INTO dbo_fantacalcio.carriera ("Id_Squadra", "Id_Giocatore", data)
            VALUES (squadra_id, giocatore_id, CURRENT_DATE);
        END LOOP;

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE EXCEPTION 'Errore durante l''inserimento della squadra e dei giocatori';
    END;
END;
$$;

-- Procedura per Registrare una Nuova Partita e lo Storico delle Squadre
CREATE OR REPLACE PROCEDURE dbo_fantacalcio.sp_add_partita_con_storico(
    IN data_partita DATE,
    IN id_squadre BIGINT[]
)
LANGUAGE plpgsql
AS $$
DECLARE
    partita_id BIGINT;
    squadra_id BIGINT;
BEGIN
    -- Inizio della transazione
    BEGIN
        -- Inserimento della partita
        INSERT INTO dbo_fantacalcio."Partita" (data)
        VALUES (data_partita)
        RETURNING "Id" INTO partita_id;

        -- Inserimento delle squadre nella tabella storico
        FOREACH squadra_id IN ARRAY id_squadre LOOP
            INSERT INTO dbo_fantacalcio.storico_partite_squadra ("Id_Partita", "Id_Squadra", data)
            VALUES (partita_id, squadra_id, CURRENT_DATE);
        END LOOP;

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE EXCEPTION 'Errore durante l''inserimento della partita e dello storico delle squadre';
    END;
END;
$$;

-- Procedura per Registrare la Partecipazione di un Giocatore a una Partita
CREATE OR REPLACE PROCEDURE dbo_fantacalcio.sp_add_partecipazione_giocatore(
    IN id_partita BIGINT,
    IN id_giocatore BIGINT
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Inizio della transazione
    BEGIN
        -- Inserimento nella tabella storico partite giocatore
        INSERT INTO dbo_fantacalcio.storico_partite_giocatore ("Id_Partita", "Id_Giocatore", data)
        VALUES (id_partita, id_giocatore, CURRENT_DATE);
        
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE EXCEPTION 'Errore durante l''inserimento della partecipazione del giocatore';
    END;
END;
$$;
