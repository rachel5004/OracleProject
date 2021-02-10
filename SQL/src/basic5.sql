-- 내장함수 
/*
       단일행 함수 : 한번에 한줄씩 처리 
       복수행(집합) 함수 : 여러개의 데이터를 동시에 처리 
       
       단일행 함수 
       ==========
        문자함수(String메소드)
           = 대문자 변환 = UPPER('hello') => HELLO 
           = 소문자 변환 = LOWER('HELLO') => hello
           = 이니셜 변환 = INITCAP('hello') => Hello
           ***= 문자 갯수   = LENGTH('Hello') => 5 , LENGTH('홍길동') => 3
                          LENGTHB('Hello') => 5 , LENGTHB('홍길동') => 9
           = CONCAT = 문자열 결합 ( || ) 
             CANCAT('Hello','Java') => HelloJava => 'Hello'||'Java'
           ***= SUBSTR = 문자를 자를때 
             SUBSTR('123456789',3,2) => 12345
                                 === 갯수
           ***= INSTR : 문자번호 추출 
             INSTR('ABCDE','C') => 3
           = LPAD , ***RPAD (ID찾기,비밀번호찾기)
             LPAD('admin' , 10, '*') => *****admin
             ***RPAD('admin' , 10, '*') => admin*****
           = LTRIM,RTRIM ,TRIM : 특수문자 제거 (좌우)
             LTRIM('ABCDA','A') => BCDA
             RTRIM('ABCDA','A') => ABCD
             ***TRIM('A' FROM 'ABCDA') => BCD
             REPLACE('ABCDE','A','B') => BBCDE
        숫자함수(Math메소드)
           ***= CEIL : 올림함수 => 총페이지 구하기 
             CEIL(12345.1) => 12346
           ***= ROUND : 반올림 => ROUND(12345.678,2) => 12345.68
           = TRUNC : 버림   => TRUNC(12345,678,2) => 12345.67 
           = MOD : 나누고 나머지 => MOD(10,2) => 10%2
        날짜함수(Date메소드)
           ***= SYSDATE : 시스템의 현재 날짜,시간 
             SYSDATE-1 , SYSDATE+1 => 
           ***= MONTHS_BETWEEN : 개월수 계산 
           = ADD_MONTHS : 개월수 추가 ADD_MONTHS(SYSDATE,3)
           = NEXT_DAY(SYSDATE,'월')
           = LAST_DAY(SYSDATE) LAST_DAY('21/01/01') => 31
        변환함수(Wrapper메소드)
           ***= TO_CHAR(): 문자열 변환 
           = TO_NUMBER() : 숫자 변환 
           = TO_DATE() : 날짜 변환 
        기타함수(오라클 자체)
           ***= NVL() : 데이터 NULL일 경우에 대체
           ***= DECODE : 다중 조건문 (if)
           = CASE : switch~case 
    
        집합함수 
        =======
          ***COUNT() : Row의 갯수 
          SUM() 
          AVG()
          ***MAX()
          MIN()
          ***RANK()
          CUBE()
          ROLLUP() 
*/
-- 대문자 ,소문자 , 이니셜 출력 
SELECT ename "일반", UPPER(ename) "대문자",LOWER(ename) "소문자",INITCAP(ename) "이니셜"
FROM emp;

SELECT ename,job,hiredate
FROM emp
WHERE ename=UPPER('king');

SELECT ename,LENGTH(ename) FROM emp;

SELECT ename
FROM emp
WHERE LENGTH(ename)=4;

SELECT ename,LPAD(ename,5,'*') , RPAD(ename,5,'*')
FROM emp;
-- 3,2
SELECT SUBSTR('Hello Oracle',3,2) FROM DUAL;
SELECT SUBSTR('Hello Oracle',-3,2) FROM DUAL;

SELECT INSTR('A-B-C-D', '-',1,3) FROM DUAL;
SELECT INSTR('A-B-C-D', '-',-1,3) FROM DUAL;
SELECT TO_NUMBER('65') FROM DUAL;
--SELECT TO_NUMBER('A') FROM DUAL;
SELECT ASCII('A') FROM DUAL;
SELECT TO_DATE('21/02/09') FROM DUAL;
SELECT empno,ename,sal,comm,NVL2(comm,sal+comm,sal*0) FROM emp;


