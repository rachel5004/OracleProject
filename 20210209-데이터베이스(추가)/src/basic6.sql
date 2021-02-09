-- 2021-02-09 SQL ������ �Լ� => row������ ó�� 
/*
     ����Ŭ : �������� ��� 
     1
     2
     3 Error  �԰� 
     4 ��� 
     5
     �Լ� = (����Ŭ���� ���� , ����� ���� �Լ� => PL ) => ����, �ҽ��� �ߺ� ���� (��� �����͸� ����¡ȭ)
      = FUNCTION : �������� ���� 
      = PROCEDURE : �������� ���� �Լ� (void)
     ������ �Լ� (69 page)
     =========
       1) ���� �Լ� (����,���ڿ�)
          = ��ȯ �Լ� 
            1. �빮�� ��ȯ  UPPER('oracle') => ORACLE 
               CREATE FUNCTION UPPER(data VARCHAR2):VARCHAR2
            2. �ҹ��� ��ȯ  LOWER('ORACLE') => oracle
            3. �̴ϼ� ��ȯ  INITCAP('oracle') => Oracle
          = ��Ÿ �Լ� 
            1. LENGTH : ������ ����(�ѱ۵� ����) LENGTH('ABC') => 3 , LENGTH('ȫ�浿') => 3
          = ���� �Լ� 
            1. ���ڿ� ���� :  CONCAT , ||
               CONCAT('Hello','Oracle') => HelloOracle
               'Hello'||'Oracle' => HelloOracle
               =============================
               String s1="Hello";
               String s2="Java";
               s1.concat(s2) => HelloJava
               s1+s2
               ============================
           *** 2. ���� �ڸ��� : SUBSTR()
               SUBSTR('1234567890',������,����) => �ڹٴ� ���� ���۹�ȣ 0,����Ŭ 1
               SUBSTR('1234567890',3,5) => 34567
                 ��� (������) : ����
               SUBSTR('1234567890',-3,2) => 89
                 ���� (������) : ������ 
            3. ���� ��ġ ã�� : INSTR()
                 INSTR('A-B-C-D','-',1,3) => indexOf
                     => 6
                 INSTR('A-B-C-D','-',-1,3) => lastIndexOf
                     => 2
            4. ���鹮�� ���� : LTRIM() , RTRIM() , TRIM() => ���� ���� Ư������ ���� (�¿츸 ����)
            5. ���� �߰� : LPAD() , *** RPAD()
            
       2) ���� �Լ� (����,�Ǽ�)
           = ROUND() : �ݿø�  ���� : ROUND(�Ǽ�,�Ҽ���)  ROUND(67.897,2) => 76.90
           = TRUNC() : ����        : TRUNC(�Ǽ�,�Ҽ���)  TRUNC(67.897,2) => 76.89
           = *** CEIL() : �ø�         : CEIL(67.1) => 68 => ��������
           = MOD() : ������ (%)    : MOD(5,2) => 5%2 = 1
       3) ��¥ �Լ� 
           = *** SYSDATE 
           = *** MONTHS_BETWEEN
           = ADD_MONTHS
           = LAST_DAY
           = NEXT_DAY
       4) ��ȯ �Լ� (���ڿ� , ����,��¥)
           = *** TO_CHAR => ���(�ð�)
           = TO_NUMBER
           = TO_DATE
           = ASCII
       5) ��Ÿ 
           = *** NVL
           = NVL2 
           = DECODE  (���� if)
           = CASE (switch~case)
      6) ���Խ� �Լ� 
*/
-- ���� �Լ� (UPPER(toUpperCase()),LOWER(toLowerCase()),ININCAT)
SELECT ename "�̸�",UPPER(ename) "�빮�ں�ȯ",LOWER(ename) "�ҹ��ں�ȯ",INITCAP(ename) "�̴ϼȺ�ȯ"
FROM emp;
SELECT ename,job
FROM emp
WHERE ename=UPPER('king');
-- ���� �Լ� (SUBSTR) : ���� ���� (�߿��� �Լ� : ���� ���Ǵ� �Լ�)
-- SUBSTR(���ڿ�,������ġ,����) : ���(����) , ����(������) , ����Ŭ ���� ���۹�ȣ�� 1���̴� 
SELECT SUBSTR('1234567890',5,3) FROM DUAL;
--             12345678910
SELECT SUBSTR('1234567890',-5,3) FROM DUAL;
--                 -3-2-1
SELECT SUBSTR(ename,1,2) FROM emp;
SELECT RPAD(SUBSTR(ename,1,2),LENGTH(ename),'*') FROM emp; -- IDã�� 
-- 1980�⿡ �Ի��� ����� ��� ���� 
SELECT *
FROM emp
WHERE SUBSTR(hiredate,1,2)=81;

-- ���� ��ġ ã�� INSTR(���ڿ�,ã�¹���,������ġ,��°) => ��°���� => 1  (��=> ��� , ��:����)
SELECT INSTR('A-B-C-D','-',1,3) FROM DUAL;
-- �� indexOf
SELECT INSTR('A-B-C-D','-',-1,3) FROM DUAL;
-- �� lastIndexOf 

SELECT ename,INSTR(ename,'A',1,2) FROM emp;

-- TRIM() => ���� ���� , Ư������ ���� 
-- LTRIM('���ڿ�','�����ҹ���') => ���ʿ� �ִ� ���ڸ� ���Ű� ����
-- LTRIM('���ڿ�') => ���� ���� 
SELECT LTRIM('AAAAAAAAABACDEFG     ','A') FROM DUAL;
SELECT RTRIM('  ABCDEFG','G') FROM DUAL;
SELECT LENGTH('     ABC    '),LENGTH('ABC') FROM DUAL;
SELECT TRIM(' ' FROM '   ABC   ') FROM DUAL;
SELECT ename,TRIM('S' FROM ename) FROM emp;

-- RPAD , LPAD 
-- LPAD(���ڿ�,���ڰ���,ä�﹮��) => ���ʿ� ä��� 
-- LPAD('ABC',7,'#')  ####ABC
-- RPAD('ABC',7,'#')  ABC####  => IDã��,��й�ȣ ã��
-- LPAD('ABCDEFG',5,'*')  ABCDE
SELECT ename,LENGTH(ename),RPAD(ename,5,'*') FROM emp;
-- ���ڿ� : LENGTH , SUBSTR , RPAD

-- ���� �Լ� : MOD
SELECT MOD(5,2) FROM DUAL; --5%2
-- emp���� ����� ¦���� ����� ��� ���� ��� 
SELECT *
FROM emp
WHERE MOD(empno,2)=0;

SELECT CEIL(COUNT(*)/10) FROM emp;
-- COUNT(*) => emp�� �Ѱ���  14/10 => 1.4 => 2 
-- ROUND (����) , TRUNC(������)
SELECT ROUND(67.894,2),TRUNC(67.894,2) FROM DUAL;
-- ��¥ : SYSDATE => �ý����� ��¥(�ð�����) => ������ 
-- ��¥ ��� (�Խ���,ȸ������,������...)
SELECT SYSDATE-1 "����",SYSDATE "����",SYSDATE+1 "����" FROM DUAL;
-- MONTHS_BETWEEN => �Ⱓ�� �������� �о� �´� 
-- ���� MONTHS_BETWEEN(���糯¥,����¥)
-- emp�� �ִ� ��� => ��� ���ߴ��� Ȯ�� => �ð� + �� => �Ҽ����� ��� �� �� �ִ� 
SELECT ename , hiredate , ROUND(MONTHS_BETWEEN(SYSDATE,hiredate),0) "�ٹ�����",
       TRUNC(ROUND(MONTHS_BETWEEN(SYSDATE,hiredate),0)/12,0) "�ٹ���"
FROM emp;

-- ADD_MONTHS => ������ ���  ����: ADD_MONTHS(��¥,������) => SYSDATE,6
SELECT SYSDATE , ADD_MONTHS('20/12/22',5) FROM DUAL;-- ���� , ����
-- NEXT_DAY , LAST_DAY , ROUND , TRUNC 
-- NEXT_DAY : ���� 
SELECT SYSDATE,NEXT_DAY(SYSDATE,'��') FROM DUAL;
-- LAST_DAY : ����� ���� ������ �� 
-- '21/08/01' => 21/08/31
SELECT SYSDATE,LAST_DAY('21/12/01') FROM DUAL;







