-- 30. 가장 비싼 도서의 이름을 조회 
select b_bookname, b_price from book b where b_price = (select max(b_price) from book); 
-- 31. 책을 구매한 이력이 있는 고객의 이름을 조회
select c_name from customer where id in(1,2,3,4);
select customer_id from orders;
select c_name from customer where id in(select customer_id from orders);
select c_name from orders o, customer c where o.id = c.id;
-- 32. 도서의 가격(PRICE)과 판매가격(SALEPRICE)의 차이가 가장 많이 나는 주문 조회
select * from book;
select* from orders;
-- book, orders를 조인해서 정가와 판매가 차이
select b.b_price - o.o_saleprice from book b, orders o where b.id = o.book_id;
select max(b.b_price - o.o_saleprice) from book b, orders o where b.id = o.book_id;
select * from book b, orders o where b.id = o.book_id and b.b_price - o.o_saleprice =6000;
select * from orders o, book b 
	where o.book_id = b.id 	
		and b_price - o_saleprice = (select max(b_price - o_saleprice) from orders o, book b where o.book_id = b.id) ;
-- 33. 고객별 평균 구매 금액이 도서의 판매 평균 금액 보다 높은 고객의 이름 조회
select * from orders;
select avg(b_price) from book;
select avg(o_saleprice) from orders;
-- 고객별 평균 구매 금액(group by)
select c_name , avg(o_saleprice) from orders o , customer c where c.id = o.customer_id group by c_name;
select c_name from orders o, customer c 
	where o.customer_id = c.id 
		group by c_name 
			having avg(o_saleprice) > (select avg(o_saleprice) from orders);
-- 34. 고객번호가 5인 고객의 주소를 대한민국 인천으로 변경 
select * from customer;
update customer set c_address = '대한민국 인천' where id=5;
-- 35. 김씨 성을 가진 고객이 주문한 총 판매액 조회
-- 김씨 성의 고객번호
select id from customer where c_name like '김%';
-- 합 구하기
select sum(o_saleprice) from orders where customer_id = 2 or customer_id =3;
select sum(o_saleprice) from customer c, orders o where c.id = o.customer_id and c_name like '김%';
select c_name, sum(o_saleprice) from customer c, orders o where c.id = o.customer_id group by c_name having c_name like '김%';

-- alter : 테이블의 구조를 변경할 때(컬럼이름 변경, 타입 변경, 컬럼삭제 ,제약조건 추가 등)
create table student(
	id bigint,
    s_name varchar(20),
    s_mobile int
);
-- 테이블의 구조 확인
desc student; 
desc book;
-- 기존 컬럼에 제약조건 추가
alter table student add constraint primary key (id);
-- 기존 컬럼 타입 변경
alter table student modify s_mobile varchar(30);
-- 컬럼 추가
alter table student add s_major varchar(30);
-- 컬럼 이름 변경
alter table student change s_mobile s_phone varchar (30);
-- 컬럼 삭제
alter table student drop s_major;