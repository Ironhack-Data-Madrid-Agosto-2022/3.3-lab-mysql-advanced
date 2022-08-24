select 
ta.title_id as TitleID,
au_id as AuthorID,
(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as RoyaltyOfEachSaleOfAuthor
from sales as s
left join titleauthor as ta on s.title_id = ta.title_id
left join titles as t on ta.title_id = t.title_id
order by RoyaltyOfEachSaleOfAuthor desc ;


select subQ.TitleID, subQ.AuthorID, sum(RoyaltyOfEachSaleOfAuthor) as royalties
from
(select 
ta.title_id as TitleID,
 au_id as AuthorID,
 (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as RoyaltyOfEachSaleOfAuthor
from sales as s
left join titleauthor as ta on s.title_id = ta.title_id
left join titles as t on ta.title_id = t.title_id) as subQ
group by AuthorId, TitleID;


select subQ2.AuthorID, sum(royalties) as profit
from
(select subQ.TitleID, subQ.AuthorID, sum(RoyaltyOfEachSaleOfAuthor) as royalties
from
(select 
ta.title_id as TitleID,
 au_id as AuthorID,
 (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as RoyaltyOfEachSaleOfAuthor
from sales as s
left join titleauthor as ta on s.title_id = ta.title_id
left join titles as t on ta.title_id = t.title_id) as subQ
group by AuthorId, TitleID) as subQ2
group by AuthorId


create temporary table profits_total
select subQ2.AuthorID, sum(royalties) as profit
from
(select subQ.TitleID, subQ.AuthorID, sum(RoyaltyOfEachSaleOfAuthor) as royalties
from
(select 
ta.title_id as TitleID,
 au_id as AuthorID,
 (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as RoyaltyOfEachSaleOfAuthor
from sales as s
left join titleauthor as ta on s.title_id = ta.title_id
left join titles as t on ta.title_id = t.title_id) as subQ
group by AuthorId, TitleID) as subQ2
group by AuthorId;


create table most_profiting_authors
select subQ2.AuthorID, sum(royalties) as profit
from
(select subQ.TitleID, subQ.AuthorID, sum(RoyaltyOfEachSaleOfAuthor) as royalties
from
(select 
ta.title_id as TitleID,
 au_id as AuthorID,
 (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as RoyaltyOfEachSaleOfAuthor
from sales as s
left join titleauthor as ta on s.title_id = ta.title_id
left join titles as t on ta.title_id = t.title_id) as subQ
group by AuthorId, TitleID) as subQ2
group by AuthorId