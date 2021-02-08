/*
      오라클 연산자 
      1. 산술 연산자 ( +  , - , * , / ) => 형변환이 존재하지 않는다,단항연산자(X)
              / => 0으로 나눌 수 없다 
              정수 / 정수 = 실수 => 출력시에 주로 사용 (SELECT뒤에서 주로 사용)
              이름    국어  영어  수학 
              =====================
              홍길동   80   80   80    SELECT 국어+영어+수학,(국어+영어+수학)/3
              심청이   90   90   90
              박문수   70   70   70
              =====================
              SUM(국어) ,AVG(영어)
      2.  비교연산자 ( = , !=(<>,^=) , < , > , <= , >=) 
          WHERE문장 뒤에 사용 (조건문을 만드는 경우에 주로 사용) => 조건(true/false)
          ## WHERE문장은 자바의 if문과 동일 => 조건문 
      3.  논리 연산자 (WHERE,HAVING뒤에 사용)  : AND(범위포함) , OR(범위미포함)
          & => 입력값을 받는 경우에 사용 , || => 문자열 결합으로 사용 
          ## 데이터 수집 : 이미지를 저장할 경우에 &가 있는 경우에 문제가 발생 
          // https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/xt8viz_sbbjiyalo.jpg?fit=around|600:400&amp;crop=600:400;*,*&amp;output-format=jpg&amp;output-quality=80
      4.  IN => OR가 여러개 일 경우
      5.  BETWEEN ~ AND => 기간, 범위 
      6.  IS NULL , IS NOT NULL : NULL값일 경우 
      7.  LIKE : 검색(유사) 
      8.  NOT   : 부정 
      9.  집합연산자 (UNION, UNION ALL,INTERSECT , MINUS) : 출력 결과값을 제어 (두개의 select문장이 필요하다)
      
      ORDER BY : 정렬 
      => 오라클은 출력시에 정렬은 ?  저장된 순서 (정렬이 없다)
      => SELECT * 
         FROM emp
         ========
         ORDER BY (컬럼명) ASC|DESC  (ASC=> 올림차순 , DESC => 내림차순)
              음악 , 영화 => 순위  => ASC
              게시판 , 댓글 => 최신 => DESC
*/
SELECT * 
FROM emp
ORDER BY empno ASC;
-- ASC는 ORDER BY시에 생략이 가능 
-- empno ename job mgr hiredate comm sal deptno
SELECT empno, ename, job, mgr, hiredate, comm ,sal, deptno
FROM emp
ORDER BY empno;
-- 번호는 컬럼의 순서 
SELECT * 
FROM emp
ORDER BY 8;
-- 출력 순서로 
-- 오라클은 0번부터가 아니고 1번부터 
/*
     HELLO JAVA
     0123456789 => 자바 
     12345678910 => 오라클 
*/
SELECT ename,deptno
FROM emp
ORDER BY 2;
-- DESC는 생략할 수 없다 
SELECT ename,deptno
FROM emp
ORDER BY deptno DESC;
-- 급여가 높은 순서로 출력
SELECT ename, sal
FROM emp
ORDER BY sal DESC;

SELECT ename,sal
FROM emp
ORDER BY 2 DESC , 1 ASC;
-- sal 내림차순 출력 => 같은 값이 있는 경우에 이름 올림차순 
/*
    SELECT 
      = SELECT * | column명,column명...
        FROM (테이블명,뷰명, SELECT~) 
                     ===== =======
                     View   인라인뷰 
        [
            1. WHERE
            2. GROUP BY
            3. HAVING => 단독으로 사용이 불가능 (Group by가 있을때만 사용이 가능)
            4. ORDER BY
        ]
        
      = DESC는 테이블의 컬럼명과 데이터형 확인 
      = 문자열,날짜는 ''을 사용한다 
              == YY/MM/DD
      = 별칭 => 컬럼 , 테이블에 사용 
               SELECT abcdefghije "AA" , as 별칭
               FROM salgrade s
      = || => 문자열 결합 
      = &  => 입력값을 받는 경우 
      = DISTINCT : 중복이 없는 데이터 출력 
      = 저장된 데이터는 대소문자를 구분 (테이블이 저장될 경우 => 대문자로 저장)
      = 비교연산자 => 숫자 , 문자,날짜 포함 
      = BETWEEN ~ AND    >=  AND <=
*/
SELECT deptno,sal,ename
FROM emp
ORDER BY 1,2 DESC;







