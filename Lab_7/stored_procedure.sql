/*Task 1*/
drop procedure if exists insert_into_user;

Delimiter !!
create procedure insert_into_user(
in login varchar(20),
 surname  varchar(20),
 first_name  varchar(20),
 last_name  varchar(20),
 birthday_date  varchar(20),
 birthday_place  varchar(50),
 living_place  varchar(50),
 note  varchar(100),
 rate  int,
 password  varchar(20)
 )
begin 
insert into user_library(login,surname,first_name,last_name,birthday_date,birthday_place,living_place,note,rate)
values (login,surname,first_name,last_name,birthday_date,birthday_place,living_place,note,rate);
insert into confidental_info(password_text)
values (password);

end!!
delimiter ;


/* Task 2*/

drop procedure if exists print_book_user;

Delimiter !!
create procedure print_book_user(
in book_parameter varchar(20)
 )
begin 

select book_name,first_name,surname 
from book left join book_user on book.id = book_user.book_id
right join user_library on book_user.user_id=user_library.id
where book_parameter="" or book_parameter=book_name ;

end!!
delimiter ;


/* Task 3*/
drop procedure if exists create_copy_book;

Delimiter !!
create procedure create_copy_book()
begin 


declare book_nameT,authorT varchar(30);
declare idT,YDKT,rateT int;
DECLARE run int DEFAULT true;

declare book_cursor cursor
for select * from book;
declare continue handler
for not found set run=false;

drop table if exists book_1;
drop table if exists book_2;
create table book_1 like book;
create table book_2 like book;
alter table book_1 add time_copy timestamp DEFAULT CURRENT_TIMESTAMP;
alter table book_2 add time_copy timestamp DEFAULT CURRENT_TIMESTAMP;

open book_cursor;
label1: while  True Do
	Fetch next from book_cursor into idT, book_nameT,authorT,YDKT,rateT;
    if run = false then leave label1;
    end if;
    if rand()>0.5 then insert into book_1(id, book_name,author,YDK,rate) values (idT, book_nameT,authorT,YDKT,rateT);
    else insert into book_2(id, book_name,author,YDK,rate) values (idT, book_nameT,authorT,YDKT,rateT);
    end if;
end while;
CLOSE book_cursor;
end!!
delimiter ;

