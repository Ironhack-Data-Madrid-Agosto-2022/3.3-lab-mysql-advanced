select temp2.Author_ID, sum(Sum_Royalty) as Sum_total
from
(select tmp_table.Author_ID, tmp_table.Title_id, sum(Royalty) as Sum_Royalty
from 
(select s.title_id as Title_ID , ta.au_id as Author_ID, (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as Royalty
from sales as s
left join titleauthor as ta
on s.title_id = ta.title_id
left join titles as t
on s.title_id=t.title_id) as tmp_table
group by tmp_table.Author_ID, tmp_table.Title_id
order by Sum_Royalty desc) as temp2
group by Author_ID
order by Sum_total desc
;

