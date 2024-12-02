
drop table if exists  tb_members;
create table tb_members(

    mem_id   varchar(100)  not null comment '아이디',
    mem_name varchar(50)   not null comment '이름',
    mem_birth varchar(20)  not null comment '생년월일',
    mem_gender varchar(10) not null comment '성별',
    reg_date   datetime   default now() comment '등록일',
    update_date datetime  null          comment '수정일',
    primary key (mem_id)
);

insert into tb_members(mem_id, mem_name, mem_birth, mem_gender)
values ('mem01', '김명숙', '800910', '여성'),
       ('mem02', '이진명', '900710', '남성'),
       ('mem03', '박명지', '971110', '여성'),
       ('mem04', '신선애', '850910', '여성'),
       ('mem05', '최건호', '841120', '남성'),
       ('mem06', '최재영', '990220', '남성'),
       ('mem07', '송지영', '000601', '여성'),
       ('mem08', '박훈',  '781101', '남성'),
       ('mem09', '박민환',  '881211', '남성');


drop table if exists book_list;
create table book_list(

    book_id  varchar(100) not null comment '책코드',
    book_name varchar(100) not null  comment  '책이름',
    book_writer varchar(50) not null comment '저자',
    released_year date   default now() comment '출시 연도',
    book_price    int    default 0     comment '책 가격',
    primary key (book_id)

);

insert into book_list(book_id, book_name, book_writer, released_year, book_price)
values('bk1001', '재미있는 mysql 이야기',   '권순철',   '2023-10-01',  27000),
      ('bk1002', '재미있는 JAVA 이야기',    '권순철',   '2024-07-10', 37000),
      ('bk1003', '개바자가 되는 방법',       '감명수',   '2023-05-01',  32000),
      ('bk1004', '뇌를 자극하는 파이썬',     '민수기',   '2023-11-11',  35000),
      ('bk1005', '자바의 정석',            '남궁성',   '2023-7-30',   29000),
      ('bk1006', '이것이 Mysql 이다',      '우재남',   '2022-05-10',   28800),
      ('bk1007', '비전공자도 쉽게익히는 IT',  '신용복',   '2022-01-01',  29000),
      ('bk1008', '자바로 배우는 알고리즘',    '이성적',   '2022-07-01',  27000),
      ('bk1009', 'DBMS 실습과 이론',       '서성자',   '2021-04-06',  33000),
      ('bk1010', '프론트앤드 개발실습 For react',   '신수기',  '2021-08-15', 39000);


drop table if exists  book_order;
create table book_order(
    order_id         int auto_increment  not null  comment '주문 번호',
    order_member     varchar(100)  not null   comment '주문한사람',
    book_id          varchar(100) not null comment '책코드',
    order_count      int          default 1  comment '주문 수량',
    order_date       date   default now() comment '주문 일자',
    order_status     varchar(10)   not null comment  '주문상태(R요청, D 배송 E 종료)',

    primary key (order_id),
    constraint order_fk foreign key (order_member) references tb_members(mem_id)
);



insert  into book_order(order_member, book_id, order_count, order_date, order_status)
values('mem01', 'bk1002', 1, '2024-10-07', 'E'),
      ('mem01', 'bk1003', 1, '2024-10-07', 'E'),
      ('mem02', 'bk1007', 1, '2024-09-27', 'E'),
      ('mem02', 'bk1004', 1, '2023-12-07', 'E'),
      ('mem03', 'bk1008', 1, '2022-10-07', 'E'),
      ('mem03', 'bk1005', 1, '2024-01-07', 'E'),
      ('mem05', 'bk1010', 3, '2023-10-07', 'E'),
      ('mem06', 'bk107',  2, '2022-08-07', 'E'),
      ('mem06', 'bk1009', 1, '2023-10-22', 'E');