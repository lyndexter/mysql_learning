/*Task 1*/
drop function if exists get_abbreviation;

Delimiter !!
create function get_abbreviation(
idT int
 ) returns varchar(30)
 deterministic
begin 
return (select  concat(substring(surname,1,1),substring(first_name,1,1),substring(last_name,1,1)) from user_library where user_library.id=idT);
end!!
delimiter ;
 
 
 /*Task 2*/
drop function if exists get_name_and_author;

Delimiter !!
create function get_name_and_author(
book_idT int
 ) returns varchar(30)
 deterministic
begin 

return (select concat( group_concat(book_name Separator ", "),group_concat(author  Separator ", ")) 
from book left join link on book.id=link.book_id 
where book.id=book_idT
group by book.id);
end!!
delimiter ;
 
 select get_name_and_author(book.id) from book;


 /*Task 2*/
drop function if exists get_name_and_author;

Delimiter !!
create function get_book_name_author(
link_id int
 ) returns varchar(30)
 deterministic
begin 

return (select concat( book_name,", " ,author )
from book left join link on book.id=link.book_id 
where link.id=link_id);
end!!
delimiter ;

select get_book_name_author(link.id) from link
