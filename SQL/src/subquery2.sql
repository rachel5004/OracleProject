-- 서브쿼리 
/*
      SELECT empno, (SELECT~),(SELECT~)  => SELECT뒤에 스칼라 서브쿼리 => JOIN 대신...
      FROM (SELECT~) => FROM뒤에 인라인뷰 
      WHERE dpetno=(SELECT~) 
                   ========= 컬럼(1) 1개값  => 단일행 서브쿼리
                   ========= 컬럼(1) 여러개  => 다중행 서브쿼리  
                   ========= 컬럼이 여러개   => 다중 컬럼 서브쿼리 
                   
      서브쿼리 
        => 메인 = (서브쿼리) => 조건문 
           먼저 실행 서브쿼리 => 메인으로 전송  => 메인 SQL이 실행 
        => 먼저 실행되는 SQL문장이 무엇인지 확인 (서브쿼리)
        => SQL문장이 여러개 합쳐서 한개의 SQL문장을 만든다 
           (네트워크 => SQL문장을 여러개 전송하는 것보다 한개의 SQL문장을 보내는 것이 속도가 좋아진다)
        => 데이터를 영구적으로 저장하는 용도 (모든 프로그램 => 자바,파이썬)...
           브라우저에 오라클을 연결 가능 (NodeJS:서버 사이드 , 스프링과 유사한 역할)
                                                        ====== ~DAO (중복(X)=> MyBatis)
                                                                              ========
                                                                              XML,Annotation
        => 자바 (1권 , 2권 (컬렉션 , IO))
        => 오라클 : DML (SELECT(연산자,내장함수,JOIN,SUBQUERY),INSERT,UPDATE,DELETE)
                   VIEW (인라인뷰,시퀀스)
                   DDL (테이블,제약조건)
        => 자바(웹과 관련된 라이브러리)
        
        => 웹 (자바,오라클,HTML,CSS,JavaScript) => 통합 (JSP) => JSP(Model1),Model2(MVC:Spring)
                                                              ============
                                                              Java+HTML   => Java,Html을 분리
*/
--SELECT DISTINCT deptno FROM emp;
--SELECT deptno,ename FROM emp;
-- 단일행 서브쿼리 (서브쿼리의 결과값이 1개일때) => 비교연산자사용 (=,<,>,<>,>=,<=)
SELECT ename,hiredate,job 
FROM emp
WHERE deptno=(SELECT deptno FROM emp WHERE ename='KING'); -- 10,20,30

-- 다중행 서브쿼리 (서브쿼리의 결과값이 여러개 일 경우에 사용) (IN,ANY,ALL,EXISTS)
/*
     IN => 결과값 전체를 사용 (deptno: 10,20,30) => deptno=10 OR deptno=20 OR deptno=30
     > ANY(서브쿼리) : 최소값 (SELECT DISTINCT deptno FROM emp) => (10,20,30) => 10
     < ANY(서브쿼리) : 최대값 (SELECT DISTINCT deptno FROM emp) => (10,20,30) => 30
     > ALL(서브쿼리) : 최대값 (SELECT DISTINCT deptno FROM emp) => (10,20,30) => 30
     < ALL(서브쿼리) : 최소값 (SELECT DISTINCT deptno FROM emp) => (10,20,30) => 10
     ==========================> SELECT MAX(deptno) FROM emp
                                 SELECT MIN(deptno) FROM emp
     EXISTS => 서브쿼리의 내용이 true일 경우에 수행 , false일 경우에는 수행하지 않는다
*/
-- 부서가 10,20,30인 사원의 이름과 부서번호,직위를 출력 
-- emp,dept => JOIN 사용을 제외하고는 한개의 테이블에서 작업
SELECT ename,deptno,job
FROM emp
WHERE deptno IN(10,20,30);
-- dept에 있는 deptno => SELECT문장이 여러개 이기 때문에 다른 테이블을 사용 할 수 있다
SELECT ename,deptno,job
FROM emp
WHERE deptno IN(SELECT deptno FROM dept); -- 서브쿼리에서 출력한 모든 결과값을 사용한다 

SELECT ename,deptno,job
FROM emp
WHERE deptno>ANY(SELECT deptno FROM dept);  --> 10,20,30,40 => 10(최소값)   '>' 
-- SELECT deptno FROM dept

-- 변경
SELECT ename,deptno,job
FROM emp
WHERE deptno>(SELECT MIN(deptno) FROM dept);

SELECT ename,deptno,job
FROM emp
WHERE deptno<ANY(SELECT deptno FROM dept);  --> 10,20,30,40 => 40(최대값) '<'

SELECT ename,deptno,job
FROM emp
WHERE deptno<(SELECT MAX(deptno) FROM dept);

-- ALL  10,20,30,40 => 10 < ALL  '<' :최소값
SELECT ename,deptno,job
FROM emp
WHERE deptno<ALL(SELECT deptno FROM dept);  --> 10,20,30,40 => 10
-- ALL  10,20,30,40 => 40 > ALL  '>' : 최대값
SELECT ename,deptno,job
FROM emp
WHERE deptno>ALL(SELECT deptno FROM dept); --> 10,20,30,40 => 40

SELECT ename,deptno,job
FROM emp
WHERE EXISTS (SELECT deptno FROM emp WHERE deptno=&dno);
-- 서브쿼리가 true면 실행 , 서브쿼리가 false면 실행하지 않는다 
-- 스칼라 서브쿼리 : JOIN대신 , 컬럼 대신 사용 
/*
     SELECT 컬럼명 , (SELECT ~ ) ,컬럼명 , (SELECT ~ )
     FROM 테이블명 
     
     스칼라변수  : 일반 변수  => name VARCHAR2(10)
     스칼라서브쿼리 : 컬럼값 
*/
-- 사원의 이름,직위,입사일,     부서명,근무지를 출력 
--       -------------(emp), ---------- (dept)
SELECT ename,job,hiredate,dname,loc 
FROM emp,dept
WHERE emp.deptno=dept.deptno;

-- 서브 쿼리로 변경 
SELECT ename,job,hiredate,(SELECT dname FROM dept d WHERE d.deptno=e.deptno) dname,
(SELECT loc FROM dept d WHERE d.deptno=e.deptno) loc
FROM emp e
ORDER BY hiredate ASC;














