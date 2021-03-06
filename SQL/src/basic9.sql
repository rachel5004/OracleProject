/*
     오라클 
       SQL (오라클을 실행하는 언어) => 검색 (SELECT)
       ===
       DML (데이터 관리(조작)) => 웹프로그래머
         = SELECT : 데이터 찾기
         = INSERT : 데이터 추가
         = UPDATE : 데이터 수정
         = DELETE : 데이터 삭제 
       DDL :  생성 (테이블,뷰...)
              CREATE , DROP , ALTER , RENAME , TRUNCATE 
       DCL : REVOKE , GRANT 
       TCL : COMMIT , ROLLBACK 
       
       Table : 저장공간 (column,row) => 단위 row
       
       1) SELECT : 데이터 검색 
          = 형식) 
            ======================================================
            SELECT *(전체) | 원하는 데이터만 출력 (column1,column2..)
            FROM 테이블명(뷰명,SELECT~~)
            ====================================================== 필수 
            [
               1. WHERE 조건문 (형식  컬럼명 연산자 값)  ==> 연산자
                                     name = '홍길동'
               ===============================================
               2. GROUP BY 컬럼명 ===> 집합함수 
               3. HAVING 그룹조건 
               ===============================================
               4. ORDER BY 컬럼명 ASC|DESC => ASC는 생략이 가능
                           ===== 번호사용 (컴럼의 위치번호)
                           ===== , 이중 정렬 
            ]
            
        2) 연산자 
           = 산술 연산자 : + , - , * , / %(MOD)
             ========== 형변환 => 1+'1' = 2
                        변환 함수 => TO_CHAR , TO_NUMBER , TO_DATE    (NUMBER)'1'(X)
           = 비교 연산자 : 결과값 : boolean(true/false)
                = (같다) , !=,<>,^= (같지 않다)
                           != : 웹프로그래머 (자바,C,C#)
                           <> : DBA
                           ^= : 저질프로그래머
                < , > , <= ,>=
           = 논리 연산자 : 결과값 : boolean(true/false)
                AND , OR
                ** & : 입력값 받는 경우 
                ** || : 문자열 결합 
           = IN => 여러개의 OR를 대체
           = BETWEEN ~ AND =>  >= AND <= (기간,범위)
           = NOT : 부정  => NOT BETWEEN , NOT LIKE , NOT IN  (!는 자바에서의 부정)
           = LIKE : %(문자열 제한이 없다) , _ (한글자)  
                    %  , %%  _%
                    => 한계 => REGEXP_LIKE() : LIKE를 보완한 함수 
           = NULL : 모든 연산자는 NULL값을 처리 할 수 없다 
                    IS NULL
                    IS NOT NULL
        3) 내장함수
           = 단일행 함수 (ROW단위로 변경)
             문자 함수 
               = LEGNTH('') : 문자 갯수
               = ***SUBSTR(문자열 , 문자시작번호, 갯수) : 문자를 자를 경우  (문자번호:오라클(1),자바(0))
                 SUBSTR('ABCDEFG',2,3) ;
                          --- BCD
                 
               = INSTR(문자열 , 찾는 문자, 문자시작번호,문자위치)
                 INSTR('A-B-C-D','-',1,3) => 6
                                     = 양수 (앞에서부터)
                                     = 음수 (뒤에서부터)
               = RPAD(문자열,문자출력갯수,'문자')
                            ========== ====
                 RPAD('ABC',2,'#') => AB
                 RPAD('ABC',7,'*') => ABC**** : ID찾기,password찾기
             숫자 함수 
               = ROUND() : 반올림
               = TRUNC() : 버림
               = ***CEIL() : 올림 =======> 총페이지 
             날짜 함수 
               = ***SYSDATE : 현재 날짜,시간  => 등록일은 자동으로 처리시 
               = MONTHS_BETWEEN => 과거부터 현재까지의 총 개월수를 출력 
                 MONTHS_BETWEEN(현재,과거) = 계시물 (3~6개월이면 지운다)
             변환 함수
               = ***TO_CHAR 
                   = 년도 : YYYY,RRRR , YY , RR
                   = 월 : MM , M
                   = 일 : DD
                   = 시간 : HH24,HH , MI (분) , 초(SS)
                   = 숫자 표현 : 99,999
             일반 함수 
               = ***NVL : NULL값 대체 
               = NVL2 : NULL=> 처리 , NOT NULL=>처리 
                 NVL2(컬럼명, NULL이 아닌 경우 처리 , NULL일 경우 처리)
                      =====
                      NULL을 포함하고 있는 데이터 컬럼 
               = DECODE : 다중 조건문 
               = CASE : 다중 선택문 
               = ***REGEXP_LIKE: 정규식을 이용한 함수 
                 [],{}
                 [] => 한글자 , 범위 지정이 가능 [A],[A-Z][a-z][0-9][가-힣]
                 {} => 글자 갯수  => {3} , {1,3}
                 .  => _ (한글자)
                 [^] => 제외  [^A-Z] => 알파벳 대문자는 제외  [^가-힣] 
                 ^ => 시작 ^A ^[0-9]
                 $ => 끝 A$ [0-9]$
                 | => A|B => A OR B
                 * => A* (뒤에 붙는 글자가 0개 이상)
                 + => A+ (뒤에 붙는 글자가 1개 이상) 
                      맛있+ 
                      짜+
                      맵+
                      
           = 다중행 함수(집합함수) => 통계 (합,평균,Rank...)
        4) 여러개의 테이블 연결후 결과값 얻기 (JOIN)
        5) SQL문장 여러개를 합쳐서 한개의 SQL문장으로 변환 (서브쿼리)
        ====================================================== DDL(제약조건) => DML
        6) VIEW , INDEX , SEQUENCE , FUNCTION , PROCEDURE , TRIGGER
*/
-- 전체 뮤직 데이터 출력 (*) 
SELECT *
FROM genie_music;

-- 원하는 데이터만 출력 (컬럼명을 알고 있어야 한다 = DESC 테이블명)
SELECT title , singer 
FROM genie_music;

-- 필요한 데이터만 출력 (조건에 해당되는 데이터만 출력 => WHERE)
-- 노래중에 새롭게 진입한 뮤직의 노래명과 가수명 , 상태를 출력 
SELECT title,singer,state
FROM genie_music
WHERE state='new';
-- 문자열이나 날짜 데이터를 코딩에 ''을 붙여서 사용 , 오라클은 원래 대소문자 구분을 하지 않는다 (단 저장된 데이터는 대소문자를 구분)
-- 상태 (유지,상승,하강,new) => 중복 없이 출력 => DISTINCT (장르 , 직위 , 부서 ...)
SELECT DISTINCT state
FROM genie_music;
-- 뮤직중에 상승 10~30 상승한 노래제목, 상태 , 가수명 , 증폭 
SELECT title,state,singer,idcrement
FROM genie_music
WHERE state='상승' AND idcrement BETWEEN 10 AND 30;

SELECT title,state,singer,idcrement
FROM genie_music
WHERE state='상승' AND idcrement>=10 AND idcrement<=30;

-- 뮤직에서 가수중에 아이로 시작한 가수의 모든 정보를 출력 
SELECT *
FROM genie_music
WHERE singer LIKE '아이%';

SELECT no,title 
FROM genie_music
ORDER BY no ASC;










