-- 2021-02-22 SubQuery 
/*
    JOIN : (한개 이상)여러개의 테이블에서 필요한 데이터를 모아서 관리 (저장된 데이터와 관련) 
           => SELECT에서만 사용 
    SubQuery : SQL문장을 합쳐서 데이터를 가지고 온다 (자바에서 많이 사용)
           => SELECT , INSERT , UPDATE ,DELETE에서 사용이 가능                           
               브라우저 =========> 자바  =========> 오라클 
                         요청            SQL문장 만들어서 전송 
                         
               브라우저  <========== 자바  <============ 오라클
                          데이터를 모아서  SQL실행된 데이터 전송
                       ======================================= 네트워크 프로그램(최대한 패킷을 한번에 전송)
    사용하는 위치)  테이블 대신 사용이 가능 , 컬럼대신 사용이 가능 
                  INSERT INTO member VALUES((SELECT NVL(MAX(no)+1,1) FROM member)....)
    
    서브쿼리 사용 방식)
                  SELECT * FROM emp
                  ================== 메인쿼리
                  WHERE empno=(SELECT~)
                              ========== 서브쿼리
                  1. 서브쿼리가 먼저 실행 => 결과값 => 메인 쿼리로 전송해서 실행 
    종류 
      = 단일행 서브쿼리  : 결과값이 1개면 
      = 다중행 서브쿼리  : 결과값이 여러개면 
      = 스칼라 서브쿼리  : 컬럼 대신 사용하는 방식 
      = 다중 컬럼 서브쿼리(사용빈도가 거의 없다) : 컬럼값이 여러개 
      = With절을 이용해 서브쿼리 
*/
SELECT sal FROM emp WHERE empno=7788; -- 단일행 
SELECT sal FROM emp;  -- 다중행
SELECT sal , comm FROM emp WHERE empno=7788; -- 다중컬럼 

-- 문제 : SCOTT사원과 같은 부서에서 근무하는 사원의 이름,입사일,직위 출력 
/*
     SCOTT => deptno
     deptno=> 같은 부서의 사원 
*/
SELECT deptno FROM emp WHERE ename='SCOTT';
SELECT ename,hiredate,job FROM emp WHERE deptno=20;

-- 한개의 SQL문장으로 변경 => 서브쿼리 
SELECT ename,hiredate,job FROM emp
WHERE deptno=(SELECT deptno FROM emp WHERE ename='SCOTT');

-- emp에서 평균급여보다 작게 받는 사원의 이름,급여,입사일 출력 
--        ========== ================================
--        SUBQUERY         메인Query
-- 1. 평균 급여 구하기 
SELECT ROUND(AVG(sal),0) FROM emp;
-- 2. 평균보다 작은 사원 검색 
SELECT ename,sal,hiredate FROM emp
WHERE sal<2073;

-- SQL문장 합치기
SELECT ename,sal,hiredate FROM emp
WHERE sal<(SELECT ROUND(AVG(sal),0) FROM emp);

-- DML전체에서 사용이 가능 => SQL문장이 복잡해진다 (JOIN,SUBQUERY) 

SELECT * FROM dept
WHERE EXISTS(SELECT deptno FROM dept WHERE deptno=&dno);



