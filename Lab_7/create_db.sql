create database if not exists Library;
use Library;

drop table if exists book_user;
drop table if exists book;
drop table if exists link;
drop table if exists confidental_info;
drop table if exists user_library;
drop table if exists catalog;


create table user_library(
id int primary key auto_increment,
login varchar(20),
surname varchar(20),
first_name varchar(20),
last_name varchar(20),
birthday_date varchar(20),
birthday_place varchar(50),
living_place varchar(50),
note varchar(200),
rate int,
password_id int
);

create table confidental_info(
id int primary key auto_increment,
password_text varchar(20)
);

create table book(
id int primary key auto_increment,
book_name varchar(30),
author varchar(30),
YDK int,
rate int
);

create table link(
id int primary key auto_increment,
book_url varchar(100),
book_id int
);

create table book_user(
id int primary key auto_increment,
book_id int,
user_id int
);

create table catalog(
id int primary key auto_increment,
heading varchar(20),
root_catalog_id int
);

