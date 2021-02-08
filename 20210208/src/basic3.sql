/*
     ��������  ( AND , OR ) 
                 &&(�Է°��� �޴� ���) ,  ||(���ڿ� ����)
*/
/*
SELECT * FROM emp
WHERE empno=&no;
*/
-- �μ���ȣ�� 20�̰� �޿��� 2000�̻� ����� �̸� , �޿� , �μ���ȣ 
--        WHERE                 ========================== SELECT ~
-- ���� => ���ڿ� , ��¥ => �ݵ�� ''�� �̿��Ѵ� (1.���ڿ��� ��ҹ��� ������ �Ѵ� , ��¥�� ��ҹ��� ������ ���� �ʴ´�)
/*SELECT ename,hiredate
FROM emp
WHERE hiredate='17-DEC-80';
SELECT ename,hiredate
FROM emp
WHERE hiredate='17-dec-80';
*/
/*
        ����  AND  ���� 
        TRUE       TRUE   => TRUE
        TRUE       FALSE  => FALSE
        FALSE      TRUE   => FALSE
        FALSE      FALSE  => FALSE
        
        ����  OR  ���� 
        TRUE       TRUE   => TRUE
        TRUE       FALSE  => TRUE
        FALSE      TRUE   => TRUE
        FALSE      FALSE  => FALSE
*/
SELECT ename , sal , deptno
FROM emp
WHERE deptno=20 AND sal>=2000;
-- �񱳿��� ���ڿ�,��¥�� ���� 
SELECT ename,sal,job
FROM emp
WHERE ename>'king';

SELECT ename,sal,hiredate
FROM emp
WHERE hiredate>='82/01/01';

-- OR => job�� MANAGER , CLECK
SELECT ename,job
FROM emp
WHERE job='MANAGER' OR job='CLERK';

-- OR ��� ��� IN
SELECT ename,job
FROM emp
WHERE job IN('MANAGER','CLERK');

-- emp���� 1981�⿡ �Ի��� ��� ����� ��� ������ ���
SELECT * 
FROM emp
WHERE hiredate>='81/01/01' AND hiredate<='81/12/31';

-- AND �Ⱓ , ���� ��ü => BETWEEN ~ AND 
SELECT *
FROM emp
WHERE hiredate BETWEEN '81/01/01' AND '81/12/31';

/*SELECT *
FROM emp
WHERE hiredate LIKE '81%';

SELECT *
FROM emp
WHERE substr(hiredate,1,2)=81;
*/
-- AND : ������ �Ⱓ�� ������ ��쿡 �ַ� ��� , OR : ������ �Ⱓ�� ������ �ȵǴ� ��� 
-- LIKE : ���� ���ڿ� �˻� (��ȭ�˻�,�����ȣ �˻�...)  :  %(���ڿ�)  , _(�ѱ���)
-- emp���� A�� �����ϴ� �̸��� ���� ����� �̸�,�Ի��� 
SELECT ename,hiredate
FROM emp
WHERE ename LIKE 'A%'; -- startsWith

-- emp���� T�� ������ �̸��� ���� ����� �̸�,�Ի��� 
SELECT ename,hiredate
FROM emp
WHERE ename LIKE '%T'; -- endsWith

-- emp���� W�� ���Ե�  �̸��� ���� ����� �̸�,�Ի��� -- contains
SELECT ename,hiredate
FROM emp
WHERE ename LIKE '%I%';

-- emp���� 11�� �̰ų� 12���� �Ի��� ����� �̸�,�Ի��� ��� = ���ڼ��� �� ��쿡�� _
-- '%/12/%'  10/12
SELECT ename,hiredate
FROM emp
WHERE hiredate LIKE '___11%' OR hiredate LIKE '___12%';

-- emp���� �̸��߿� �ι�° ���ڰ� A�� ����� �̸��� ��� 
SELECT ename
FROM emp
WHERE ename LIKE '_A%';

-- NULL (���� �������� �ʴ´�) 
SELECT ename,comm 
FROM emp
WHERE comm IS NULL;

SELECT ename,comm
FROM emp
WHERE comm IS NOT NULL;

-- emp���� �������� �޴� ����� �̸�,�޿�,������ ��� 
SELECT ename,sal,comm
FROM emp
WHERE comm IS NOT NULL AND comm<>0;
-- comm!=0 , comm^=0

-- ���������� not
-- 81�⿡ �Ի����� ���� ����� �̸� , �Ի��� 
SELECT ename,hiredate
FROM emp
WHERE hiredate NOT LIKE '81%';

-- 10,20,30 => 20��,30�� �μ��� �ƴ� �μ����� �ٹ��ϴ� ����� �̸� �μ���ȣ 
SELECT ename,deptno
FROM emp
WHERE deptno NOT IN(20,30);

-- emp���� �޿��� 1500~3000������ �޿��� �ƴ� ����� �̸�,�޿� 
-- NOT BETWEEN 1500 AND 3000 
SELECT ename,sal
FROM emp
WHERE NOT (sal>=1500 AND sal<=3000);

SELECT ename,sal
FROM emp
WHERE sal NOT BETWEEN 1500 AND 3000;

-- emp���� ���(mgr)�� ���� ����� �̸��� ����,�Ի����� ��� 
SELECT ename,job,hiredate
FROM emp
WHERE mgr IS NULL;

-- ���տ����� 
/*
     UNION 
     UNION ALL
     INTERSECT
     MINUS
*/
/*
CREATE TABLE op1(no NUMBER);
CREATE TABLE op2(no NUMBER);
INSERT INTO op1 VALUES(1);
INSERT INTO op1 VALUES(2);
INSERT INTO op1 VALUES(3);
INSERT INTO op1 VALUES(4);
INSERT INTO op1 VALUES(5);

INSERT INTO op2 VALUES(3);
INSERT INTO op2 VALUES(4);
INSERT INTO op2 VALUES(5);
INSERT INTO op2 VALUES(6);
INSERT INTO op2 VALUES(7);
COMMIT;
*/
SELECT no
FROM op1;

SELECT no
FROM op2;

-- UNION : 1234567
SELECT no
FROM op1
UNION
SELECT no
FROM op2;

-- UNION ALL : 1 2 3 4 5 3 4 5 6 7 => FULL OUTER JOIN
SELECT no
FROM op1
UNION ALL
SELECT no
FROM op2;

-- INTERSECT : 3 4 5 (������) => INNER JOIN
SELECT no
FROM op1
INTERSECT
SELECT no
FROM op2;

-- MINUS : op1-op2 => ������  1 2  op2-op1 => 6 7
SELECT no
FROM op1
MINUS
SELECT no
FROM op2;

SELECT no
FROM op2
MINUS
SELECT no
FROM op1;


