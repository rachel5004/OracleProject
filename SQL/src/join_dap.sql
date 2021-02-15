-- 2021-02-15 JOIN ����

-- 1. �����, �μ���, �޿������ ����϶�.
    SELECT ename,dname,grade
    FROM emp,dept,salgrade
    WHERE emp.deptno=dept.deptno
    AND sal BETWEEN losal AND hisal;
    
    SELECT ename,dname,grade
    FROM emp 
    JOIN dept
    ON emp.deptno=dept.deptno
    JOIN salgrade
    ON sal BETWEEN losal AND hisal;
/*	 
2. �޿� 1000�̻��� ����� ������� ����!
		 �μ���ȣ��, job�� ��� �޿��� ���ϵ�
		 ��ձ޿��� 2000 �̻���
		 �μ��� �μ�no, job, ��� �޿��� ����Ͻÿ�.
*/	
    SELECT deptno,job,AVG(sal)
    FROM emp
    WHERE sal>=1000
    GROUP BY deptno,job
    HAVING AVG(sal)>=2000
    ORDER BY deptno;
--3. ������� �̸�, �μ� ��ȣ, �μ� �̸��� ����϶�?
	SELECT ename,emp.deptno,dname
    FROM emp,dept
    WHERE emp.deptno=dept.deptno;
    
    SELECT ename,emp.deptno,dname
    FROM emp JOIN dept
    ON emp.deptno=dept.deptno;
--4. 30�� �μ��� ������� �̸�, ����, �μ���ġ�� ����϶�?
	 SELECT ename,job,loc
     FROM emp,dept
     WHERE emp.deptno=dept.deptno
     AND emp.deptno=30;
     
     SELECT ename,job,loc
     FROM emp JOIN dept
     ON emp.deptno=dept.deptno
     AND emp.deptno=30;


--5. ������ �޴� ����� �̸�, ����, �μ���ġ�� ����϶�?
	 SELECT ename , job , loc 
     FROM emp,dept
     WHERE emp.deptno=dept.deptno
     AND comm IS NOT NULL AND comm<>0;
     
     SELECT ename , job , loc 
     FROM emp JOIN dept
     ON emp.deptno=dept.deptno
     AND comm IS NOT NULL AND comm<>0;
--6. DALLAS���� �ٹ��ϴ� ����� �̸�, ����, �μ���ȣ, �μ��̸��� ����϶�.
     SELECT ename,job,emp.deptno,dname
     FROM emp,dept
     WHERE emp.deptno=dept.deptno
     AND loc='DALLAS';

     SELECT ename,job,emp.deptno,dname
     FROM emp JOIN dept
     ON emp.deptno=dept.deptno
     AND loc='DALLAS';
--7.�̸��� A�� ���� ������� �̸��� �μ��̸��� ����϶�?
	SELECT ename,dname
    FROM emp,dept
    WHERE emp.deptno=dept.deptno
    AND ename LIKE '%A%';
    
    SELECT ename,dname
    FROM emp JOIN dept
    ON emp.deptno=dept.deptno
    AND ename LIKE '%A%';
/*
8.����̸��� �� ����� ������ �̸��� ����϶�
(�� �÷� HEADING�� employee, manager ���)
*/	
   SELECT e1.ename as employee , e2.ename as manager
   FROM emp e1,emp e2
   WHERE e1.mgr=e2.empno;
   
   SELECT e1.ename as employee , e2.ename as manager
   FROM emp e1 JOIN emp e2
   ON e1.mgr=e2.empno;
--9.����̸��� ����, �޿�, �޿������ ����϶�?
	
    SELECT ename,job,grade
    FROM emp,salgrade
    WHERE sal BETWEEN losal AND hisal;
    
    SELECT ename,job,grade
    FROM emp JOIN salgrade
    ON sal BETWEEN losal AND hisal;

--10.����̸��� �μ���� ������ ����ϴµ� ������ 3000�̻��� ����� ����϶�?
	 SELECT ename,dname,sal 
     FROM emp,dept
     WHERE emp.deptno=dept.deptno
     AND sal>=3000;

     SELECT ename,dname,sal 
     FROM emp JOIN dept
     ON emp.deptno=dept.deptno
     AND sal>=3000;

--11.BLAKE�̶� ������� �ʰ� �Ի��� ����� �̸��� �Ի����� ����϶�?
	SELECT ename,hiredate
    FROM emp
    WHERE hiredate>(SELECT hiredate FROM emp WHERE ename='BLAKE');

--12. �μ����� SALES �μ���� �� ���� ���� �޿��� �޴� ����� �޿���?
   	SELECT MAX(sal) FROM emp WHERE deptno=(SELECT deptno FROM dept WHERE dname='SALES');
   	