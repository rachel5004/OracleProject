-- 2021-02-15 �����Լ� (Group By)
/*
    ��ü �����͸� ������� ��踦 ���ϴ� ���α׷� 
    COUNT() : ��ü �ο��� ����(�����)
              = �α��� ó�� 
              = ���̵� �ߺ�üũ 
              ����) 
                   COUNT(*) : NULL���� ���� 
                   COUNT(column): NULL���� ���� 
    MAX() : ��ü �������߿� �ְ��� ������ �ö�
              = �ڵ����� ��ȣ  ����  => MAX()+1
                ===========  �Խ��� , ��ٱ��� , �����ϱ� 
    MIN() : �ּҰ� 
    AVG() : ��ü�� ������� ���  (column)
    SUM() : ��ü�� ������� �� 
    RANK() : ���� ���� 
             1 2 3 3 5
    DENSE_RANK() : ���� ���� 
             1 2 3 3 4
    CUBE() :   ROW���� ��� + Column���� ���
    ROLLUP() : ROW���� ��� 
    
    # ������ 
    �Ϲ� �÷����� ���ÿ� ����� �Ұ����ϴ� 
    ������ �Լ��� ���ÿ� ����� �Ұ����ϴ� 
    ��)
        SELECT ename,count(*) FROM emp => (X)
        SELECT count(*),substr() FROM emp => (X)
*/
-- COUNT() �Լ� => ��ϵ� ����
-- ����� ������� Ȯ�� 
SELECT COUNT(*) FROM emp; -- NULL���� ���� 
SELECT COUNT(comm) FROM emp; -- NULL���� ���� 
SELECT COUNT(mgr) FROM emp;
-- ��ȭ�� �Ѱ��� = movie
SELECT COUNT(*) FROM movie;
-- ������ �Ѱ��� = genie_music
SELECT COUNT(*) FROM genie_music;
/*
CREATE TABLE member(
   id VARCHAR2(10),
   pwd VARCHAR2(10)
);
INSERT INTO member VALUES('hong','1234');
INSERT INTO member VALUES('shim','1234');
COMMIT;
SELECT * FROM member;
*/
-- SELECT id FROM member WHERE id='kim';
-- �޿��� 1500�̻��̰� 3000������ ����� ����
-- sal>=1500 AND sal<=3000
-- sal BETWEEN 1500 AND 3000
SELECT COUNT(*) FROM emp
WHERE sal BETWEEN 1500 AND 3000;

SELECT COUNT(*) FROM emp
WHERE sal>=1500 AND sal<=3000;

-- ��ȭ(Movie)����  �帣�� �׼��� ��ȭ�� ������ Ȯ�� 
SELECT COUNT(*) FROM movie
WHERE genre LIKE '%�׼�%';

SELECT COUNT(*) FROM movie
WHERE REGEXP_LIKE(genre,'�׼�');
-- ������Ʈ => �˻�

-- ����(genie_music) �����߿� ��ź�ҳ���� �뷡�� � 
SELECT singer FROM genie_music;
SELECT COUNT(*) FROM genie_music
WHERE singer='��ź�ҳ��';
-- MAX => �ִ밪  => ���� : MAX(column��) 
SELECT MAX(sal),MIN(sal) FROM emp;
SELECT MAX(empno),MIN(empno) FROM emp;

-- AVG(���) => ����) AVG(column��)
-- emp(�������)�� ��ϵ� ����� �޿��� ����� ������ �´� 
SELECT AVG(sal) FROM emp;
-- ����߿� ��պ��� �޿��� ���� ����� ����ΰ�?
SELECT COUNT(*) FROM emp
WHERE sal>2073;
SELECT COUNT(*) FROM emp
WHERE sal>(SELECT AVG(sal) FROM emp);
-- ��������
-- SUM(��)   => ����) SUM(column��)
SELECT SUM(sal),ROUND(AVG(sal),0) FROM emp; 
-- ����߿� ����� Ȧ���� ����� �޿��� , �ο��� , �޿������ ���
SELECT SUM(sal),COUNT(*),AVG(sal) FROM emp
WHERE MOD(empno,2)=1;

-- deptno(�μ���ȣ) �μ����� �ο���,�޿���,�޿����
-- 10 , 20 , 30
SELECT COUNT(*),SUM(sal),AVG(sal) FROM emp
WHERE deptno=10;
SELECT COUNT(*),SUM(sal),AVG(sal) FROM emp
WHERE deptno=20;
SELECT COUNT(*),SUM(sal),AVG(sal) FROM emp
WHERE deptno=30;
/*
SELECT deptno,COUNT(*),SUM(sal),AVG(sal) FROM emp
GROUP BY deptno;
*/
-- ���� �� ���°�? (�޼ҵ�,Ŭ����) => �Լ�
-- RANK => ����) RANK() OVER(ORDER BY column�� ASC|DESC)
SELECT empno,ename,sal,RANK() OVER(ORDER BY sal DESC) "rank"
FROM emp;
SELECT empno,ename,sal,DENSE_RANK() OVER(ORDER BY sal DESC) "rank"
FROM emp;

-- ����߿� �Ի��� ������ ����� ���� (�̸�,�Ի���, ���)
SELECT ename,hiredate,RANK() OVER(ORDER BY hiredate ASC) "�Ի��"
FROM emp;
SELECT ename,hiredate,DENSE_RANK() OVER(ORDER BY hiredate ASC) "�Ի��"
FROM emp;
-- SORT
-- ����� �̸��� A.B.C..
SELECT ename , RANK() OVER(ORDER BY ename ASC) "�̸���"
FROM emp;

-- GROUP BY 
SELECT * FROM emp;
SELECT * FROM emp 
ORDER BY deptno ASC;

-- GROUP BY �÷��� (�Լ�)
/*
     1.�׷��Լ��� ����� ���� , �׷����� ������ �÷��̳� �Լ��� �����ϰ� 
       �������� ���� ����� �Ұ���
     
     SELECT deptno,ename,AVG(sal)
     FROM emp
     GROUP BY deptno;
     
     2. �׷��÷��� ��Ī�� ��� �� �� ���� 
     
     
*/
-- �μ��� �ο��� , �޿��� ��
SELECT deptno,COUNT(*),SUM(sal)
FROM emp
GROUP BY deptno;

-- �Ի�⵵���� �ο��� , �޿��� ��� (�ݿø�)
-- �Ի�⵵ 1980 
SELECT TO_CHAR(hiredate,'YYYY'), COUNT(*), ROUND(AVG(sal),0)
FROM emp
GROUP BY hiredate;

SELECT TO_CHAR(hiredate,'RRRR'),COUNT(*),ROUND(AVG(sal),0)
FROM emp
GROUP BY TO_CHAR(hiredate,'RRRR')
ORDER BY TO_CHAR(hiredate,'RRRR');

-- �Ի�⵵���� �ο��� , �޿� ����� ��� => ��ü �޿���պ��� ���� �׷� ���)
SELECT TO_CHAR(hiredate,'RRRR'),COUNT(*),ROUND(AVG(sal),0)
FROM emp
--WHERE sal>(SELECT AVG(sal) FROM emp)
-- WHERE sal>AVG(sal)
GROUP BY TO_CHAR(hiredate,'RRRR')
HAVING AVG(sal)>2073;

SELECT TO_CHAR(hiredate, 'YYYY'),COUNT(*), ROUND(AVG(sal),0)
FROM emp
WHERE sal > (SELECT AVG(sal) FROM emp)
GROUP BY  TO_CHAR(hiredate, 'YYYY')
ORDER BY  TO_CHAR(hiredate, 'YYYY');

-- ��ȭ(movie) �����⵵���� ��ȭ ������ �����?
SELECT SUBSTR(regdate,1,4),COUNT(*) 
FROM movie
GROUP BY SUBSTR(regdate,1,4)
ORDER BY 1;
-- ����(genie_music) ������ �뷡�� �������?
SELECT singer , COUNT(*)
FROM genie_music
GROUP BY singer;
/*
    SELECT������ ����
    ================
    SELECT 
    FROM 
    ================ �ʼ� 
    [
       WHERE 
       ===========
       GROUP BY
       HAVING =======> �׷쿡 ���� ���� GROUP BY�� �ִ� ��쿡�� ����� ����
       ===========
       ORDER BY
    ]
*/
-- ���� GROUP BY   ==> �÷���,�÷���
SELECT * FROM emp
ORDER BY deptno;

SELECT deptno,job,COUNT(*),SUM(sal),AVG(sal)
FROM emp
GROUP BY deptno,job
ORDER BY deptno;

-- �μ��� => �μ��ȿ� �Ի�⵵�� , SUM(sal) , COUNT(*)
SELECT deptno,TO_CHAR(hiredate,'YYYY'),SUM(sal),COUNT(sal)
FROM emp
GROUP BY deptno,TO_CHAR(hiredate,'YYYY')
ORDER BY deptno;

-- ROLLUP.CUBE => �ݵ�� GROUP BY�� �̿��Ѵ� 
SELECT deptno,job,COUNT(*)
FROM emp
GROUP BY ROLLUP(deptno,job);

SELECT NVL(deptno,0),NVL(job,'total'),COUNT(*)
FROM emp
GROUP BY CUBE(deptno,job);
-- �ڹ�,����Ŭ => NULL�� 
-- ROLLUP => ���� => ������ , ���� , COUNT(*)
SELECT singer,state , COUNT(*)
FROM genie_music
GROUP BY ROLLUP(singer,state);

SELECT singer,state , COUNT(*)
FROM genie_music
GROUP BY CUBE(singer,state);
/*
     1. GROUP BY (�ķ� , �Լ�(��¥ => DATE (TO_CHAR) , VARCHAR2 (SUBSTR))
     2. �׷쿡 ���� ���� => HAVING 
     3. �׷� �Լ� 
        = COUNT(*) 
        = MAX()
        = AVG(),SUM()
        = RANK() , DENSE_RANK()
     4. ROLLUP , CUBE
     
     ==================== �⺻ SQL
     ==================== ��� SQL (JOIN,SUBQUERY) 
     = DDL 
     = TCL 
     = VIEW , SEQUENCE , INDEX , PL/SQL 
     = ����Ŭ�� ���� ���� �ƴ϶� => �ڹٿ��� ����ϴ� ����Ŭ SQL (2��) 
*/









