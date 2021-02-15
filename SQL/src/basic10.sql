-- 2021-02-15 집합함수 (Group By)
/*
    전체 데이터를 대상으로 통계를 구하는 프로그램 
    COUNT() : 전체 로우의 갯수(등록한)
              = 로그인 처리 
              = 아이디 중복체크 
              형식) 
                   COUNT(*) : NULL값을 포함 
                   COUNT(column): NULL값을 제외 
    MAX() : 전체 데이터중에 최고값을 가지고 올때
              = 자동증가 번호  생성  => MAX()+1
                ===========  게시판 , 장바구니 , 예매하기 
    MIN() : 최소값 
    AVG() : 전체를 대상으로 평균  (column)
    SUM() : 전체를 대상으로 합 
    RANK() : 순위 결정 
             1 2 3 3 5
    DENSE_RANK() : 순위 결정 
             1 2 3 3 4
    CUBE() :   ROW단위 계산 + Column단위 계산
    ROLLUP() : ROW단위 계산 
    
    # 주의점 
    일반 컬럼과는 동시에 사용이 불가능하다 
    단일행 함수와 동시에 사용이 불가능하다 
    예)
        SELECT ename,count(*) FROM emp => (X)
        SELECT count(*),substr() FROM emp => (X)
*/
-- COUNT() 함수 => 등록된 갯수
-- 사원이 몇명인지 확인 
SELECT COUNT(*) FROM emp; -- NULL값을 포함 
SELECT COUNT(comm) FROM emp; -- NULL값을 제외 
SELECT COUNT(mgr) FROM emp;
-- 영화의 총갯수 = movie
SELECT COUNT(*) FROM movie;
-- 음악의 총갯수 = genie_music
SELECT COUNT(*) FROM genie_music;
/*
CREATE TABLE member(
   id VARCHAR2(10),
   pwd VARCHAR2(10)
);
INSERT INTO member VALUES('hong','1234');
INSERT INTO member VALUES('shim','1234');
COMMIT;
SELECT * FROM member;
*/
-- SELECT id FROM member WHERE id='kim';
-- 급여가 1500이상이고 3000이하인 사원의 갯수
-- sal>=1500 AND sal<=3000
-- sal BETWEEN 1500 AND 3000
SELECT COUNT(*) FROM emp
WHERE sal BETWEEN 1500 AND 3000;

SELECT COUNT(*) FROM emp
WHERE sal>=1500 AND sal<=3000;

-- 영화(Movie)에서  장르가 액션이 영화의 갯수를 확인 
SELECT COUNT(*) FROM movie
WHERE genre LIKE '%액션%';

SELECT COUNT(*) FROM movie
WHERE REGEXP_LIKE(genre,'액션');
-- 웹사이트 => 검색

-- 음악(genie_music) 가수중에 방탄소년단의 노래가 몇개 
SELECT singer FROM genie_music;
SELECT COUNT(*) FROM genie_music
WHERE singer='방탄소년단';
-- MAX => 최대값  => 형식 : MAX(column명) 
SELECT MAX(sal),MIN(sal) FROM emp;
SELECT MAX(empno),MIN(empno) FROM emp;

-- AVG(평균) => 형식) AVG(column명)
-- emp(저장공간)에 등록된 사원의 급여의 평균을 가지고 온다 
SELECT AVG(sal) FROM emp;
-- 사원중에 평균보다 급여가 많은 사원이 몇명인가?
SELECT COUNT(*) FROM emp
WHERE sal>2073;
SELECT COUNT(*) FROM emp
WHERE sal>(SELECT AVG(sal) FROM emp);
-- 서브쿼리
-- SUM(합)   => 형식) SUM(column명)
SELECT SUM(sal),ROUND(AVG(sal),0) FROM emp; 
-- 사원중에 사번이 홀수인 사원의 급여합 , 인원수 , 급여평균을 출력
SELECT SUM(sal),COUNT(*),AVG(sal) FROM emp
WHERE MOD(empno,2)=1;

-- deptno(부서번호) 부서별로 인원수,급여합,급여평균
-- 10 , 20 , 30
SELECT COUNT(*),SUM(sal),AVG(sal) FROM emp
WHERE deptno=10;
SELECT COUNT(*),SUM(sal),AVG(sal) FROM emp
WHERE deptno=20;
SELECT COUNT(*),SUM(sal),AVG(sal) FROM emp
WHERE deptno=30;
/*
SELECT deptno,COUNT(*),SUM(sal),AVG(sal) FROM emp
GROUP BY deptno;
*/
-- 누가 잘 묶는가? (메소드,클래스) => 함수
-- RANK => 형식) RANK() OVER(ORDER BY column명 ASC|DESC)
SELECT empno,ename,sal,RANK() OVER(ORDER BY sal DESC) "rank"
FROM emp;
SELECT empno,ename,sal,DENSE_RANK() OVER(ORDER BY sal DESC) "rank"
FROM emp;

-- 사원중에 입사한 순서로 등수를 설정 (이름,입사일, 등수)
SELECT ename,hiredate,RANK() OVER(ORDER BY hiredate ASC) "입사순"
FROM emp;
SELECT ename,hiredate,DENSE_RANK() OVER(ORDER BY hiredate ASC) "입사순"
FROM emp;
-- SORT
-- 사원의 이름을 A.B.C..
SELECT ename , RANK() OVER(ORDER BY ename ASC) "이름순"
FROM emp;

-- GROUP BY 
SELECT * FROM emp;
SELECT * FROM emp 
ORDER BY deptno ASC;

-- GROUP BY 컬럼명 (함수)
/*
     1.그룹함수는 사용이 가능 , 그룹으로 설정된 컬럼이나 함수를 제외하고 
       나머지는 같이 사용이 불가능
     
     SELECT deptno,ename,AVG(sal)
     FROM emp
     GROUP BY deptno;
     
     2. 그룹컬럼에 별칭을 사용 할 수 없다 
     
     
*/
-- 부서별 인원수 , 급여의 합
SELECT deptno,COUNT(*),SUM(sal)
FROM emp
GROUP BY deptno;

-- 입사년도별로 인원수 , 급여의 평균 (반올림)
-- 입사년도 1980 
SELECT TO_CHAR(hiredate,'YYYY'), COUNT(*), ROUND(AVG(sal),0)
FROM emp
GROUP BY hiredate;

SELECT TO_CHAR(hiredate,'RRRR'),COUNT(*),ROUND(AVG(sal),0)
FROM emp
GROUP BY TO_CHAR(hiredate,'RRRR')
ORDER BY TO_CHAR(hiredate,'RRRR');

-- 입사년도별로 인원수 , 급여 평균을 출력 => 전체 급여평균보다 많은 그룹 출력)
SELECT TO_CHAR(hiredate,'RRRR'),COUNT(*),ROUND(AVG(sal),0)
FROM emp
--WHERE sal>(SELECT AVG(sal) FROM emp)
-- WHERE sal>AVG(sal)
GROUP BY TO_CHAR(hiredate,'RRRR')
HAVING AVG(sal)>2073;

SELECT TO_CHAR(hiredate, 'YYYY'),COUNT(*), ROUND(AVG(sal),0)
FROM emp
WHERE sal > (SELECT AVG(sal) FROM emp)
GROUP BY  TO_CHAR(hiredate, 'YYYY')
ORDER BY  TO_CHAR(hiredate, 'YYYY');

-- 영화(movie) 개봉년도별로 영화 갯수가 몇개인지?
SELECT SUBSTR(regdate,1,4),COUNT(*) 
FROM movie
GROUP BY SUBSTR(regdate,1,4)
ORDER BY 1;
-- 뮤직(genie_music) 가수별 노래가 몇곡인지?
SELECT singer , COUNT(*)
FROM genie_music
GROUP BY singer;
/*
    SELECT문장의 순서
    ================
    SELECT 
    FROM 
    ================ 필수 
    [
       WHERE 
       ===========
       GROUP BY
       HAVING =======> 그룹에 대한 조건 GROUP BY가 있는 경우에만 사용이 가능
       ===========
       ORDER BY
    ]
*/
-- 이중 GROUP BY   ==> 컬럼명,컬럼명
SELECT * FROM emp
ORDER BY deptno;

SELECT deptno,job,COUNT(*),SUM(sal),AVG(sal)
FROM emp
GROUP BY deptno,job
ORDER BY deptno;

-- 부서별 => 부서안에 입사년도별 , SUM(sal) , COUNT(*)
SELECT deptno,TO_CHAR(hiredate,'YYYY'),SUM(sal),COUNT(sal)
FROM emp
GROUP BY deptno,TO_CHAR(hiredate,'YYYY')
ORDER BY deptno;

-- ROLLUP.CUBE => 반드시 GROUP BY를 이용한다 
SELECT deptno,job,COUNT(*)
FROM emp
GROUP BY ROLLUP(deptno,job);

SELECT NVL(deptno,0),NVL(job,'total'),COUNT(*)
FROM emp
GROUP BY CUBE(deptno,job);
-- 자바,오라클 => NULL값 
-- ROLLUP => 뮤직 => 가수명 , 상태 , COUNT(*)
SELECT singer,state , COUNT(*)
FROM genie_music
GROUP BY ROLLUP(singer,state);

SELECT singer,state , COUNT(*)
FROM genie_music
GROUP BY CUBE(singer,state);
/*
     1. GROUP BY (컴럼 , 함수(날짜 => DATE (TO_CHAR) , VARCHAR2 (SUBSTR))
     2. 그룹에 대한 조건 => HAVING 
     3. 그룹 함수 
        = COUNT(*) 
        = MAX()
        = AVG(),SUM()
        = RANK() , DENSE_RANK()
     4. ROLLUP , CUBE
     
     ==================== 기본 SQL
     ==================== 고급 SQL (JOIN,SUBQUERY) 
     = DDL 
     = TCL 
     = VIEW , SEQUENCE , INDEX , PL/SQL 
     = 오라클을 배우는 것이 아니라 => 자바에서 사용하는 오라클 SQL (2주) 
*/









