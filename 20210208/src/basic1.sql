-- 한줄 주석 
/*
     여러줄 주석 
     오라클 표현법 
       = 숫자표현 : 10 , 10.5 => 정수 / 실수 
       = 문자/문자열 표현 : 'A'=(문자) ,'ABC' (문자열) => ""(인용부호:별칭)
       = 날짜표현: '' (문자열 형식으로 저장) 
                  형식) 'YY/MM/DD' => '21/02/08'
     데이터베이스
     오라클 
     SQL 
      = DQL : SELECT (저장된 데이터를 검색)
              = SELECT의 형식 
              = 조건 
                 = 연산자 
              = 내장 함수 => 사용처 
                 = 단일행 함수
                 = 집합 함수 
              = JOIN : 데이터 연결 
                 = INNER JOIN
                   = EQUI_JOIN
                   = NON_EQUI_JOIN
                 = OUTER JOIN (INNER JOIN+알파)
                   = LEFT_OUTER_JOIN
                   = RIGTH_OUTER_JOIN
                   = FULL_OUTER_JON
              = SUBQUERY : SQL문장 연결 
                   = 단일행 서브쿼리
                   = 다중행 서브쿼리
                   = 스칼라 서브쿼리 : 컬럼대신 사용
                   = 인라인(Top-N) : 테이블 대신 사용
      = DML : 조작언어 (추가 , 수정, 삭제)
              INSERT , UPDATE , DELETE 
      ------------------------------------- 웹프로그래머가 사용 
      = DCL : DBA (권한부여 / 권한 해제)
                 GRANT   /  REVOKE
      = DDL : 생성 => CREATE , ALTER , DROP , RENAME , TRUNCATE 
                      생성      수정    삭제    이름 변경  잘라내기
                      제약조건 : 오라클에 저장되는 데이터 (공유) : 필요한 데이터만 저장
                               (정형화된 데이터)
                               => 정규화 (프로젝트)
      = TCL : 정상 저장 / 취소 
              COMMIT  / ROLLBACK => TRANSACTION (일괄처리) : Spring,JSP
              
      사용자 요청 ========> Java  ============> 오라클 
            데이터를 받아서 => SQL문장으로 변환 => 오라클 전송 
              <========= Java  <============= 오라클
              
      1. SQL (DQL) => Column명이 어떤게 있는지 확인 
                      ======== 자바 멤버변수
                      1) Column을 확인 => DESC table명 => table(column+record)
                                                                      ======= row
                                         오라클은 데이터가 저장이 될때 기본단위가 table (column명+실제 데이터)
                      2) 오라클 문법 
                         ========= 1. 대소문자 구분이 없다 (약속: 키워드는 대문자로 사용)
                                   2. 문장이 종료하면 ;을 사용한다 (자바에서 SQL문장을 전송할때 ;을 사용하면 오류발생
                                        
*/
DESC emp;
/*
      EMPNO    NOT NULL NUMBER(4)    => 사번 (중복이 없다) => 정수형으로 저장 (int)
                        ========= 0~9999
      ENAME             VARCHAR2(4000) => 이름             => 문자열  ==> ''  WHERE ename='SCOTT' (String)
                                ==== 1~10 => Byte 
      JOB               VARCHAR2(9)   => 직위            => 문자열 
      MGR               NUMBER(4)    => 사수             => 정수형 
      HIREDATE          DATE          => 입사일          => 날짜형 (java.util.Date)
      SAL               NUMBER(7,2)   => 급여            => 실수형 (double)
      COMM              NUMBER(7,2)   => 성과급
      DEPTNO            NUMBER(2)     => 부서번호
                        =========== 0~99 
*/
/*
      폴더 , 파일 
      ===   ===
      데이터베이스 , 테이블
      ========== XE
      DQL : SELECT (오라클에 저장된 데이터를 검색)
      1) SELECT의 문법 형식
         SELECT *|column명,column명  ==> *(전체데이터 검색),필요한 데이터만 읽기 (column...)
         FROM 테이블명(파일명) ==> for
         [
            1.WHERE 조건문  ==> 자바 (if) => 연산자 
            2.GROUP BY (그룹컬럼) => 그룹별로 나눠서 처리 (입사년도,직위별,부서별)
            3.HAVING 그룹 조건 => GROUP BY가 있는 경우에만 사용이 가능 => 연산자 
            4.ORDER BY 컬럼명 (ASC|DESC) => 정렬 
                     ename ASC|DESC
         ]
         => 조건 , 정렬  WHERE , ORDER BY
         
*/
-- 1. emp(사원 정보) => 모든 사원 정보를 보여 달라 
SELECT * FROM emp;
-- 2. emp(사원정보) => 사번 , 이름 , 급여 
SELECT empno,ename,sal FROM emp;
-- 3. emp(사원정보) => 이름 , 직위 , 입사일 
SELECT ename,job,hiredate FROM emp;
-- 4. SELECT 사용방식 
SELECT ename,job,hiredate
FROM emp;
-- 5. XE(데이터베이스:폴더) : 모든 테이블(파일)이 저장 => 모든 테이블 확인 
-- 테이블명이 중복되면 안된다 (테이블 명이 유일)
SELECT * FROM tab;
/*
    이미 만들어진 테이블 확인 
     SELECT * FROM tab;
    컬럼 확인 
     DESC 테이블명
*/
-- 옵션 사항 (1. 문자열 결합, 2. 컬럼의 별칭 , 3.중복없는 데이터 출력)
/*
     문자열 결합 (자바 + , 오라클 || => OR)
     별칭 hiredate , job , sal
         hiredate "입사일"
         hiredate as 입사일
     중복없는 데이터 DISTINCT
*/
-- 1. 별칭 
SELECT empno "사번",ename as 이름,job "직위",hiredate as 입사일,sal "급여"
FROM emp;
-- 2. 중복없는 데이터 (직위 종류)
SELECT DISTINCT job FROM emp;
-- 3. 부서(deptno)의 종류를 가지고 온다 => 별칭을 부서번호 
SELECT DISTINCT deptno "부서번호"
FROM emp;
-- 4. 문자열 결합 (||)
SELECT '이름은 '||ename||'이고 입사일은 '||hiredate||'입니다'  as 사원정보
FROM emp;
   










