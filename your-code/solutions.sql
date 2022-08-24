--1.1
select titles.title_id, titleauthor.au_id, titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as sales_royalty
from titles

left join titleauthor
on titles.title_id = titleauthor.title_id

left join sales
on titles.title_id = sales.title_id;

--1.2

select tmp1.au_id, tmp1.title_id, sum(sales_royalty) as total_royalties
from
(select titles.title_id, titleauthor.au_id, titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as sales_royalty
from titles

left join titleauthor
on titles.title_id = titleauthor.title_id

left join sales
on titles.title_id = sales.title_id) as tmp1

group by tmp1.au_id, tmp1.title_id;

--1.3

select tmp2.au_id, sum(total_royalties)
from
(select tmp1.au_id, tmp1.title_id, sum(sales_royalty) as total_royalties
from
(select titles.title_id, titleauthor.au_id, titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as sales_royalty
from titles

left join titleauthor
on titles.title_id = titleauthor.title_id

left join sales
on titles.title_id = sales.title_id) as tmp1

group by tmp1.au_id, tmp1.title_id) as tmp2

group by tmp2.au_id;

--2

select  a.au_id, sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) + t.advance as TOTAL
from titles as t
left join titleauthor as ta
on t.title_id = ta.title_id
left join authors as a
on ta.au_id = a.au_id
left join sales as s
on s.title_id = t.title_id
group by a.au_id;

--3

create table most_profiting_authors
select  a.au_id, sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) + t.advance as profits
from titles as t
left join titleauthor as ta
on t.title_id = ta.title_id
left join authors as a
on ta.au_id = a.au_id
left join sales as s
on s.title_id = t.title_id
group by a.au_id;


