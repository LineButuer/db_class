use db_dbclass;

drop table if exists member_tbl_02;
create table member_tbl_02(
	custno int primary key auto_increment,
    custname varchar(20),
    phone varchar(13),
    address varchar(60),
    joindate datetime default now(),
    grade char(1),
    city char(2)
);

-- 회원 데이터 저장
insert into member_tbl_02 values(100001, '김행복', '010-1111-2222', '서울 동대문구 휘경1동', '20151202', 'A', '01');   
insert into member_tbl_02 values(100002, '이축복', '010-1111-3333', '서울 동대문구 휘경2동', '20151206', 'B', '01');   
insert into member_tbl_02 values(100003, '장믿음', '010-1111-4444', '울릉군 울릉읍 독도1리', '20151001', 'B', '30');   
insert into member_tbl_02 values(100004, '최사랑', '010-1111-5555', '울릉군 울릉읍 독도2리', '20151103', 'A', '30');   
insert into member_tbl_02 values(100005, '진평화', '010-1111-6666', '제주도 제주시 외나무골', '20151225', 'B', '60');   
insert into member_tbl_02 values(100006, '차공단', '010-1111-7777', '제주도 제주시 감나무골', '20151211', 'C', '60');
select * from member_tbl_02;

drop table if exists money_tbl_02;
create table money_tbl_02(
	custno int,
    saleno int primary key auto_increment,
    pcost int,
    amount int,
    price int,
    pcode varchar (4),
    sdate datetime default now()
);
-- 회원 매출 데이터 저장
insert into money_tbl_02(custno, pcost, amount, price, pcode, sdate) values(100001, 500, 5, 2500, 'A001', '20160101');    
insert into money_tbl_02(custno, pcost, amount, price, pcode, sdate) values(100001, 1000, 4, 4000, 'A002', '20160101');    
insert into money_tbl_02(custno, pcost, amount, price, pcode, sdate) values(100001, 500, 3, 1500, 'A008', '20160101');    
insert into money_tbl_02(custno, pcost, amount, price, pcode, sdate) values(100002, 2000, 1, 2000, 'A004', '20160102');    
insert into money_tbl_02(custno, pcost, amount, price, pcode, sdate) values(100002, 500, 1, 500, 'A001', '20160103');    
insert into money_tbl_02(custno, pcost, amount, price, pcode, sdate) values(100003, 1500, 2, 3000, 'A003', '20160103');    
insert into money_tbl_02(custno, pcost, amount, price, pcode, sdate) values(100004, 500, 2, 1000, 'A001', '20160104');    
insert into money_tbl_02(custno, pcost, amount, price, pcode, sdate) values(100004, 300, 1, 300, 'A005', '20160104');    
insert into money_tbl_02(custno, pcost, amount, price, pcode, sdate) values(100004, 600, 1, 600, 'A006', '20160104');    
insert into money_tbl_02(custno, pcost, amount, price, pcode, sdate) values(100004, 3000, 1, 3000, 'A007', '20160106');    
select * from money_tbl_02;

select custno, custname, phone, address, joindate, 
		case 	when grade = 'A' then 'VIP'
				when grade = 'B' then '일반'
                when grade = 'C' then '직원'
                else '없음'
		end as grade, 
        city
        from member_tbl_02;
        
select * from member_tbl_02 mb, money_tbl_02 mn where mb.custno = mn.custno;

select mb.custno as '회원번호', custname as '회원성명', 
			case 	when grade = 'A' then 'vip'
					when grade = 'B' then '일반'
                    when grade = 'C' then '직원'
                    else '없음'
			end as '고객등급',
 sum(price) as '매출' from member_tbl_02 mb, money_tbl_02 mn where mb.custno = mn.custno group by mn.custno order by '매출' desc;



