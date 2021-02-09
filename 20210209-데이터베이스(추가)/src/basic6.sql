-- 2021-02-09 SQL 단일행 함수 => row단위로 처리 
/*
     오라클 : 비절차적 언어 
     1
     2
     3 Error  입고 
     4 재고 
     5
     함수 = (오라클에서 제공 , 사용자 정의 함수 => PL ) => 재사용, 소스의 중복 방지 (모든 데이터를 페이징화)
      = FUNCTION : 리턴형이 존재 
      = PROCEDURE : 리턴형이 없는 함수 (void)
     단일행 함수 (69 page)
     =========
       1) 문자 함수 (문자,문자열)
          = 변환 함수 
            1. 대문자 변환  UPPER('oracle') => ORACLE 
               CREATE FUNCTION UPPER(data VARCHAR2):VARCHAR2
            2. 소문자 변환  LOWER('ORACLE') => oracle
            3. 이니셜 변환  INITCAP('oracle') => Oracle
          = 기타 함수 
            1. LENGTH : 문자의 갯수(한글도 동일) LENGTH('ABC') => 3 , LENGTH('홍길동') => 3
          = 제어 함수 
            1. 문자열 결합 :  CONCAT , ||
               CONCAT('Hello','Oracle') => HelloOracle
               'Hello'||'Oracle' => HelloOracle
               =============================
               String s1="Hello";
               String s2="Java";
               s1.concat(s2) => HelloJava
               s1+s2
               ============================
           *** 2. 문자 자르기 : SUBSTR()
               SUBSTR('1234567890',시작점,갯수) => 자바는 문자 시작번호 0,오라클 1
               SUBSTR('1234567890',3,5) => 34567
                 양수 (시작점) : 왼쪽
               SUBSTR('1234567890',-3,2) => 89
                 음수 (시작점) : 오른쪽 
            3. 문자 위치 찾기 : INSTR()
                 INSTR('A-B-C-D','-',1,3) => indexOf
                     => 6
                 INSTR('A-B-C-D','-',-1,3) => lastIndexOf
                     => 2
            4. 공백문자 제거 : LTRIM() , RTRIM() , TRIM() => 공백 포함 특정문자 제거 (좌우만 가능)
            5. 문자 추가 : LPAD() , *** RPAD()
            
       2) 숫자 함수 (정수,실수)
           = ROUND() : 반올림  원형 : ROUND(실수,소수점)  ROUND(67.897,2) => 76.90
           = TRUNC() : 버림        : TRUNC(실수,소수점)  TRUNC(67.897,2) => 76.89
           = *** CEIL() : 올림         : CEIL(67.1) => 68 => 총페이지
           = MOD() : 나머지 (%)    : MOD(5,2) => 5%2 = 1
       3) 날짜 함수 
           = *** SYSDATE 
           = *** MONTHS_BETWEEN
           = ADD_MONTHS
           = LAST_DAY
           = NEXT_DAY
       4) 변환 함수 (문자열 , 숫자,날짜)
           = *** TO_CHAR => 댓글(시간)
           = TO_NUMBER
           = TO_DATE
           = ASCII
       5) 기타 
           = *** NVL
           = NVL2 
           = DECODE  (다중 if)
           = CASE (switch~case)
      6) 정규식 함수 
*/
-- 문자 함수 (UPPER(toUpperCase()),LOWER(toLowerCase()),ININCAT)
SELECT ename "이름",UPPER(ename) "대문자변환",LOWER(ename) "소문자변환",INITCAP(ename) "이니셜변환"
FROM emp;
SELECT ename,job
FROM emp
WHERE ename=UPPER('king');
-- 문자 함수 (SUBSTR) : 문자 추출 (중요한 함수 : 자주 사용되는 함수)
-- SUBSTR(문자열,시작위치,갯수) : 양수(왼쪽) , 음수(오른쪽) , 오라클 문자 시작번호는 1번이다 
SELECT SUBSTR('1234567890',5,3) FROM DUAL;
--             12345678910
SELECT SUBSTR('1234567890',-5,3) FROM DUAL;
--                 -3-2-1
SELECT SUBSTR(ename,1,2) FROM emp;
SELECT RPAD(SUBSTR(ename,1,2),LENGTH(ename),'*') FROM emp; -- ID찾기 
-- 1980년에 입사한 사원의 모든 정보 
SELECT *
FROM emp
WHERE SUBSTR(hiredate,1,2)=81;

-- 문자 위치 찾기 INSTR(문자열,찾는문자,시작위치,번째) => 번째생략 => 1  (앞=> 양수 , 뒤:음수)
SELECT INSTR('A-B-C-D','-',1,3) FROM DUAL;
-- 앞 indexOf
SELECT INSTR('A-B-C-D','-',-1,3) FROM DUAL;
-- 뒤 lastIndexOf 

SELECT ename,INSTR(ename,'A',1,2) FROM emp;

-- TRIM() => 공백 제거 , 특정문자 제거 
-- LTRIM('문자열','제거할문자') => 왼쪽에 있는 문자만 제거가 가능
-- LTRIM('문자열') => 공백 제거 
SELECT LTRIM('AAAAAAAAABACDEFG     ','A') FROM DUAL;
SELECT RTRIM('  ABCDEFG','G') FROM DUAL;
SELECT LENGTH('     ABC    '),LENGTH('ABC') FROM DUAL;
SELECT TRIM(' ' FROM '   ABC   ') FROM DUAL;
SELECT ename,TRIM('S' FROM ename) FROM emp;

-- RPAD , LPAD 
-- LPAD(문자열,문자갯수,채울문자) => 왼쪽에 채운다 
-- LPAD('ABC',7,'#')  ####ABC
-- RPAD('ABC',7,'#')  ABC####  => ID찾기,비밀번호 찾기
-- LPAD('ABCDEFG',5,'*')  ABCDE
SELECT ename,LENGTH(ename),RPAD(ename,5,'*') FROM emp;
-- 문자열 : LENGTH , SUBSTR , RPAD

-- 숫자 함수 : MOD
SELECT MOD(5,2) FROM DUAL; --5%2
-- emp에서 사번이 짝수인 사원의 모든 정보 출력 
SELECT *
FROM emp
WHERE MOD(empno,2)=0;

SELECT CEIL(COUNT(*)/10) FROM emp;
-- COUNT(*) => emp의 총갯수  14/10 => 1.4 => 2 
-- ROUND (세금) , TRUNC(퇴직금)
SELECT ROUND(67.894,2),TRUNC(67.894,2) FROM DUAL;
-- 날짜 : SYSDATE => 시스템의 날짜(시간포함) => 숫자형 
-- 날짜 등록 (게시판,회원가입,예매일...)
SELECT SYSDATE-1 "어제",SYSDATE "오늘",SYSDATE+1 "내일" FROM DUAL;
-- MONTHS_BETWEEN => 기간의 개월수를 읽어 온다 
-- 형식 MONTHS_BETWEEN(현재날짜,전날짜)
-- emp에 있는 사원 => 몇개월 일했는지 확인 => 시간 + 분 => 소수점이 출력 할 수 있다 
SELECT ename , hiredate , ROUND(MONTHS_BETWEEN(SYSDATE,hiredate),0) "근무개월",
       TRUNC(ROUND(MONTHS_BETWEEN(SYSDATE,hiredate),0)/12,0) "근무년"
FROM emp;

-- ADD_MONTHS => 개월수 등록  원형: ADD_MONTHS(날짜,개월수) => SYSDATE,6
SELECT SYSDATE , ADD_MONTHS('20/12/22',5) FROM DUAL;-- 적금 , 보험
-- NEXT_DAY , LAST_DAY , ROUND , TRUNC 
-- NEXT_DAY : 요일 
SELECT SYSDATE,NEXT_DAY(SYSDATE,'수') FROM DUAL;
-- LAST_DAY : 등록한 달의 마지막 날 
-- '21/08/01' => 21/08/31
SELECT SYSDATE,LAST_DAY('21/12/01') FROM DUAL;







