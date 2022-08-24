-- Ejercicio 1 --

SELECT t.title_id as title_id, ta.au_id, t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100
FROM titles as t

LEFT JOIN titleauthor as ta
ON t.title_id = ta.title_id

LEFT JOIN sales as s
ON t.title_id = s.title_id;

-- Ejercicio 2 --


SELECT title_id, au_id, sum(royalty) as "Roy per Author"
FROM

(SELECT t.title_id as title_id, ta.au_id, t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 as royalty
FROM titles as t

LEFT JOIN titleauthor as ta
ON t.title_id = ta.title_id

LEFT JOIN sales as s
ON t.title_id = s.title_id) as roy_total

GROUP BY au_id , title_id
;

-- Ejercicio 3 --

SELECT au_id, sum(total_a_t) AS pasta
FROM

(SELECT title_id, au_id, sum(royalty) as total_a_t
FROM

(SELECT t.title_id as title_id, ta.au_id, t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 as royalty
FROM titles as t

LEFT JOIN titleauthor as ta
ON t.title_id = ta.title_id

LEFT JOIN sales as s
ON t.title_id = s.title_id) as tabla1

GROUP BY au_id , title_id) as tabla2

GROUP BY au_id
;
