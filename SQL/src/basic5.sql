-- �����Լ� 
/*
       ������ �Լ� : �ѹ��� ���پ� ó�� 
       ������(����) �Լ� : �������� �����͸� ���ÿ� ó�� 
       
       ������ �Լ� 
       ==========
        �����Լ�(String�޼ҵ�)
           = �빮�� ��ȯ = UPPER('hello') => HELLO 
           = �ҹ��� ��ȯ = LOWER('HELLO') => hello
           = �̴ϼ� ��ȯ = INITCAP('hello') => Hello
           ***= ���� ����   = LENGTH('Hello') => 5 , LENGTH('ȫ�浿') => 3
                          LENGTHB('Hello') => 5 , LENGTHB('ȫ�浿') => 9
           = CONCAT = ���ڿ� ���� ( || ) 
             CANCAT('Hello','Java') => HelloJava => 'Hello'||'Java'
           ***= SUBSTR = ���ڸ� �ڸ��� 
             SUBSTR('123456789',3,2) => 12345
                                 === ����
           ***= INSTR : ���ڹ�ȣ ���� 
             INSTR('ABCDE','C') => 3
           = LPAD , ***RPAD (IDã��,��й�ȣã��)
             LPAD('admin' , 10, '*') => *****admin
             ***RPAD('admin' , 10, '*') => admin*****
           = LTRIM,RTRIM ,TRIM : Ư������ ���� (�¿�)
             LTRIM('ABCDA','A') => BCDA
             RTRIM('ABCDA','A') => ABCD
             ***TRIM('A' FROM 'ABCDA') => BCD
             REPLACE('ABCDE','A','B') => BBCDE
        �����Լ�(Math�޼ҵ�)
           ***= CEIL : �ø��Լ� => �������� ���ϱ� 
             CEIL(12345.1) => 12346
           ***= ROUND : �ݿø� => ROUND(12345.678,2) => 12345.68
           = TRUNC : ����   => TRUNC(12345,678,2) => 12345.67 
           = MOD : ������ ������ => MOD(10,2) => 10%2
        ��¥�Լ�(Date�޼ҵ�)
           ***= SYSDATE : �ý����� ���� ��¥,�ð� 
             SYSDATE-1 , SYSDATE+1 => 
           ***= MONTHS_BETWEEN : ������ ��� 
           = ADD_MONTHS : ������ �߰� ADD_MONTHS(SYSDATE,3)
           = NEXT_DAY(SYSDATE,'��')
           = LAST_DAY(SYSDATE) LAST_DAY('21/01/01') => 31
        ��ȯ�Լ�(Wrapper�޼ҵ�)
           ***= TO_CHAR(): ���ڿ� ��ȯ 
           = TO_NUMBER() : ���� ��ȯ 
           = TO_DATE() : ��¥ ��ȯ 
        ��Ÿ�Լ�(����Ŭ ��ü)
           ***= NVL() : ������ NULL�� ��쿡 ��ü
           ***= DECODE : ���� ���ǹ� (if)
           = CASE : switch~case 
    
        �����Լ� 
        =======
          ***COUNT() : Row�� ���� 
          SUM() 
          AVG()
          ***MAX()
          MIN()
          ***RANK()
          CUBE()
          ROLLUP() 
*/
-- �빮�� ,�ҹ��� , �̴ϼ� ��� 
SELECT ename "�Ϲ�", UPPER(ename) "�빮��",LOWER(ename) "�ҹ���",INITCAP(ename) "�̴ϼ�"
FROM emp;

SELECT ename,job,hiredate
FROM emp
WHERE ename=UPPER('king');

SELECT ename,LENGTH(ename) FROM emp;

SELECT ename
FROM emp
WHERE LENGTH(ename)=4;

SELECT ename,LPAD(ename,5,'*') , RPAD(ename,5,'*')
FROM emp;
-- 3,2
SELECT SUBSTR('Hello Oracle',3,2) FROM DUAL;
SELECT SUBSTR('Hello Oracle',-3,2) FROM DUAL;

SELECT INSTR('A-B-C-D', '-',1,3) FROM DUAL;
SELECT INSTR('A-B-C-D', '-',-1,3) FROM DUAL;
SELECT TO_NUMBER('65') FROM DUAL;
--SELECT TO_NUMBER('A') FROM DUAL;
SELECT ASCII('A') FROM DUAL;
SELECT TO_DATE('21/02/09') FROM DUAL;
SELECT empno,ename,sal,comm,NVL2(comm,sal+comm,sal*0) FROM emp;


