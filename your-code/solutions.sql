SELECT t.title,p.pub_name as PUBLISHER,a.au_id as AUTHORID,a.au_lname,a.au_fname,r.royalty
FROM titles as t
LEFT JOIN publishers as p
ON t.pub_id = p.pub_id
LEFT JOIN titleauthor as ta
ON t.title_id = ta.title_id
LEFT JOIN authors as a
ON a.au_id = ta.au_id
LEFT JOIN roysched as r
ON r.title_id = ta.title_id;



SELECT t.title_id,
ta.au_id,
t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 as royalty
FROM titles as t
LEFT JOIN titleauthor as ta
ON ta.title_id = t.title_id
LEFT JOIN sales as s
ON t.title_id = s.title_id;



SELECT title_id,au_id,SUM(royalty) AS total_royal
FROM (SELECT t.title_id,
ta.au_id,
t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 as royalty
FROM titles as t
LEFT JOIN titleauthor as ta
ON ta.title_id = t.title_id
LEFT JOIN sales as s
ON t.title_id = s.title_id) AS total_royalties 
GROUP BY ta.au_id,t.title_id;


SELECT au_id, sum(total_royal) AS profit
FROM
(SELECT title_id, au_id, sum(royalty) as total_royal
FROM
(SELECT t.title_id as title_id, ta.au_id, t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 as royalty
FROM titles as t
LEFT JOIN titleauthor as ta
ON t.title_id = ta.title_id
LEFT JOIN sales as s
ON t.title_id = s.title_id) as rol
GROUP BY au_id , title_id) as total
GROUP BY au_id
            








CREATE TABLE most_profiting_authors

SELECT au_id, sum(total_a_t) AS profit
FROM
(SELECT title_id, au_id, sum(royalty) as total_a_t
FROM
(SELECT t.title_id as title_id, ta.au_id, t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 as royalty
FROM titles as t
LEFT JOIN titleauthor as ta
ON t.title_id = ta.title_id
LEFT JOIN sales as s
ON t.title_id = s.title_id) as rol
GROUP BY au_id , title_id) as total
GROUP BY au_id