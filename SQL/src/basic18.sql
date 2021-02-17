-- 2021-02-17 DML (6��)
/*
     1. DML (������ ���۾��) 
        = SELECT (������ �˻�)
        ����)
              SELECT * | column1,column2
              FROM table_name|view_name|SELECT~
              [
                 WHERE �÷���(�Լ�) ������ ��
                 GROUP BY �÷���(�Լ�)
                 HAVING �׷� ����
                 ORDER BY �÷���(�Լ���) ASC|DESC
              ]
        = INSERT (������ �߰�)
        ����)
              1) �÷� ��ü ���� ä��� ��� 
                 = �÷��� �������� (����:10,20..,����:' ',��¥:'YY/MM/DD',SYSDATE) => '' ,' '
                                                              ===  ===
                                                              NULL ����
                 INSERT INTO table_name(view_name)(*) VALUES(��1,��2,��3..:���̺��� ������ �ִ� ������ŭ)
                                        
              2) �ʿ��� �÷��� ä��� ��� 
                 INSERT INTO table_name(�÷�1,�÷�2...) VALUES(�÷���1,�÷���2...)
        = UPDATE (������ ����)
        ����) 
              UPDATE table_name SET
              �÷���=��,�÷���=��,�÷���=��... 
              ============================= ��ü ������ ���� 
              [WHERE ����] ================ ������ �ʿ��� �κ� ���� 
        = DELETE (������ ����)
        ����) 
             DELETE FROM table_name
             [WHERE ����]
        = ���̺��� �⺻������ �ߺ��� ���� �����͸� ������ �־�� �Ѵ� (������ ���Ἲ : PRIMARY KEY)
                           =============== ID,�׿ܴ� ����
          �̻����� : ����,���� => ������ �ʴ� ������ ����
          
        1) ���̺� ����� 
           = ��� 
             ���̺�� ���� 
             1. ���ĺ�(�ѱ�)���� �����Ѵ� 
             2. ���ڸ� ��� �� �� �ִ� (�տ� ��� ����)
             3. Ű����� ����� ����(�������̸� ��� ���� ����) : SELECT , FROM ,ORDER BY
             4. Ư������ ��� ����( _ , $ , # ) => _ (�ӽ����̺�,�ΰ��̻� �ܾ�) 
                => ����Ŭ�� ��ҹ��� ������ ���� �ʴ´�(�� ����� �����ʹ� ��ҹ��� ����)
                => ����Ŭ�� ���̺���� �ڵ����� �빮�ڷ� ����ȴ� 
             5. ���̺��,�÷����� 30byte���� ����� ���� (�ѱ��� 15��) => 5~10
             �������� 
             1. ������ ==> �ڹ�(String)
                CHAR(1~2000byte) : ���� ����Ʈ 
                VARCHAR2(1~4000byte) : ���� ����Ʈ 
                CLOB 4GB : ���� ����Ʈ 
             2. ������
                NUMBER(1~38,~127)
                ���� : NUMBER , NUMBER(�ڸ���) => int , long
                �Ǽ� : NUMBER(�ڸ���,�Ҽ���)    => double
             3. ��¥�� ==> java.util.Date
                DATE : �ý����� ��¥,�ð�.. 
                TIMESTAMP : ��� 
             ����
             *** table_name�� ���ϰ��̴� (�ߺ��� �̸��� ����ϸ� �ʵȴ�) => �Ѱ��� �����ͺ��̽��ȿ���(XE)
             *** ���̺�� Ȯ�� 
                 SELECT * FROM tab;
             *** ���̺� ���� Ȯ�� 
                 DESC table_name
             *** ���� , ���� => ALTER , DROP , �����丵:RENAME(�÷���,���̺��)
                              ======
                              �÷�����(MODIFY), �÷�����(DROP COLUMN) ,�÷� �߰�(ADD)
             *** �������̺� = WITH
             === ������ ���̺��� ���� 
             CREATE TABLE table_name
             AS (SELECT ~ )
             CREATE TABLE table_name
             AS (SELECT ~ WHERE 1=2)
                                ==== false�̸� ���̺� ����
             === ���ο� ���̺� ����
             CREATE TABLE table_name
             (
                 �÷��� �������� [��������], => �÷�����
                 �÷��� �������� [��������],
                 �÷��� �������� [��������],
                 �÷��� �������� [��������],
                 �÷��� �������� [��������],
                 ...,
                 [��������] => ���̺���
             );
  
*/
-- ���̺� ���� 
/*
     �Խ��� 
      = �Խù���ȣ (�ߺ����� ������) => MAX , SEQUENCE  => NUMBER (�ڸ����� ������ �ʴ� ��� 14)
      = �̸� : VARCHAR2(34)
      = ���� : VARCHAR2(4000)
      = ���� : CLOB
      = ��й�ȣ : VARCHAR2(10)
      = �ۼ��� : DATE
      = ��ȸ�� NUMBER(7)
      = ���ƿ� : NUMBER(7)
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

-- ���� Ȯ�� 
DESC freeboard;
-- ������ �߰�(��ü�� �߰�)
INSERT INTO freeboard VALUES(1,'ȫ�浿','DML�� INSERT������...','������ �߰��ϴ� ����..','1234',SYSDATE,0,0);
COMMIT; -- ������ �޸𸮿� ���� (Ȯ��)
SELECT * FROM freeboard;
-- ������ �Ϻθ� �߰� => DEFAULT�� ���� 
INSERT INTO freeboard(no,name,subject,content,pwd) 
VALUES(2,'��û��','DEFAULT ����..','DEFAULT�� �÷��� �����ؾ� ����','1234');
COMMIT;
-- 3 , 4 
INSERT INTO freeboard(no,name,subject,content,pwd)
VALUES((SELECT NVL(MAX(no)+1,1) FROM freeboard),'�ڹ���','�ڵ� ���� ��ȣ �̿�','MAX()+1=SEQUENCE','1234');
COMMIT;
-- �ڵ� ���� ��ȣ ���� 
-- ù��° ������ ���� ���  => no : NULL 
-- SELECT NVL(MAX(no)+1,1) FROM freeboard;
-- �ݵ�� (DML�� ���ÿ��� COMMIT�� ����Ѵ�) => COMMIT�� ���� ���¿����� �ӽñ�� 
-- INSERT ��� , INSERT , INSERT ALL
-- CREATE , TRUNCATE , DROP , ALTER , RENAME => �ڵ� ���� (COMMIT�� ����� �ʿ䰡 ����)
-- INSERT , UPDATE , DELETE => COMMIT�� ���� 
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

-- �б⺰ ���� 
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

-- genie_music ==> �ΰ��� ���� ����  music_top200 , music_genre => INSERT ALL
DESC genie_music;
-- ����
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

-- ���� ä��� 
INSERT ALL
  WHEN cno=1 THEN
   INTO music_top200 VALUES(no,title,singer,album,poster,state,idcrement)
  WHEN cno=2 THEN
   INTO music_genre VALUES(no,title,singer,album,poster,state,idcrement)
SELECT no,cno,title,singer,album,poster,state,idcrement 
FROM genie_music;

SELECT * FROM music_top200;
SELECT * FROM music_genre;

-- emp���� �Ի�⵵���� ���� ���� 
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
 
-- ������ ÷�� ==> 
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

