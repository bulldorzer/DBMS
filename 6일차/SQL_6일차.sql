/*----------------------------------<컬럼추가>----------------------------------*/

alter table members add mem_gender  varchar(10) not null after mem_age;
show processlist; /* 작업중인 리스트 확인 테이블 락걸려잇는지 확인할 때 사용*/
select @@autocommit; /* 오토커밋 확인 */
set @@autocommit 0; /* 오토커밋 설정 1:오토커밋 0:오토커밋해재*/

select * from members m ;

drop table if exists book_list; /* 테이블을 지울 때 해당 테이블이 존재할때 라는 조건을 검 */
create table book_list(
	book_id 		varchar(100) 	not null 		comment '책코드',
	book_name 		varchar(100) 	not null 		comment '책이름',
	book_writer 	varchar(50) 	not null 		comment '저자',
	released_year 	date			default now() 	comment '출시연도',
	book_price 		int 			default 0 		comment '책 가격',
	primary key(book_id)
);

/*----------<sql,csv파일을 sql툴에 밀어넣기>------------*/
mysql -uroot -p << 깔려있는 sql 사용법 맥노트북으로		

use class_db
source C:\DBMS\init_data.sql

MariaDB [(none)]> use class_db    << 사용할 데이터베이스 설정
Database changed
MariaDB [class_db]> source C:\DBMS\init_data.sql << 사용할 데이터에 실행시킬 SQL파일 경로 지정 실행


/*----------<쿼리문>------------*/
select * 
from tb_members tm ;
select * 
from book_list bl;
select * 
from book_order bo ;

/* 두쿼리중 빠른거 확인해서 해보면된다 실행->실행계획보기로 roop를 확인해보기 */
select tm.mem_id,
		tm.mem_name,
		bo.order_id,
		bo.book_id,
		bl.book_name,
		bo.order_count 
from tb_members tm 
	left join book_order bo on tm.mem_id =bo.order_member 
	left join book_list bl on bo.book_id =bl.book_id 
order by tm.mem_name asc;

select tm.mem_id,
		tm.mem_name,
		bo.order_id,
		bo.book_id,
		(select book_name 
		from book_list bl 
		where bo.book_id=bl.book_id) 
		as 'book_name',
		bo.order_count 
from tb_members tm 
	left join book_order bo on tm.mem_id =bo.order_member  
order by tm.mem_name asc;

select mem_id,
		mem_name,
		ifnull(order_id,0) as order_id,
		ifnull(book_id,0) as book_id,
		ifnull(book_name,'') as book_name,
		ifnull(order_count,0) as order_count
from(
		select tm.mem_id,
				tm.mem_name,
				bo.order_id,
				bo.book_id,
				(select book_name 
				from book_list bl 
				where bo.book_id=bl.book_id) 
				as 'book_name',
				bo.order_count 
		from tb_members tm 
			left join book_order bo on tm.mem_id =bo.order_member  
	)sub
order by mem_name asc;