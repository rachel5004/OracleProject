-- 2021-02-15(4장 - 조인 : SQL고급과정)
/*
     2개이상의 테이블로부터 데이터 수집 경우 : 조인(JOIN)
                        ======
     2개이상의 SQL문장을 합쳐서 데이터 수집 : 서브쿼리    ===> SELECT 
            ================
            
     조인 
      1) 테이블 한개이상에서 필요한 데이터를 찾아오기 
         ============
      2) 조인의 종류 
         = INNER JOIN => 교집합 (값이 같은 것이 있는 경우)
           = EQUI_JOIN
             1. Oracle JOIN
             2. ANSI JOIN
             3. NATURAL JOIN
             4. JOIN~USING
           = NON_EQUI_JOIN
             1. Oracle JOIN
             2. ANSI JOIN
         = OUTER JOIN
           = LEFT OUTER JOIN
           = RIGHT OUTER JOIN
           = FULL OUTER JOIN
*/
SELECT * FROM emp;
SELECT * FROM dept;
/*
SELECT * FROM salgrade;
CREATE TABLE salgrade(
    grade NUMBER,
    losal NUMBER,
    hisal NUMBER
);
INSERT INTO salgrade VALUES(1,700,1200);
INSERT INTO salgrade VALUES(2,1201,1400);
INSERT INTO salgrade VALUES(3,1401,2000);
INSERT INTO salgrade VALUES(4,2001,3000);
INSERT INTO salgrade VALUES(5,3001,9000);
COMMIT;
*/
/*
     INNER JOIN 
     1) EQUI_JOIN
        = Oracle JOIN (A,B) (오라클에서만 사용이 가능)
          SELECT A.col1,A.col2,B.col1,B.col2
          FROM A,B
          WHERE A.col3=B.col3;
        = ANSI JOIN(표준화=>모든 데이터베이스 공동으로 사용이 가능)
          SELECT A.col1,A.col2,B.col1,B.col2
          FROM A (INNER) JOIN B
          ON A.col3=B.col3;
*/
-- emp (사번 , 이름 ,직위, 입사일) , dept (부서명,근무지)  => deptno
SELECT empno,ename,job,hiredate,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno;
-- 테이블의 별칭을 사용 (테이블명이 글자수의 제한)
SELECT empno,ename,job,hiredate,dname,loc
FROM emp e,dept d
WHERE e.deptno=d.deptno;

-- ANSI 
SELECT empno,ename,job,hiredate,dname,loc
FROM emp INNER JOIN dept
ON emp.deptno=dept.deptno;

SELECT empno,ename,job,hiredate,dname,loc
FROM emp JOIN dept
ON emp.deptno=dept.deptno;
------------------------------------- 테이블이 같은 컬럼명이 존재해야 한다 (다른 컬럼을 비교해서 사용:값이 동일)
-- 자연조인
SELECT empno,ename,job,hiredate,dname,loc
FROM emp NATURAL JOIN dept;

-- JOIN _ USING
SELECT empno,ename,job,hiredate,dname,loc
FROM emp JOIN dept USING(deptno);
--------------------------------------------
/*
     테이블 => 컬럼명이 다른 경우에는 컬럼명만 사용해도 된다 , 같은 컬럼명이면 어느 테이블에서 가지고 올 것인지 설정 
*/
SELECT empno,ename,job,hiredate,dname,loc,e.deptno
FROM emp e,dept d
WHERE e.deptno=d.deptno;
/*
     NON EQUI_JOIN : JOIN~USING,NATURAL JOIN은 사용 할 수 없다 
     ============== =이 아닌 다른 연산자를 사용할 경우에 (BETWEEN, >= AND <=)
     EQUI_JOIN : (연산자 = ) => 단점 (연산자를 사용 했기 때문에 NULL값이 있는 경우에는 처리가 불가능하다)
*/
SELECT ename,sal,hiredate,grade
FROM emp,salgrade 
WHERE sal BETWEEN losal AND hisal;
/*
      emp(사원정보)
        empno : 사번
        ename : 이름
        job : 직위
        mgr : 사수번호
        hiredate : 입사일
        sal : 급여
        comm : 성과급
        deptno : 부서번호 
      dept(부서정보)
        deptno : 부서번호
        dname : 부서명
        loc : 근무지 
      salgrade(급여등급)
        grade : 등급 (호봉)
        losal : 최저급여
        hisal : 최대급여 
*/
-- 조인 조건 , 개인 조건 
-- 이름,직위,입사일,급여,부서명,근무지 출력 => 사번이 7788인 사원의 정보출력 
SELECT ename,job,hiredate,sal,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno
AND empno=7788;

-- 위에 Oracle JOIN => ANSI JOIN으로 변경 
SELECT ename,job,hiredate,sal,dname,loc
FROM emp JOIN dept
ON emp.deptno=dept.deptno
AND empno=7788;

-- emp(ename,job,hiredate,sal) , dept(dname,loc) , salgrade(grade)
-- 1. Oracle JOIN
SELECT ename,job,hiredate,sal,dname,loc,grade
FROM emp,dept,salgrade
WHERE emp.deptno=dept.deptno
AND sal BETWEEN losal AND hisal;
-- 2. ANSI JOIN
SELECT ename,job,hiredate,sal,dname,loc,grade
FROM emp 
JOIN dept
ON emp.deptno=dept.deptno
JOIN salgrade
ON sal BETWEEN losal AND hisal;

-- 한개의 테이블에서 조인이 가능 => 반드시 테이블에 별칭을 사용한다 
-- emp(본인 이름),emp(사수 이름)
/*
    조인 조건 
    1. 컬럼명이 같다 (같은 값을 가지고 있다)
       ===========
       primary key , foreign key
    2. 컬럼명이 다르다 (같은 값을 가지고 있다) => 게시판 <==> 댓글 
*/
-- self join
SELECT e1.ename "본인 이름",e2.ename "사수 이름"
FROM emp e1,emp e2
WHERE e1.mgr=e2.empno;
-- 조건검색에 컬럼명이 다르면 NATURAL JOIN,JOIN~USING은 사용이 불가능하다 

-- emp (사번 , 이름 , 직위 , 성과급 , 급여) , dept(부서명 , 근무지) => JOIN , 성괴급을 받는 사원에 대해서만 출력 
SELECT empno,ename,job,comm,sal,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno
AND comm IS NOT NULL AND comm<>0;

-- ANSI JOIN
SELECT empno,ename,job,comm,sal,dname,loc
FROM emp JOIN dept
ON emp.deptno=dept.deptno
AND comm IS NOT NULL AND comm<>0;

-- emp (사번 , 이름 ,직위 , 성과급, 급여) , dept(부서명,근무지 )=> JOIN , 이름중에 A를 포함하고 있는 사원의 정보를 출력 
-- Oracle Join
SELECT empno,ename,job,comm,sal,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno
AND ename LIKE '%A%';
-- ANSI JOIN
SELECT empno,ename,job,comm,sal,dname,loc
FROM emp JOIN dept
ON emp.deptno=dept.deptno
AND ename LIKE '%A%';

-- emp (사번 , 이름 ,직위 , 성과급, 급여) , dept(부서명,근무지 )=> JOIN , 81년에 입사한 사원에 대해서 출력 
SELECT empno,ename,job,comm,sal,hiredate,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno
AND SUBSTR(hiredate,1,2)=81;

SELECT empno,ename,job,comm,sal,hiredate,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno
AND hiredate LIKE '81%';

SELECT empno,ename,job,comm,sal,hiredate,dname,loc
FROM emp JOIN dept
ON emp.deptno=dept.deptno
AND hiredate LIKE '81%';
/*
    자바 : 포함 클래스 
                   사용자 요청               SQL 
    브라우저(HTML)  <========> 자바(파이썬) <=========> 오라클
                     전송                  실행 결과
       
*/
-- OUTER JOIN (INNER JOIN + 알파) => null값을 포함해서 데이터를 가지고 온다 
/*
      = LEFT OUTER JOIN
        1. Oracle JOIN (A,B => col1,col2,col3(공통된 데이터가 있다))
        A.col3  B.col3
          1       1
          2       2
          3       3
          4  (출력을 할 수 없다)
           SELECT A.col1,A.col2,B.col1,B.col2
           FROM A,B
           WHERE A.col3=B.col3(+)
        2. ANSI JOIN 
           SELECT A.col1,A.col2,B.col1,B.col2
           FROM A LEFT OUTER JOIN B
                  ===============
           ON A.col3=B.col3
      = RIGHT OUTER JOIN
        1. Oracle JOIN
           SELECT A.col1,A.col2,B.col1,B.col2
           FROM A,B
           WHERE A.col3(+)=B.col3
        2. ANSI JOIN 
           SELECT A.col1,A.col2,B.col1,B.col2
           FROM A RIGHT OUTER JOIN B
                  ===============
           ON A.col3=B.col3
      = FULL OUTER JOIN(사용빈도가 별로 없다)
        1. ANSI JOIN
           SELECT A.col1,A.col2,B.col1,B.col2
           FROM A FULL OUTER JOIN B
                  ===============
           ON A.col3=B.col3
*/
-- RIGHT 
SELECT empno,ename,job,dept.deptno,dname,loc
FROM emp,dept
WHERE emp.deptno(+)=dept.deptno;

SELECT empno,ename,job,dept.deptno,dname,loc
FROM emp RIGHT OUTER JOIN dept
ON emp.deptno=dept.deptno;

SELECT e1.ename "본인" , e2.ename "사수"
FROM emp e1, emp e2
WHERE e1.mgr=e2.empno(+);

SELECT e1.ename "본인" , e2.ename "사수"
FROM emp e1 LEFT OUTER JOIN emp e2
ON e1.mgr=e2.empno;

SELECT e1.ename "본인" , e2.ename "사수"
FROM emp e1 FULL OUTER JOIN emp e2
ON e1.mgr=e2.empno;
-- 14 (KING,BLAKE,JONES , FORD, SCOTT , CLARK)


