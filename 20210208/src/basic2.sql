/*
     WHERE : ���ϴ� ���Ǹ� ��󳻱� (40page)
     ## ���ڿ� , ��¥ => ''�� �̿��Ѵ� 
        ""�� ��Ī�̳� �ο��ȣ�� ����Ҷ� ��� 
     ���� => ������  
     1. ����Ŭ���� �����ϴ� ������(NULL�� ����ó���ϸ� NULL) 
        = ���׿����� 
           SELECT sal*12,sal+comm
        1) ��������� : + , - , * , / (������:MOD)
                      / => 0���� ���� �� ���� , ����/����=�Ǽ� (5/2=2.5)
        2) �񱳿����� : =(����) , !=(�����ʴ�) => <> , ^=
                      < , > , <= , >=
        3) �������� : AND , OR => (&&: Scanner, ||: ���ڿ� ����)
        4) NULL ������ 
                = IS NULL : NULL�� ��� ó��
                = IS NOT NULL : NULL���� �ƴ� ��� ó��
        5) IN ������ : OR�� ������ �ϰ�쿡 ��� 
                WHERE deptno=10 OR deptno=20 OR deptno=30
                WHERE deptno IN(10,20,30)
        6) BETWEEN ~ AND : �Ⱓ , ������ ����  => ���� => ������ ������ 
                WHERE deptno BEWEEN 10 AND 30  ==> detpno>=10 AND deptno<=30 
        7) LIKE : ���繮�ڿ� �˻� 
                  % : ���ڿ� 
                      ��) A%  => A�� �����ϴ� ��� ���ڿ� 
                          %A  => A�� ������ ��� ���ڿ�
                          %A% => A�� ���Ե� ��� ���ڿ� 
                  _ : �ѱ� ���� 
                      ��) __O__  => 5���� ��� O�� ���Ե� ���ڿ� 
                      => �Լ� : REGEXP_LIKE("���Խ�",value)
            SELECT �÷��� ,(SELECT~ ) as "" , (SELECT ~) as ""
            SEELCT ~ FROM (SELECT~~)
            SELECT => ������ �˻� (�ķ����,���̺� ���)
        8) NOT : ���� 
                 NOT LIKE => !LIKE(X)
                 NOT IN
                 NOT BETWEEN ~ AND
*/
--SELECT ename , sal+comm FROM emp;
-- ����ó�� (���������) emp , ������ ���̺� (DUAL)  SELECT 1+2 FROM DUAL;
-- ����Ŭ�� ��ҹ��� ������ ���� (�� ��ҹ��� ������ �ִ� ���� �ִ� => ����� ������) 
--SELECT * FROM emp WHERE ename='KING';
-- String sql="SELECT * FROM emp WHERE ename='KING'";
--SELECT * FROM emp WHERE ename=KING;
-- String sql="SELECT * FROM emp WHERE ename=KING";
-- 1. ��������� => ����ȯ (�Լ�: TO_CHAR,TO_NUMBER,TO_DATE) 
SELECT 10+20,10-20,10*20,5/2 FROM DUAL;
-- ����/����=�Ǽ�
-- NULL ���� ���� ���� ���� => ����ó�� NULL�� �ִ� ��쿡�� ����ó�� = NULL
SELECT 10+null , 5/2 FROM DUAL;
-- emp���� �̸�,���� �޿�(sal,comm)�� ������ ���
-- ��� �����ڴ� boolean(true/false) => ���ǹ����� ����� �Ұ���  (SELECT �ڿ��� ó��)
SELECT ename,sal+NVL(comm,0),sal*12 FROM emp;
-- �񱳿����� ( = , != , < , > , <= , >=)
-- �μ���ȣ�� 10�� ����� �̸�,�μ���ȣ,������ ��� 
SELECT ename,deptno,job,hiredate
FROM emp
WHERE deptno=10+10;
-- ����̸��� SCOTT�� ����� ��� ������ ���  => *
SELECT * 
FROM emp
WHERE ename='SCOTT';
-- ����߿� 1981�� 4�� 1�Ͽ� �Ի��� ����� ��� ������ ��� 
-- ��¥ => ''
-- ��¥ ���� => YY/MM/DD
SELECT ename,hiredate,TO_CHAR(hiredate,'YYYY-MM-DD')
FROM emp
WHERE hiredate='81/04/01';
-- =�� ���� (==�� �ƴϴ�) =������ (�񱳿����� , ���Կ�����) => WHERE������ =(�񱳿�����) , WHERE�ƴ� �ٸ��� (���Կ�����)
/*
     UPDATE emp SET
     ename='ȫ�浿'  = ����
     WHERE empno=7788 = ��
*/
-- != , <> , ^=
SELECT ename,job 
FROM emp
WHERE ename!='KING';

SELECT ename,job 
FROM emp
WHERE ename<>'KING';

SELECT ename,job 
FROM emp
WHERE ename^='KING';

-- < : ������ ����   sal<1500
SELECT * FROM emp
WHERE sal<1500;

SELECT * FROM emp
WHERE sal>1500;

SELECT * FROM emp
WHERE sal<=1500;

SELECT * FROM emp
WHERE sal>=1500;






