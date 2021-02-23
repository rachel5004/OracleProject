-- �������� 
/*
      SELECT empno, (SELECT~),(SELECT~)  => SELECT�ڿ� ��Į�� �������� => JOIN ���...
      FROM (SELECT~) => FROM�ڿ� �ζ��κ� 
      WHERE dpetno=(SELECT~) 
                   ========= �÷�(1) 1����  => ������ ��������
                   ========= �÷�(1) ������  => ������ ��������  
                   ========= �÷��� ������   => ���� �÷� �������� 
                   
      �������� 
        => ���� = (��������) => ���ǹ� 
           ���� ���� �������� => �������� ����  => ���� SQL�� ���� 
        => ���� ����Ǵ� SQL������ �������� Ȯ�� (��������)
        => SQL������ ������ ���ļ� �Ѱ��� SQL������ ����� 
           (��Ʈ��ũ => SQL������ ������ �����ϴ� �ͺ��� �Ѱ��� SQL������ ������ ���� �ӵ��� ��������)
        => �����͸� ���������� �����ϴ� �뵵 (��� ���α׷� => �ڹ�,���̽�)...
           �������� ����Ŭ�� ���� ���� (NodeJS:���� ���̵� , �������� ������ ����)
                                                        ====== ~DAO (�ߺ�(X)=> MyBatis)
                                                                              ========
                                                                              XML,Annotation
        => �ڹ� (1�� , 2�� (�÷��� , IO))
        => ����Ŭ : DML (SELECT(������,�����Լ�,JOIN,SUBQUERY),INSERT,UPDATE,DELETE)
                   VIEW (�ζ��κ�,������)
                   DDL (���̺�,��������)
        => �ڹ�(���� ���õ� ���̺귯��)
        
        => �� (�ڹ�,����Ŭ,HTML,CSS,JavaScript) => ���� (JSP) => JSP(Model1),Model2(MVC:Spring)
                                                              ============
                                                              Java+HTML   => Java,Html�� �и�
*/
--SELECT DISTINCT deptno FROM emp;
--SELECT deptno,ename FROM emp;
-- ������ �������� (���������� ������� 1���϶�) => �񱳿����ڻ�� (=,<,>,<>,>=,<=)
SELECT ename,hiredate,job 
FROM emp
WHERE deptno=(SELECT deptno FROM emp WHERE ename='KING'); -- 10,20,30

-- ������ �������� (���������� ������� ������ �� ��쿡 ���) (IN,ANY,ALL,EXISTS)
/*
     IN => ����� ��ü�� ��� (deptno: 10,20,30) => deptno=10 OR deptno=20 OR deptno=30
     > ANY(��������) : �ּҰ� (SELECT DISTINCT deptno FROM emp) => (10,20,30) => 10
     < ANY(��������) : �ִ밪 (SELECT DISTINCT deptno FROM emp) => (10,20,30) => 30
     > ALL(��������) : �ִ밪 (SELECT DISTINCT deptno FROM emp) => (10,20,30) => 30
     < ALL(��������) : �ּҰ� (SELECT DISTINCT deptno FROM emp) => (10,20,30) => 10
     ==========================> SELECT MAX(deptno) FROM emp
                                 SELECT MIN(deptno) FROM emp
     EXISTS => ���������� ������ true�� ��쿡 ���� , false�� ��쿡�� �������� �ʴ´�
*/
-- �μ��� 10,20,30�� ����� �̸��� �μ���ȣ,������ ��� 
-- emp,dept => JOIN ����� �����ϰ�� �Ѱ��� ���̺��� �۾�
SELECT ename,deptno,job
FROM emp
WHERE deptno IN(10,20,30);
-- dept�� �ִ� deptno => SELECT������ ������ �̱� ������ �ٸ� ���̺��� ��� �� �� �ִ�
SELECT ename,deptno,job
FROM emp
WHERE deptno IN(SELECT deptno FROM dept); -- ������������ ����� ��� ������� ����Ѵ� 

SELECT ename,deptno,job
FROM emp
WHERE deptno>ANY(SELECT deptno FROM dept);  --> 10,20,30,40 => 10(�ּҰ�)   '>' 
-- SELECT deptno FROM dept

-- ����
SELECT ename,deptno,job
FROM emp
WHERE deptno>(SELECT MIN(deptno) FROM dept);

SELECT ename,deptno,job
FROM emp
WHERE deptno<ANY(SELECT deptno FROM dept);  --> 10,20,30,40 => 40(�ִ밪) '<'

SELECT ename,deptno,job
FROM emp
WHERE deptno<(SELECT MAX(deptno) FROM dept);

-- ALL  10,20,30,40 => 10 < ALL  '<' :�ּҰ�
SELECT ename,deptno,job
FROM emp
WHERE deptno<ALL(SELECT deptno FROM dept);  --> 10,20,30,40 => 10
-- ALL  10,20,30,40 => 40 > ALL  '>' : �ִ밪
SELECT ename,deptno,job
FROM emp
WHERE deptno>ALL(SELECT deptno FROM dept); --> 10,20,30,40 => 40

SELECT ename,deptno,job
FROM emp
WHERE EXISTS (SELECT deptno FROM emp WHERE deptno=&dno);
-- ���������� true�� ���� , ���������� false�� �������� �ʴ´� 
-- ��Į�� �������� : JOIN��� , �÷� ��� ��� 
/*
     SELECT �÷��� , (SELECT ~ ) ,�÷��� , (SELECT ~ )
     FROM ���̺�� 
     
     ��Į�󺯼�  : �Ϲ� ����  => name VARCHAR2(10)
     ��Į�󼭺����� : �÷��� 
*/
-- ����� �̸�,����,�Ի���,     �μ���,�ٹ����� ��� 
--       -------------(emp), ---------- (dept)
SELECT ename,job,hiredate,dname,loc 
FROM emp,dept
WHERE emp.deptno=dept.deptno;

-- ���� ������ ���� 
SELECT ename,job,hiredate,(SELECT dname FROM dept d WHERE d.deptno=e.deptno) dname,
(SELECT loc FROM dept d WHERE d.deptno=e.deptno) loc
FROM emp e
ORDER BY hiredate ASC;














