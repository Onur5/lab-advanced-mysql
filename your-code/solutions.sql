-- Challenge 1
-- step 1
select authors.au_id, titles.title_id, (qty*price*(royalty/100)*(royaltyper/100)) AS sales_royalty from authors
join titleauthor
on authors.au_id = titleauthor.au_id
join titles
on titleauthor.title_id=titles.title_id
join publishers
on titles.pub_id= publishers.pub_id
join sales
on titles.title_id = sales.title_id
ORDER BY sales_royalty DESC;

-- step 2
select authors.au_id, titles.title_id, sum(qty*price*(royalty/100)*(royaltyper/100)) AS sales_royalty from authors
join titleauthor
on authors.au_id = titleauthor.au_id
join titles
on titleauthor.title_id=titles.title_id
join publishers
on titles.pub_id= publishers.pub_id
join sales
on titles.title_id = sales.title_id
GROUP BY authors.au_id, titles.title_id
ORDER BY sales_royalty DESC;

-- step 3
select authors.au_id, (total_royalty+(advance*(royalty/100)*(royaltyper/100))) as profit from (
	select authors.au_id, titles.title_id, sum(qty*price*(royalty/100)*(royaltyper/100)) AS total_royalty from authors
	join titleauthor
	on authors.au_id = titleauthor.au_id
	join titles
	on titleauthor.title_id=titles.title_id
	join publishers
	on titles.pub_id= publishers.pub_id
	join sales
	on titles.title_id = sales.title_id
	GROUP BY authors.au_id, titles.title_id
	ORDER BY total_royalty DESC) step2
GROUP BY authors.au_id
ORDER BY profit DESC;

-- Challenge 2
Create temporary table step2
	select authors.au_id, titles.title_id, sum(qty*price*(royalty/100)*(royaltyper/100)) AS total_royalty from authors
	join titleauthor
	on authors.au_id = titleauthor.au_id
	join titles
	on titleauthor.title_id=titles.title_id
	join publishers
	on titles.pub_id= publishers.pub_id
	join sales
	on titles.title_id = sales.title_id
	GROUP BY authors.au_id, titles.title_id
	ORDER BY total_royalty DESC;
    
    select authors.au_id, (total_royalty+(advance*(royalty/100)*(royaltyper/100))) as profit from step2
    GROUP BY authors.au_id
	ORDER BY profit DESC;
    
-- Challenge 3
create table [if not exists] profits(
au_id int AUTO_INCREMENT,
profit varchar(255) NOT NULL,
PRIMARY KEY (task_id)
)  ENGINE=INNODB;