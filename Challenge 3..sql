create table if not exists lab2
select au_id, tabla.advance + sum(tabla.total_royal) as ganancias
from 
(select temp.title_id, temp.au_id, temp.advance, sum(sales_royalty) as total_royal
from
(select ti.title_id, a.au_id, ti.advance, ti.price * sa.qty * ti.royalty / 100 * t.royaltyper / 100 as sales_royalty
from titleauthor as t
left join authors as a
on t.au_id=a.au_id
left join titles as ti
on t.title_id = ti.title_id
left join sales as sa
on ti.title_id=sa.title_id
order by sales_royalty desc)as temp
group by temp.au_id, temp.title_id) as tabla
group by tabla.au_id
order by ganancias desc