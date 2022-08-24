
-- ejercicio 1
select escritor, sum(suma_sq2)  from

(select titulo, escritor, sum(sales_royalty) as suma_sq2 from 

(select s.ord_num, t.title as titulo, t.royalty, s.qty, t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 as sales_royalty, a.au_id as escritor
from sales as s 

left join titles as t
on t.title_id=s.title_id

left join titleauthor as ta
on t.title_id=ta.title_id

left join authors as a
on ta.au_id=a.au_id) as ry

group by titulo, escritor) as sq2

group by escritor;

-- ejercicio 2

create temporary table rollalties
select s.ord_num, t.title as titulo, t.royalty, s.qty, t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 as sales_royalty, a.au_id as escritor
from sales as s 

left join titles as t
on t.title_id=s.title_id

left join titleauthor as ta
on t.title_id=ta.title_id

left join authors as a
on ta.au_id=a.au_id;

select roll.escritor, sum(sales_royalty) as agg_royalties

 from rollalties as roll 
 
 group by roll.escritor;
 
 -- ejercicio 3
 
 create table tabla_resumen
select roll.escritor, sum(sales_royalty) as agg_royalties

 from rollalties as roll 
 
 group by roll.escritor;

