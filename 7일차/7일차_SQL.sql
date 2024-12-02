/*퀴즈1
	책 중에서 20203년 이후 발매된 책 리스트를 출력하시오 	
*/
select * 
from book_list bl 
	where bl.released_year >'2022-12-31';
/*퀴즈2
	모든 회원을 대상으로 각자 몇권의 책을 구매하였는지 출력하라.
	단 책의 제목은 상관없이 권 수만 출력한다.
	이름 책권수
	----------
	A   1
	B   2
	ex)
*/
select tm.mem_name,
		sum(bo.order_count) as order_count
from tb_members tm 
	inner join book_order bo on tm.mem_id =bo.order_member
	inner join book_list bl on bo.book_id = bl.book_id 
	group by tm.mem_name 
	having order_count>2 
	and tm.mem_name = '최건호';

/*퀴즈3
	가장 많은 책을 산 사람과 권수를 출력해라.
*/
select tm.mem_name,
		max(bo.order_count)
from tb_members tm 
	inner join book_order bo on tm.mem_id =bo.order_member
group by tm.mem_name ;

select tm.mem_name,
		bo.order_count 
from tb_members tm 
	inner join book_order bo on tm.mem_id =bo.order_member ;

select tm.mem_name,
		sum(bo.order_count) as order_count
from tb_members tm 
	inner join book_order bo on tm.mem_id =bo.order_member
	inner join book_list bl on bo.book_id = bl.book_id 
	group by tm.mem_name
	order by order_count desc 
	limit 0, 1;
select *
from (
select row_number()over(order by order_count desc) as rn,
		mem_name,
		order_count
		from(
			select mem_name,
				sum(order_count) as order_count
			from tb_members tm 
				inner join book_order bo on tm.mem_id = bo.order_member
				inner join book_list bl on bo.book_id = bl.book_id 
				group by tm.mem_name
				
		)a
		
		)b 
where rn =1;

/*퀴즈4
	첵을 구매하는데 돈을 가장 많이 쓴 사람을 출력하라.
*/

select tm.mem_name,
		max(bo.order_count*(select bl.book_price
		from book_list bl where bo.book_id=bl.book_id )
		) as pay_price
from tb_members tm 
	inner join book_order bo on tm.mem_id = bo.order_member
group by tm.mem_name
order by pay_price desc 
limit 0,1;

		


/*------------<Union>-----------*/

select sum(temp) as temp,
		sum(humidity) as humidity
from(
		select 10 as 'temp',65 as `humidity`
		union all
		select 30 as 'temp',0 as `himidity`
) tmp
order by temp desc;


select 10 as 'temp',65 as `humidity`
union all
select 30 as 'temp',0 as `himidity`
order by temp desc;

/*
select 장비이름, in_bps, 0 as in_bps
from 장비_inbps_table
where 장비이름 ='L4'
	and 날짜 between '2024-10-30' and 날짜 <= '2024-11-01'
	또는 날짜>='2024-10-30' and 날짜 <='2024-11-01'
union all 
select 장비이름, out_bps, 0 as out_bps
from 장비_outbps_table
where 장비이름 ='L4'
	and 날짜 between '2024-10-30' and 날짜 <= '2024-11-01'
	또는 날짜>='2024-10-30' and 날짜 <='2024-11-01'
*/

/*------------<Union>-----------*/
select *
from tb_members tm 
where (tm.mem_name ='김명숙' or mem_name ='신선애')
and tm.mem_birth=800910 ;

select *
from tb_members tm 
where mem_name in('김명숙','신선애');

/*------------<검색패턴>-----------*/
select * 
from(
select '굴짬뽕' as menu
union all
select '백짬뽕' as menu
union all
select '차돌짬뽕' as menu
union all
select '사천짜장' as menu
union all
select '간짜장' as menu
)c
where menu like '%짬뽕%' or menu like '%짜장';

/*------------<정규식>-----------*/
/* 더미 테이블 만들때 서브 쿼리로 만듬*/
select * 
from (
	select '집에가자' as sentence
	union all
	select '1234' as sentence
)a
where sentence regexp '[^0-9]';
/*
 /^=> not 부정형
  0-9 모든 숫자 패턴
*/


/* regexp_replace 패턴에 해당하는 값을 두번째 값으로 대체해라*/
select regexp_replace(sentence,'[^0-9]+','') as sentence
from(
	select '집1에2가3자4' as sentence
)a;

		
