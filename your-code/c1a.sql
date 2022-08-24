select  s.title_id as Title_ID , ta.au_id as Author_ID, (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as Royalty
from sales as s

left join titleauthor as ta
on s.title_id = ta.title_id

left join titles as t
on s.title_id=t.title_id
;

