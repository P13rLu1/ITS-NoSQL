-- Popolazione della tabella docenti
INSERT INTO dbo_registro.docenti (cod_docente, nome_d, dipartimento) VALUES
(1, 'Mario Rossi', 'Informatica'),
(2, 'Giulia Bianchi', 'Lettere e Filosofia'),
(3, 'Luca Verdi', 'Informatica'),
(4, 'Anna Neri', 'Storia'),
(5, 'Felice Leoni', 'Informatica');

-- Popolazione della tabella corsi_di_laurea
INSERT INTO dbo_registro.corsi_di_laurea (corso_laurea, tipo_laurea, facolta) VALUES
('INF101', 'Laurea Triennale', 'Scienze e Tecnologie'),
('SBC102', 'Laurea Magistrale', 'Lettere e Filosofia'),
('MAT103', 'Laurea Triennale', 'Scienze e Tecnologie'),
('STO104', 'Laurea Triennale', 'Storia');

-- Popolazione della tabella corsi
INSERT INTO dbo_registro.corsi (cod_corso, nome_corso, cod_docente) VALUES
(1001, 'Basi di Dati e Sistemi Informativi', 1),
(1002, 'Informatica Generale', 3),
(1003, 'Letteratura Italiana', 2),
(1004, 'Storia Romana', 4),
(1005, 'Programmazione', 5);

-- Popolazione della tabella studenti
INSERT INTO dbo_registro.studenti (matricola, nome_s, anno_n, corso_laurea) VALUES
(2001, 'Alice Neri', 2000, 'INF101'),
(2002, 'Marco Gialli', 1999, 'SBC102'),
(2003, 'Sofia Viola', 1998, 'MAT103'),
(2004, 'Giorgio Blu', 2001, 'STO104'),
(2005, 'Felice Rossi', 1999, 'INF101');

-- Popoliamo la tabella frequenta
INSERT INTO dbo_registro.frequenta (matricola, cod_corso, id) VALUES
    (2001, 1001, 1),  -- Alice Neri frequenta il corso "Basi di Dati e Sistemi Informativi"
    (2001, 1005, 2),  -- Alice Neri frequenta anche "Programmazione"
    (2002, 1003, 3),  -- Marco Gialli frequenta "Letteratura Italiana"
    (2003, 1001, 4),  -- Sofia Viola frequenta "Basi di Dati e Sistemi Informativi"
    (2004, 1004, 5),  -- Giorgio Blu frequenta "Storia Romana"
    (2005, 1002, 6);  -- Felice Rossi frequenta "Informatica Generale"

-- Popolazione aggiuntiva della tabella docenti
INSERT INTO dbo_registro.docenti (cod_docente, nome_d, dipartimento) VALUES
(6, 'Clara Gialli', 'Matematica'),
(7, 'Roberto Blu', 'Fisica'),
(8, 'Elisa Viola', 'Ingegneria'),
(9, 'Paolo Rossi', 'Informatica'),
(10, 'Laura Bianchi', 'Lettere e Filosofia'),
(11, 'Daniele Rossi', 'Scienze Politiche'),
(12, 'Sara Verde', 'Giurisprudenza'),
(13, 'Tommaso Neri', 'Medicina'),
(14, 'Rita Leoni', 'Psicologia'),
(15, 'Giorgio Marrone', 'Biologia'),
(16, 'Elena Grigi', 'Chimica'),
(17, 'Lorenzo Rossi', 'Informatica'),
(18, 'Federico Neri', 'Lettere e Filosofia'),
(19, 'Chiara Blu', 'Ingegneria'),
(20, 'Luca Bianchi', 'Architettura'),
(21, 'Marta Rossi', 'Scienze Politiche'),
(22, 'Alessandro Verde', 'Matematica'),
(23, 'Francesca Neri', 'Economia'),
(24, 'Valentina Blu', 'Fisica'),
(25, 'Antonio Gialli', 'Informatica');

-- Popolazione aggiuntiva della tabella corsi_di_laurea
INSERT INTO dbo_registro.corsi_di_laurea (corso_laurea, tipo_laurea, facolta) VALUES
('ING201', 'Laurea Magistrale', 'Ingegneria'),
('MED202', 'Laurea Magistrale', 'Medicina e Chirurgia'),
('PSY203', 'Laurea Triennale', 'Psicologia'),
('BIO204', 'Laurea Triennale', 'Scienze Biologiche'),
('PHY205', 'Laurea Magistrale', 'Scienze Fisiche'),
('ARC206', 'Laurea Triennale', 'Architettura'),
('ECO207', 'Laurea Triennale', 'Economia'),
('MAT208', 'Laurea Magistrale', 'Matematica'),
('LAW209', 'Laurea Triennale', 'Giurisprudenza'),
('SCI210', 'Laurea Triennale', 'Scienze Politiche'),
('SOC211', 'Laurea Magistrale', 'Sociologia'),
('ENG212', 'Laurea Magistrale', 'Ingegneria'),
('CHE213', 'Laurea Triennale', 'Chimica'),
('AGR214', 'Laurea Triennale', 'Agraria'),
('FOR215', 'Laurea Magistrale', 'Forestale'),
('COM216', 'Laurea Triennale', 'Comunicazione'),
('INF217', 'Laurea Magistrale', 'Informatica'),
('HUM218', 'Laurea Triennale', 'Lettere e Filosofia'),
('ENV219', 'Laurea Triennale', 'Scienze Ambientali'),
('ANT220', 'Laurea Triennale', 'Antropologia');

-- Popolazione aggiuntiva della tabella corsi
INSERT INTO dbo_registro.corsi (cod_corso, nome_corso, cod_docente) VALUES
(1006, 'Matematica Generale', 6),
(1007, 'Fisica I', 7),
(1008, 'Ingegneria del Software', 8),
(1009, 'Algoritmi e Strutture Dati', 9),
(1010, 'Filosofia Antica', 10),
(1011, 'Relazioni Internazionali', 11),
(1012, 'Diritto Privato', 12),
(1013, 'Anatomia Umana', 13),
(1014, 'Psicologia Generale', 14),
(1015, 'Genetica', 15),
(1016, 'Chimica Organica', 16),
(1017, 'Intelligenza Artificiale', 17),
(1018, 'Storia Medievale', 18),
(1019, 'Meccanica Razionale', 19),
(1020, 'Progettazione Architettonica', 20),
(1021, 'Economia Politica', 23),
(1022, 'Fisica II', 24),
(1023, 'Analisi Matematica', 22),
(1024, 'Metodologia della Ricerca', 21),
(1025, 'Teoria dei Numeri', 6);

-- Popolazione aggiuntiva della tabella studenti
INSERT INTO dbo_registro.studenti (matricola, nome_s, anno_n, corso_laurea) VALUES
(2006, 'Davide Rossi', 2000, 'ING201'),
(2007, 'Francesca Neri', 1999, 'PSY203'),
(2008, 'Simone Bianchi', 1998, 'MAT103'),
(2009, 'Martina Viola', 2001, 'ARC206'),
(2010, 'Gianluca Blu', 1997, 'ECO207'),
(2011, 'Elisa Gialli', 2002, 'PHY205'),
(2012, 'Federico Rossi', 1996, 'INF217'),
(2013, 'Lucia Verde', 1998, 'SCI210'),
(2014, 'Paola Marrone', 2001, 'SOC211'),
(2015, 'Michele Neri', 1995, 'LAW209'),
(2016, 'Antonio Grigi', 1997, 'CHE213'),
(2017, 'Angela Viola', 2000, 'AGR214'),
(2018, 'Raffaella Bianchi', 1999, 'COM216'),
(2019, 'Andrea Rossi', 1995, 'STO104'),
(2020, 'Stefano Blu', 1996, 'BIO204'),
(2021, 'Chiara Verde', 2001, 'HUM218'),
(2022, 'Sara Neri', 1998, 'ENV219'),
(2023, 'Paolo Rossi', 1997, 'ANT220'),
(2024, 'Anna Bianchi', 1999, 'ING201'),
(2025, 'Giulia Blu', 2000, 'INF101');

-- Popolazione aggiuntiva della tabella frequenta
INSERT INTO dbo_registro.frequenta (matricola, cod_corso, id) VALUES
(2006, 1008, 7),  -- Davide Rossi frequenta "Ingegneria del Software"
(2007, 1014, 8),  -- Francesca Neri frequenta "Psicologia Generale"
(2008, 1006, 9),  -- Simone Bianchi frequenta "Matematica Generale"
(2009, 1020, 10), -- Martina Viola frequenta "Progettazione Architettonica"
(2010, 1021, 11), -- Gianluca Blu frequenta "Economia Politica"
(2011, 1007, 12), -- Elisa Gialli frequenta "Fisica I"
(2012, 1009, 13), -- Federico Rossi frequenta "Algoritmi e Strutture Dati"
(2013, 1011, 14), -- Lucia Verde frequenta "Relazioni Internazionali"
(2014, 1024, 15), -- Paola Marrone frequenta "Metodologia della Ricerca"
(2015, 1012, 16), -- Michele Neri frequenta "Diritto Privato"
(2016, 1016, 17), -- Antonio Grigi frequenta "Chimica Organica"
(2017, 1025, 18), -- Angela Viola frequenta "Teoria dei Numeri"
(2018, 1010, 19), -- Raffaella Bianchi frequenta "Filosofia Antica"
(2019, 1004, 20), -- Andrea Rossi frequenta "Storia Romana"
(2020, 1015, 21), -- Stefano Blu frequenta "Genetica"
(2021, 1018, 22), -- Chiara Verde frequenta "Storia Medievale"
(2022, 1017, 23), -- Sara Neri frequenta "Intelligenza Artificiale"
(2023, 1023, 24), -- Paolo Rossi frequenta "Analisi Matematica"
(2024, 1022, 25), -- Anna Bianchi frequenta "Fisica II"
(2025, 1002, 26); -- Giulia Blu frequenta "Informatica Generale"

delete from dbo_registro.studenti WHERE matricola between 2006 and 2025
delete from dbo_registro.frequenta where matricola BETWEEN 2006 and 2025

-- Popolazione aggiornata della tabella studenti
INSERT INTO dbo_registro.studenti (matricola, nome_s, anno_n, corso_laurea) VALUES
(2006, 'Davide Rossi', 2000, 'INF101'),
(2007, 'Francesca Neri', 1999, 'INF101'),
(2008, 'Simone Bianchi', 1998, 'INF101'),
(2009, 'Martina Viola', 2001, 'SBC102'),
(2010, 'Gianluca Blu', 1997, 'SBC102'),
(2011, 'Elisa Gialli', 2002, 'SBC102'),
(2012, 'Federico Rossi', 1996, 'MAT103'),
(2013, 'Lucia Verde', 1998, 'MAT103'),
(2014, 'Paola Marrone', 2001, 'MAT103'),
(2015, 'Michele Neri', 1995, 'STO104'),
(2016, 'Antonio Grigi', 1997, 'STO104'),
(2017, 'Angela Viola', 2000, 'STO104'),
(2018, 'Raffaella Bianchi', 1999, 'ING201'),
(2019, 'Andrea Rossi', 1995, 'ING201'),
(2020, 'Stefano Blu', 1996, 'ING201'),
(2021, 'Chiara Verde', 2001, 'ING201'),
(2022, 'Sara Neri', 1998, 'ING201'),
(2023, 'Paolo Rossi', 1997, 'PSY203'),
(2024, 'Anna Bianchi', 1999, 'PSY203'),
(2025, 'Giulia Blu', 2000, 'PSY203');

-- Popolazione aggiornata della tabella frequenta, assegnando ciascuno studente a più corsi
INSERT INTO dbo_registro.frequenta (matricola, cod_corso, id) VALUES
(2006, 1001, 7),  -- Davide Rossi frequenta "Basi di Dati e Sistemi Informativi"
(2007, 1005, 8),  -- Francesca Neri frequenta "Programmazione"
(2008, 1009, 9),  -- Simone Bianchi frequenta "Algoritmi e Strutture Dati"
(2009, 1003, 10), -- Martina Viola frequenta "Letteratura Italiana"
(2010, 1010, 11), -- Gianluca Blu frequenta "Filosofia Antica"
(2011, 1002, 12), -- Elisa Gialli frequenta "Informatica Generale"
(2012, 1006, 13), -- Federico Rossi frequenta "Matematica Generale"
(2013, 1013, 14), -- Lucia Verde frequenta "Anatomia Umana"
(2014, 1012, 15), -- Paola Marrone frequenta "Diritto Privato"
(2015, 1004, 16), -- Michele Neri frequenta "Storia Romana"
(2016, 1015, 17), -- Antonio Grigi frequenta "Genetica"
(2017, 1011, 18), -- Angela Viola frequenta "Relazioni Internazionali"
(2018, 1017, 19), -- Raffaella Bianchi frequenta "Intelligenza Artificiale"
(2019, 1021, 20), -- Andrea Rossi frequenta "Economia Politica"
(2020, 1023, 21), -- Stefano Blu frequenta "Analisi Matematica"
(2021, 1022, 22), -- Chiara Verde frequenta "Fisica II"
(2022, 1018, 23), -- Sara Neri frequenta "Storia Medievale"
(2023, 1014, 24), -- Paolo Rossi frequenta "Psicologia Generale"
(2024, 1019, 25), -- Anna Bianchi frequenta "Meccanica Razionale"
(2025, 1016, 26); -- Giulia Blu frequenta "Chimica Organica"


-- Aggiungi nuovi studenti al corso di Informatica Generale
INSERT INTO dbo_registro.frequenta (matricola, cod_corso, id) VALUES
(2006, 1002, 27),  -- Davide Rossi frequenta Informatica Generale
(2007, 1002, 28),  -- Francesca Neri frequenta Informatica Generale
(2008, 1002, 29),  -- Simone Bianchi frequenta Informatica Generale
(2010, 1002, 30),  -- Gianluca Blu frequenta Informatica Generale
(2012, 1002, 31);  -- Federico Rossi frequenta Informatica Generale