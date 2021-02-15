/*
    page 18 => DBMS (����) 
    page 19 => SQL 
      SQL 
       DML (SELECT,INSERT,UPDATE,DELETE)
       DDL (CREATE , ALTER , DROP , RENAME, TRUNCATE)
       TCL (COMMIT, ROLLBACK)
    page 26 => SELECT ����
               ======= ��� , �÷� ��� , ���̺� ��� 
                            ==========  ==========
                             ��Į�� �������� , �ζ��� �� 
       SELECT * | column1,column2...
             ===  ==================
             page 26    page 29
       FROM table��|View��|SELECT ~~
       [
          WHERE
          GROUP BY
          HAVING
          ORDER BY
       ]
       
    page 33 => ��Ī => �Լ��� ��� , �÷����� ��� 
       = �÷��� "��Ī"
       = �÷��� as ��Ī 
    page 34 => �ߺ��� ���� : DISTINCT (�÷� �տ� ���)
       SELECT DISTINCT deptno ~~
    page 37 => ���ڿ� ���� : ||
               =====
               '' => ����,���ڿ�,��¥ (���� => ''�� �ٿ��� ����� ���� (�ڵ�����ȯ)=> �ӵ��� �ʴ�)
               
    page 36 => ORDER BY 
            1. ���� (����Ŭ�� ������� �����͸� �����ϱ� ������ ������ �������� �ʴ´�) 
            2. ORDER BY �÷���ȣ,�÷���,�Լ� ASC|DESC => ASC�� ������ ���� 
                        =======
               SELECT * FROM emp
               ORDER BY 1 => empno
            3. ���� ���� =>() ,() => ��� , �亯�� �Խ��� 
                         ===  ==
    page 40 => WHERE (���ǹ�) 
               ====== ������ 
               ��� ������ : �ַ� SELECT�ڿ� 
               ������ ������ : boolean => WHERE ���� �ڿ� 
               ===========
                �񱳿����� : = , !=(<>) , < , > , <= ,>=
                �������� : AND , OR
                ���Կ����� : = (UPDATE)
                NOT,NULL,BETWEEN,IN(OR�� ������),LIKE(%,_)
                === ===== ����ó���� �ȵȴ� => IS NULL , IS NOT NULL 
                NOT IN()
                NOT BETWEEN
                NOT LIKE 
                NOT (sal>= AND sal<=)
    page 41 => ���� ��ȸ�� '' , ��ҹ��� ����  (page 43)
    page 45 => ������ ���� (45~56)
    page 56 => ORDER BY 
    page 59 => ���� ������(���̺� 2������ �����͸� ������)
               UNION :  ������ ��ü�� ������ �´� (�� �ߺ��� ����)
                  A : 12345 
                  B : 34567    ==> 1234567
               UNION ALL : ������ ��ü�� ������ �´� (FULL OUTER JOIN)
                  A : 12345 
                  B : 34567    ==> 1234534567
               INTERSECT : ������  (INNER JOIN)
                  A : 12345 
                  B : 34567    ==> 345
               MINUS : ���� ������ �����ϰ� ������ 
                  A : 12345 
                  B : 34567    ==> A-B :12 , B-A : 67
               INTERSECT+(A-B) : LEFT OUTER JOIN
               INSERSECT+(B-A) : RIGHT OUTER JOIN
               
    page 68 : ������ , �����Լ� 
    page 69 : ������ 
              =====
              �����Լ� , �����Լ� , ��¥�Լ� ,��ȯ�Լ� ,�Ϲ��Լ� 
    page 70 : �����Լ� 
              SUBSTR() : 75 page
              LENGTH() : 73 page
              INSTR()  : 76 page
              RPAD ()  : 81 page
              REGEXP_LIKE() : 124 page
    page 86 : �����Լ� 
              ROUND() : �ݿø� => 86 page
              TRUNC() : ����   => 86 page
              MOD() : ������   => 87 page
              CEIL(): �ø�    => 87 page
    page 89 : ��¥�Լ� 
              SYSDATE : �ý����� ��¥ , �ð� => 90 page
              MONTHS_BETWEEN()            => 91 page
    page 99 : ����ȯ�Լ� 
              TO_CHAR () :���ڿ� ��ȯ (page 102(�⵵,��,��,�ð�,��,��)
                                     (page 107 (���ں�ȯ))
              page 99 => ����Ŭ���� ����ϴ� �������� 
              ������ (CHAR , VARCHAR2,CLOB) => String
              ������ (NUMBER) => int ,double
              ��¥�� (DATE,TIMESTAMP) => java.util.Date
    page 110 : �Ϲ��Լ�
               NVL() : NULL���� ��쿡 ��ü�ϴ� �Լ� : 110page
               DECODE() : ���� ���ǹ� : 113page
    �����Լ� 
    page 158 => COUNT(159),SUM(159),AVG(160),MAX(160),RANK(198) , CUBE(176),ROLLUP(167)
                ===============================================
    page 162 => GROUP BY (162~166)
*/
-- SELECT * FROM genie_music;
/*
SELECT * FROM emp;
SELECT ename,empno,hiredate
FROM emp
ORDER BY 1;
*/











