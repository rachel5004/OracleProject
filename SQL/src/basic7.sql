-- 변환 함수 
/*
     오라클 데이터형 
     =============
     
     문자형 => String
       = CHAR(1~2000byte)  CHAR(2) => 고정
         CHAR(100) => 'A' 
       = ***VARCHAR2(1~4000byte) => 가변  VARCHAR2(100) 'A' => 1byte
       = ***CLOB (4GA) => 가변 
     숫자형 => int / double
       = ***NUMBER(1~38) => NUMBER(4) NUMBER => 14자리  int a="100";
       = NUMBER(7,2) => 7자리에 두자리 소수점으로 사용 
     날짜형 => java.util.Date
       = ***DATE
       = TIMESTAMP : 기록경주 
     기타형 => 이미지,동영상 , 애니메이션  : InputStream
       = BLOB (4GA) : Binary저장
       = BFILE (4GA): 파일 형식
       
       
     문자 변환 : TO_CHAR
     숫자 변환 : TO_NUMBER
     날짜 변환 : TO_DATE
     
     2+'2' => 4
*/
--SELECT 2+TO_NUMBER('2') FROM DUAL;
--SELECT 2+ASCII('12') FROM DUAL;--'0' = 48
-- 문자 변환 (TO_CHAR)  => String.valueOf()
-- 날짜 변환 
SELECT ename,hiredate,TO_CHAR(hiredate,'yyyy-mm-dd') FROM emp;
SELECT ename,hiredate,TO_CHAR(hiredate,'YYYY"년도" MM"월" DD"일"') FROM emp;
SELECT SYSDATE,TO_CHAR(SYSDATE,'RRRR-MM-DD HH24:MI:SS') FROM DUAL;
/*
    날짜 문자열로 변경 
    년도 : YYYY(yyyy) , YYY(yyy) , YY(yy)
           RRRR,RR (2000년도 Y2K) 
     월 : MM
     일 : DD
     시간 : HH , HH24 
     분 : MI
     초 : SS
     
    숫자 : 999999
     '10' 'A' 
*/
SELECT ename,sal,TO_CHAR(sal,'L999,999') FROM emp;
SELECT TO_NUMBER('10') , TO_DATE('21/02/09') FROM DUAL;
-- '2' Integer.parseInt() , SimpleDateFormat()
-- 기타 함수 (NVL:NULL값을 다른 값을 변경할 때 사용)
-- NVL2(comm,값,값)
-- NVL2(comm,sal+comm,sal+0)
-- ''=>NULL ' '=>공백 
-- NVL => 데이터형을 맞춘다 
SELECT ename,sal "급여",comm "성과급", sal+NVL(comm,0) "실제급" FROM emp;
SELECT zipcode,sido,gugun,dong,NVL(bunji,' ') FROM zipcode;
-- NVL2
-- NVL2(컬럼명(NULL이 있는),처리 , 처리)
SELECT ename,sal,comm,NVL2(comm,sal+comm,sal) FROM emp;--삼항연산자
-- DECODE => 다중 조건문)
/*
    DECODE(컬럼명,10,''
                 20,''
                 30,''
                 40,'')
                 
                 DECODE(tel,02,'서울'
                           032,'인천'
*/
-- Trigger
SELECT ename,job,sal,deptno,DECODE(deptno,10,'개발부',
                                20,'영업부',
                                30,'기획부') "부서"
FROM emp;

SELECT ename,job,deptno,CASE WHEN deptno=10 THEN '개발부'
                             WHEN deptno=20 THEN '영업부'
                             WHEN deptno=30 THEN '기획부'
                             END "부서"
FROM emp;

SELECT ename,job,sal,CASE WHEN sal>=800 AND sal<=1500 THEN '1등급'
                          WHEN sal>1500 AND sal<=2000 THEN '2등급'
                          WHEN sal>2000 AND sal<=2500 THEN '3등급'
                          WHEN sal>2500 AND sal<=3000 THEN '4등급'
                          WHEN sal>3000 THEN '5등급'
                          END "grade"
FROM emp;

SELECT * FROM emp;
SELECT ename,job,DECODE(job,'MANAGER','관리자',
                            'SALESMAN','판매자',
                            'ANALYST','분석가',
                            'CLERK','일반사원',
                            'PRESIDENT','사장') "직위"
FROM emp;

-- NVL , NVL2 
/*
     문자 함수 : LENGTH,SUBSTR , RPAD 
     숫자 함수 : CEIL
     날짜 함수 : SYSDATE , MONTHS_BETWEEN
     변환 함수 : TO_CHAR
     기타 함수 : NVL
                DECODE (약간)
*/










