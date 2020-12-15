use library;
SET SQL_SAFE_UPDATES = 0;

drop table if exists user_register;
create table user_register like user_library;
alter table user_register add change_time timestamp default current_timestamp;
alter table user_register add user_name varchar(50);
alter table user_register add action varchar(10);
alter table user_register add user_id int;

/*Task 2*/
drop trigger if exists check_login;

delimiter !!
create trigger check_login
before insert
on user_library for each row 
begin 
 if (new.login regexp '^[[:digit:]].*$' or length(new.login)<6) 
 then signal sqlstate "45000" 
 set message_text = "Your insert is invalid first symbol of login can't start on number and length of login must be more then 6";
 end if;
 end !!
 Delimiter ;


/*Task 3*/
drop trigger if exists check_rate;

delimiter !!
create trigger check_rate
before insert
on user_library for each row 
begin 
 if (new.rate >10 or new.rate<1) 
 then signal sqlstate "45000" 
 set message_text = "Your insert is invalid rate can be in [1,10]";
 end if;
 end !!
 Delimiter ;


/*Task 4*/
drop trigger if exists check_cardinality;

delimiter !!
create trigger check_cardinality
after delete
on user_library for each row 
begin 
 if (select count(*) from user_library)< 2
 then signal sqlstate "45000" 
 set message_text = "Your can't delete this row min cardinality is 2";
 end if;
 insert into user_register(user_id,login,surname,first_name,last_name,birthday_date,birthday_place,living_place,note,rate,password_id,user_name,action)  
 values (old.id,old.login,old.surname,old.first_name,old.last_name,
 old.birthday_date,old.birthday_place,old.living_place,old.note,old.rate,old.password_id,user(),"delete");
 end !!
 Delimiter ;


/*Logging user*/
drop trigger if exists log_insert;

delimiter !!
create trigger log_insert
after insert
on user_library for each row 
begin 
 insert into user_register(user_id,login,surname,first_name,last_name,birthday_date,birthday_place,living_place,note,rate,password_id,user_name,action)  
 values (new.id,new.login,new.surname,new.first_name,new.last_name,
 new.birthday_date,new.birthday_place,new.living_place,new.note,new.rate,new.password_id,user(),"insert");
 end !!
 Delimiter ;


drop trigger if exists log_update;

delimiter !!
create trigger log_update
after update
on user_library for each row 
begin 
 insert into user_register(user_id,login,surname,first_name,last_name,birthday_date,birthday_place,living_place,note,rate,password_id,user_name,action)  
 values (new.id,new.login,new.surname,new.first_name,new.last_name,
 new.birthday_date,new.birthday_place,new.living_place,new.note,new.rate,new.password_id,user(),"update");
 end !!
 Delimiter ;		

/*Task 1*/

/*User_library constraint*/
 drop trigger if exists user_integrity_delete;

delimiter !!
create trigger user_integrity_delete
before delete
on user_library for each row 
begin 
 delete  book_user from book_user where book_user.user_id=old.id;
 delete  confidental_info from confidental_info where confidental_info.id=old.password_id;
 end !!
 Delimiter ;
 
drop trigger if exists user_integrity_update;

delimiter !!
create trigger user_integrity_update
before update
on user_library for each row 
begin 
if old.password_id!=new.password.id 
then signal sqlstate "45000" 
 set message_text = "Your can't update password id";
 end if;
 end !!
 Delimiter ;
 
 /*Link constraint*/
 
drop trigger if exists link_integrity_insert;

delimiter !!
create trigger link_integrity_insert
before insert
on link for each row 
begin 
if (select  distinct id from book where book.id=new.book_id) is null 
then signal sqlstate "45000" 
 set message_text = "Your can't insert this row this book don't exist";
 end if;
 end !!
 Delimiter ;
 
 drop trigger if exists link_integrity_update;

delimiter !!
create trigger link_integrity_update
before update
on link for each row 
begin 
if (select  distinct id from book where book.id=new.book_id) is null 
then signal sqlstate "45000" 
 set message_text = "Your can't update this row this book don't exist";
 end if;
 end !!
 Delimiter ;
 
 /*Password constraint*/
  drop trigger if exists password_integrity_delete;
 
 delimiter !!
create trigger password_integrity_delete
before delete
on confidental_info for each row 
begin 
 signal sqlstate "45000" 
 set message_text = "Your can't delete this password";
 end !!
 Delimiter ;
 
 
 /*Book constraint*/
 drop trigger if exists book_integrity_delete;
 
delimiter !!
create trigger book_integrity_delete
before delete
on book for each row 
begin 
delete from link where link.book_id=old.id;
delete from book_user where book_user.book_id = old.id;
end !!
Delimiter ;
 
 /*Tree catalog*/
  drop trigger if exists catalog_integrity_delete;
  
 delimiter !!
create trigger catalog_integrity_delete
before delete
on catalog for each row 
begin 
update  book set book.YDK = Null  where book.YDK = old.id;
end !!
Delimiter ;
 
 /*Book-User constraint*/
drop trigger if exists book_user_integrity_insert;
  
 delimiter !!
create trigger book_user_integrity_insert
before insert
on book_user for each row 
begin 
if (select distinct id from book where book.id=new.book_id) is Null
then  signal sqlstate "45000" 
 set message_text = "Your can't insert this book_id it not exist";
end if;
if (select distinct id from user_library where user_library.id=new.user_id) is Null
then  signal sqlstate "45000" 
 set message_text = "Your can't insert this user_id it not exist";
end if;
end !!
Delimiter ;
 
 
 drop trigger if exists book_user_integrity_update;
  
 delimiter !!
create trigger book_user_integrity_update
before update
on book_user for each row 
begin 
if old.book_id!=new.book_id and (select distinct id from book where book.id=new.book_id) is Null
then  signal sqlstate "45000" 
 set message_text = "Your can't update to this book_id it not exist";
end if;
if old.user_id!=new.user_id and (select distinct id from user_library where user_library.id=new.user_id) is Null
then  signal sqlstate "45000" 
 set message_text = "Your can't update to this user_id it not exist";
end if;
end !!
Delimiter ;
 
 