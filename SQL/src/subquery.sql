-- 2021-02-22 SubQuery 
/*
    JOIN : (�Ѱ� �̻�)�������� ���̺��� �ʿ��� �����͸� ��Ƽ� ���� (����� �����Ϳ� ����) 
           => SELECT������ ��� 
    SubQuery : SQL������ ���ļ� �����͸� ������ �´� (�ڹٿ��� ���� ���)
           => SELECT , INSERT , UPDATE ,DELETE���� ����� ����                           
               ������ =========> �ڹ�  =========> ����Ŭ 
                         ��û            SQL���� ���� ���� 
                         
               ������  <========== �ڹ�  <============ ����Ŭ
                          �����͸� ��Ƽ�  SQL����� ������ ����
                       ======================================= ��Ʈ��ũ ���α׷�(�ִ��� ��Ŷ�� �ѹ��� ����)
    ����ϴ� ��ġ)  ���̺� ��� ����� ���� , �÷���� ����� ���� 
                  INSERT INTO member VALUES((SELECT NVL(MAX(no)+1,1) FROM member)....)
    
    �������� ��� ���)
                  SELECT * FROM emp
                  ================== ��������
                  WHERE empno=(SELECT~)
                              ========== ��������
                  1. ���������� ���� ���� => ����� => ���� ������ �����ؼ� ���� 
    ���� 
      = ������ ��������  : ������� 1���� 
      = ������ ��������  : ������� �������� 
      = ��Į�� ��������  : �÷� ��� ����ϴ� ��� 
      = ���� �÷� ��������(���󵵰� ���� ����) : �÷����� ������ 
      = With���� �̿��� �������� 
*/
SELECT sal FROM emp WHERE empno=7788; -- ������ 
SELECT sal FROM emp;  -- ������
SELECT sal , comm FROM emp WHERE empno=7788; -- �����÷� 

-- ���� : SCOTT����� ���� �μ����� �ٹ��ϴ� ����� �̸�,�Ի���,���� ��� 
/*
     SCOTT => deptno
     deptno=> ���� �μ��� ��� 
*/
SELECT deptno FROM emp WHERE ename='SCOTT';
SELECT ename,hiredate,job FROM emp WHERE deptno=20;

-- �Ѱ��� SQL�������� ���� => �������� 
SELECT ename,hiredate,job FROM emp
WHERE deptno=(SELECT deptno FROM emp WHERE ename='SCOTT');

-- emp���� ��ձ޿����� �۰� �޴� ����� �̸�,�޿�,�Ի��� ��� 
--        ========== ================================
--        SUBQUERY         ����Query
-- 1. ��� �޿� ���ϱ� 
SELECT ROUND(AVG(sal),0) FROM emp;
-- 2. ��պ��� ���� ��� �˻� 
SELECT ename,sal,hiredate FROM emp
WHERE sal<2073;

-- SQL���� ��ġ��
SELECT ename,sal,hiredate FROM emp
WHERE sal<(SELECT ROUND(AVG(sal),0) FROM emp);

-- DML��ü���� ����� ���� => SQL������ ���������� (JOIN,SUBQUERY) 

SELECT * FROM dept
WHERE EXISTS(SELECT deptno FROM dept WHERE deptno=&dno);



