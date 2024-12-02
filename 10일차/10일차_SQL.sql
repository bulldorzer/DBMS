/* if 구문 */
select name,
		age,
		/*if (age>19, '성인',if(age>13,'청소년')) as '단위' <= 되지 않음*/
		if (age>19, '성인',if(age>13,'청소년','어린이')) as '단위'
from(
	select '홍길동' as name, 17 as age
	union all
	select '김철수' as name, 13 as age
	union all
	select '박지영' as name, 21 as age
)a;

/* case when then else end 구문 */
select name,
		age,
		case when age>19 then '어른'
			when age>15 then '청소년'
			when age>13	then '어린이'
			else '미취학아동'
			end as '등급'
from(
	select '홍길동' as name, 17 as age
	union all
	select '김철수' as name, 13 as age
	union all
	select '박지영' as name, 21 as age
)a;


/* case when then else end 구문 */

select name,
		age,
		case when age>19 then '어른'
			when age>15 then '청소년'
			when age>13	then '어린이'
			else '미취학아동'
			end as '등급',
		decode_oracle(gender,'M','남성','F','여성')as gender
from(
	select '홍길동' as name, 17 as age, 'M' as gender
	union all
	select '김철수' as name, 13 as age, 'M' as gender
	union all
	select '박지영' as name, 21 as age, 'F' as gender
)a;
