-- Challenge 1 - Most Profiting Authors --


-- Step 1: Calculate the royalties of each sales for each author
select sales.title_id, titleauthor.au_id, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) 
as sales_royalty from sales 
join  titleauthor on sales.title_id = titleauthor.title_id
join  titles on titleauthor.title_id = titles.title_id
;
-- Step 2: Aggregate the total royalties for each title for each author
create temporary table royalty_table
as (select sales.title_id, titleauthor.au_id,  (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) 
as sales_royalty 
from sales 
join titleauthor on sales.title_id = titleauthor.title_id
join titles on titleauthor.title_id = titles.title_id);

Select title_id, au_id, sum(sales_royalty) as royaleties  from royalty_table
group by title_id, au_id;

-- Step 3: Calculate the total profits of each author

CREATE TEMPORARY TABLE author_profits
as (Select title_id, au_id, sum(sales_royalty) as Agg_royalties  
from royalty_table
group by title_id, au_id);

Select a.*, b.advance, (Agg_royalties+advance) as Profits from author_profits a
join titles b on a.title_id=b.title_id
order by Profits desc
limit 3;
-- Challenge 2 -Alternative Solution --
-- Create temporary table publications.royalties_authors

-- Challenge 3