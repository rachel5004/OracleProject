-- ���� �ּ� 
/*
     ������ �ּ� 
     ����Ŭ ǥ���� 
       = ����ǥ�� : 10 , 10.5 => ���� / �Ǽ� 
       = ����/���ڿ� ǥ�� : 'A'=(����) ,'ABC' (���ڿ�) => ""(�ο��ȣ:��Ī)
       = ��¥ǥ��: '' (���ڿ� �������� ����) 
                  ����) 'YY/MM/DD' => '21/02/08'
     �����ͺ��̽�
     ����Ŭ 
     SQL 
      = DQL : SELECT (����� �����͸� �˻�)
              = SELECT�� ���� 
              = ���� 
                 = ������ 
              = ���� �Լ� => ���ó 
                 = ������ �Լ�
                 = ���� �Լ� 
              = JOIN : ������ ���� 
                 = INNER JOIN
                   = EQUI_JOIN
                   = NON_EQUI_JOIN
                 = OUTER JOIN (INNER JOIN+����)
                   = LEFT_OUTER_JOIN
                   = RIGTH_OUTER_JOIN
                   = FULL_OUTER_JON
              = SUBQUERY : SQL���� ���� 
                   = ������ ��������
                   = ������ ��������
                   = ��Į�� �������� : �÷���� ���
                   = �ζ���(Top-N) : ���̺� ��� ���
      = DML : ���۾�� (�߰� , ����, ����)
              INSERT , UPDATE , DELETE 
      ------------------------------------- �����α׷��Ӱ� ��� 
      = DCL : DBA (���Ѻο� / ���� ����)
                 GRANT   /  REVOKE
      = DDL : ���� => CREATE , ALTER , DROP , RENAME , TRUNCATE 
                      ����      ����    ����    �̸� ����  �߶󳻱�
                      �������� : ����Ŭ�� ����Ǵ� ������ (����) : �ʿ��� �����͸� ����
                               (����ȭ�� ������)
                               => ����ȭ (������Ʈ)
      = TCL : ���� ���� / ��� 
              COMMIT  / ROLLBACK => TRANSACTION (�ϰ�ó��) : Spring,JSP
              
      ����� ��û ========> Java  ============> ����Ŭ 
            �����͸� �޾Ƽ� => SQL�������� ��ȯ => ����Ŭ ���� 
              <========= Java  <============= ����Ŭ
              
      1. SQL (DQL) => Column���� ��� �ִ��� Ȯ�� 
                      ======== �ڹ� �������
                      1) Column�� Ȯ�� => DESC table�� => table(column+record)
                                                                      ======= row
                                         ����Ŭ�� �����Ͱ� ������ �ɶ� �⺻������ table (column��+���� ������)
                      2) ����Ŭ ���� 
                         ========= 1. ��ҹ��� ������ ���� (���: Ű����� �빮�ڷ� ���)
                                   2. ������ �����ϸ� ;�� ����Ѵ� (�ڹٿ��� SQL������ �����Ҷ� ;�� ����ϸ� �����߻�
                                        
*/
DESC emp;
/*
      EMPNO    NOT NULL NUMBER(4)    => ��� (�ߺ��� ����) => ���������� ���� (int)
                        ========= 0~9999
      ENAME             VARCHAR2(4000) => �̸�             => ���ڿ�  ==> ''  WHERE ename='SCOTT' (String)
                                ==== 1~10 => Byte 
      JOB               VARCHAR2(9)   => ����            => ���ڿ� 
      MGR               NUMBER(4)    => ���             => ������ 
      HIREDATE          DATE          => �Ի���          => ��¥�� (java.util.Date)
      SAL               NUMBER(7,2)   => �޿�            => �Ǽ��� (double)
      COMM              NUMBER(7,2)   => ������
      DEPTNO            NUMBER(2)     => �μ���ȣ
                        =========== 0~99 
*/
/*
      ���� , ���� 
      ===   ===
      �����ͺ��̽� , ���̺�
      ========== XE
      DQL : SELECT (����Ŭ�� ����� �����͸� �˻�)
      1) SELECT�� ���� ����
         SELECT *|column��,column��  ==> *(��ü������ �˻�),�ʿ��� �����͸� �б� (column...)
         FROM ���̺��(���ϸ�) ==> for
         [
            1.WHERE ���ǹ�  ==> �ڹ� (if) => ������ 
            2.GROUP BY (�׷��÷�) => �׷캰�� ������ ó�� (�Ի�⵵,������,�μ���)
            3.HAVING �׷� ���� => GROUP BY�� �ִ� ��쿡�� ����� ���� => ������ 
            4.ORDER BY �÷��� (ASC|DESC) => ���� 
                     ename ASC|DESC
         ]
         => ���� , ����  WHERE , ORDER BY
         
*/
-- 1. emp(��� ����) => ��� ��� ������ ���� �޶� 
SELECT * FROM emp;
-- 2. emp(�������) => ��� , �̸� , �޿� 
SELECT empno,ename,sal FROM emp;
-- 3. emp(�������) => �̸� , ���� , �Ի��� 
SELECT ename,job,hiredate FROM emp;
-- 4. SELECT ����� 
SELECT ename,job,hiredate
FROM emp;
-- 5. XE(�����ͺ��̽�:����) : ��� ���̺�(����)�� ���� => ��� ���̺� Ȯ�� 
-- ���̺���� �ߺ��Ǹ� �ȵȴ� (���̺� ���� ����)
SELECT * FROM tab;
/*
    �̹� ������� ���̺� Ȯ�� 
     SELECT * FROM tab;
    �÷� Ȯ�� 
     DESC ���̺��
*/
-- �ɼ� ���� (1. ���ڿ� ����, 2. �÷��� ��Ī , 3.�ߺ����� ������ ���)
/*
     ���ڿ� ���� (�ڹ� + , ����Ŭ || => OR)
     ��Ī hiredate , job , sal
         hiredate "�Ի���"
         hiredate as �Ի���
     �ߺ����� ������ DISTINCT
*/
-- 1. ��Ī 
SELECT empno "���",ename as �̸�,job "����",hiredate as �Ի���,sal "�޿�"
FROM emp;
-- 2. �ߺ����� ������ (���� ����)
SELECT DISTINCT job FROM emp;
-- 3. �μ�(deptno)�� ������ ������ �´� => ��Ī�� �μ���ȣ 
SELECT DISTINCT deptno "�μ���ȣ"
FROM emp;
-- 4. ���ڿ� ���� (||)
SELECT '�̸��� '||ename||'�̰� �Ի����� '||hiredate||'�Դϴ�'  as �������
FROM emp;
   










