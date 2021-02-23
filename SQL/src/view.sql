-- 2021-02-22 VIEW 
/*
    View : ������ �ִ� ���� (SELECT�� ����� ����) => DML(INSERT,UPDATE,DELETE)
    => �����ϴ� ���̺� ���� 
    => DML�� ������ ���� (DEFAULT => WITH CHECK OPTION) 
    => �б� ���� (���� => WITH READ ONLY)
    ���� : �Ѱ��̻��� ���̺��� �����͸� �����ؼ� �������� �ʿ��� �����͸� ��Ƽ� ó�� 
    1. View�� ����ϴ� ���� 
       1) ������ SQL�� �ܼ�ȭ ��ų �� �ִ� 
       2) ���� ���̺� => ���� 
       3) ���ǻ��� : ���� ���̺� ������ ��ģ�� 
    2. View�� ���� 
       1) �ܼ��� : �Ѱ��� ���̺� ���� => �ʿ��� �����͸� ��Ƽ� ����  
          ������� 
             CREATE [OR REPLACE] VIEW view_name
             AS
               SELECT * FROM emp;
               => INSERT , UPDATE , DELETE : emp���̺� ������ ��ģ��
               
             CREATE [OR REPLACE] VIEW view_name
             AS
              SELECT * FROM emp WITH CHECK OPTION; (DML�� ���� => DEFAULT)
            
            CREATE [OR REPLACE] VIEW view_name
             AS
              SELECT * FROM emp WITH READ ONLY;  (�б� ���� : SELECT)
       2) ���պ� : �Ѱ��̻� (JOIN,SUBQuery) ���̺� ���� 
           CREATE [OR REPLACE] 
           ======     =======
            ����        ����
           
           CREATE [OR REPLACE] VIEW view_name
           AS
            SELECT empno,ename,hiredate,sal,dname,loc
            FROM emp,dept
            WHERE emp.deptno=dept.deptno; => DML(X)
            
       SQL�� �ܼ�ȭ(Java���� SQL������ ����� ���)
       ===========
         String sql="SELECT empno,ename,hiredate,sal,dname,loc "
                    +"FROM emp,dept "
                    +"WHERE emp.deptno=dept.deptno";
         String sql="SELECT * FROM view_name";
       ***3) �ζ��� �� : ���̺� ��� SELECT ������ �̿��ؼ� �ַ� ó�� (����¡���)
          CREATE [OR REPLACE] (X)
          SELECT * (������ �÷��� ��� �� ����
          FROM (SELECT ~) => ����
                ======== ������ �÷�
            
              => SubQuery => �ݵ�� (subquery) :()�� ���� ���� ����=> �ٸ� SQL������ ����
          ��) SELECT empno,ename,job,hiredate,sal    ==> ���� 
              FROM (SELECT empno,ename,job,sal,comm,deptno => hiredate�� �������� �ʾҴ�
                    FROM emp);
              => FROM (SELECT~)
                      ========= �ݵ�� ()�� ����Ѵ� 
       4) MATERIALIZED VIew (MView) : ��üȭ�� �� (�ӵ��� ������ , 11g���� (XE) => Rewrite�� �ȵȴ�)
          REWRITE : INSERT , UPDATE , DELETE (12C => XE����(11g => 18C)
          => SQL������ �����ϱ����� �����͸� �̸� ������ �ͼ� => Ȱ�� 
*/
-- �ܼ��� : �Ѱ��� ���̺��� �����ؼ� �������� �����͸� ó�� 
/*CREATE OR REPLACE VIEW movie_view
AS
 SELECT * FROM movie
 WHERE genre LIKE '%�׼�%';

SELECT * FROM movie_view;
*/
-- ���̺� ���� 
CREATE TABLE dept_test
AS
 SELECT * FROM dept;

SELECT * FROM dept_test;

-- VIEW��  ����
CREATE OR REPLACE VIEW dept_view
AS
  SELECT * FROM dept_test;

SELECT * FROM dept_view;

-- DML
INSERT INTO dept_view VALUES(50,'���ߺ�','����');
COMMIT;

-- VIEWȮ��
SELECT * FROM dept_view;
-- ���̺� Ȯ��
SELECT * FROM dept_test;

-- DML�� ������� �ʰ� ����� OPTION => WITH READ ONLY
CREATE OR REPLACE VIEW dept_view
AS
  SELECT * FROM dept_test WITH READ ONLY;
  
INSERT INTO dept_view VALUES(50,'���ߺ�','����');
COMMIT;

-- ���պ� : �ΰ� �̻��� ���̺��� �����ϴ� VIEW (���տ�����(UNION,UNION ALL,MINUS,INTERSECT),MERGE,JOIN)
CREATE OR REPLACE VIEW emp_dept_view
AS
  SELECT empno,ename,job,hiredate,sal,dname,loc,grade
  FROM emp,dept,salgrade
  WHERE emp.deptno=dept.deptno
  AND sal BETWEEN losal AND hisal;

SELECT * FROM emp_dept_view; -- SQL������ �ܼ�ȭ

CREATE OR REPLACE VIEW emp_union
AS
  SELECT * FROM emp_10
  UNION
  SELECT * FROM emp_20;

SELECT * FROM emp_union;

--  �ζ��κ� 
/*
     View�� �ʿ�ÿ� ������ ���� ������ ���� (�ʿ��� ��ġ���� ����)
     �ζ��κ�� �����ϴ� ���� �ƴ϶� FROM���� SELECT�� �̿��ؼ� ��� (�������� , �ζ��κ� => ������ ������)
     
     ����)
         SELECT * 
         FROM (SELECT~~)
*/
SELECT *
FROM (SELECT * FROM emp);

-- ���μ��� �޿��� �ִ밪�� ���ϴ� SQL
SELECT e.deptno, dname,sal
FROM (SELECT deptno,MAX(sal) sal
      FROM emp
      GROUP BY deptno) e,dept d
WHERE e.deptno=d.deptno;
-- SELECT ���� (������ �˻�, ���̺� ���(�ζ��κ�),�÷� ���(��Į�� ��������) ����� ����)
-- rownum : ����Ŭ���� ���� => ����ɶ� �� ROW���� ��ȣ ���� 
-- rownum�� �̿��� �̿��ϴ� ���α׷� (Top-N:�α���� 10��..), ������ ������, �Խ���,��ȭ(�󼼺��� => ��������)
-- rownum�� �߰��� ������ ��ȣ�� ���� 
SELECT empno,ename,job,hiredate,sal,rownum
FROM emp_test;
-- ���� => COMMIT�� ����ϸ� ROLLBACK�� ��� �� �� ���� 
DELETE FROM emp_test
WHERE empno=7499;
ROLLBACK;

-- 5���� ������ �´� 
SELECT empno,ename,job,hiredate,sal,rownum
FROM emp_test
WHERE rownum<=5;

-- ���� 5�� => ���� 5�� , �α����(hit�� ���� ��)... 
-- �޿��� ���� ��� ������ ��� 
SELECT ename,sal,rownum
FROM emp_test;

SELECT ename,sal,rownum
FROM emp_test
WHERE rownum<=5
ORDER BY sal DESC;

SELECT ename,sal,rownum
FROM (SELECT ename,sal FROM emp ORDER BY sal DESC) -- rownum�� ���� ����
WHERE rownum<=5;

-- ���� : rownum�� �̿��ؼ� ���ϴ� �κи� ������ ��¿� (������ ��� ���� , �߰��� �ڸ��� ���� �Ұ���)

SELECT ename,sal,rownum
FROM (SELECT ename,sal FROM emp ORDER BY sal DESC) -- rownum�� ���� ����
WHERE rownum BETWEEN 1 AND 5;

SELECT ename,sal,rownum
FROM (SELECT ename,sal FROM emp ORDER BY sal DESC) -- rownum�� ���� ����
WHERE rownum BETWEEN 6 AND 10;
-- �ʼ������� ���� 
-- ���պ� , �ܼ��� (�÷��� ���� �ִ� ��� => SQL������ ���̱� ���ؼ� ���� ��� 
SELECT ename,sal,num
FROM (SELECT ename,sal,rownum as num 
      FROM (SELECT ename,sal FROM emp ORDER BY sal DESC)) -- rownum�� ���� ����
WHERE num BETWEEN 11 AND 14;

-- ��ȭ => movie (title, actor, director, score,poster) => 1938 => 20�� ���� (����� �Ѵ��� �� �� �ִ� 15~20)
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
FROM (SELECT mno,title FROM movie ORDER BY mno ASC)) -- rownum�� �Ѱ� �÷����� �ν�=> ����
WHERE num BETWEEN 21 AND 40;

SELECT mno,title,rownum
FROM (SELECT mno,title FROM movie ORDER BY mno ASC)
WHERE mno=1;
SELECT mno,title,rownum
FROM (SELECT mno,title FROM movie ORDER BY mno ASC)
WHERE mno=2;
-- �÷����� �����Ͱ� �����ɶ� �������� , rownum�� �����Ͱ� �����ɶ� ��ȣ�����Ǵ� ���� �ƴ϶� => ���� ����ش� 
-- ArrayList
-- MView => ������ ���� (hr/happy: �����)
-- 1. MView
CREATE MATERIALIZED VIEW m_emp2
BUILD IMMEDIATE -- MView�� �����ϴ� ��� �������� (AS �ؿ� �ִ� ������ �����ϰ� => �����͸� MView�� ����)
REFRESH
ON DEMAND -- ����ȭ (���� ������) => View�� �������Ŀ� ���������͸� ����
COMPLETE -- ����ȭ ������ ��ü 
AS
 SELECT * FROM emp;
 
SELECT * FROM m_emp2;
-- page 412 : ���� ���̺� (����Ȱ��� �����Ͱ� �ƴ϶� SELECT~������ ����Ǿ� �ִ�) 
-- page 413 : ����(�޸𸮿� ���� �����Ͱ� �������� �ʱ� ������ => ��ŷ(X) ������ ����)
-- �ӵ��� �ʴ� : ����� ��û ==> View�� Select�� ���� => �������̺�
-- �ַ� ��� : �˻� (�ǹ����� Ȱ�뵵�� ���� ��ü , ������� �ʴ� ��ü�� �ִ�)
-- page 414 : ���� (�ܼ���) : => XE(������ �ο��Ǿ� �ִ�)
/*
    ���� : => ��� ���� : SYSTEM,SYSDBA (�����ͺ��̽� ������) , hr�� ����� ����
          conn SYSTEM/happy
          conn / as SYSDBA 
          => GRANT CREATE VIEW TO hr
    �ܼ��� : �Ѱ��� ���̺� ���� 
            ����) CREATE [OR REPLACE] VIEW view_name
                 AS 
                    SUBQUERY (SELECT ~~)
            => DML�� ����� �� �ִ� (page 416)
            DML(INSERT,UPDATE,DELETE) => ���� ���̺� ������ �߻� �� �� �ִ� 
            => ���� : WITH READ ONLY => SELECT�� ����� ���� �ϰ� ����� 
    page 419 : ���պ� (������ ���̺� ����) => ���տ�����(������ ������ ����),JOIN =>View�� ����ϸ� SQL������ ����Ⱑ ����
               SELECT * FROM [teble_name|view_name|SELECT~]
               => ���α׷����� ����(����� ���������� ���� ��쿡 �ַ� ���)
               => ���(JOIN),�󼼺��� ... 
    page 421 : �ζ��κ� (View�� �������� �ʰ� select������ �̿��ؼ� �����͸� ������ ���� SQL)
               ����) 
                    SELECT ~ 
                    FROM (SELECT~) => rownum�� �̿�(������ ������)
                    rownum : ����Ŭ���� �ڵ����� �����ϴ� ��ȣ (������ ��ȣ�� ����)
                    ����� ������ (����� �޸� ����)
    page 425 : MView : ��üȭ�� �� (��ȿ� �����Ͱ��� ä�� ���� ����)
    
*/


