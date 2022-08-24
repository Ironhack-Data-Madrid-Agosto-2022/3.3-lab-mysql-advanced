select titleid, authorid, sum(sales_royalty) as agregate

from

(Select (t.price * sa.qty * t.royalty / 100 * ta.royaltyper / 100) as 'sales_royalty', a.au_id as 'authorid', t.title_id as 'titleid', t.royalty, t.advance as 'advance1'
from authors as a

left join titleauthor as ta
on a.au_id = ta.au_id

left join titles as t
on ta.title_id = t.title_id

left join sales as sa
on t.title_id = sa.title_id) as table1

group by authorid and titleid
