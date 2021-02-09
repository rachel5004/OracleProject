-- ��ȯ �Լ� 
/*
     ����Ŭ �������� 
     =============
     
     ������ => String
       = CHAR(1~2000byte)  CHAR(2) => ����
         CHAR(100) => 'A' 
       = ***VARCHAR2(1~4000byte) => ����  VARCHAR2(100) 'A' => 1byte
       = ***CLOB (4GA) => ���� 
     ������ => int / double
       = ***NUMBER(1~38) => NUMBER(4) NUMBER => 14�ڸ�  int a="100";
       = NUMBER(7,2) => 7�ڸ��� ���ڸ� �Ҽ������� ��� 
     ��¥�� => java.util.Date
       = ***DATE
       = TIMESTAMP : ��ϰ��� 
     ��Ÿ�� => �̹���,������ , �ִϸ��̼�  : InputStream
       = BLOB (4GA) : Binary����
       = BFILE (4GA): ���� ����
       
       
     ���� ��ȯ : TO_CHAR
     ���� ��ȯ : TO_NUMBER
     ��¥ ��ȯ : TO_DATE
     
     2+'2' => 4
*/
--SELECT 2+TO_NUMBER('2') FROM DUAL;
--SELECT 2+ASCII('12') FROM DUAL;--'0' = 48
-- ���� ��ȯ (TO_CHAR)  => String.valueOf()
-- ��¥ ��ȯ 
SELECT ename,hiredate,TO_CHAR(hiredate,'yyyy-mm-dd') FROM emp;
SELECT ename,hiredate,TO_CHAR(hiredate,'YYYY"�⵵" MM"��" DD"��"') FROM emp;
SELECT SYSDATE,TO_CHAR(SYSDATE,'RRRR-MM-DD HH24:MI:SS') FROM DUAL;
/*
    ��¥ ���ڿ��� ���� 
    �⵵ : YYYY(yyyy) , YYY(yyy) , YY(yy)
           RRRR,RR (2000�⵵ Y2K) 
     �� : MM
     �� : DD
     �ð� : HH , HH24 
     �� : MI
     �� : SS
     
    ���� : 999999
     '10' 'A' 
*/
SELECT ename,sal,TO_CHAR(sal,'L999,999') FROM emp;
SELECT TO_NUMBER('10') , TO_DATE('21/02/09') FROM DUAL;
-- '2' Integer.parseInt() , SimpleDateFormat()
-- ��Ÿ �Լ� (NVL:NULL���� �ٸ� ���� ������ �� ���)
-- NVL2(comm,��,��)
-- NVL2(comm,sal+comm,sal+0)
-- ''=>NULL ' '=>���� 
-- NVL => ���������� ����� 
SELECT ename,sal "�޿�",comm "������", sal+NVL(comm,0) "������" FROM emp;
SELECT zipcode,sido,gugun,dong,NVL(bunji,' ') FROM zipcode;
-- NVL2
-- NVL2(�÷���(NULL�� �ִ�),ó�� , ó��)
SELECT ename,sal,comm,NVL2(comm,sal+comm,sal) FROM emp;--���׿�����
-- DECODE => ���� ���ǹ�)
/*
    DECODE(�÷���,10,''
                 20,''
                 30,''
                 40,'')
                 
                 DECODE(tel,02,'����'
                           032,'��õ'
*/
-- Trigger
SELECT ename,job,sal,deptno,DECODE(deptno,10,'���ߺ�',
                                20,'������',
                                30,'��ȹ��') "�μ�"
FROM emp;

SELECT ename,job,deptno,CASE WHEN deptno=10 THEN '���ߺ�'
                             WHEN deptno=20 THEN '������'
                             WHEN deptno=30 THEN '��ȹ��'
                             END "�μ�"
FROM emp;

SELECT ename,job,sal,CASE WHEN sal>=800 AND sal<=1500 THEN '1���'
                          WHEN sal>1500 AND sal<=2000 THEN '2���'
                          WHEN sal>2000 AND sal<=2500 THEN '3���'
                          WHEN sal>2500 AND sal<=3000 THEN '4���'
                          WHEN sal>3000 THEN '5���'
                          END "grade"
FROM emp;

SELECT * FROM emp;
SELECT ename,job,DECODE(job,'MANAGER','������',
                            'SALESMAN','�Ǹ���',
                            'ANALYST','�м���',
                            'CLERK','�Ϲݻ��',
                            'PRESIDENT','����') "����"
FROM emp;

-- NVL , NVL2 
/*
     ���� �Լ� : LENGTH,SUBSTR , RPAD 
     ���� �Լ� : CEIL
     ��¥ �Լ� : SYSDATE , MONTHS_BETWEEN
     ��ȯ �Լ� : TO_CHAR
     ��Ÿ �Լ� : NVL
                DECODE (�ణ)
*/










