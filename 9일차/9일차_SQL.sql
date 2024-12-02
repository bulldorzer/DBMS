/*테이블생성 4개*/
create table user_info (
	user_id 		varchar(100)	not null,
	user_passwd		varchar(100)	not null,
	contact_id		varchar(100)	not null,
	user_role		varchar(10)		not null,
	user_pos		varchar(10)		not null,
	primary key(user_id)
)
/*보통 innodb로 설정 잡음*/
engine='INNODB'
/*문자코드 설정*/
default charset='utf8mb4' 
/* 문자기준 정립 A-Z a-z 순으로 정렬되며 대소문자로 순서 구분하지 않음*/
collate='utf8mb4_general_ci'; 

use class_db;
drop table if exists user_info;

create table contacts(
	contact_id	varchar(100)	not null,
	mails		varchar(100)	not null,
	phone		varchar(100)	not null,
	gender		varchar(10)		not null,
	reg_date	datetime		default now(),
	update_date datetime		default null,
	primary key(contact_id)
);

create table user_role(
	role_id		varchar(100)	not null,
	role_name	varchar(100)	not null,
	used_yn		char(1)			default 'Y',
	primary key(role_id)
);

create table positions(
	pos_code	varchar(100)	not null,
	pos_name	varchar(100)	not null,
	used_yn		char(1)			default 'Y',
	primary key(pos_code)
);

/* 데이터 생성 4개테이블 */
insert into positions (pos_code,pos_name)
values ('ps01','사원'),
('ps02','사원'),
('ps03','주임'),
('ps04','대리'),
('ps05','과장'),
('ps06','차장'),
('ps07','부장'),
('ps08','이사'),
('ps09','대표');
select * from positions p ;

insert into user_role (role_id,role_name)
values ('role101','user'),
('role102','manager'),
('role103','admin');
select * from user_role ur ;

insert into contacts (contact_id,name,mails,phone,gender)
values('ct101','김철수','csk@naver.com','010-1111-222','남성'),
('ct102','오미영','myO@naver.com','010-1111-2232','여성'),
('ct103','이소마','soma@naver.com','010-1111-2242','남성'),
('ct104','최상훈','sanghun@naver.com','010-1111-2252','남성'),
('ct105','서민지','minji@naver.com','010-1111-2262','여성');
select * from contacts c ;

insert into user_info (user_id,contact_id,user_passwd,user_role,user_pos)
values('admin','ct104','1234','role103','ps07'),
('user01','ct101','1234','role101','ps03'),
('manager01','ct105','1234','role102','ps05'),
('user02','ct103','1234','role101','ps02'),
('user03','ct102','1234','role101','ps03');
select * from user_info ui ;

/* 뷰 예시 */
create view users_main_info as
select ui.user_id,
		c.name,
		c.mails, 
		c.phone,
		c.gender,
		ur.role_name,
		p.pos_name 
from user_info ui
	inner join contacts c on ui.contact_id = c.contact_id 
	inner join user_role ur on ui.user_role = ur.role_id 
	inner join positions p on ui.user_pos = p.pos_code ;

drop view if exists users_main_info ;

select * from users_main_info umi ;