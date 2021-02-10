/*
     논리연산자  ( AND , OR ) 
                 &&(입력값을 받는 경우) ,  ||(문자열 결합)
*/
/*
SELECT * FROM emp
WHERE empno=&no;
*/
-- 부서번호가 20이고 급여가 2000이상 사원의 이름 , 급여 , 부서번호 
--        WHERE                 ========================== SELECT ~
-- 문법 => 문자열 , 날짜 => 반드시 ''을 이용한다 (1.문자열은 대소문자 구분을 한다 , 날짜는 대소문자 구분을 하지 않는다)
/*SELECT ename,hiredate
FROM emp
WHERE hiredate='17-DEC-80';
SELECT ename,hiredate
FROM emp
WHERE hiredate='17-dec-80';
*/
/*
        조건  AND  조건 
        TRUE       TRUE   => TRUE
        TRUE       FALSE  => FALSE
        FALSE      TRUE   => FALSE
        FALSE      FALSE  => FALSE
        
        조건  OR  조건 
        TRUE       TRUE   => TRUE
        TRUE       FALSE  => TRUE
        FALSE      TRUE   => TRUE
        FALSE      FALSE  => FALSE
*/
SELECT ename , sal , deptno
FROM emp
WHERE deptno=20 AND sal>=2000;
-- 비교연산 문자열,날짜도 가능 
SELECT ename,sal,job
FROM emp
WHERE ename>'king';

SELECT ename,sal,hiredate
FROM emp
WHERE hiredate>='82/01/01';

-- OR => job이 MANAGER , CLECK
SELECT ename,job
FROM emp
WHERE job='MANAGER' OR job='CLERK';

-- OR 대신 사용 IN
SELECT ename,job
FROM emp
WHERE job IN('MANAGER','CLERK');

-- emp에서 1981년에 입사한 모든 사원의 모든 정보를 출력
SELECT * 
FROM emp
WHERE hiredate>='81/01/01' AND hiredate<='81/12/31';

-- AND 기간 , 범위 대체 => BETWEEN ~ AND 
SELECT *
FROM emp
WHERE hiredate BETWEEN '81/01/01' AND '81/12/31';

/*SELECT *
FROM emp
WHERE hiredate LIKE '81%';

SELECT *
FROM emp
WHERE substr(hiredate,1,2)=81;
*/
-- AND : 범위나 기간이 포함일 경우에 주로 사용 , OR : 범위나 기간에 포함이 안되는 경우 
-- LIKE : 유사 문자열 검색 (영화검색,우편번호 검색...)  :  %(문자열)  , _(한글자)
-- emp에서 A로 시작하는 이름을 가진 사원의 이름,입사일 
SELECT ename,hiredate
FROM emp
WHERE ename LIKE 'A%'; -- startsWith

-- emp에서 T로 끝나는 이름을 가진 사원의 이름,입사일 
SELECT ename,hiredate
FROM emp
WHERE ename LIKE '%T'; -- endsWith

-- emp에서 W가 포함된  이름을 가진 사원의 이름,입사일 -- contains
SELECT ename,hiredate
FROM emp
WHERE ename LIKE '%I%';

-- emp에서 11월 이거나 12월에 입사한 사원의 이름,입사일 출력 = 글자수를 알 경우에는 _
-- '%/12/%'  10/12
SELECT ename,hiredate
FROM emp
WHERE hiredate LIKE '___11%' OR hiredate LIKE '___12%';

-- emp에서 이름중에 두번째 글자가 A인 사원의 이름만 출력 
SELECT ename
FROM emp
WHERE ename LIKE '_A%';

-- NULL (값이 존재하지 않는다) 
SELECT ename,comm 
FROM emp
WHERE comm IS NULL;

SELECT ename,comm
FROM emp
WHERE comm IS NOT NULL;

-- emp에서 성과급을 받는 사원의 이름,급여,성과급 출력 
SELECT ename,sal,comm
FROM emp
WHERE comm IS NOT NULL AND comm<>0;
-- comm!=0 , comm^=0

-- 부정연산자 not
-- 81년에 입사하지 않은 사원의 이름 , 입사일 
SELECT ename,hiredate
FROM emp
WHERE hiredate NOT LIKE '81%';

-- 10,20,30 => 20번,30번 부서가 아닌 부서에서 근무하는 사원의 이름 부서번호 
SELECT ename,deptno
FROM emp
WHERE deptno NOT IN(20,30);

-- emp에서 급여가 1500~3000사이의 급여가 아닌 사원의 이름,급여 
-- NOT BETWEEN 1500 AND 3000 
SELECT ename,sal
FROM emp
WHERE NOT (sal>=1500 AND sal<=3000);

SELECT ename,sal
FROM emp
WHERE sal NOT BETWEEN 1500 AND 3000;

-- emp에서 사수(mgr)가 없는 사원의 이름과 직위,입사일을 출력 
SELECT ename,job,hiredate
FROM emp
WHERE mgr IS NULL;

-- 집합연산자 
/*
     UNION 
     UNION ALL
     INTERSECT
     MINUS
*/
/*
CREATE TABLE op1(no NUMBER);
CREATE TABLE op2(no NUMBER);
INSERT INTO op1 VALUES(1);
INSERT INTO op1 VALUES(2);
INSERT INTO op1 VALUES(3);
INSERT INTO op1 VALUES(4);
INSERT INTO op1 VALUES(5);

INSERT INTO op2 VALUES(3);
INSERT INTO op2 VALUES(4);
INSERT INTO op2 VALUES(5);
INSERT INTO op2 VALUES(6);
INSERT INTO op2 VALUES(7);
COMMIT;
*/
SELECT no
FROM op1;

SELECT no
FROM op2;

-- UNION : 1234567
SELECT no
FROM op1
UNION
SELECT no
FROM op2;

-- UNION ALL : 1 2 3 4 5 3 4 5 6 7 => FULL OUTER JOIN
SELECT no
FROM op1
UNION ALL
SELECT no
FROM op2;

-- INTERSECT : 3 4 5 (교집합) => INNER JOIN
SELECT no
FROM op1
INTERSECT
SELECT no
FROM op2;

-- MINUS : op1-op2 => 나머지  1 2  op2-op1 => 6 7
SELECT no
FROM op1
MINUS
SELECT no
FROM op2;

SELECT no
FROM op2
MINUS
SELECT no
FROM op1;


