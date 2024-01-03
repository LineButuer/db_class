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