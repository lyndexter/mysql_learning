use library;

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


/*Task 1*/
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

