-- 2021-02-15(4�� - ���� : SQL��ް���)
/*
     2���̻��� ���̺�κ��� ������ ���� ��� : ����(JOIN)
                        ======
     2���̻��� SQL������ ���ļ� ������ ���� : ��������    ===> SELECT 
            ================
            
     ���� 
      1) ���̺� �Ѱ��̻󿡼� �ʿ��� �����͸� ã�ƿ��� 
         ============
      2) ������ ���� 
         = INNER JOIN => ������ (���� ���� ���� �ִ� ���)
           = EQUI_JOIN
             1. Oracle JOIN
             2. ANSI JOIN
             3. NATURAL JOIN
             4. JOIN~USING
           = NON_EQUI_JOIN
             1. Oracle JOIN
             2. ANSI JOIN
         = OUTER JOIN
           = LEFT OUTER JOIN
           = RIGHT OUTER JOIN
           = FULL OUTER JOIN
*/
SELECT * FROM emp;
SELECT * FROM dept;
/*
SELECT * FROM salgrade;
CREATE TABLE salgrade(
    grade NUMBER,
    losal NUMBER,
    hisal NUMBER
);
INSERT INTO salgrade VALUES(1,700,1200);
INSERT INTO salgrade VALUES(2,1201,1400);
INSERT INTO salgrade VALUES(3,1401,2000);
INSERT INTO salgrade VALUES(4,2001,3000);
INSERT INTO salgrade VALUES(5,3001,9000);
COMMIT;
*/
/*
     INNER JOIN 
     1) EQUI_JOIN
        = Oracle JOIN (A,B) (����Ŭ������ ����� ����)
          SELECT A.col1,A.col2,B.col1,B.col2
          FROM A,B
          WHERE A.col3=B.col3;
        = ANSI JOIN(ǥ��ȭ=>��� �����ͺ��̽� �������� ����� ����)
          SELECT A.col1,A.col2,B.col1,B.col2
          FROM A (INNER) JOIN B
          ON A.col3=B.col3;
*/
-- emp (��� , �̸� ,����, �Ի���) , dept (�μ���,�ٹ���)  => deptno
SELECT empno,ename,job,hiredate,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno;
-- ���̺��� ��Ī�� ��� (���̺���� ���ڼ��� ����)
SELECT empno,ename,job,hiredate,dname,loc
FROM emp e,dept d
WHERE e.deptno=d.deptno;

-- ANSI 
SELECT empno,ename,job,hiredate,dname,loc
FROM emp INNER JOIN dept
ON emp.deptno=dept.deptno;

SELECT empno,ename,job,hiredate,dname,loc
FROM emp JOIN dept
ON emp.deptno=dept.deptno;
------------------------------------- ���̺��� ���� �÷����� �����ؾ� �Ѵ� (�ٸ� �÷��� ���ؼ� ���:���� ����)
-- �ڿ�����
SELECT empno,ename,job,hiredate,dname,loc
FROM emp NATURAL JOIN dept;

-- JOIN _ USING
SELECT empno,ename,job,hiredate,dname,loc
FROM emp JOIN dept USING(deptno);
--------------------------------------------
/*
     ���̺� => �÷����� �ٸ� ��쿡�� �÷��� ����ص� �ȴ� , ���� �÷����̸� ��� ���̺��� ������ �� ������ ���� 
*/
SELECT empno,ename,job,hiredate,dname,loc,e.deptno
FROM emp e,dept d
WHERE e.deptno=d.deptno;
/*
     NON EQUI_JOIN : JOIN~USING,NATURAL JOIN�� ��� �� �� ���� 
     ============== =�� �ƴ� �ٸ� �����ڸ� ����� ��쿡 (BETWEEN, >= AND <=)
     EQUI_JOIN : (������ = ) => ���� (�����ڸ� ��� �߱� ������ NULL���� �ִ� ��쿡�� ó���� �Ұ����ϴ�)
*/
SELECT ename,sal,hiredate,grade
FROM emp,salgrade 
WHERE sal BETWEEN losal AND hisal;
/*
      emp(�������)
        empno : ���
        ename : �̸�
        job : ����
        mgr : �����ȣ
        hiredate : �Ի���
        sal : �޿�
        comm : ������
        deptno : �μ���ȣ 
      dept(�μ�����)
        deptno : �μ���ȣ
        dname : �μ���
        loc : �ٹ��� 
      salgrade(�޿����)
        grade : ��� (ȣ��)
        losal : �����޿�
        hisal : �ִ�޿� 
*/
-- ���� ���� , ���� ���� 
-- �̸�,����,�Ի���,�޿�,�μ���,�ٹ��� ��� => ����� 7788�� ����� ������� 
SELECT ename,job,hiredate,sal,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno
AND empno=7788;

-- ���� Oracle JOIN => ANSI JOIN���� ���� 
SELECT ename,job,hiredate,sal,dname,loc
FROM emp JOIN dept
ON emp.deptno=dept.deptno
AND empno=7788;

-- emp(ename,job,hiredate,sal) , dept(dname,loc) , salgrade(grade)
-- 1. Oracle JOIN
SELECT ename,job,hiredate,sal,dname,loc,grade
FROM emp,dept,salgrade
WHERE emp.deptno=dept.deptno
AND sal BETWEEN losal AND hisal;
-- 2. ANSI JOIN
SELECT ename,job,hiredate,sal,dname,loc,grade
FROM emp 
JOIN dept
ON emp.deptno=dept.deptno
JOIN salgrade
ON sal BETWEEN losal AND hisal;

-- �Ѱ��� ���̺��� ������ ���� => �ݵ�� ���̺� ��Ī�� ����Ѵ� 
-- emp(���� �̸�),emp(��� �̸�)
/*
    ���� ���� 
    1. �÷����� ���� (���� ���� ������ �ִ�)
       ===========
       primary key , foreign key
    2. �÷����� �ٸ��� (���� ���� ������ �ִ�) => �Խ��� <==> ��� 
*/
-- self join
SELECT e1.ename "���� �̸�",e2.ename "��� �̸�"
FROM emp e1,emp e2
WHERE e1.mgr=e2.empno;
-- ���ǰ˻��� �÷����� �ٸ��� NATURAL JOIN,JOIN~USING�� ����� �Ұ����ϴ� 

-- emp (��� , �̸� , ���� , ������ , �޿�) , dept(�μ��� , �ٹ���) => JOIN , �������� �޴� ����� ���ؼ��� ��� 
SELECT empno,ename,job,comm,sal,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno
AND comm IS NOT NULL AND comm<>0;

-- ANSI JOIN
SELECT empno,ename,job,comm,sal,dname,loc
FROM emp JOIN dept
ON emp.deptno=dept.deptno
AND comm IS NOT NULL AND comm<>0;

-- emp (��� , �̸� ,���� , ������, �޿�) , dept(�μ���,�ٹ��� )=> JOIN , �̸��߿� A�� �����ϰ� �ִ� ����� ������ ��� 
-- Oracle Join
SELECT empno,ename,job,comm,sal,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno
AND ename LIKE '%A%';
-- ANSI JOIN
SELECT empno,ename,job,comm,sal,dname,loc
FROM emp JOIN dept
ON emp.deptno=dept.deptno
AND ename LIKE '%A%';

-- emp (��� , �̸� ,���� , ������, �޿�) , dept(�μ���,�ٹ��� )=> JOIN , 81�⿡ �Ի��� ����� ���ؼ� ��� 
SELECT empno,ename,job,comm,sal,hiredate,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno
AND SUBSTR(hiredate,1,2)=81;

SELECT empno,ename,job,comm,sal,hiredate,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno
AND hiredate LIKE '81%';

SELECT empno,ename,job,comm,sal,hiredate,dname,loc
FROM emp JOIN dept
ON emp.deptno=dept.deptno
AND hiredate LIKE '81%';
/*
    �ڹ� : ���� Ŭ���� 
                   ����� ��û               SQL 
    ������(HTML)  <========> �ڹ�(���̽�) <=========> ����Ŭ
                     ����                  ���� ���
       
*/
-- OUTER JOIN (INNER JOIN + ����) => null���� �����ؼ� �����͸� ������ �´� 
/*
      = LEFT OUTER JOIN
        1. Oracle JOIN (A,B => col1,col2,col3(����� �����Ͱ� �ִ�))
        A.col3  B.col3
          1       1
          2       2
          3       3
          4  (����� �� �� ����)
           SELECT A.col1,A.col2,B.col1,B.col2
           FROM A,B
           WHERE A.col3=B.col3(+)
        2. ANSI JOIN 
           SELECT A.col1,A.col2,B.col1,B.col2
           FROM A LEFT OUTER JOIN B
                  ===============
           ON A.col3=B.col3
      = RIGHT OUTER JOIN
        1. Oracle JOIN
           SELECT A.col1,A.col2,B.col1,B.col2
           FROM A,B
           WHERE A.col3(+)=B.col3
        2. ANSI JOIN 
           SELECT A.col1,A.col2,B.col1,B.col2
           FROM A RIGHT OUTER JOIN B
                  ===============
           ON A.col3=B.col3
      = FULL OUTER JOIN(���󵵰� ���� ����)
        1. ANSI JOIN
           SELECT A.col1,A.col2,B.col1,B.col2
           FROM A FULL OUTER JOIN B
                  ===============
           ON A.col3=B.col3
*/
-- RIGHT 
SELECT empno,ename,job,dept.deptno,dname,loc
FROM emp,dept
WHERE emp.deptno(+)=dept.deptno;

SELECT empno,ename,job,dept.deptno,dname,loc
FROM emp RIGHT OUTER JOIN dept
ON emp.deptno=dept.deptno;

SELECT e1.ename "����" , e2.ename "���"
FROM emp e1, emp e2
WHERE e1.mgr=e2.empno(+);

SELECT e1.ename "����" , e2.ename "���"
FROM emp e1 LEFT OUTER JOIN emp e2
ON e1.mgr=e2.empno;

SELECT e1.ename "����" , e2.ename "���"
FROM emp e1 FULL OUTER JOIN emp e2
ON e1.mgr=e2.empno;
-- 14 (KING,BLAKE,JONES , FORD, SCOTT , CLARK)


