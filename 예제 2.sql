-- 1. 모든 도서의 가격과 도서명 조회 
select b_bookname, b_price from book;
-- 2. 모든 출판사 이름 조회 
select b_publisher from book;
-- 2.1 중복값을 제외한 출판사 이름 조회
select distinct b_publisher from book;
-- 3. BOOK테이블의 모든 내용 조회 
select * from book;
-- 4. 20000원 미만의 도서만 조회 
select * from book where b_price < 20000;
-- 5. 10000원 이상 20000원 이하인 도서만 조회
select * from book where b_price between 10000 and 20000; -- between은 입력된 값을 포함한다.
-- 6. 출판사가 좋은출판사 또는 대한출판사인 도서 조회 
select * from book where b_publisher = '대한출판사' or b_publisher = '좋은출판사';
select * from book where b_publisher in ('대한출판사', '좋은출판사');
-- 7. 도서명에 축구가 포함된 모든 도서를 조회
select * from book where b_bookname like '%축구%';
-- 8. 도서명의 두번째 글자가 구인 도서 조회
select* from book where b_bookname like '_구%';
-- 9. 축구 관련 도서 중 가격이 20000원 이상인 도서 조회
select* from book where b_bookname like '%축구%' and b_price >=20000;
-- 10. 책 이름순으로 전체 도서 조회
select* from book order by b_bookname asc;
-- 11. 도서를 가격이 낮은 것 부터 조회하고 같은 가격일 경우 도서명을 가나다 순으로 조회
select* from book order by b_price, b_bookname asc;

-- 12. 주문 도서의 총 판매액 조회 
select sum(o_saleprice) from orders;
-- 13. 1번 고객이 주문한 도서 총 판매액 조회 
select sum(o_saleprice) from orders where customer_id = 1;
-- 14. ORDERS 테이블로 부터 평균판매가, 최고판매가, 최저판매가 조회 
select max(o_saleprice) as '최고 판매가', min(o_saleprice) as '최저 판매가', avg(o_saleprice) as'평균 판매가' from orders;
-- 15. 고객별로 주문한 도서의 총 수량과 총 판매액 조회 (GROUP BY 활용)
select customer_id, sum(o_saleprice),  count(*) from orders group by customer_id;
-- 16. 가격이 8,000원 이상인 도서를 구매한 고객/에 대해 고객별 주문 도서의 총 수량 /조회 (GROUP BY 활용)
--    (단, 8,000원 이상 도서 두 권 이상 구매한 고객만) 
select customer_id, count(*) from orders where o_saleprice>=8000 group by customer_id having count(*)>=2;
-- 17. 김연아고객(고객번호 : 2) 총 구매액
select sum(o_saleprice) from orders where customer_id = 2;
select sum(o_saleprice) from orders where customer_id = (select id from customer where c_name = '김연아');
-- 18. 김연아고객(고객번호 : 2)이 구매한 도서의 수
select customer_id, count(*) from orders where customer_id=2;
-- 19. 서점에 있는 도서의 총 권수
select count(id) from book;
-- 20. 출판사의 총 수 
select count(distinct b_publisher) from book;
-- 21. 7월 4일 ~ 7일 사이에 주문한 도서의 주문번호 조회 
select count(*) from orders where o_oderdate between '2023-07-04' and '2023-07-07';
-- 22. 7월 4일 ~ 7일 사이에 주문하지 않은 도서의 주문번호 조회
select count(*) from orders where o_oderdate not between '2023-07-04' and '2023-07-07';