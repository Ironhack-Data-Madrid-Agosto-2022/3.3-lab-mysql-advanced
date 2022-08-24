create temporary table Royalty
select  s.title_id as Title_ID , ta.au_id as Author_ID, (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as Royalty
from sales as s

left join titleauthor as ta
on s.title_id = ta.title_id

left join titles as t
on s.title_id=t.title_id
;

create temporary table Royalty_Title
select Title_ID, Author_ID, sum(Royalty) as Sum_Royalty
from Royalty
group by Title_ID, Author_ID
order by Sum_Royalty desc;

select Author_ID, sum(Sum_Royalty) as Royalty_Author
from Royalty_Title
group by Author_ID
order by Royalty_Author desc;
