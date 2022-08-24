create table most_profiting_authors
select Author_ID, sum(Sum_Royalty) as Royalty_Author
from Royalty_Title
group by Author_ID
order by Royalty_Author desc;
