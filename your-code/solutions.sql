----------------------------------------------
#                CHALLENGE 1
----------------------------------------------

SELECT *
FROM authors

left join titleauthor
on authors.au_id=titleauthor.au_id

left join titles
on titleauthor.title_id=titles.title_id

left join sales
on titles.title_id=sales.title_id
;

----------------------------------------------
#STEP 1
----------------------------------------------
SELECT 
	titles.title_id  as Title_ID,
    authors.au_id as Author_ID,
    titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as sales_royalty
FROM authors

inner join titleauthor
on authors.au_id=titleauthor.au_id

inner join titles
on titleauthor.title_id=titles.title_id

inner join sales
on titles.title_id=sales.title_id
;

----------------------------------------------
#STEP 2
----------------------------------------------
SELECT 
	Title_ID,
    Author_ID,
    sum(sales_royalty) as Agregated_sales_royalty

FROM
(SELECT 
	titles.title_id  as Title_ID,
    authors.au_id as Author_ID,
    titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as sales_royalty
    
FROM authors

inner join titleauthor
on authors.au_id=titleauthor.au_id

inner join titles
on titleauthor.title_id=titles.title_id

inner join sales
on titles.title_id=sales.title_id) as tabla

GROUP BY Author_ID, Title_ID
;

----------------------------------------------
#STEP 3
----------------------------------------------

SELECT 
	Author_ID,
    sum(Agregated_sales_royalty) as Total_profits

FROM
(SELECT 
	Title_ID,
    Author_ID,
    sum(sales_royalty) as Agregated_sales_royalty

FROM
(SELECT 
	titles.title_id  as Title_ID,
    authors.au_id as Author_ID,
    titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as sales_royalty
    
    
FROM authors

inner join titleauthor
on authors.au_id=titleauthor.au_id

inner join titles
on titleauthor.title_id=titles.title_id

inner join sales
on titles.title_id=sales.title_id) as tabla

GROUP BY Author_ID, Title_ID) as tabla2

GROUP BY Author_ID
;

----------------------------------------------
#                CHALLENGE 2
----------------------------------------------

----------------------------------------------
#STEP 1
----------------------------------------------
CREATE TEMPORARY TABLE publications.step1
SELECT 
	titles.title_id  as Title_ID,
    authors.au_id as Author_ID,
    titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as sales_royalty
FROM authors

left join titleauthor
on authors.au_id=titleauthor.au_id

left join titles
on titleauthor.title_id=titles.title_id

left join sales
on titles.title_id=sales.title_id
;

----------------------------------------------
#STEP 2
----------------------------------------------
CREATE TEMPORARY TABLE publications.step2
SELECT 
	Title_ID,
    Author_ID,
    sum(sales_royalty) as Agregated_sales_royalty
FROM step1
GROUP BY Author_ID, Title_ID
;

----------------------------------------------
#STEP 3
----------------------------------------------
CREATE TEMPORARY TABLE publications.step3
SELECT 
	Author_ID,
    sum(Agregated_sales_royalty) as Total_profits

FROM step2
GROUP BY Author_ID
;

----------------------------------------------
#                CHALLENGE 3
----------------------------------------------

CREATE TABLE most_profiting_authors
SELECT 
	Author_ID as au_id,
    Total_profits as profits
FROM step3;

