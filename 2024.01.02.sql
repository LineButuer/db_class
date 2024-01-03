use db_dbclass;

create table table1(
	col1 int,
    col2 varchar(5)
);

-- 테이블 조회(*모든 커럼을 보겠다)
select * from table1;

-- 테이블에 데이터 저장
insert into table1(col1, col2) values(1, '안녕');
insert into table1(col1, col2) values(2, '화요일');
-- 정의한 컬럼에 맞지 않는 데이커가 들어오면 에러
insert into table1(col1, col2) values('aa', '화요일');
-- col2의 내용이 지정한 길이보다 길어서 오류!! 영어도 마찬가지
insert into table1(col1, col2) values(4, '화요일입니다');

/*
	학생 관리번호(id)
    학번(studentNumber)
    이름(studentName)
    전화번호(studentMobile)
    학과(studentMajor) 정보를 저장하는 student_table 생성
*/

create table table2(
id bigint,
studentNumber int,
studentName varchar(5),
studentMobile varchar(14),
studentMajor varchar(6)
);

insert into table2(id, studentNumber, studentName, studentMobile, studentMajor) 
	values(1, 2, '이태양', '010-1111-1111', '물류학과');
select *from table2;
-- 부서 
drop table dept;
create table dept (
    deptno int,
    dname varchar(14),
    loc varchar(13)
);
drop table emp;
create table emp (
    empno int,
    ename varchar(10),
    job varchar(9),
    mgr int,
    hiredate date,
    sal int,
    comm int,
    deptno int
);

create table bonus (
    ename varchar(10),
    job varchar(9),
    sal int,
    comm int
);


create table salgrade (
    grade int,
    losal int,
    hisal int
);
    
insert into dept values	(10,'ACCOUNTING','NEW YORK');
insert into dept values (20,'RESEARCH','DALLAS');
insert into dept values (30,'SALES','CHICAGO');
insert into dept values	(40,'OPERATIONS','BOSTON');    

insert into emp values (7369,'SMITH','CLERK',7902, str_to_date('17-12-1980','%d-%m-%Y'),800,NULL,20);
insert into emp values (7499,'ALLEN','SALESMAN',7698,str_to_date('20-2-1981','%d-%m-%Y'),1600,300,30);
insert into emp values (7521,'WARD','SALESMAN',7698,str_to_date('22-2-1981','%d-%m-%Y'),1250,500,30);
insert into emp values (7566,'JONES','MANAGER',7839,str_to_date('2-4-1981','%d-%m-%Y'),2975,NULL,20);
insert into emp values (7654,'MARTIN','SALESMAN',7698,str_to_date('28-9-1981','%d-%m-%Y'),1250,1400,30);
insert into emp values (7698,'BLAKE','MANAGER',7839,str_to_date('1-5-1981','%d-%m-%Y'),2850,NULL,30);
insert into emp values (7782,'CLARK','MANAGER',7839,str_to_date('9-6-1981','%d-%m-%Y'),2450,NULL,10);
insert into emp values (7788,'SCOTT','ANALYST',7566,str_to_date('13-7-87','%d-%m-%Y'),3000,NULL,20);
insert into emp values (7839,'KING','PRESIDENT',NULL,str_to_date('17-11-1981','%d-%m-%Y'),5000,NULL,10);
insert into emp values (7844,'TURNER','SALESMAN',7698,str_to_date('8-9-1981','%d-%m-%Y'),1500,0,30);
insert into emp values (7876,'ADAMS','CLERK',7788,str_to_date('13-7-87','%d-%m-%Y'),1100,NULL,20);
insert into emp values (7900,'JAMES','CLERK',7698,str_to_date('3-12-1981','%d-%m-%Y'),950,NULL,30);
insert into emp values (7902,'FORD','ANALYST',7566,str_to_date('3-12-1981','%d-%m-%Y'),3000,NULL,20);
insert into emp values (7934,'MILLER','CLERK',7782,str_to_date('23-1-1982','%d-%m-%Y'),1300,NULL,10);
		 
insert into salgrade values (1,700,1200);
insert into salgrade values (2,1201,1400);
insert into salgrade values (3,1401,2000);
insert into salgrade values (4,2001,3000);
insert into salgrade values (5,3001,9999);

select * from emp; 
select * from bonus; -- 조회결과 없음
select * from salgrade;
select * from dept;

-- emp 테이블 전체 컬럼 조회
select * from emp;
-- emp 테이블의 empno, ename 컬럼만 조회
select empno, ename, sal from emp;
-- select SMITH from emp; 는 안됨
-- emp 테이블의 jop 컬럼만 조회
select job from emp;
-- 중복 값은 한 번만 조회 보통 뭐가 있는지 확인만 할 때 씀
select distinct job from emp;
-- 사원 이름 조회(오름차순)
select * from emp order by ename asc; 
-- 내림차순
select * from emp order by ename desc;
-- 급여(sal) 기준 오름차순 정렬
select * from emp order by sal asc;
-- 급여(sal) 기준 내림차순 정렬
select * from emp order by sal desc;
-- 입사일(hiredate) 기준 오름차순
select * from emp order by hiredate asc;
-- 입사일 내림차순
select * from emp order by hiredate desc;
-- 정렬 기준이 두가지 라면 콤마(,)로 구분
-- 입사일 기준 내림차순 정렬하고 입사일이 같다면 이름 기준 오름차순 
select * from emp order by hiredate desc, ename asc;

-- 조건 : 툭정 데이터를 기준으로 조회하고자 할 때
-- where 
-- 직급(job)이 saleman인 사원 조회 
select * from emp where job = 'salesman';
-- 직급(job) manager
select * from emp where job = 'manager';
-- 부서번호(deptno)가 10인 사원
select * from emp where deptno = 10;
-- 이름이(ename) james인 사원
select * from emp where ename = 'james';
-- 사번 (empno)이 7654인 사원
select * from emp where empno = '7654';

-- 조건이 2가지 이상
-- 직급이 manager 이고 부서번호가 20인 사원
select * from emp where job = 'manager' and deptno = 20;
-- 직급이 세일즈맨이거나 사원인 사원
select * from emp where job = 'salesman' or job = 'clerk';
-- 급여가 3000 이상인 사원
select * from emp where sal >= 3000;
-- 급여가 1000이상 3000이하인 사원
select * from emp where 1000<= sal and sal <= 3000;
select * from emp where sal between 1000 and 3000;
-- 급여가 1000 미만이거나 3000 초과
select * from emp where sal not between 1000 and 3000;
-- 급여가 3000 이하인 사원 조회를 sal 기준으로 오름차순 정렬
select * from emp where sal <= 3000;
-- 급여가 3000 이하인 사원 조회를 sal 기준으로 오름차순 정렬
select * from emp where sal <= 3000 order by sal asc; 
-- 직급이 salesman이 아닌 사원
select * from emp where job !='salesman';
select * from emp where !jop = 'salesman';
-- 입사 일자 (hiredate)가 81년 4월 1일 이후인 사원
select * from emp where hiredate > '1981-04-01' order by hiredate asc;
-- str_to_date():문자를 날짜형으로 변환하는 함수
select * from emp where hiredate > str_to_date('1981-04-01','%Y-%m-%d');

-- like 연산자
select * from emp where ename like 'm%';
select * from emp where ename like '%m';
select * from emp where ename like '%m%';
select * from emp where ename like '_m%'; 
select * from emp where ename like '__m%';
-- 김씨 성을 가진 이름이 3글자인 사원
-- 이씨 성을 가진 이름이 2글자인 사원
-- 이름이 3글자인 사원 중에서 이름 중간에 '가'가 있는 사원
select * from emp where ename like '김__';
select * from emp where ename like '이_';
select * from emp where ename like '_가_';

-- 함수
-- sum(), avg(), max(), min(), count()
-- 급여 총합
select sum(sal) from emp;
select sum(sal) as'급여총함'from emp;
-- 세일즈맨의 급여 총합
select sum(sal) as'세일즈맨'from emp where job = 'salesman'; 
-- 평균 급여 조회
select truncate(avg(sal), 2) from emp;
-- 평균값을 소수 둘째자리 까지만 조회하려면
-- round()함수 반올림
-- dual : 문장을 완성하기 위한 가상의 테이블
select round(12.123456, 2) from dual; -- 12.35
select round(12.123456, 1) from dual; -- 12.3
select round(12.123456, 0) from dual; -- 12
select round(12.567, 0) from dual; -- 13
select sysdate() from dual; 
select round(avg(sal), 2) from emp;
-- 가장 많은 급여
select max(sal) from emp;
-- 가장 적은 급여
select min(sal) from emp;
-- 전체 사원 수
select count(*) from emp;
-- 부서 번호가 20인 사원 수
select count(*) from emp where deptno = 20;

-- 그룹화(grouping, 특정 컬럼을 기준으로 동일한 데이터끼리 묶는 것)
-- 그룹화한 결과를 조회할 때는 그룹화한 컬럼으로 조회만 가능
-- job을 기준으로
select * from emp group by job;
select job from emp group by job;
-- 직급별 평균 급여
select avg(sal), job from emp group by job;
-- 직급이 clerk인 사원들의 급여 평균
select job, avg(sal) from emp where job = 'clerk';
-- 부서(deptno)별 평균 급여
select deptno, avg(sal) from emp group by deptno;
-- 직급별 사원수
select job, count(*) from emp group by job;
-- 직급별 평균 급여, 사원수
select job, avg (sal), count(*) from emp group by job;
-- 위 결과 직급기준 오름차순 정렬
select job, avg (sal), count(*) from emp group by job order by job asc;
-- 위 결과 평균 급여 소수 첫째자리 까지
select job, round(avg(sal),1), count(*) from emp group by job order by job;
-- 위 결과 job은 '직급' 급여 '평균 급여', 사원수는 ' 사원수 ' 로 표현하여 조회
select job as '직급' , round(avg(sal),1) as '평균 급여', count(*) as '사원수' from emp group by job order by job;

-- 두 개 이상의 컬럼 그룹화
-- detpno를 기준으로 그릅화 하고 그 결과 내에서 job 기준으로 그룹화
select deptno as '부서 번호', job '직급', count(*) ,round(avg(sal),1) as '급여' from emp group by deptno, job order by deptno;
-- 그룹화한 결과에 조건을 적용
-- having 
-- 위의 결과에서 평균 급여가 2000 이상인 결과만 조회
select deptno as '부서 번호', job '직급', count(*) ,round(avg(sal),1) as '급여' 
from emp 
	group by deptno, job
		having avg(sal) >= 2000 
			order by deptno asc;
-- 급여가 3000 이하인 사원만 가지고 부서별, 직급별 그룹화를 하고 평균 급여가 2000 이상인 결과 조회
select deptno as '부서 번호', job '직급', count(*) ,round(avg(sal),1) as '급여' 
	from emp 
		where sal <= 3000
			group by deptno, job
				having avg(sal) >= 2000 
					order by deptno asc; -- 순서는 바뀔 수 없음 반드시 맞춰야 함.
                    
-- date 타입을 문자로 표현 : date_format()
select date_format(hiredate, '%Y') as '입사 년도' from emp;

/*
	연습문제
	1. 부서별 평균급여, 최고급여, 최저급여, 사원수 조회(평균급여는 소수점 둘째자리에서 반올림)
    2. 직급별 사원수 조회(단 3명 이상인 결과만 출력)
    3. 연도별 입사한 사원수 조회(조회결과 : 연도(yyyy), 사원수)
    3.1. 위의 결과에서 각 연도별로 부서별 입사한 사원수 조회(조회결과 : 연도(yyyy), 부서번호, 사원수)
*/

select deptno as '부서', round(avg(sal),1) as '평균급여', max(sal) as '최고 급여', min(sal) as '최저 급여', count(*) as'사원수' from emp group by deptno;

select job, count(*) from emp group by job having count(*) >= 3;

select date_format(hiredate, '%Y') as '입사 년도', count(*) as '사원수' from emp group by date_format(hiredate, '%Y');

select date_format(hiredate, '%Y') as '입사 년도', deptno as '부서번호', count(*) as '사원수' from emp group by date_format(hiredate, '%Y'), deptno;

-- 조인(join)
-- 두 개 이상의 테이블을 하나의 테이블처럼 사용할 때
select * from emp, dept;
select * from emp;
select * from dept;
-- 내부조인(inner join)
-- 조인하려는 두 테이블에 공통 컬럼이 존재해야 함.
select * from emp e , dept d where e.deptno = d.deptno;
-- deptno 컬럼은 두 테이블에 모두 있기 때문에 확실한 주소를 적어줘야 출력이 됨 아니면 amgiuous 에러가 뜸
select e.empno, e.ename, e.job, e.deptno, d.dname, d.loc from emp e , dept d where e.deptno = d.deptno;
-- emp, dept를 조인하여 empno, ename, deptno, dname, loc 조회
-- 단, 급여기 2500 이상인 사원만 조회하고, 조회 결과는 사원이름 기준으로 오름차순 정렬
select e.empno, e.ename, e.deptno, d.dname, d.loc from emp e, dept d where e.deptno = d.deptno and sal >= 2500 order by e.ename;

-- 서브쿼리 (sub query)
-- 하나의 쿼리문 안에서 다른 쿼리문을 수행하는 것
-- 최저 급여를 받는 사원의 이름
select ename, sal from emp where sal = 800;
-- 1. 최저급여가 얼마인지? => 800
select min(sal) from emp;
-- 2. 800 급여를 받는 사원의 이름 => smith
-- 위의 두 문장을 서브쿼리로
select ename, sal from emp where sal=(select min(sal) from emp);
-- 최고 급여를 받는 사원의 정보 조회
select ename ,sal from emp where sal = (select max(sal) from emp);
select sal from emp where ename = 'allen';
-- allen 보다 높은 급여를 받는 사원 조회
select * from emp where sal > (select sal from emp where ename = 'allen');

select* from emp;

/*
	연습문제 
    1. clark 보다 늦게 입사한 사원 조회 
    2. 부서번호가 20인 사원 중에서 전체 사원 평균 급여보다 높은 급여를 받는 사원 조회 
    3. 2번 조회 결과에서 부서이름, 부서위치도 함께 조회 
*/

select hiredate from emp where ename = 'clark';
select ename from emp where hiredate > (select hiredate from emp where ename = 'clark');
select avg(sal) from emp where deptno = 20;
select * from emp where sal>2175 and deptno = 20;
select * from emp where sal> (select avg(sal) from emp) and deptno = 20;
select * from emp where deptno = 20 and sal > (select avg(sal) from emp);

select *, d.dname , d.loc
	from emp e, dept d 
		where e.deptno = d.deptno and e.deptno = 20 and sal > (select avg(sal) from emp);
-- 4. martin과 같은 부서 사원 중에서 전체 사원 평균 급여보다 높은 급여를 받는 사원 조회 
select * from emp 
	where sal > (select avg(sal) from emp) 
		and deptno =( select deptno from emp where ename = 'martin');