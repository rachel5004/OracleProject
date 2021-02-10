/*
     WHERE : 원하는 조건만 골라내기 (40page)
     ## 문자열 , 날짜 => ''를 이용한다 
        ""는 별칭이나 인용부호를 사용할때 사용 
     조건 => 연산자  
     1. 오라클에서 지원하는 연산자(NULL을 연산처리하면 NULL) 
        = 이항연산자 
           SELECT sal*12,sal+comm
        1) 산술연산자 : + , - , * , / (나머지:MOD)
                      / => 0으로 나눌 수 없다 , 정수/정수=실수 (5/2=2.5)
        2) 비교연산자 : =(같다) , !=(같지않다) => <> , ^=
                      < , > , <= , >=
        3) 논리연산자 : AND , OR => (&&: Scanner, ||: 문자열 결합)
        4) NULL 연산자 
                = IS NULL : NULL일 경우 처리
                = IS NOT NULL : NULL값이 아닌 경우 처리
        5) IN 연산자 : OR가 여러개 일경우에 사용 
                WHERE deptno=10 OR deptno=20 OR deptno=30
                WHERE deptno IN(10,20,30)
        6) BETWEEN ~ AND : 기간 , 범위에 포함  => 포함 => 페이지 나눌때 
                WHERE deptno BEWEEN 10 AND 30  ==> detpno>=10 AND deptno<=30 
        7) LIKE : 유사문자열 검색 
                  % : 문자열 
                      예) A%  => A로 시작하는 모든 문자열 
                          %A  => A로 끝나는 모든 문자열
                          %A% => A가 포함된 모든 문자열 
                  _ : 한글 글자 
                      예) __O__  => 5글자 가운데 O가 포함된 문자열 
                      => 함수 : REGEXP_LIKE("정규식",value)
            SELECT 컬럼명 ,(SELECT~ ) as "" , (SELECT ~) as ""
            SEELCT ~ FROM (SELECT~~)
            SELECT => 데이터 검색 (컴럼대신,테이블 대신)
        8) NOT : 부정 
                 NOT LIKE => !LIKE(X)
                 NOT IN
                 NOT BETWEEN ~ AND
*/
--SELECT ename , sal+comm FROM emp;
-- 연산처리 (산술연산자) emp , 연습용 테이블 (DUAL)  SELECT 1+2 FROM DUAL;
-- 오라클은 대소문자 구분이 없다 (단 대소문자 구분이 있는 곳이 있다 => 저장된 데이터) 
--SELECT * FROM emp WHERE ename='KING';
-- String sql="SELECT * FROM emp WHERE ename='KING'";
--SELECT * FROM emp WHERE ename=KING;
-- String sql="SELECT * FROM emp WHERE ename=KING";
-- 1. 산술연산자 => 형변환 (함수: TO_CHAR,TO_NUMBER,TO_DATE) 
SELECT 10+20,10-20,10*20,5/2 FROM DUAL;
-- 정수/정수=실수
-- NULL 값은 값이 없는 상태 => 연산처리 NULL이 있는 경우에는 연산처리 = NULL
SELECT 10+null , 5/2 FROM DUAL;
-- emp에서 이름,실제 급여(sal,comm)와 연봉을 출력
-- 산술 연산자는 boolean(true/false) => 조건문에서 사용이 불가능  (SELECT 뒤에서 처리)
SELECT ename,sal+NVL(comm,0),sal*12 FROM emp;
-- 비교연산자 ( = , != , < , > , <= , >=)
-- 부서번호가 10인 사원의 이름,부서번호,직위를 출력 
SELECT ename,deptno,job,hiredate
FROM emp
WHERE deptno=10+10;
-- 사원이름이 SCOTT인 사원의 모든 정보를 출력  => *
SELECT * 
FROM emp
WHERE ename='SCOTT';
-- 사원중에 1981년 4월 1일에 입사한 사원의 모든 정보를 출력 
-- 날짜 => ''
-- 날짜 형식 => YY/MM/DD
SELECT ename,hiredate,TO_CHAR(hiredate,'YYYY-MM-DD')
FROM emp
WHERE hiredate='81/04/01';
-- =은 같다 (==이 아니다) =연산자 (비교연산자 , 대입연산자) => WHERE다음에 =(비교연산자) , WHERE아닌 다른곳 (대입연산자)
/*
     UPDATE emp SET
     ename='홍길동'  = 대입
     WHERE empno=7788 = 비교
*/
-- != , <> , ^=
SELECT ename,job 
FROM emp
WHERE ename!='KING';

SELECT ename,job 
FROM emp
WHERE ename<>'KING';

SELECT ename,job 
FROM emp
WHERE ename^='KING';

-- < : 왼쪽을 기준   sal<1500
SELECT * FROM emp
WHERE sal<1500;

SELECT * FROM emp
WHERE sal>1500;

SELECT * FROM emp
WHERE sal<=1500;

SELECT * FROM emp
WHERE sal>=1500;






