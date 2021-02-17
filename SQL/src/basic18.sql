-- 2021-02-17 DML (6장)
/*
     1. DML (데이터 조작언어) 
        = SELECT (데이터 검색)
        형식)
              SELECT * | column1,column2
              FROM table_name|view_name|SELECT~
              [
                 WHERE 컬럼명(함수) 연산자 값
                 GROUP BY 컬럼명(함수)
                 HAVING 그룹 조건
                 ORDER BY 컬럼명(함수명) ASC|DESC
              ]
        = INSERT (데이터 추가)
        형식)
              1) 컬럼 전체 값을 채우는 방식 
                 = 컬럼의 데이터형 (숫자:10,20..,문자:' ',날짜:'YY/MM/DD',SYSDATE) => '' ,' '
                                                              ===  ===
                                                              NULL 공백
                 INSERT INTO table_name(view_name)(*) VALUES(값1,값2,값3..:테이블이 가지고 있는 갯수만큼)
                                        
              2) 필요한 컬럼만 채우는 방식 
                 INSERT INTO table_name(컬럼1,컬럼2...) VALUES(컬럼값1,컬럼값2...)
        = UPDATE (데이터 수정)
        형식) 
              UPDATE table_name SET
              컬럼명=값,컬럼명=값,컬럼명=값... 
              ============================= 전체 데이터 변경 
              [WHERE 조건] ================ 수정이 필요한 부분 변경 
        = DELETE (데이터 삭제)
        형식) 
             DELETE FROM table_name
             [WHERE 조건]
        = 테이블은 기본적으로 중복이 없는 데이터를 가지고 있어야 한다 (데이터 무결성 : PRIMARY KEY)
                           =============== ID,그외는 숫자
          이상현상 : 수정,삭제 => 원하지 않는 데이터 변경
          
        1) 테이블 만들기 
           = 방법 
             테이블명 설정 
             1. 알파벳(한글)으로 시작한다 
             2. 숫자를 사용 할 수 있다 (앞에 사용 금지)
             3. 키워드는 사용이 가능(가급적이면 사용 금지 권장) : SELECT , FROM ,ORDER BY
             4. 특수문자 사용 가능( _ , $ , # ) => _ (임시테이블,두개이상 단어) 
                => 오라클은 대소문자 구분을 하지 않는다(단 저장된 데이터는 대소문자 구분)
                => 오라클에 테이블명은 자동으로 대문자로 저장된다 
             5. 테이블명,컬럼명은 30byte까지 사용이 가능 (한글은 15자) => 5~10
             데이터형 
             1. 문자형 ==> 자바(String)
                CHAR(1~2000byte) : 고정 바이트 
                VARCHAR2(1~4000byte) : 가변 바이트 
                CLOB 4GB : 가변 바이트 
             2. 숫자형
                NUMBER(1~38,~127)
                정수 : NUMBER , NUMBER(자리수) => int , long
                실수 : NUMBER(자리수,소수점)    => double
             3. 날짜형 ==> java.util.Date
                DATE : 시스템의 날짜,시간.. 
                TIMESTAMP : 기록 
             형식
             *** table_name은 유일값이다 (중복된 이름을 사용하면 않된다) => 한개의 데이터베이스안에서(XE)
             *** 테이블명 확인 
                 SELECT * FROM tab;
             *** 테이블 구조 확인 
                 DESC table_name
             *** 변경 , 삭제 => ALTER , DROP , 리팩토링:RENAME(컬럼명,테이블명)
                              ======
                              컬럼변경(MODIFY), 컬럼삭제(DROP COLUMN) ,컬럼 추가(ADD)
             *** 가상테이블 = WITH
             === 기존의 테이블을 재사용 
             CREATE TABLE table_name
             AS (SELECT ~ )
             CREATE TABLE table_name
             AS (SELECT ~ WHERE 1=2)
                                ==== false이면 테이블 구조
             === 새로운 테이블 제작
             CREATE TABLE table_name
             (
                 컬럼명 데이터형 [제약조건], => 컬럼레벨
                 컬럼명 데이터형 [제약조건],
                 컬럼명 데이터형 [제약조건],
                 컬럼명 데이터형 [제약조건],
                 컬럼명 데이터형 [제약조건],
                 ...,
                 [제약조건] => 테이블레벨
             );
  
*/
-- 테이블 생성 
/*
     게시판 
      = 게시물번호 (중복없는 데이터) => MAX , SEQUENCE  => NUMBER (자리수를 정하지 않는 경우 14)
      = 이름 : VARCHAR2(34)
      = 제목 : VARCHAR2(4000)
      = 내용 : CLOB
      = 비밀번호 : VARCHAR2(10)
      = 작성일 : DATE
      = 조회수 NUMBER(7)
      = 좋아요 : NUMBER(7)
*/
CREATE TABLE freeboard(
   no NUMBER,
   name VARCHAR2(34),
   subject VARCHAR2(4000),
   content CLOB,
   pwd VARCHAR2(10),
   regdate DATE DEFAULT SYSDATE,
   hit NUMBER(7) DEFAULT 0,
   like1 NUMBER(7) DEFAULT 0
);

-- 구조 확인 
DESC freeboard;
-- 데이터 추가(전체값 추가)
INSERT INTO freeboard VALUES(1,'홍길동','DML의 INSERT수업중...','데이터 추가하는 연습..','1234',SYSDATE,0,0);
COMMIT; -- 실제로 메모리에 저장 (확정)
SELECT * FROM freeboard;
-- 데이터 일부만 추가 => DEFAULT가 적용 
INSERT INTO freeboard(no,name,subject,content,pwd) 
VALUES(2,'심청이','DEFAULT 적용..','DEFAULT는 컬럼을 지정해야 적용','1234');
COMMIT;
-- 3 , 4 
INSERT INTO freeboard(no,name,subject,content,pwd)
VALUES((SELECT NVL(MAX(no)+1,1) FROM freeboard),'박문수','자동 증가 번호 이용','MAX()+1=SEQUENCE','1234');
COMMIT;
-- 자동 증가 번호 생성 
-- 첫번째 데이터 없는 경우  => no : NULL 
-- SELECT NVL(MAX(no)+1,1) FROM freeboard;
-- 반드시 (DML을 사용시에는 COMMIT을 사용한다) => COMMIT이 없는 상태에서는 임시기억 
-- INSERT 방식 , INSERT , INSERT ALL
-- CREATE , TRUNCATE , DROP , ALTER , RENAME => 자동 저장 (COMMIT을 사용할 필요가 없다)
-- INSERT , UPDATE , DELETE => COMMIT을 수행 
CREATE TABLE emp_insert
AS SELECT empno,ename,job,hiredate,sal 
   FROM emp
   WHERE 1=2;

INSERT INTO emp_insert
SELECT empno,ename,job,hiredate,sal FROM emp;

SELECT * FROM emp_insert;

CREATE TABLE emp_10
AS 
  SELECT * FROM emp WHERE 1=2;
  
CREATE TABLE emp_20
AS
  SELECT * FROM emp WHERE 2=3;

CREATE TABLE emp_30
AS
  SELECT * FROM emp WHERE 100=200;

-- 분기별 실적 
INSERT ALL
  WHEN deptno=10 THEN
   INTO emp_10 VALUES(empno,ename,job,mgr,hiredate,sal,comm,deptno)
  WHEN deptno=20 THEN
   INTO emp_20 VALUES(empno,ename,job,mgr,hiredate,sal,comm,deptno)
  WHEN deptno=30 THEN
   INTO emp_30 VALUES(empno,ename,job,mgr,hiredate,sal,comm,deptno)
SELECT * FROM emp;

SELECT * FROM emp_10;
SELECT * FROM emp_20;
SELECT * FROM emp_30;

DROP TABLE emp_insert;
DROP TABLE emp_10;
DROP TABLE emp_20;
DROP TABLE emp_30;
DROP TABLE emp1;
DROP TABLE op1;
DROP TABLE op2;
DROP TABLE table1;
DROP TABLE table2;
DROP TABLE zipcode1;

-- genie_music ==> 두개를 따로 저장  music_top200 , music_genre => INSERT ALL
DESC genie_music;
-- 구조
CREATE TABLE music_top200
AS
 SELECT no,title,singer,album,poster,state,idcrement 
 FROM genie_music 
 WHERE 1=2;
 
CREATE TABLE music_genre
AS
 SELECT no,title,singer,album,poster,state,idcrement 
 FROM genie_music 
 WHERE 1=2;

-- 값을 채운다 
INSERT ALL
  WHEN cno=1 THEN
   INTO music_top200 VALUES(no,title,singer,album,poster,state,idcrement)
  WHEN cno=2 THEN
   INTO music_genre VALUES(no,title,singer,album,poster,state,idcrement)
SELECT no,cno,title,singer,album,poster,state,idcrement 
FROM genie_music;

SELECT * FROM music_top200;
SELECT * FROM music_genre;

-- emp에서 입사년도별로 따로 저장 
DESC emp;
SELECT DISTINCT TO_CHAR(hiredate,'YYYY') FROM emp;

-- emp1980 , emp1981 , emp1982 , emp1983
CREATE TABLE emp1980
AS
 SELECT * FROM emp WHERE 1=2;
CREATE TABLE emp1981
AS
 SELECT * FROM emp WHERE 1=2;
CREATE TABLE emp1982
AS
 SELECT * FROM emp WHERE 1=2;
CREATE TABLE emp1983
AS
 SELECT * FROM emp WHERE 1=2;
 
-- 데이터 첨부 ==> 
INSERT ALL
 WHEN TO_CHAR(hiredate,'YYYY')=1980 THEN
   INTO emp1980 VALUES(empno,ename,job,mgr,hiredate,sal,comm,deptno)
 WHEN TO_CHAR(hiredate,'YYYY')=1981 THEN
   INTO emp1981 VALUES(empno,ename,job,mgr,hiredate,sal,comm,deptno)
 WHEN TO_CHAR(hiredate,'YYYY')=1982 THEN
   INTO emp1982 VALUES(empno,ename,job,mgr,hiredate,sal,comm,deptno)
 WHEN TO_CHAR(hiredate,'YYYY')=1983 THEN
   INTO emp1983 VALUES(empno,ename,job,mgr,hiredate,sal,comm,deptno)
SELECT * FROM emp;
SELECT * FROM emp1983;

CREATE TABLE empTotal
AS
 SELECT * FROM emp WHERE 1=2;
DESC empTotal;
MERGE INTO empTotal et
USING emp1983 e1
ON (et.empno=e1.empno)
WHEN MATCHED THEN
  UPDATE SET et.ename=e1.ename
WHEN NOT MATCHED THEN
INSERT VALUES(e1.empno,e1.ename,e1.job,e1.mgr,e1.hiredate,e1.sal,e1.comm,e1.deptno);

SELECT * FROM empTotal;

