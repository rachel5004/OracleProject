/*
      ����Ŭ ������ 
      1. ��� ������ ( +  , - , * , / ) => ����ȯ�� �������� �ʴ´�,���׿�����(X)
              / => 0���� ���� �� ���� 
              ���� / ���� = �Ǽ� => ��½ÿ� �ַ� ��� (SELECT�ڿ��� �ַ� ���)
              �̸�    ����  ����  ���� 
              =====================
              ȫ�浿   80   80   80    SELECT ����+����+����,(����+����+����)/3
              ��û��   90   90   90
              �ڹ���   70   70   70
              =====================
              SUM(����) ,AVG(����)
      2.  �񱳿����� ( = , !=(<>,^=) , < , > , <= , >=) 
          WHERE���� �ڿ� ��� (���ǹ��� ����� ��쿡 �ַ� ���) => ����(true/false)
          ## WHERE������ �ڹ��� if���� ���� => ���ǹ� 
      3.  �� ������ (WHERE,HAVING�ڿ� ���)  : AND(��������) , OR(����������)
          & => �Է°��� �޴� ��쿡 ��� , || => ���ڿ� �������� ��� 
          ## ������ ���� : �̹����� ������ ��쿡 &�� �ִ� ��쿡 ������ �߻� 
          // https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/xt8viz_sbbjiyalo.jpg?fit=around|600:400&amp;crop=600:400;*,*&amp;output-format=jpg&amp;output-quality=80
      4.  IN => OR�� ������ �� ���
      5.  BETWEEN ~ AND => �Ⱓ, ���� 
      6.  IS NULL , IS NOT NULL : NULL���� ��� 
      7.  LIKE : �˻�(����) 
      8.  NOT   : ���� 
      9.  ���տ����� (UNION, UNION ALL,INTERSECT , MINUS) : ��� ������� ���� (�ΰ��� select������ �ʿ��ϴ�)
      
      ORDER BY : ���� 
      => ����Ŭ�� ��½ÿ� ������ ?  ����� ���� (������ ����)
      => SELECT * 
         FROM emp
         ========
         ORDER BY (�÷���) ASC|DESC  (ASC=> �ø����� , DESC => ��������)
              ���� , ��ȭ => ����  => ASC
              �Խ��� , ��� => �ֽ� => DESC
*/
SELECT * 
FROM emp
ORDER BY empno ASC;
-- ASC�� ORDER BY�ÿ� ������ ���� 
-- empno ename job mgr hiredate comm sal deptno
SELECT empno, ename, job, mgr, hiredate, comm ,sal, deptno
FROM emp
ORDER BY empno;
-- ��ȣ�� �÷��� ���� 
SELECT * 
FROM emp
ORDER BY 8;
-- ��� ������ 
-- ����Ŭ�� 0�����Ͱ� �ƴϰ� 1������ 
/*
     HELLO JAVA
     0123456789 => �ڹ� 
     12345678910 => ����Ŭ 
*/
SELECT ename,deptno
FROM emp
ORDER BY 2;
-- DESC�� ������ �� ���� 
SELECT ename,deptno
FROM emp
ORDER BY deptno DESC;
-- �޿��� ���� ������ ���
SELECT ename, sal
FROM emp
ORDER BY sal DESC;

SELECT ename,sal
FROM emp
ORDER BY 2 DESC , 1 ASC;
-- sal �������� ��� => ���� ���� �ִ� ��쿡 �̸� �ø����� 
/*
    SELECT 
      = SELECT * | column��,column��...
        FROM (���̺��,���, SELECT~) 
                     ===== =======
                     View   �ζ��κ� 
        [
            1. WHERE
            2. GROUP BY
            3. HAVING => �ܵ����� ����� �Ұ��� (Group by�� �������� ����� ����)
            4. ORDER BY
        ]
        
      = DESC�� ���̺��� �÷���� �������� Ȯ�� 
      = ���ڿ�,��¥�� ''�� ����Ѵ� 
              == YY/MM/DD
      = ��Ī => �÷� , ���̺� ��� 
               SELECT abcdefghije "AA" , as ��Ī
               FROM salgrade s
      = || => ���ڿ� ���� 
      = &  => �Է°��� �޴� ��� 
      = DISTINCT : �ߺ��� ���� ������ ��� 
      = ����� �����ʹ� ��ҹ��ڸ� ���� (���̺��� ����� ��� => �빮�ڷ� ����)
      = �񱳿����� => ���� , ����,��¥ ���� 
      = BETWEEN ~ AND    >=  AND <=
*/
SELECT deptno,sal,ename
FROM emp
ORDER BY 1,2 DESC;







