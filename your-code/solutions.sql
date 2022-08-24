-- CHALLENGE 1 --
-- Step 1 --
SELECT 
	s.title_id,
    t.au_id,
    titles.price * s.qty * titles.royalty / 100 * t.royaltyper / 100 as sales_royalty
FROM sales AS s
LEFT JOIN titleauthor AS t ON t.title_id = s.title_id
LEFT JOIN titles ON titles.title_id = t.title_id;

-- Step 2 --
SELECT 
	subTabla.title_id,
	subTabla.au_id,
    sum(subTabla.sales_royalty)
    FROM (SELECT 
			s.title_id,
			t.au_id,
			titles.price * s.qty * titles.royalty / 100 * t.royaltyper / 100 as sales_royalty
			FROM sales AS s
			LEFT JOIN titleauthor AS t ON t.title_id = s.title_id
			LEFT JOIN titles ON titles.title_id = t.title_id) as subTabla
	GROUP BY subTabla.title_id, subTabla.au_id
    
-- Step 3 --
SELECT 
	subSub.au_id,
    subSub.sumRoyalty + subSub.advance as prof_authors
	FROM (SELECT 
			subTabla.title_id,
			subTabla.au_id,
			sum(subTabla.sales_royalty) as sumRoyalty,
            subTabla.advance
			FROM (SELECT 
					s.title_id,
					t.au_id,
					titles.price * s.qty * titles.royalty / 100 * t.royaltyper / 100 as sales_royalty,
                    titles.advance
					FROM sales AS s
					LEFT JOIN titleauthor AS t ON t.title_id = s.title_id
					LEFT JOIN titles ON titles.title_id = t.title_id) as subTabla
			GROUP BY subTabla.title_id, subTabla.au_id) as subSub
	ORDER BY prof_authors DESC LIMIT 3
    
    
    
-- CHALLENGE 2 --
-- Step 1 --
CREATE TEMPORARY TABLE publications.temp1
SELECT 
	s.title_id,
    t.au_id,
    titles.price * s.qty * titles.royalty / 100 * t.royaltyper / 100 as sales_royalty
FROM sales AS s
LEFT JOIN titleauthor AS t ON t.title_id = s.title_id
LEFT JOIN titles ON titles.title_id = t.title_id;

-- Step 2 -- 
CREATE TEMPORARY TABLE publications.temp2
SELECT 
	temp1.title_id,
	temp1.au_id,
    sum(temp1.sales_royalty) as sumRoyalty
    FROM temp1
	GROUP BY temp1.title_id, temp1.au_id

-- Step 3 -- 
SELECT
	temp2.au_id,
    temp2.sumRoyalty + titles.advance as prof_authors
	FROM temp2
    left join titles on titles.title_id = temp2.title_id
	ORDER BY prof_authors DESC LIMIT 3



-- CHALLENGE 3 --

CREATE TABLE most_profiting_authors
SELECT 
	subSub.au_id as au_id,
    subSub.sumRoyalty + subSub.advance as profits
	FROM (SELECT 
			subTabla.title_id,
			subTabla.au_id,
			sum(subTabla.sales_royalty) as sumRoyalty,
            subTabla.advance
			FROM (SELECT 
					s.title_id,
					t.au_id,
					titles.price * s.qty * titles.royalty / 100 * t.royaltyper / 100 as sales_royalty,
                    titles.advance
					FROM sales AS s
					LEFT JOIN titleauthor AS t ON t.title_id = s.title_id
					LEFT JOIN titles ON titles.title_id = t.title_id) as subTabla
			GROUP BY subTabla.title_id, subTabla.au_id) as subSub
	ORDER BY profits DESC LIMIT 3