use db_dbclass;

drop table if exists book;
create table book(
	id bigint auto_increment primary key,
    b_bookname varchar (20),
    b_publisher varchar (10),
    b_price bigint
    );

drop table if exists customer;
create table customer(
	id bigint auto_increment primary key ,
    c_name varchar (20),
    c_address varchar (20),
    c_phone varchar(14)
    );

drop table if exists orders;
create table orders(
	id bigint auto_increment primary key,
    o_saleprice bigint,
    o_oderdate date,
    customer_id bigint,
    book_id bigint,
    constraint fk_orders foreign key(customer_id) references customer(id) on delete set null,
    foreign key(book_id) references book(id) on delete set null
    );
    
insert into book(b_bookname, b_publisher, b_price) values ('축구역사', '좋은출판사', '7000');
insert into book(b_bookname, b_publisher, b_price) values ('축구 리포트', '나무출판사', '13000');
insert into book(b_bookname, b_publisher, b_price) values ('축구를 알려주마', '대한출판사', '22000');
insert into book(b_bookname, b_publisher, b_price) values ('배구의 바이블', '대한출판사', '35000');
insert into book(b_bookname, b_publisher, b_price) values ('피겨교과서', '좋은출판사', '8000');
insert into book(b_bookname, b_publisher, b_price) values ('피칭의 단계별 기술', '좋은출판사', '6000');
insert into book(b_bookname, b_publisher, b_price) values ('야구의 추억 이야기', '나이스미디어', '20000');
insert into book(b_bookname, b_publisher, b_price) values ('야구 읽어주는 남자', '나이스미디어', '13000');
insert into book(b_bookname, b_publisher, b_price) values ('올림픽 스토리', '이야기당', '7500');
insert into book(b_bookname, b_publisher, b_price) values ('olympic history', 'strawberry', '13000');
select * from book;
insert into customer(c_name, c_address, c_phone) values('손흥민', '영국 런던', '000-4000-0001');
insert into customer(c_name, c_address, c_phone) values('김연아', '대한민국 서울', '000-5000-0001');
insert into customer(c_name, c_address, c_phone) values('김연경', '대한민국 서울', '000-6000-0001');
insert into customer(c_name, c_address, c_phone) values('류현진', '캐나다 토론토', '000-7000-0001');
insert into customer(c_name, c_address) values('이강인', '프랑스 파리');
select*from customer;

insert into orders(customer_id, book_id, o_saleprice, o_oderdate) values(1, 1, '6000', '2023-07-01');
insert into orders(customer_id, book_id, o_saleprice, o_oderdate) values(1, 3, '21000', '2023-07-03');
insert into orders(customer_id, book_id, o_saleprice, o_oderdate) values(2, 5, '8000', '2023-07-03');
insert into orders(customer_id, book_id, o_saleprice, o_oderdate) values(3, 6, '6000', '2023-07-04');
insert into orders(customer_id, book_id, o_saleprice, o_oderdate) values(4, 7, '20000', '2023-07-05');
insert into orders(customer_id, book_id, o_saleprice, o_oderdate) values(1, 2, '12000', '2023-07-07');
insert into orders(customer_id, book_id, o_saleprice, o_oderdate) values(4, 8, '13000', '2023-07-07');
insert into orders(customer_id, book_id, o_saleprice, o_oderdate) values(3, 10, '12000', '2023-07-08');
insert into orders(customer_id, book_id, o_saleprice, o_oderdate) values(2, 10, '7000', '2023-07-09');
insert into orders(customer_id, book_id, o_saleprice, o_oderdate) values(3, 8, '13000', '2023-07-10');
select* from orders;