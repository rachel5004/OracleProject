--**. �μ����� SALES �μ���� �� ���� ���� �޿��� �޴� ����� �޿���?
   	/*
         SALES => dept => emp (deptno)
         SALES=>deptno => deptno => MAX(SAL)
         
         SELECT deptno FROM dept WHERE dname='SALES';
               ========
         SELECT MAX(sal) FROM emp 
         WHERE deptno=deptno;
    */
    SELECT MAX(sal)
    FROM emp
    WHERE deptno=(SELECT deptno FROM dept WHERE dname='SALES');
    
    SELECT ename,sal
    FROM emp
    WHERE deptno=30;
--**. SMITH ���� ������ ���� �޴� ������� �̸��� ������ ����϶�?
    -- SMITH�� �޿��� ���Ѵ� 
    SELECT sal 
    FROM emp 
    WHERE ename='SMITH';

    SELECT ename,sal
    FROM emp
    WHERE sal>800;
    
    SELECT ename,sal
    FROM emp
    WHERE sal>(SELECT sal 
               FROM emp 
               WHERE ename='SMITH');

--**.10�� �μ��� ������ ���� ������ ���� ������� �̸��� ���ް� �μ���ȣ�� ����϶�.
	SELECT DISTINCT job 
    FROM emp
    WHERE deptno=10;
    
    SELECT ename,sal,deptno
    FROM emp
    WHERE job='CLERK' OR job='PRESIDENT' OR job='MANAGER';
    
    SELECT ename,sal,deptno
    FROM emp
    WHERE job IN('CLERK','PRESIDENT','MANAGER');
    
    SELECT ename,sal,deptno
    FROM emp
    WHERE job IN(SELECT DISTINCT job 
                 FROM emp
                 WHERE deptno=10) AND deptno<>10;
    -- ������ �������� (������� ������ �ִ� => ��ü ����)
--**.BLAKE�� ���� �μ�(deptno)�� �ִ� ������� �̸��� �Ի����� ����ϵ� BLAKE�� ����
	 SELECT deptno
     FROM emp
     WHERE ename='BLAKE';
     
     SELECT ename,hiredate
     FROM emp
     WHERE deptno=(SELECT deptno
                   FROM emp
                   WHERE ename='BLAKE') AND ename<>'BLAKE';
--**.��� �޿����� ���� �޿��� �޴� ������� ���, �̸�, ������ ��Ÿ���� ������ ���� ��� ������ ����϶�?
	-- �޿��� ��� => ���� 
    SELECT AVG(sal)
    FROM emp; --2073���� ���� ���
    SELECT empno,ename,sal
    FROM emp
    WHERE sal>(SELECT AVG(sal)
               FROM emp)
    ORDER BY sal DESC;
    
    
--**.�̸��� T�� �����ϰ� �ִ� ������ ������ �μ����� �ٹ��ϰ� �ִ� ����� ��� ��ȣ�� �̸��� ����϶�? => IN
	SELECT deptno
    FROM emp
    WHERE ename LIKE '%T%';
    
    SELECT empno ,ename
    FROM emp
    WHERE deptno=20 OR deptno=30;
    
    SELECT empno ,ename
    FROM emp
    WHERE deptno IN(20,30);
    
    SELECT empno ,ename
    FROM emp
    WHERE deptno IN(SELECT DISTINCT deptno
                    FROM emp
                    WHERE ename LIKE '%T%')
    ORDER BY empno ASC;

--**.30�� �μ��� �ְ� �޿��� �޴� ������ٵ� �� ���� �޿��� �޴� ��ü ������� ����϶�
	SELECT MAX(sal)
    FROM emp
    WHERE deptno=30;
    
    SELECT *
    FROM emp
    WHERE sal>(SELECT MAX(sal)
               FROM emp
               WHERE deptno=30);

--**.�μ� ��ġ�� DALLAS�� ��� ����� �̸�, �μ���ȣ �� ������ ����϶�.
	--�μ���ȣ => emp���� �����μ� ����� ã�´� 
    SELECT deptno
    FROM dept
    WHERE loc='DALLAS';
    
    SELECT ename,deptno,job
    FROM emp
    WHERE deptno=20;
    
    SELECT ename,deptno,job
    FROM emp
    WHERE deptno=(SELECT deptno
                  FROM dept
                  WHERE loc='DALLAS');
--**.SALES �μ��� ��� ����� ���� �μ���ȣ, �̸� �� ������ ����϶�?
	-- deptno ���ϱ� 
    SELECT deptno
    FROM dept
    WHERE dname='SALES';
    -- ���� ������ ���� => 30
    -- ���� ������ ����� 
    SELECT deptno,ename,job
    FROM emp
    WHERE deptno=30;
    
    SELECT deptno,ename,job
    FROM emp
    WHERE deptno=(SELECT deptno
                  FROM dept
                  WHERE dname='SALES');
                  
   SELECT * FROM emp_test;
   
   -- ��� �߰� => empno (Primary Key) => �������� �̿��ؼ� ó�� 
   /*
       1. ��Į�� �������� 
       2. DML���� ��� => PRIMATY ���� ���ϴ� ��� (�ڵ� ����)
       3. ��� DML���� ����� ���� (INSERT , UPDATE , DELETE)
   */
   -- �ڵ� ���� ��ȣ (PRIMARY KEY)
   -- �����Ͱ� ���� ��� => MAX()=NULL 
   INSERT INTO emp_test VALUES(
     (SELECT NVL(MAX(empno)+1,1) FROM emp),'ȫ�浿','�븮',7788,SYSDATE,3000,200,40);
   COMMIT;
   
   SELECT * FROM emp_test;
   
   CREATE TABLE emp_test2
   AS
     SELECT * FROM emp WHERE 1=2;
     
   INSERT INTO emp_test2 VALUES(
     (SELECT NVL(MAX(empno)+1,1) FROM emp_test2),'ȫ�浿','�븮',7788,SYSDATE,3000,200,40);
   COMMIT;
   
   SELECT * FROM emp_test2; 
   DELETE FROM emp_test2;
   COMMIT;
   
   -- UPDATE ��� => SMITH�� �ִ� �μ��� ��� ����� �޿��� 1.1% => sal*1.1
   UPDATE emp_test SET
   sal=sal*1.1
   WHERE deptno=(SELECT deptno FROM emp WHERE ename='SMITH');
   
   SELECT * FROM emp_test;
   
   -- DELETE BLAKE => ��� => 30���� ��� ��� ���  
   DELETE FROM emp_test
   WHERE deptno=(SELECT deptno FROM emp_test WHERE ename='BLAKE');
   ROLLBACK;
   /*
        ������ 
        ��ü ��� => IN  (10,20,30)
        �ִ밪 => MAX(10,20,30)
        �ּҰ� => MIN(10,20,30)
        
        => deptno > ANY (10,20,30) => 10(�ּҰ�)
           deptno < ANY (10,20,30) => 30(�ִ밪)
           
           deptno > ALL(10,20,30) => 30(�ִ밪)
           deptno < ALL(10,20,30) => 10(�ּҰ�) 
        ���翩�� (�����ϸ� ���� , �������� �ʴ� ��� �̼���) = EXISTS
   */