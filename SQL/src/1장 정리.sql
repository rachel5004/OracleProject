/*
      DML (������ ���۾��) 
      ==================
        SELECT : ������ �˻�
          1) ����
             SELECT *(��ü)|column1,column2..(���ϴ� �����͸� ���)
             FROM table��
                  =======  �����Ͱ� ����� ���� => 2���� ���� (column,row)
                  =============================
                     name    sex    addr  ===> ������ ���� (�÷�)
                  =============================
                    ȫ�浿    ����    ����  ===> row (record) => �����͸� �о���� ���� record
                  =============================
                    ��û��    ����    ���  ===> row (record) => �����͸� �о���� ���� record
                  =============================
             [
                 1) WHERE ���ǹ� => ������
                 2) GROUP BY �׷��÷� => �׷캰�� ������ ó��
                 3) HAVING (�׷쿡 ���� ����) => �ݵ�� GROUP BY�� �����Ͽ� ����� ���� 
                 4) ORDER BY �����÷� ASC(�ø�����:������ ����)|DESC(��������)
                             ======= �÷���ġ��ȣ�� ���� 
             ]
          2) ���ǿ� �ش��ϴ� �����͸� ������ �ö� 
             = ������ : ���� ���� ���(NULL)  => ' '(���鹮��),''(NULL)
               ��� ������ => ����ȯ�� ���� => ����ȯ�Ҷ��� �ݵ�� �Լ� �̿��Ѵ� 
                            TO_CHAR , TO_NUMBER , TO_DATE , ASCII(���ڸ� ���������� ����)
                                      TO_NUMBER('A') : Error  => ASCII('A') => 65
                                      Integer.parseInt("A"):Error
                 +,-,*,/ => / (1. 0���� ���� �� ���� , 2. ����/����=�Ǽ�) => SELECT �ڿ��� ����ó�� 
                            ���� , ��� , ���� , �޿�...
               �� ������
                 = , !=(<>,^=) , < , > , <= , >= 
               �� ������
                 OR : ������ ���� ��� ( || => ���ڿ� ����)
                 AND: ������ ������ ��� ( & => ����� �Է°��� �޴� ���)
               NOT : ���� => NOT LIKE , NOT BETWEEN , NOT IN
               LIKE : ���繮�ڿ� 
                  % => ���ڿ�(���ڿ� ������ ����)
                       A% : A�� �����ϴ� ���ڿ� 
                       %A : A�� ������ ���ڿ� 
                       %A%: A�� ���� 
                  _ => �ѱ��� __O__
               BETWEEN : ������ �Ⱓ   =>  >= AND <=
               IN : OR�� ������ �϶� �ַ� ��� 
               NULL : �����Ͱ� NULL �� ��쿡�� ����ó���� ���� �ʴ´� 
                      IS NULL (NULL�� ���)
                      IS NOT NULL (NULL�� �ƴ� ���)
               = ���ڿ� ���� : ||
               = �ߺ� ���� : DISTINCT
               = & : �Է°� �޴� ��� 
        INSERT : ������ �߰� 
        UPDATE : ������ ����
        DELETE : ������ ���� 
*/
--<<1>>  �μ� ��ȣ�� 10���� �μ��� ��� �� �����ȣ(deptno), �̸�(ename), �޿�(sal)�� ����϶�.
-- 1. ��� ���� Ȯ�� 
-- 2. ���� 
   SELECT deptno,ename,sal
   FROM emp
   WHERE deptno=10; -- (=) ���� 

--<<2>>  �����ȣ(empno)�� 7698�� ��� �� �̸�, �Ի�����(hiredate), �μ���ȣ�� ����϶�.
  SELECT ename,hiredate,deptno
  FROM emp
  WHERE empno=7698;

--<<3>>  �̸��� ALLEN�� ����� ��� ������ ����϶�.
  SELECT *
  FROM emp
  WHERE ename='ALLEN'; 
  -- 1. ���ڿ� , ��¥�� �ݵ�� ''�� ����Ѵ� 
  -- 2. ���ڿ� �����ʹ� ��ҹ��ڸ� �����Ѵ� 
  -- 3. ����Ŭ�� ǥ�� 2�� '' , ���� => ""(��Ī,�ο�) TO_CHAR(SYSDATE,'YYYY"�⵵" MM"��" DD"��"')
  -- 4. ����Ŭ������ ������ ����Ǹ� ;�� ����Ѵ� , �ڹٿ��� �ڵ����� ;�� �߰� 
  -- String sql="SELECT * FROM emp"
--<<4>>  �Ի����ڰ� 83/01/15�� ����� �̸�, �μ� ��ȣ, �޿��� ����϶�.
  -- ��¥�� ���ڿ��� ���� ���   '83/01/15' 
  SELECT ename,deptno,sal
  FROM emp
  WHERE hiredate='83/01/15';
  -- ��¥�� �⺻�� ==> YY/MM/DD => system���� ������ ����  YYYY-MM-DD
  -- ���ڿ� , ������ , ��¥�� => ��� �����ڸ� �����Ѵ� (��¥,���ڸ� �񱳿����ڷ� ����ó���� ����)
--<<5>>  ������ MANAGER�� �ƴ� ����� ��� ������ ����϶�.
  -- != , <> , ^= , NOT ���� => ����Ŭ�� ���� (���� ����ε� ������ ���� ����) => ���� (��û�� ���� ���)
  -- ���� : ����ȭ
  SELECT *
  FROM emp
  WHERE job<>'MANAGER';

--<<6>>  �Ի����ڰ� 81/04/01 ���Ŀ� �Ի��� ����� ������ ����϶�.
  -- ��¥�� �Ϲ� ����ó�� ����ó���� ���� 
  SELECT *
  FROM emp
  WHERE hiredate>'81/04/01';

--<<7>>  �޿��� $800�̻��� ����� �̸�, �޿�, �μ� ��ȣ�� ����϶�.
  SELECT ename,sal,deptno
  FROM emp
  WHERE sal>=800;

--<<8>>  �μ���ȣ�� 20�� �̻��� ����� ��� ������ ����϶�.
  SELECT *
  FROM emp
  WHERE deptno>=20;

--<<9>>  ������ K�� �����ϴ� ������� ���� �̸��� ���� ����� ��� ������ ����϶�.
  SELECT *
  FROM emp
  WHERE ename>'K%' AND ename<>'KING';

     
--<<10>>  �Ի����ڰ� 80/12/09 ���� ���� �Ի��� ������� ��� ������ ����϶�.
  SELECT *
  FROM emp
  WHERE hiredate<'80/12/09';

--<<11>>  �Ի��ȣ�� 7698 ���� �۰ų� ���� ������� �Ի��ȣ�� �̸��� ����϶�.
  -- �� ������ => <=	
  SELECT empno,ename
  FROM emp
  WHERE empno<='7698'; 
  -- �ڵ����� ���ڿ��� ���ڷ� ���� 
--<<12>>  �Ի����ڰ� 81/04/01 ���� �ʰ� 82/12/22 ���� ���� ����� �̸�, ����, �μ� ��ȣ�� ����϶�.
  -- �� ������ => AND , OR => BETWEEN ~ AND (X)
  SELECT ename,sal,deptno
  FROM emp
  WHERE hiredate>'81/04/01' AND hiredate<'82/12/22';

--<<13>>  �޿��� 1,600 ���� ũ�� $3,000���� ���� ����� �̸�, ����, �޿��� ����϶�.
  SELECT ename,job,sal
  FROM emp
  WHERE sal>1600 AND sal<3000;

--<<14>>  �����ȣ�� 7654�� 7788 ���� �̿��� ����� ��� ������ ����϶�.
  SELECT *
  FROM emp
  WHERE NOT (empno>=7654 AND empno<=7788);
  -- NOT ���� => (�ڹ� !)
--<<15>> �̸��� B�� J ������ ��� ����� ������ ����϶�.
  -- BETWEEN ~ AND 
  SELECT *
  FROM emp
  WHERE ename BETWEEN 'B' AND 'J';

--<<16>>  �Ի����ڰ� 81�� �̿ܿ� �Ի��� ����� ��� ������ ����϶�.
  -- NOT LIKE 
  SELECT *
  FROM emp
  WHERE hiredate NOT LIKE '81%';

  SELECT *
  FROM emp
  WHERE hiredate NOT BETWEEN '81/01/01' AND '81/12/31';
--<<17>>  ������ MANAGER�� SALESMAN�� ����� ��� ������ ����϶�.
  -- OR => IN
  SELECT *
  FROM emp
  WHERE job='MANAGER' OR job='SALESMAN';
  
  SELECT *
  FROM emp
  WHERE job IN('MANAGER','SALESMAN');
--<<18>>  �μ� ��ȣ�� 20,30���� ������ ��� ����� �̸�, �����ȣ, �μ� ��ȣ�� ����϶�.
  SELECT ename,empno,deptno
  FROM emp
  WHERE deptno NOT IN(20,30);
	
--<<19>>  �̸��� S�� �����ϴ� ����� �����ȣ, �̸�, �Ի�����, �μ���ȣ�� ����϶�.
  -- LIKE => 'S%' => �ڹٿ����� ���� 
  SELECT empno,ename,hiredate,deptno
  FROM emp
  WHERE ename LIKE 'S%';

--<<20>>  �Ի����ڰ� 81�⵵�� ����� ��� ������ ����϶�.
  SELECT *
  FROM emp
  WHERE hiredate LIKE '81%';
  
  SELECT *
  FROM emp
  WHERE SUBSTR(hiredate,1,2)=81;

--<<21>>  �̸� �� S�ڰ� �� �ִ� ����� ��� ������ ����϶�.
  SELECT *
  FROM emp
  WHERE ename LIKE '%S%';
	
-- �����ȣ ã�� 
/*
     zipcode 
     sido
     gugun
     dong
     bunji
     1. dong���� �˻� 
     2. �����ȣ , address�� ��� => ���� 
*/
    SELECT zipcode,sido||' '||gugun||' '||dong||' '||bunji as address
    FROM zipcode
    WHERE dong LIKE '%����%';
    -- ���̺��� �÷����� �����ص� �ȴ� 
--<<22>>  �̸��� S�� �����ϰ� ������ ���ڰ� T�� ����� ��� ������ ����϶� (��, �̸��� ��ü 5�ڸ��̴�.>> 
   -- _
   SELECT * 
   FROM emp
   WHERE ename LIKE 'S___T';
--<<23>>  ù ��° ���ڴ� ������� �� ��° ���ڰ� A�� ����� ������ ����϶�.
  SELECT *
  FROM emp
  WHERE ename LIKE '_A%';
  
--<<24>>  Ŀ�̼��� NULL�� ����� ������ ����϶�.
  -- �����Ͱ� NULL�� ��쿡�� ����ó���� �� �� ���� => NULL�� ���� ������ ��� => IS NULL, IS NOT NULL
  SELECT *
  FROM emp
  WHERE comm IS NULL;

--<<25>>  Ŀ�̼��� NULL�� �ƴ� ����� ��� ������ ����϶�.
  SELECT *
  FROM emp
  WHERE comm IS NOT NULL;
  -- NULL�� 0�� �ƴϴ�  (0�� ���� ���� , NULL�� ���� �������� �ʴ´�)
--<<26>>  �μ��� 30�� �μ��̰� �޿��� $1,500 �̻��� ����� �̸�, �μ�, ������ ����϶�.
  -- �� ������ AND
  SELECT ename,deptno,sal
  FROM emp
  WHERE deptno=30 AND sal>=1500;

--<<27>>  �̸��� ù ���ڰ� K�� �����ϰų� �μ� ��ȣ�� 30�� ����� �����ȣ, �̸�, �μ� ��ȣ�� ����϶�.
	-- OR���� (IN������ ��� �� �� ����) => IN(������ ������)
    SELECT empno,ename,deptno
    FROM emp
    WHERE deptno=30 OR ename LIKE 'K%';
	
--<<28>>  �޿��� $1,500�̻��̰� �μ� ��ȣ�� 30���� ��� �� ������ MANAGER�� ����� ������ ����϶�.
	SELECT *
    FROM emp
    WHERE sal>=1500 AND deptno=30 AND job='MANAGER';


--<<29>>  �μ� ��ȣ�� 30�� ��� �� �����ȣ�� SORT �϶�.
	-- ORDER BY => SQL������ �������� ���
    SELECT *
    FROM emp
    WHERE deptno=30
    ORDER BY empno DESC;
    
    SELECT *
    FROM emp
    WHERE deptno=30
    ORDER BY empno ASC;
    
    SELECT *
    FROM emp
    WHERE deptno=30
    ORDER BY empno;
    
    SELECT *
    FROM emp
    WHERE deptno=30
    ORDER BY 1 ASC;
	
   
--<<30>>  �޿��� ���� ������ SORT�϶�.
  SELECT *
  FROM emp
  ORDER BY sal DESC;
  
  -- ���� �޿��� ���� ������ 5�� ��� 
  SELECT * FROM emp
  WHERE ROWNUM <= 5
  ORDER BY sal DESC;
  -- ����¡ => �ζ��κ� 
  SELECT empno,ename,sal,rownum
  FROM (SELECT empno,ename,sal FROM emp ORDER BY sal DESC)
  WHERE rownum<=5;
--<<31>>  �μ� ��ȣ�� ASCENDING SORT�� �� �޿��� ���� ��� ������ ����϶�.
  SELECT * 
  FROM emp
  ORDER BY deptno ASC , sal DESC;
  -- GROUP BY
/*
@c:\oracleDev\zipcode
COMMIT;
*/
-- SELECT COUNT(*) FROM zipcode;
-- SELECT * FROM zipcode;
