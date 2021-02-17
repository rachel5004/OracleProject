-- UPDATE (데이터 수정)
/*
     형식) 
          UPDATE table_name SET
          컬럼명=값,컬럼명=값...
          [WHERE 조건]
*/
-- View 제작 (가상테이블)
CREATE TABLE student(
   name VARCHAR2(34),
   kor NUMBER(3),
   eng NUMBER(3),
   math NUMBER(3),
   hap NUMBER(3) GENERATED ALWAYS AS(kor+eng+math) virtual,
   avg NUMBER(5,2) GENERATED ALWAYS AS((kor+eng+math)/3) virtual
);
-- 데이터 추가
INSERT INTO student(name,kor,eng,math) VALUES('홍길동',89,78,90);
INSERT INTO student(name,kor,eng,math) VALUES('심청이',80,90,60);
INSERT INTO student(name,kor,eng,math) VALUES('박문수',70,88,95);
INSERT INTO student(name,kor,eng,math) VALUES('박문수',75,90,78);
COMMIT;
-- 출력 이름,국어,영어,수학,총점,평균(소수점 2자리),등수
SELECT student.*,(kor+eng+math) "total",ROUND((kor+eng+math)/3,2) "avg",
       RANK() OVER(ORDER BY (kor+eng+math) DESC) "rank"
FROM student;
-- 수정 
UPDATE student SET
kor=80,eng=78,math=90;
ROLLBACK; -- UPDATE명령어 취소 
UPDATE student SET
kor=80,eng=78,math=90
WHERE name='심청이';
COMMIT;
-- 테이블 => 중복이 없는 데이터가 반드시 필요
UPDATE student SET
kor=90,eng=90,math=60 -- =는 대입연산자
WHERE name='박문수'; -- =비교연산자
ROLLBACK;

DROP TABLE student;


-- DELETE (데이터 삭제) => COMMIT(정상 저장) , ROLLBACK (명령어 취소)
/*
    형식) 
       DELETE FROM table_name -- 데이터 전체 삭제 => TRUNCATE(COMMIT을 포함)
       [WHERE 조건] -- 원하는 데이터만 삭제
       
       => INSERT => COMMIT
       => DELETE => ROLLBACK
       => SELECT
*/
DELETE FROM student;
SELECT * FROM student;
ROLLBACK;

-- 홍길동 삭제
DELETE FROM student
WHERE name='홍길동';
COMMIT;
-- 280 page (read only) : 일기 전용 테이블 (INSERT,UPDATE,DELETE는 사용 금지 , SELECT만 사용이 가능)
-- 282 page (가상 컬럼) : hap NUMBER(3) GENERATED ALWAYS AS(kor+eng+math) virtual,
-- 296 page (INSERT) : 전체 table_name, 필요한 데이터 첨부 table_name(컬럼...)
-- 301 page : 서브쿼리를 이용해서 데이터 첨부 
/*
     INSERT INTO emp1
     SELECT ~
*/
-- 302 page : 테이블을 나눠서 처리  INSERT ALL
-- 305 page : UPDATE 
-- 306 page : DELETE
-- 문법 형식 
-- INSERT : 1. 날짜 , 2. NULL값 첨부 
-- 날짜 : SYSDATE => '21/02/18'
CREATE TABLE reserve(
   id VARCHAR2(10),
   regdate DATE,
   seat VARCHAR2(10)
);

INSERT INTO reserve VALUES('hong',SYSDATE,NULL);

INSERT INTO reserve VALUES('shim',SYSDATE,'');

INSERT INTO reserve VALUES('park','21/02/20',NULL);
SELECT * FROM reserve;

ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';
ALTER SESSION SET NLS_DATE_FORMAT='YY/MM/DD';
SELECT * FROM emp;


