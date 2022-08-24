-- Challenge 1 - Most Profiting Authors

-- Step 1

select t.title_id,ta.au_id,t.advance, t.price * sa.qty * t.royalty / 100 * ta.royaltyper / 100 as sales_royalties
from sales as sa
left join titles as t on sa.title_id = t.title_id
left join titleauthor as ta on t.title_id = ta.title_id;

--Step 2

select subq.title_id, subq.au_id, subq.advance, sum(sales_royalties) as royalties
from
(select t.title_id,ta.au_id, t.advance, t.price * sa.qty * t.royalty / 100 * ta.royaltyper / 100 as sales_royalties
from sales as sa
left join titles as t on sa.title_id = t.title_id
left join titleauthor as ta on t.title_id = ta.title_id) as subq
group by au_id, title_id
order by royalties desc;

--Step 3

select subq2.au_id, subq2.advance + royalties as profit
from
(select subq.title_id, subq.au_id, subq.advance, sum(sales_royalties) as royalties
from
(select t.title_id,ta.au_id, t.advance, t.price * sa.qty * t.royalty / 100 * ta.royaltyper / 100 as sales_royalties
from sales as sa
left join titles as t on sa.title_id = t.title_id
left join titleauthor as ta on t.title_id = ta.title_id) as subq
group by au_id, title_id
order by royalties desc) as subq2
group by au_id, title_id
order by profit desc
limit 3;


-- Challenge 2 - Alternative Solution

create temporary table publications.lab3

select subq2.au_id, subq2.advance + royalties as profit
from
(select subq.title_id, subq.au_id, subq.advance, sum(sales_royalties) as royalties
from
(select t.title_id,ta.au_id, t.advance, t.price * sa.qty * t.royalty / 100 * ta.royaltyper / 100 as sales_royalties
from sales as sa
left join titles as t on sa.title_id = t.title_id
left join titleauthor as ta on t.title_id = ta.title_id) as subq
group by au_id, title_id
order by royalties desc) as subq2
group by au_id, title_id
order by profit desc
limit 3;



-- Challenge 3

create table if not exists most_profiting_authors

select subq2.au_id, subq2.advance + royalties as profit
from
(select subq.title_id, subq.au_id, subq.advance, sum(sales_royalties) as royalties
from
(select t.title_id,ta.au_id, t.advance, t.price * sa.qty * t.royalty / 100 * ta.royaltyper / 100 as sales_royalties
from sales as sa
left join titles as t on sa.title_id = t.title_id
left join titleauthor as ta on t.title_id = ta.title_id) as subq
group by au_id, title_id
order by royalties desc) as subq2
group by au_id, title_id
order by profit desc
limit 3;
