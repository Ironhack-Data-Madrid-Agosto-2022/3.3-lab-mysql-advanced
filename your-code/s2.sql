select total_royalty.title_id, total_royalty.au_id, sum(sales_royalty)
from
(select t.title_id, ti.au_id, t.price * s.qty * t.royalty / 100 * ti.royaltyper / 100 as sales_royalty
from sales as s
left join titles as t
on s.title_id=t.title_id

left join titleauthor as ti
on t.title_id=ti.title_id
) as total_royalty
group by au_id, title_id
order by sales_royalty desc
;


