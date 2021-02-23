--**. 부서명이 SALES 부서사원 중 가장 많은 급여를 받는 사원의 급여는?
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
--**. SMITH 보다 월급을 많이 받는 사원들의 이름과 월급을 출력하라?
    -- SMITH의 급여를 구한다 
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

--**.10번 부서의 사원들과 같은 직위를 가진 사원들의 이름과 월급과 부서번호를 출력하라.
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
    -- 다중행 서브쿼리 (결과값이 여러개 있다 => 전체 대입)
--**.BLAKE와 같은 부서(deptno)에 있는 사람들의 이름과 입사일을 출력하되 BLAKE는 제외
	 SELECT deptno
     FROM emp
     WHERE ename='BLAKE';
     
     SELECT ename,hiredate
     FROM emp
     WHERE deptno=(SELECT deptno
                   FROM emp
                   WHERE ename='BLAKE') AND ename<>'BLAKE';
--**.평균 급여보다 많은 급여를 받는 사원들의 사번, 이름, 월급을 나타내되 월급이 높은 사람 순으로 출력하라?
	-- 급여의 평균 => 대입 
    SELECT AVG(sal)
    FROM emp; --2073보다 많은 사원
    SELECT empno,ename,sal
    FROM emp
    WHERE sal>(SELECT AVG(sal)
               FROM emp)
    ORDER BY sal DESC;
    
    
--**.이름에 T를 포함하고 있는 사원들과 동일한 부서에서 근무하고 있는 사원의 사원 번호와 이름을 출력하라? => IN
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

--**.30번 부서의 최고 급여를 받는 사원보다도 더 많은 급여를 받는 전체 사원들을 출력하라
	SELECT MAX(sal)
    FROM emp
    WHERE deptno=30;
    
    SELECT *
    FROM emp
    WHERE sal>(SELECT MAX(sal)
               FROM emp
               WHERE deptno=30);

--**.부서 위치가 DALLAS인 모든 사원의 이름, 부서번호 및 직업을 출력하라.
	--부서번호 => emp에서 같은부서 사원을 찾는다 
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
--**.SALES 부서의 모든 사원에 대한 부서번호, 이름 및 직업을 출력하라?
	-- deptno 구하기 
    SELECT deptno
    FROM dept
    WHERE dname='SALES';
    -- 구한 데이터 대입 => 30
    -- 메인 쿼리를 만든다 
    SELECT deptno,ename,job
    FROM emp
    WHERE deptno=30;
    
    SELECT deptno,ename,job
    FROM emp
    WHERE deptno=(SELECT deptno
                  FROM dept
                  WHERE dname='SALES');
                  
   SELECT * FROM emp_test;
   
   -- 사원 추가 => empno (Primary Key) => 서브쿼리 이용해서 처리 
   /*
       1. 스칼라 서브쿼리 
       2. DML에서 사용 => PRIMATY 값을 구하는 경우 (자동 증가)
       3. 모든 DML에서 사용이 가능 (INSERT , UPDATE , DELETE)
   */
   -- 자동 증가 번호 (PRIMARY KEY)
   -- 데이터가 없는 경우 => MAX()=NULL 
   INSERT INTO emp_test VALUES(
     (SELECT NVL(MAX(empno)+1,1) FROM emp),'홍길동','대리',7788,SYSDATE,3000,200,40);
   COMMIT;
   
   SELECT * FROM emp_test;
   
   CREATE TABLE emp_test2
   AS
     SELECT * FROM emp WHERE 1=2;
     
   INSERT INTO emp_test2 VALUES(
     (SELECT NVL(MAX(empno)+1,1) FROM emp_test2),'홍길동','대리',7788,SYSDATE,3000,200,40);
   COMMIT;
   
   SELECT * FROM emp_test2; 
   DELETE FROM emp_test2;
   COMMIT;
   
   -- UPDATE 사용 => SMITH가 있는 부서에 모든 사원의 급여를 1.1% => sal*1.1
   UPDATE emp_test SET
   sal=sal*1.1
   WHERE deptno=(SELECT deptno FROM emp WHERE ename='SMITH');
   
   SELECT * FROM emp_test;
   
   -- DELETE BLAKE => 퇴사 => 30번에 모든 사원 퇴사  
   DELETE FROM emp_test
   WHERE deptno=(SELECT deptno FROM emp_test WHERE ename='BLAKE');
   ROLLBACK;
   /*
        다중행 
        전체 사용 => IN  (10,20,30)
        최대값 => MAX(10,20,30)
        최소값 => MIN(10,20,30)
        
        => deptno > ANY (10,20,30) => 10(최소값)
           deptno < ANY (10,20,30) => 30(최대값)
           
           deptno > ALL(10,20,30) => 30(최대값)
           deptno < ALL(10,20,30) => 10(최소값) 
        존재여부 (존재하면 수행 , 존재하지 않는 경우 미수행) = EXISTS
   */