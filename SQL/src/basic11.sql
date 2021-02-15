/*
    page 18 => DBMS (면접) 
    page 19 => SQL 
      SQL 
       DML (SELECT,INSERT,UPDATE,DELETE)
       DDL (CREATE , ALTER , DROP , RENAME, TRUNCATE)
       TCL (COMMIT, ROLLBACK)
    page 26 => SELECT 문법
               ======= 출력 , 컬럼 대신 , 테이블 대신 
                            ==========  ==========
                             스칼라 서브쿼리 , 인라인 뷰 
       SELECT * | column1,column2...
             ===  ==================
             page 26    page 29
       FROM table명|View명|SELECT ~~
       [
          WHERE
          GROUP BY
          HAVING
          ORDER BY
       ]
       
    page 33 => 별칭 => 함수로 출력 , 컬럼명이 길다 
       = 컬럼명 "별칭"
       = 컬럼명 as 별칭 
    page 34 => 중복을 제거 : DISTINCT (컬럼 앞에 사용)
       SELECT DISTINCT deptno ~~
    page 37 => 문자열 결합 : ||
               =====
               '' => 문자,문자열,날짜 (숫자 => ''을 붙여도 상관이 없다 (자동형변환)=> 속도가 늦다)
               
    page 36 => ORDER BY 
            1. 정렬 (오라클은 빈공간에 데이터를 저장하기 때문에 순서가 존재하지 않는다) 
            2. ORDER BY 컬럼번호,컬럼명,함수 ASC|DESC => ASC는 생략이 가능 
                        =======
               SELECT * FROM emp
               ORDER BY 1 => empno
            3. 이중 정렬 =>() ,() => 댓글 , 답변형 게시판 
                         ===  ==
    page 40 => WHERE (조건문) 
               ====== 연산자 
               산술 연산자 : 주로 SELECT뒤에 
               나머지 연산자 : boolean => WHERE 문장 뒤에 
               ===========
                비교연산자 : = , !=(<>) , < , > , <= ,>=
                논리연산자 : AND , OR
                대입연산자 : = (UPDATE)
                NOT,NULL,BETWEEN,IN(OR가 여러개),LIKE(%,_)
                === ===== 연산처리가 안된다 => IS NULL , IS NOT NULL 
                NOT IN()
                NOT BETWEEN
                NOT LIKE 
                NOT (sal>= AND sal<=)
    page 41 => 문자 조회는 '' , 대소문자 구분  (page 43)
    page 45 => 연산자 종류 (45~56)
    page 56 => ORDER BY 
    page 59 => 집합 연산자(테이블 2개에서 데이터를 얻어오기)
               UNION :  데이터 전체를 가지고 온다 (단 중복은 제거)
                  A : 12345 
                  B : 34567    ==> 1234567
               UNION ALL : 데이터 전체를 가지고 온다 (FULL OUTER JOIN)
                  A : 12345 
                  B : 34567    ==> 1234534567
               INTERSECT : 교집합  (INNER JOIN)
                  A : 12345 
                  B : 34567    ==> 345
               MINUS : 같은 데이터 제외하고 나머지 
                  A : 12345 
                  B : 34567    ==> A-B :12 , B-A : 67
               INTERSECT+(A-B) : LEFT OUTER JOIN
               INSERSECT+(B-A) : RIGHT OUTER JOIN
               
    page 68 : 단일행 , 집합함수 
    page 69 : 단일행 
              =====
              문자함수 , 숫자함수 , 날짜함수 ,변환함수 ,일반함수 
    page 70 : 문자함수 
              SUBSTR() : 75 page
              LENGTH() : 73 page
              INSTR()  : 76 page
              RPAD ()  : 81 page
              REGEXP_LIKE() : 124 page
    page 86 : 숫자함수 
              ROUND() : 반올림 => 86 page
              TRUNC() : 버림   => 86 page
              MOD() : 나머지   => 87 page
              CEIL(): 올림    => 87 page
    page 89 : 날짜함수 
              SYSDATE : 시스템의 날짜 , 시간 => 90 page
              MONTHS_BETWEEN()            => 91 page
    page 99 : 형변환함수 
              TO_CHAR () :문자열 변환 (page 102(년도,월,일,시간,분,초)
                                     (page 107 (숫자변환))
              page 99 => 오라클에서 사용하는 데이터형 
              문자형 (CHAR , VARCHAR2,CLOB) => String
              숫자형 (NUMBER) => int ,double
              날짜형 (DATE,TIMESTAMP) => java.util.Date
    page 110 : 일반함수
               NVL() : NULL값일 경우에 대체하는 함수 : 110page
               DECODE() : 다중 조건문 : 113page
    집합함수 
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











