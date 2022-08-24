-- ejercicio 1

	select escritor, sum(suma_sq2+ adv) as profits  from

	(select  adv, titulo, escritor, sum(sales_royalty) as suma_sq2 from 

	(select  t.advance as adv, s.ord_num, t.title as titulo, t.royalty, s.qty, t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 as sales_royalty, a.au_id as escritor
	from sales as s 

	left join titles as t
	on t.title_id=s.title_id

	left join titleauthor as ta
	on t.title_id=ta.title_id

	left join authors as a
	on ta.au_id=a.au_id) as ry

	group by titulo, escritor)  as sq2

	group by escritor

	order by profits desc;


-- ejercicio 2
	-- instancia 1
	create temporary table sales_royalty

	select  t.advance as adv, s.ord_num, t.title as titulo, t.royalty, s.qty, t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 as sales_royalty, a.au_id as escritor
	from sales as s 

	left join titles as t
	on t.title_id=s.title_id

	left join titleauthor as ta
	on t.title_id=ta.title_id

	left join authors as a
	on ta.au_id=a.au_id;
	-- instancia 2
	create temporary table royalties

	select sum(sales_royalty) as royalties, escritor, titulo, adv

	from sales_royalty

	group by  escritor, titulo;
	-- instancia 3
	select escritor, sum(royalties+adv) as profit from royalties group by escritor order by profit asc
    
-- ejercicio 3
	-- instancia 3 anterior modificada- crear la tabla permanente
    create table most_profiting_authors
	select escritor, sum(royalties+adv) as profit from royalties group by escritor order by profit asc
    
    
