-- CHALLENGE 1:
-- step 1:
select titles.title_id as 'Title ID', au_id as 'Author ID', titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as  sales_royalty
from titles
left join titleauthor
on titles.title_id= titleauthor.title_id
left join sales 
on titles.title_id= sales.title_id;

-- step 2:


select title_id, au_id, sum(sales_royalty) from
(select titles.title_id, au_id, titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as  sales_royalty
from titles
left join titleauthor
on titles.title_id= titleauthor.title_id
left join sales 
on titles.title_id= sales.title_id) as temp1
group by au_id,title_id ;



-- step 3:
select title_id, au_id, sales + advance as profit from
(select title_id, au_id, sum(sales_royalty) as sales , advance from
(select titles.title_id, au_id, titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as  sales_royalty, titles.advance
from titles
left join titleauthor
on titles.title_id= titleauthor.title_id
left join sales 
on titles.title_id= sales.title_id) as temp1
group by au_id,title_id) as temp2
group by au_id, title_id;

-- CREAR TABLA

create table most_profiting_authors (
 select au_id, sales + advance as profits from
(select title_id, au_id, sum(sales_royalty) as sales , advance from
(select titles.title_id, au_id, titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as  sales_royalty, titles.advance
from titles
left join titleauthor
on titles.title_id= titleauthor.title_id
left join sales 
on titles.title_id= sales.title_id) as temp1
group by au_id,title_id) as temp2
group by au_id, title_id);



