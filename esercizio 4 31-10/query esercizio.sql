SET search_path TO dbo_registro;

-- 1. il nome e l'anno di nascita degli studenti iscritti a SBC, in ordine rispetto al nome
select nome_s, anno_n
from studenti
where corso_laurea = 'SBC102'
order by nome_s;

-- 2. il nome e il dipartimento dei docenti di "Basi di dati e sistemi informativi" o di "informatica generale"
SELECT nome_d, dipartimento, nome_corso
FROM docenti
JOIN corsi on docenti.cod_docente = corsi.cod_docente
where nome_corso in ('Basi di Dati e Sistemi Informativi', 'Informatica Generale');

-- 3. matricola e nome degli studenti di un corso di laurea triennale (tipoLaurea = 'L') che seguono un corso di un docente di nome Felice
WITH studenti_per_tipolaurea as(
	select s.nome_s, s.matricola, cdl.tipo_laurea
	from studenti as s
	join corsi_di_laurea as cdl on s.corso_laurea = cdl.corso_laurea
	where cdl.tipo_laurea = 'Laurea Triennale'
) 
select spt.matricola, spt.nome_s,d.nome_d
from studenti_per_tipolaurea as spt
join frequenta as f on spt.matricola = f.matricola
join corsi as c on f.cod_corso = c.cod_corso
join docenti as d on c.cod_docente = d.cod_docente
where d.nome_d = 'Felice Leoni';

-- 4. per ogni tipo per laurea, il tipoLaurea e l'etá media degli studenti
select cdl.tipo_laurea, round(avg(2024 - s.anno_n), 2) as eta_media
from corsi_di_laurea as cdl
join studenti as s on cdl.corso_laurea = s.corso_laurea
GROUP by cdl.tipo_laurea

-- 5. di ogni corso di un docente di nome Leoni. il codCorso e il numero degli studenti che lo frequentano
with corsi_prof_leoni as (
	select d.nome_d, c.cod_corso
	from docenti as d
	join corsi as c on d.cod_docente = c.cod_docente
	where d.nome_d = 'Felice Leoni'
)
select cpl.nome_d, cpl.cod_corso, count(s.matricola) as count_studenti
from corsi_prof_leoni as cpl
join frequenta as f on cpl.cod_corso = f.cod_corso
join studenti as s on f.matricola = s.matricola
group by cpl.cod_corso, cpl.nome_d;

-- 6. il codice dei corsi frequentati da piú di 5 studenti e tenuti da docenti del dipartimento di informatica
select c.cod_corso, c.nome_corso, count(s.matricola) as count_studenti
from docenti as d
join corsi as c on d.cod_docente = c.cod_docente
join frequenta as f on c.cod_corso = f.cod_corso
join studenti as s on f.matricola = s.matricola
where d.dipartimento = 'Informatica'
group by c.cod_corso
having count(s.matricola) > 5;

-- 7. Per ogni studente della facoltá di lettere e filosofia, la matricola ed il numero dei corsi seguiti
select s.nome_s, s.matricola, count(f. matricola) as numero_corsi_seguiti
from corsi_di_laurea as cdl
join studenti as s on s.corso_laurea = cdl.corso_laurea
join frequenta as f on s.matricola = f.matricola
where cdl.facolta = 'Lettere e Filosofia'
group by s.matricola

-- 8. matricola e nome degli studenti che non frequentano nessun corso
select s.matricola, s.nome_s
from studenti as s
where s.corso_laurea is null

-- 9. il codice ed il nome dei docenti dei corsi che non sono frequentati da nessuno studente
select d.cod_docente, d.nome_d
from docenti as d
join corsi as c on d.cod_docente = c.cod_docente
join frequenta as f on c.cod_corso = f.cod_corso
join studenti as s on f.matricola = s.matricola
where s.corso_laurea is null

-- 10. matricola e nome degli studenti che seguono solo corsi di docenti del dipartimento di storia
select s.matricola, s.nome_s, d.dipartimento
from docenti as d
join corsi as c on d.cod_docente = c.cod_docente
join frequenta as f on c.cod_corso = f.cod_corso
join studenti as s on f.matricola = s.matricola
where d.dipartimento = 'Storia'

-- 11. il codcorso dei corsi seguiti solo di studenti che appartengono al corso di laurea triennale in SBC102
select c.cod_corso, c.nome_corso
from corsi as c
join frequenta as f on c.cod_corso = f.cod_corso
join studenti as s on f.matricola = s.matricola
join corsi_di_laurea as cdl on s.corso_laurea = cdl.corso_laurea
where cdl.corso_laurea = 'SBC102' and cdl.tipo_laurea = 'Laurea Triennale'

-- funziona
select c.cod_corso, c.nome_corso
from corsi as c
where not exists(
	select *
	from frequenta as f
	join studenti as s on f.matricola = s.matricola
	join corsi_di_laurea as cdl on s.corso_laurea = cdl.corso_laurea
	where f.cod_corso = c.cod_corso and (cdl.tipo_laurea != 'Laurea Triennale' or s.corso_laurea != 'SBC102')
);

-- 12. nome e codice docente dei docenti che insegnano qualche corso seguito da piú di 5 studenti
select d.nome_d, d.cod_docente, c.nome_corso, count(s.matricola) as count_studenti
from docenti as d
join corsi as c on d.cod_docente = c.cod_docente
join frequenta as f on c.cod_corso = f.cod_corso
join studenti as s on f.matricola = s.matricola
group by d.cod_docente, c.nome_corso
having count(s.matricola) > 5;

-- 13. codice dei corsi che sono frequentati da tutti gli studenti del corsolaurea SBC102
select c.cod_corso, c.nome_corso, s.corso_laurea
from corsi as c
join frequenta as f on c.cod_corso = f.cod_corso
join studenti as s on f.matricola = s.matricola
where s.corso_laurea = 'SBC102'