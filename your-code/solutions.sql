select sales.title_id, au_id, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
from sales
left join titles
on sales.title_id = titles.title_id
left join titleauthor
on sales.title_id = titleauthor.title_id
order by sales_royalty desc;

select temp.title_id, temp.au_id, sum(sales_royalty) as ventas from
(select sales.title_id, au_id, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
from sales
left join titles
on sales.title_id = titles.title_id
left join titleauthor
on sales.title_id = titleauthor.title_id
order by sales_royalty desc) as temp
group by temp.au_id, temp.title_id
order by ventas desc;

select temp2.title_id, temp2.au_id, sum(ventas) as total from 
(select temp.title_id, temp.au_id, sum(sales_royalty) as ventas from
(select sales.title_id, au_id, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
from sales
left join titles
on sales.title_id = titles.title_id
left join titleauthor
on sales.title_id = titleauthor.title_id
order by sales_royalty desc) as temp
group by temp.au_id, temp.title_id
order by ventas desc) as temp2
group by temp2.au_id
order by total desc;

create temporary table royalties
select sales.title_id, au_id, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
from sales
left join titles
on sales.title_id = titles.title_id
left join titleauthor
on sales.title_id = titleauthor.title_id
order by sales_royalty desc;

select * from royalties;

select royalties.title_id, royalties.au_id, sum(royalties.sales_royalty) as ventas 
from royalties
group by royalties.au_id, royalties.title_id
order by ventas desc;

select royalties.title_id, royalties.au_id, sum(royalties.sales_royalty) as total 
from royalties
group by royalties.au_id
order by total desc;

create table if not exists most_profiting_authors
(select royalties.au_id, sum(royalties.sales_royalty) as total 
from royalties
group by royalties.au_id
order by total desc);




select * from most_profiting_authors;