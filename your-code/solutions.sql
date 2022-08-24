# Challenge 1

select  c2.au_id, c2.advance+c2.royalty as 'profit'
from
#step 2
(select title_id, au_id, sum(sales_royalty) as 'royalty' , c1.advance as 'advance'
from 
#step 1
(select ts.title_id, ta.au_id, sa.qty * ts.price *ts.royalty/100 * ta.royaltyper/100 as 'sales_royalty', ts.advance
from titles as ts

left join titleauthor as ta
on ts.title_id = ta.title_id

left join sales as sa
on ts.title_id = sa.title_id) 
as c1

group by c1.au_id, c1.title_id) 
as c2

left join titles as ts
on c2.title_id = ts.advance

group by c2.au_id
order by profit desc
limit 3 ;

#Challenge 2

create table ct1
select ts.title_id, ta.au_id, sa.qty * ts.price *ts.royalty/100 * ta.royaltyper/100 as 'sales_royalty', ts.advance
from titles as ts

left join titleauthor as ta
on ts.title_id = ta.title_id

left join sales as sa
on ts.title_id = sa.title_id;

create table ct2
select title_id, au_id, sum(sales_royalty) as 'royalty' , ct1.advance as 'advance'
from ct1
group by ct1.au_id, ct1.title_id;

select  ct2.au_id, ct2.advance+ct2.royalty as 'profit'
from ct2

left join titles as ts
on ct2.title_id = ts.advance

group by ct2.au_id
order by profit desc
limit 3 ;

# Challenge 3

create table if not exists most_profiting_authors
select  c2.au_id, c2.advance+c2.royalty as 'profit'
from 
(select title_id, au_id, sum(sales_royalty) as 'royalty' , c1.advance as 'advance'
from 
#step 1
(select ts.title_id, ta.au_id, sa.qty * ts.price *ts.royalty/100 * ta.royaltyper/100 as 'sales_royalty', ts.advance
from titles as ts

left join titleauthor as ta
on ts.title_id = ta.title_id

left join sales as sa
on ts.title_id = sa.title_id) 
as c1

group by c1.au_id, c1.title_id) 
as c2

group by c2.au_id
order by profit desc


