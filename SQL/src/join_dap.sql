-- 2021-02-15 JOIN 문제

-- 1. 사원명, 부서명, 급여등급을 출력하라.
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
2. 급여 1000이상인 사원을 대상으로 조사!
		 부서번호별, job별 평균 급여를 구하되
		 평균급여가 2000 이상인
		 부서의 부서no, job, 평균 급여를 출력하시오.
*/	
    SELECT deptno,job,AVG(sal)
    FROM emp
    WHERE sal>=1000
    GROUP BY deptno,job
    HAVING AVG(sal)>=2000
    ORDER BY deptno;
--3. 사원들의 이름, 부서 번호, 부서 이름을 출력하라?
	SELECT ename,emp.deptno,dname
    FROM emp,dept
    WHERE emp.deptno=dept.deptno;
    
    SELECT ename,emp.deptno,dname
    FROM emp JOIN dept
    ON emp.deptno=dept.deptno;
--4. 30번 부서의 사원들의 이름, 직업, 부서위치를 출력하라?
	 SELECT ename,job,loc
     FROM emp,dept
     WHERE emp.deptno=dept.deptno
     AND emp.deptno=30;
     
     SELECT ename,job,loc
     FROM emp JOIN dept
     ON emp.deptno=dept.deptno
     AND emp.deptno=30;


--5. 수당을 받는 사원의 이름, 직업, 부서위치를 출력하라?
	 SELECT ename , job , loc 
     FROM emp,dept
     WHERE emp.deptno=dept.deptno
     AND comm IS NOT NULL AND comm<>0;
     
     SELECT ename , job , loc 
     FROM emp JOIN dept
     ON emp.deptno=dept.deptno
     AND comm IS NOT NULL AND comm<>0;
--6. DALLAS에서 근무하는 사원의 이름, 직업, 부서번호, 부서이름을 출력하라.
     SELECT ename,job,emp.deptno,dname
     FROM emp,dept
     WHERE emp.deptno=dept.deptno
     AND loc='DALLAS';

     SELECT ename,job,emp.deptno,dname
     FROM emp JOIN dept
     ON emp.deptno=dept.deptno
     AND loc='DALLAS';
--7.이름에 A가 들어가는 사원들의 이름과 부서이름을 출력하라?
	SELECT ename,dname
    FROM emp,dept
    WHERE emp.deptno=dept.deptno
    AND ename LIKE '%A%';
    
    SELECT ename,dname
    FROM emp JOIN dept
    ON emp.deptno=dept.deptno
    AND ename LIKE '%A%';
/*
8.사원이름과 그 사원의 관리자 이름을 출력하라
(단 컬럼 HEADING을 employee, manager 출력)
*/	
   SELECT e1.ename as employee , e2.ename as manager
   FROM emp e1,emp e2
   WHERE e1.mgr=e2.empno;
   
   SELECT e1.ename as employee , e2.ename as manager
   FROM emp e1 JOIN emp e2
   ON e1.mgr=e2.empno;
--9.사원이름과 직업, 급여, 급여등급을 출력하라?
	
    SELECT ename,job,grade
    FROM emp,salgrade
    WHERE sal BETWEEN losal AND hisal;
    
    SELECT ename,job,grade
    FROM emp JOIN salgrade
    ON sal BETWEEN losal AND hisal;

--10.사원이름과 부서명과 월급을 출력하는데 월급이 3000이상인 사원을 출력하라?
	 SELECT ename,dname,sal 
     FROM emp,dept
     WHERE emp.deptno=dept.deptno
     AND sal>=3000;

     SELECT ename,dname,sal 
     FROM emp JOIN dept
     ON emp.deptno=dept.deptno
     AND sal>=3000;

--11.BLAKE이란 사원보다 늦게 입사한 사원의 이름과 입사일을 출력하라?
	SELECT ename,hiredate
    FROM emp
    WHERE hiredate>(SELECT hiredate FROM emp WHERE ename='BLAKE');

--12. 부서명이 SALES 부서사원 중 가장 많은 급여를 받는 사원의 급여는?
   	SELECT MAX(sal) FROM emp WHERE deptno=(SELECT deptno FROM dept WHERE dname='SALES');
   	