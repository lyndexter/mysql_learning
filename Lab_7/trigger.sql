use library;


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
drop trigger if exists check_rate;

delimiter !!
create trigger check_rate
after delete
on user_library for each row 
begin 
 if (select count(*) from user_library)< 2
 then signal sqlstate "45000" 
 set message_text = "Your can't delete this row min cardinality is 2";
 end if;
 end !!
 Delimiter ;

