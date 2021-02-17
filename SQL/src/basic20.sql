/*
    DML (CRUD)
      = INSERT
        형식)
             INSERT INTO table_name VALUES(값1....) => 모든 컬럼에 값을 설정
             INSERT INTO table_name(컬럼명...) VALUES(설정된 컬럼의 갯수만큼) => 필요한 데이터 추가
             *** NULL값을 설정 (NULL,'')
             *** 문자열,날짜일 경우 : '' , 숫자 : 일반
      = UPDATE
        형식) 
             ==============================
             UPDATE table_name SET
             컬럼명=값대입,컬럼명=값대입...
             ============================== 전체 수정 (동일한 급여 인상)
             [WHERE 조건]      ============= 필요한 데이터 변경 
      = DELETE
        형식)
             DELETE FROM table_name
             [WHERE 조건]
      = MERGE (병합)
*/
CREATE TABLE emp10
AS
  SELECT * FROM emp WHERE 1=2;

CREATE TABLE emp20
AS
  SELECT * FROM emp WHERE 2=3;

CREATE TABLE emp30
AS
  SELECT * FROM emp WHERE 3=4;
  
CREATE TABLE empAll
AS
  SELECT * FROM emp WHERE 4=5;
  
-- 값을 채운다 (입고,출고,재고) => 파티션 테이블 
INSERT ALL
 WHEN deptno=10 THEN
  INTO emp10 VALUES(empno,ename,job,mgr,hiredate,sal,comm,deptno)
 WHEN deptno=20 THEN
  INTO emp20 VALUES(empno,ename,job,mgr,hiredate,sal,comm,deptno)
 WHEN deptno=30 THEN
  INTO emp30 VALUES(empno,ename,job,mgr,hiredate,sal,comm,deptno)
SELECT * FROM emp;

SELECT * FROM emp10;
SELECT * FROM emp20;
SELECT * FROM emp30;
/*
   병합 (ERP) : 관리 (인사관리,급여관리,물류관리...매장관리)
   형식)
        MERGE INTO table1 별칭 => 저장할 테이블 
        USING table2 별칭 => 데이터를 가지고 있는 테이블 
        ON(조건)
        WHEN MATCHED THEN (조건이 TRUE처리)
          UPDATE,DELETE
        WHEN NOT MATCHED THEN (조건이 FALSE처리)
          INSERT
*/
 MERGE INTO empAll ea
 USING emp30 e10
 ON(ea.empno=e10.empno)
 WHEN MATCHED THEN
   UPDATE SET ea.ename=e10.ename
 WHEN NOT MATCHED THEN
   INSERT VALUES(e10.empno,e10.ename,e10.job,e10.mgr,e10.hiredate,e10.sal,e10.comm,e10.deptno);
   
SELECT * FROM empAll;
 







