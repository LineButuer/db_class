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