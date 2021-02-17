-- UPDATE (������ ����)
/*
     ����) 
          UPDATE table_name SET
          �÷���=��,�÷���=��...
          [WHERE ����]
*/
-- View ���� (�������̺�)
CREATE TABLE student(
   name VARCHAR2(34),
   kor NUMBER(3),
   eng NUMBER(3),
   math NUMBER(3),
   hap NUMBER(3) GENERATED ALWAYS AS(kor+eng+math) virtual,
   avg NUMBER(5,2) GENERATED ALWAYS AS((kor+eng+math)/3) virtual
);
-- ������ �߰�
INSERT INTO student(name,kor,eng,math) VALUES('ȫ�浿',89,78,90);
INSERT INTO student(name,kor,eng,math) VALUES('��û��',80,90,60);
INSERT INTO student(name,kor,eng,math) VALUES('�ڹ���',70,88,95);
INSERT INTO student(name,kor,eng,math) VALUES('�ڹ���',75,90,78);
COMMIT;
-- ��� �̸�,����,����,����,����,���(�Ҽ��� 2�ڸ�),���
SELECT student.*,(kor+eng+math) "total",ROUND((kor+eng+math)/3,2) "avg",
       RANK() OVER(ORDER BY (kor+eng+math) DESC) "rank"
FROM student;
-- ���� 
UPDATE student SET
kor=80,eng=78,math=90;
ROLLBACK; -- UPDATE��ɾ� ��� 
UPDATE student SET
kor=80,eng=78,math=90
WHERE name='��û��';
COMMIT;
-- ���̺� => �ߺ��� ���� �����Ͱ� �ݵ�� �ʿ�
UPDATE student SET
kor=90,eng=90,math=60 -- =�� ���Կ�����
WHERE name='�ڹ���'; -- =�񱳿�����
ROLLBACK;

DROP TABLE student;


-- DELETE (������ ����) => COMMIT(���� ����) , ROLLBACK (��ɾ� ���)
/*
    ����) 
       DELETE FROM table_name -- ������ ��ü ���� => TRUNCATE(COMMIT�� ����)
       [WHERE ����] -- ���ϴ� �����͸� ����
       
       => INSERT => COMMIT
       => DELETE => ROLLBACK
       => SELECT
*/
DELETE FROM student;
SELECT * FROM student;
ROLLBACK;

-- ȫ�浿 ����
DELETE FROM student
WHERE name='ȫ�浿';
COMMIT;
-- 280 page (read only) : �ϱ� ���� ���̺� (INSERT,UPDATE,DELETE�� ��� ���� , SELECT�� ����� ����)
-- 282 page (���� �÷�) : hap NUMBER(3) GENERATED ALWAYS AS(kor+eng+math) virtual,
-- 296 page (INSERT) : ��ü table_name, �ʿ��� ������ ÷�� table_name(�÷�...)
-- 301 page : ���������� �̿��ؼ� ������ ÷�� 
/*
     INSERT INTO emp1
     SELECT ~
*/
-- 302 page : ���̺��� ������ ó��  INSERT ALL
-- 305 page : UPDATE 
-- 306 page : DELETE
-- ���� ���� 
-- INSERT : 1. ��¥ , 2. NULL�� ÷�� 
-- ��¥ : SYSDATE => '21/02/18'
CREATE TABLE reserve(
   id VARCHAR2(10),
   regdate DATE,
   seat VARCHAR2(10)
);

INSERT INTO reserve VALUES('hong',SYSDATE,NULL);

INSERT INTO reserve VALUES('shim',SYSDATE,'');

INSERT INTO reserve VALUES('park','21/02/20',NULL);
SELECT * FROM reserve;

ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';
ALTER SESSION SET NLS_DATE_FORMAT='YY/MM/DD';
SELECT * FROM emp;


