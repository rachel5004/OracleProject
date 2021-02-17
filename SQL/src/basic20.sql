/*
    DML (CRUD)
      = INSERT
        ����)
             INSERT INTO table_name VALUES(��1....) => ��� �÷��� ���� ����
             INSERT INTO table_name(�÷���...) VALUES(������ �÷��� ������ŭ) => �ʿ��� ������ �߰�
             *** NULL���� ���� (NULL,'')
             *** ���ڿ�,��¥�� ��� : '' , ���� : �Ϲ�
      = UPDATE
        ����) 
             ==============================
             UPDATE table_name SET
             �÷���=������,�÷���=������...
             ============================== ��ü ���� (������ �޿� �λ�)
             [WHERE ����]      ============= �ʿ��� ������ ���� 
      = DELETE
        ����)
             DELETE FROM table_name
             [WHERE ����]
      = MERGE (����)
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
  
-- ���� ä��� (�԰�,���,���) => ��Ƽ�� ���̺� 
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
   ���� (ERP) : ���� (�λ����,�޿�����,��������...�������)
   ����)
        MERGE INTO table1 ��Ī => ������ ���̺� 
        USING table2 ��Ī => �����͸� ������ �ִ� ���̺� 
        ON(����)
        WHEN MATCHED THEN (������ TRUEó��)
          UPDATE,DELETE
        WHEN NOT MATCHED THEN (������ FALSEó��)
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
 







