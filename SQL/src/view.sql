-- 2021-02-22 VIEW 
/*
    View : 보여만 주는 문장 (SELECT만 사용이 가능) => DML(INSERT,UPDATE,DELETE)
    => 참조하는 테이블에 영향 
    => DML이 가능한 조건 (DEFAULT => WITH CHECK OPTION) 
    => 읽기 전용 (설정 => WITH READ ONLY)
    정의 : 한개이상의 테이블의 데이터를 참조해서 가상으로 필요한 데이터만 모아서 처리 
    1. View를 사용하는 목적 
       1) 복합한 SQL을 단순화 시킬 수 있다 
       2) 가상 테이블 => 보안 
       3) 주의사항 : 원본 테이블에 영향을 미친다 
    2. View의 종류 
       1) 단순뷰 : 한개의 테이블 참조 => 필요한 데이터만 모아서 관리  
          생성방법 
             CREATE [OR REPLACE] VIEW view_name
             AS
               SELECT * FROM emp;
               => INSERT , UPDATE , DELETE : emp테이블에 영향을 미친다
               
             CREATE [OR REPLACE] VIEW view_name
             AS
              SELECT * FROM emp WITH CHECK OPTION; (DML이 가능 => DEFAULT)
            
            CREATE [OR REPLACE] VIEW view_name
             AS
              SELECT * FROM emp WITH READ ONLY;  (읽기 전용 : SELECT)
       2) 복합뷰 : 한개이상 (JOIN,SUBQuery) 테이블 참조 
           CREATE [OR REPLACE] 
           ======     =======
            생성        수정
           
           CREATE [OR REPLACE] VIEW view_name
           AS
            SELECT empno,ename,hiredate,sal,dname,loc
            FROM emp,dept
            WHERE emp.deptno=dept.deptno; => DML(X)
            
       SQL을 단순화(Java에서 SQL문장을 만드는 경우)
       ===========
         String sql="SELECT empno,ename,hiredate,sal,dname,loc "
                    +"FROM emp,dept "
                    +"WHERE emp.deptno=dept.deptno";
         String sql="SELECT * FROM view_name";
       ***3) 인라인 뷰 : 테이블 대신 SELECT 문장을 이용해서 주로 처리 (페이징기법)
          CREATE [OR REPLACE] (X)
          SELECT * (설정된 컬럼을 벗어날 수 없다
          FROM (SELECT ~) => 보안
                ======== 설정한 컬럼
            
              => SubQuery => 반드시 (subquery) :()안 문장 먼저 실행=> 다른 SQL문장을 실행
          예) SELECT empno,ename,job,hiredate,sal    ==> 오류 
              FROM (SELECT empno,ename,job,sal,comm,deptno => hiredate가 존재하지 않았다
                    FROM emp);
              => FROM (SELECT~)
                      ========= 반드시 ()를 사용한다 
       4) MATERIALIZED VIew (MView) : 구체화된 뷰 (속도가 빠르다 , 11g에서 (XE) => Rewrite가 안된다)
          REWRITE : INSERT , UPDATE , DELETE (12C => XE버전(11g => 18C)
          => SQL문장을 실행하기전에 데이터를 미리 가지고 와서 => 활용 
*/
-- 단순뷰 : 한개의 테이블을 참조해서 가상으로 데이터를 처리 
/*CREATE OR REPLACE VIEW movie_view
AS
 SELECT * FROM movie
 WHERE genre LIKE '%액션%';

SELECT * FROM movie_view;
*/
-- 테이블 생성 
CREATE TABLE dept_test
AS
 SELECT * FROM dept;

SELECT * FROM dept_test;

-- VIEW로  변경
CREATE OR REPLACE VIEW dept_view
AS
  SELECT * FROM dept_test;

SELECT * FROM dept_view;

-- DML
INSERT INTO dept_view VALUES(50,'개발부','서울');
COMMIT;

-- VIEW확인
SELECT * FROM dept_view;
-- 테이블 확인
SELECT * FROM dept_test;

-- DML를 사용하지 않게 만드는 OPTION => WITH READ ONLY
CREATE OR REPLACE VIEW dept_view
AS
  SELECT * FROM dept_test WITH READ ONLY;
  
INSERT INTO dept_view VALUES(50,'개발부','서울');
COMMIT;

-- 복합뷰 : 두개 이상의 테이블을 참조하는 VIEW (집합연산자(UNION,UNION ALL,MINUS,INTERSECT),MERGE,JOIN)
CREATE OR REPLACE VIEW emp_dept_view
AS
  SELECT empno,ename,job,hiredate,sal,dname,loc,grade
  FROM emp,dept,salgrade
  WHERE emp.deptno=dept.deptno
  AND sal BETWEEN losal AND hisal;

SELECT * FROM emp_dept_view; -- SQL문장이 단순화

CREATE OR REPLACE VIEW emp_union
AS
  SELECT * FROM emp_10
  UNION
  SELECT * FROM emp_20;

SELECT * FROM emp_union;

--  인라인뷰 
/*
     View는 필요시에 생성해 놓고 재사용이 가능 (필요한 위치에서 재사용)
     인라인뷰는 생성하는 것이 아니라 FROM에서 SELECT를 이용해서 사용 (서브쿼리 , 인라인뷰 => 페이지 나누기)
     
     형식)
         SELECT * 
         FROM (SELECT~~)
*/
SELECT *
FROM (SELECT * FROM emp);

-- 각부서의 급여의 최대값을 구하는 SQL
SELECT e.deptno, dname,sal
FROM (SELECT deptno,MAX(sal) sal
      FROM emp
      GROUP BY deptno) e,dept d
WHERE e.deptno=d.deptno;
-- SELECT 문장 (데이터 검색, 테이블 대신(인라인뷰),컬럼 대신(스칼라 서브쿼리) 사용이 가능)
-- rownum : 오라클에서 지원 => 저장될때 각 ROW마다 번호 설정 
-- rownum을 이용을 이용하는 프로그램 (Top-N:인기순위 10개..), 페이지 나누기, 게시판,영화(상세보기 => 다음보기)
-- rownum은 중간에 빠지는 번호가 없다 
SELECT empno,ename,job,hiredate,sal,rownum
FROM emp_test;
-- 연습 => COMMIT을 사용하면 ROLLBACK을 사용 할 수 없다 
DELETE FROM emp_test
WHERE empno=7499;
ROLLBACK;

-- 5개를 가지고 온다 
SELECT empno,ename,job,hiredate,sal,rownum
FROM emp_test
WHERE rownum<=5;

-- 상위 5개 => 평점 5개 , 인기순위(hit가 많은 거)... 
-- 급여가 많은 사원 순으로 출력 
SELECT ename,sal,rownum
FROM emp_test;

SELECT ename,sal,rownum
FROM emp_test
WHERE rownum<=5
ORDER BY sal DESC;

SELECT ename,sal,rownum
FROM (SELECT ename,sal FROM emp ORDER BY sal DESC) -- rownum의 순서 변경
WHERE rownum<=5;

-- 단점 : rownum을 이용해서 원하는 부분만 데이터 출력에 (위에서 몇개는 가능 , 중간에 자르는 것응 불가능)

SELECT ename,sal,rownum
FROM (SELECT ename,sal FROM emp ORDER BY sal DESC) -- rownum의 순서 변경
WHERE rownum BETWEEN 1 AND 5;

SELECT ename,sal,rownum
FROM (SELECT ename,sal FROM emp ORDER BY sal DESC) -- rownum의 순서 변경
WHERE rownum BETWEEN 6 AND 10;
-- 필수적으로 본다 
-- 복합뷰 , 단순뷰 (컬럼이 많이 있는 경우 => SQL문장을 줄이기 위해서 보통 사용 
SELECT ename,sal,num
FROM (SELECT ename,sal,rownum as num 
      FROM (SELECT ename,sal FROM emp ORDER BY sal DESC)) -- rownum의 순서 변경
WHERE num BETWEEN 11 AND 14;

-- 영화 => movie (title, actor, director, score,poster) => 1938 => 20개 정도 (사람이 한눈에 볼 수 있는 15~20)
SELECT title,actor,director,mno,rownum
FROM movie;

SELECT mno,title,rownum
FROM movie;

SELECT mno,title,rownum
FROM (SELECT mno,title FROM movie ORDER BY mno ASC);

SELECT mno,title,rownum
FROM (SELECT mno,title FROM movie ORDER BY mno ASC)
WHERE rownum<=10;

SELECT mno,title,rownum
FROM (SELECT mno,title FROM movie ORDER BY mno ASC)
WHERE rownum BETWEEN 1 AND 1938;

SELECT mno,title,rownum
FROM (SELECT mno,title FROM movie ORDER BY mno ASC)
WHERE rownum BETWEEN 21 AND 40;

SELECT mno,title,num
FROM (SELECT mno,title,rownum as num
FROM (SELECT mno,title FROM movie ORDER BY mno ASC)) -- rownum을 한개 컬럼으로 인식=> 제어
WHERE num BETWEEN 21 AND 40;

SELECT mno,title,rownum
FROM (SELECT mno,title FROM movie ORDER BY mno ASC)
WHERE mno=1;
SELECT mno,title,rownum
FROM (SELECT mno,title FROM movie ORDER BY mno ASC)
WHERE mno=2;
-- 컬럼값은 데이터가 삭제될때 없어진다 , rownum은 데이터가 삭제될때 번호삭제되는 것이 아니라 => 위로 당겨준다 
-- ArrayList
-- MView => 권한이 없다 (hr/happy: 사용자)
-- 1. MView
CREATE MATERIALIZED VIEW m_emp2
BUILD IMMEDIATE -- MView를 생성하는 즉시 서브쿼리 (AS 밑에 있는 문장을 수행하고 => 데이터를 MView에 저장)
REFRESH
ON DEMAND -- 동기화 (원본 데이터) => View를 갱신한후에 원본데이터를 변경
COMPLETE -- 동기화 범위가 전체 
AS
 SELECT * FROM emp;
 
SELECT * FROM m_emp2;
-- page 412 : 가상 테이블 (저장된것은 데이터가 아니라 SELECT~문장이 저장되어 있다) 
-- page 413 : 가상(메모리에 실제 데이터가 존재하지 않기 때문에 => 해킹(X) 보안이 좋다)
-- 속도가 늦다 : 사용자 요청 ==> View의 Select를 수행 => 원본테이블
-- 주로 사용 : 검색 (실무에서 활용도가 많은 업체 , 사용하지 않는 업체도 있다)
-- page 414 : 종류 (단순뷰) : => XE(권한이 부여되어 있다)
/*
    권한 : => 사용 권한 : SYSTEM,SYSDBA (데이터베이스 관리자) , hr은 사용자 계정
          conn SYSTEM/happy
          conn / as SYSDBA 
          => GRANT CREATE VIEW TO hr
    단순뷰 : 한개의 테이블만 연결 
            형식) CREATE [OR REPLACE] VIEW view_name
                 AS 
                    SUBQUERY (SELECT ~~)
            => DML을 사용할 수 있다 (page 416)
            DML(INSERT,UPDATE,DELETE) => 원본 테이블에 문제가 발생 할 수 있다 
            => 방지 : WITH READ ONLY => SELECT만 사용이 가능 하게 만든다 
    page 419 : 복합뷰 (여러개 테이블 연결) => 집합연산자(가급적 사용금지 권장),JOIN =>View를 사용하면 SQL문장을 만들기가 쉽다
               SELECT * FROM [teble_name|view_name|SELECT~]
               => 프로그램에서 사용빈도(비슷한 쿼리문장이 많은 경우에 주로 사용)
               => 목록(JOIN),상세보기 ... 
    page 421 : 인라인뷰 (View를 생성하지 않고 select문장을 이용해서 데이터를 가지고 오는 SQL)
               형식) 
                    SELECT ~ 
                    FROM (SELECT~) => rownum을 이용(페이지 나누기)
                    rownum : 오라클에서 자동으로 지정하는 번호 (빠지는 번호가 없다)
                    저장된 순서로 (저장된 메모리 순서)
    page 425 : MView : 구체화된 뷰 (뷰안에 데이터값을 채워 놓고 시작)
    
*/


