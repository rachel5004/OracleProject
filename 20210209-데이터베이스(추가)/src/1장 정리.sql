/*
      DML (데이터 조작언어) 
      ==================
        SELECT : 데이터 검색
          1) 형식
             SELECT *(전체)|column1,column2..(원하는 데이터만 출력)
             FROM table명
                  =======  데이터가 저장된 공간 => 2차원 구조 (column,row)
                  =============================
                     name    sex    addr  ===> 데이터 구분 (컬럼)
                  =============================
                    홍길동    남자    서울  ===> row (record) => 데이터를 읽어오는 단위 record
                  =============================
                    심청이    여자    경기  ===> row (record) => 데이터를 읽어오는 단위 record
                  =============================
             [
                 1) WHERE 조건문 => 연산자
                 2) GROUP BY 그룹컬럼 => 그룹별로 나눠서 처리
                 3) HAVING (그룹에 대한 조건) => 반드시 GROUP BY가 존재하여 사용이 가능 
                 4) ORDER BY 정렬컬럼 ASC(올림차순:생략이 가능)|DESC(내림차순)
                             ======= 컬럼위치번호로 설정 
             ]
          2) 조건에 해당하는 데이터를 가지고 올때 
             = 연산자 : 값이 없는 경우(NULL)  => ' '(공백문자),''(NULL)
               산술 연산자 => 형변환이 없다 => 형변환할때는 반드시 함수 이용한다 
                            TO_CHAR , TO_NUMBER , TO_DATE , ASCII(문자를 정수형으로 변경)
                                      TO_NUMBER('A') : Error  => ASCII('A') => 65
                                      Integer.parseInt("A"):Error
                 +,-,*,/ => / (1. 0으로 나눌 수 없다 , 2. 정수/정수=실수) => SELECT 뒤에서 연산처리 
                            총점 , 평균 , 연봉 , 급여...
               비교 연산자
                 = , !=(<>,^=) , < , > , <= , >= 
               논리 연산자
                 OR : 범위에 없는 경우 ( || => 문자열 결합)
                 AND: 범위에 포함한 경우 ( & => 사용자 입력값을 받는 경우)
               NOT : 부정 => NOT LIKE , NOT BETWEEN , NOT IN
               LIKE : 유사문자열 
                  % => 문자열(문자에 제한이 없다)
                       A% : A로 시작하는 문자열 
                       %A : A로 끝나는 문자열 
                       %A%: A가 포함 
                  _ => 한글자 __O__
               BETWEEN : 범위나 기간   =>  >= AND <=
               IN : OR가 여러게 일때 주로 사용 
               NULL : 데이터가 NULL 일 경우에는 연산처리가 되지 않는다 
                      IS NULL (NULL일 경우)
                      IS NOT NULL (NULL이 아닐 경우)
               = 문자열 결합 : ||
               = 중복 제거 : DISTINCT
               = & : 입력값 받는 경우 
        INSERT : 데이터 추가 
        UPDATE : 데이터 수정
        DELETE : 데이터 삭제 
*/
--<<1>>  부서 번호가 10번인 부서의 사람 중 사원번호(deptno), 이름(ename), 급여(sal)를 출력하라.
-- 1. 출력 내용 확인 
-- 2. 조건 
   SELECT deptno,ename,sal
   FROM emp
   WHERE deptno=10; -- (=) 같다 

--<<2>>  사원번호(empno)가 7698인 사람 중 이름, 입사일자(hiredate), 부서번호를 출력하라.
  SELECT ename,hiredate,deptno
  FROM emp
  WHERE empno=7698;

--<<3>>  이름이 ALLEN인 사람의 모든 정보를 출력하라.
  SELECT *
  FROM emp
  WHERE ename='ALLEN'; 
  -- 1. 문자열 , 날짜는 반드시 ''을 사용한다 
  -- 2. 문자열 데이터는 대소문자를 구분한다 
  -- 3. 오라클의 표현 2개 '' , 숫자 => ""(별칭,인용) TO_CHAR(SYSDATE,'YYYY"년도" MM"월" DD"일"')
  -- 4. 오라클에서는 문장이 종료되면 ;을 사용한다 , 자바에서 자동으로 ;을 추가 
  -- String sql="SELECT * FROM emp"
--<<4>>  입사일자가 83/01/15인 사원의 이름, 부서 번호, 급여를 출력하라.
  -- 날짜는 문자열과 같이 취급   '83/01/15' 
  SELECT ename,deptno,sal
  FROM emp
  WHERE hiredate='83/01/15';
  -- 날짜가 기본형 ==> YY/MM/DD => system에서 변경은 가능  YYYY-MM-DD
  -- 문자열 , 숫자형 , 날짜형 => 모든 연산자를 적용한다 (날짜,문자를 비교연산자로 연산처리가 가능)
--<<5>>  직업이 MANAGER가 아닌 사람의 모든 정보를 출력하라.
  -- != , <> , ^= , NOT 조건 => 오라클의 단점 (같은 출력인데 형식이 많이 존재) => 정답 (요청한 내용 출력)
  -- 정답 : 최적화
  SELECT *
  FROM emp
  WHERE job<>'MANAGER';

--<<6>>  입사일자가 81/04/01 이후에 입사한 사원의 정보를 출력하라.
  -- 날짜도 일반 숫자처럼 연산처리가 가능 
  SELECT *
  FROM emp
  WHERE hiredate>'81/04/01';

--<<7>>  급여가 $800이상인 사람의 이름, 급여, 부서 번호를 출력하라.
  SELECT ename,sal,deptno
  FROM emp
  WHERE sal>=800;

--<<8>>  부서번호가 20번 이상인 사원의 모든 정보를 출력하라.
  SELECT *
  FROM emp
  WHERE deptno>=20;

--<<9>>  성명이 K로 시작하는 사람보다 높은 이름을 가진 사람의 모든 정보를 출력하라.
  SELECT *
  FROM emp
  WHERE ename>'K%' AND ename<>'KING';

     
--<<10>>  입사일자가 80/12/09 보다 먼저 입사한 사람들의 모든 정보를 출력하라.
  SELECT *
  FROM emp
  WHERE hiredate<'80/12/09';

--<<11>>  입사번호가 7698 보다 작거나 같은 사람들의 입사번호와 이름을 출력하라.
  -- 비교 연산자 => <=	
  SELECT empno,ename
  FROM emp
  WHERE empno<='7698'; 
  -- 자동으로 문자열이 숫자로 변경 
--<<12>>  입사일자가 81/04/01 보다 늦고 82/12/22 보다 빠른 사원의 이름, 월급, 부서 번호를 출력하라.
  -- 논리 연산자 => AND , OR => BETWEEN ~ AND (X)
  SELECT ename,sal,deptno
  FROM emp
  WHERE hiredate>'81/04/01' AND hiredate<'82/12/22';

--<<13>>  급여가 1,600 보다 크고 $3,000보다 작은 사람은 이름, 직무, 급여를 출력하라.
  SELECT ename,job,sal
  FROM emp
  WHERE sal>1600 AND sal<3000;

--<<14>>  사원번호가 7654와 7788 사이 이외의 사원의 모든 정보를 출력하라.
  SELECT *
  FROM emp
  WHERE NOT (empno>=7654 AND empno<=7788);
  -- NOT 부정 => (자바 !)
--<<15>> 이름이 B와 J 사이의 모든 사원의 정보를 출력하라.
  -- BETWEEN ~ AND 
  SELECT *
  FROM emp
  WHERE ename BETWEEN 'B' AND 'J';

--<<16>>  입사일자가 81년 이외에 입사한 사람의 모든 정보를 출력하라.
  -- NOT LIKE 
  SELECT *
  FROM emp
  WHERE hiredate NOT LIKE '81%';

  SELECT *
  FROM emp
  WHERE hiredate NOT BETWEEN '81/01/01' AND '81/12/31';
--<<17>>  직무가 MANAGER와 SALESMAN인 사람의 모든 정보를 출력하라.
  -- OR => IN
  SELECT *
  FROM emp
  WHERE job='MANAGER' OR job='SALESMAN';
  
  SELECT *
  FROM emp
  WHERE job IN('MANAGER','SALESMAN');
--<<18>>  부서 번호와 20,30번을 제외한 모든 사람의 이름, 사원번호, 부서 번호를 출력하라.
  SELECT ename,empno,deptno
  FROM emp
  WHERE deptno NOT IN(20,30);
	
--<<19>>  이름이 S로 시작하는 사원의 사원번호, 이름, 입사일자, 부서번호를 출력하라.
  -- LIKE => 'S%' => 자바에서는 오류 
  SELECT empno,ename,hiredate,deptno
  FROM emp
  WHERE ename LIKE 'S%';

--<<20>>  입사일자가 81년도인 사람의 모든 정보를 출력하라.
  SELECT *
  FROM emp
  WHERE hiredate LIKE '81%';
  
  SELECT *
  FROM emp
  WHERE SUBSTR(hiredate,1,2)=81;

--<<21>>  이름 중 S자가 들어가 있는 사람만 모든 정보를 출력하라.
  SELECT *
  FROM emp
  WHERE ename LIKE '%S%';
	
-- 우편번호 찾기 
/*
     zipcode 
     sido
     gugun
     dong
     bunji
     1. dong으로 검색 
     2. 우편번호 , address로 출력 => 신촌 
*/
    SELECT zipcode,sido||' '||gugun||' '||dong||' '||bunji as address
    FROM zipcode
    WHERE dong LIKE '%신촌%';
    -- 테이블명과 컬럼명이 동일해도 된다 
--<<22>>  이름이 S로 시작하고 마지막 글자가 T인 사람의 모든 정보를 출력하라 (단, 이름은 전체 5자리이다.>> 
   -- _
   SELECT * 
   FROM emp
   WHERE ename LIKE 'S___T';
--<<23>>  첫 번째 문자는 관계없고 두 번째 문자가 A인 사람의 정보를 출력하라.
  SELECT *
  FROM emp
  WHERE ename LIKE '_A%';
  
--<<24>>  커미션이 NULL인 사람의 정보를 출력하라.
  -- 데이터가 NULL일 경우에는 연산처리를 할 수 없다 => NULL과 관련 연산자 사용 => IS NULL, IS NOT NULL
  SELECT *
  FROM emp
  WHERE comm IS NULL;

--<<25>>  커미션이 NULL이 아닌 사람의 모든 정보를 출력하라.
  SELECT *
  FROM emp
  WHERE comm IS NOT NULL;
  -- NULL은 0이 아니다  (0은 값이 존재 , NULL은 값이 존재하지 않는다)
--<<26>>  부서가 30번 부서이고 급여가 $1,500 이상인 사람의 이름, 부서, 월급을 출력하라.
  -- 논리 연산자 AND
  SELECT ename,deptno,sal
  FROM emp
  WHERE deptno=30 AND sal>=1500;

--<<27>>  이름의 첫 글자가 K로 시작하거나 부서 번호가 30인 사람의 사원번호, 이름, 부서 번호를 출력하라.
	-- OR연산 (IN연산은 사용 할 수 없다) => IN(동일한 데이터)
    SELECT empno,ename,deptno
    FROM emp
    WHERE deptno=30 OR ename LIKE 'K%';
	
--<<28>>  급여가 $1,500이상이고 부서 번호가 30번인 사워 중 직업이 MANAGER인 사람의 정보를 출력하라.
	SELECT *
    FROM emp
    WHERE sal>=1500 AND deptno=30 AND job='MANAGER';


--<<29>>  부서 번호가 30인 사람 중 사원번호를 SORT 하라.
	-- ORDER BY => SQL문장의 마지막에 사용
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
	
   
--<<30>>  급여가 많은 순으로 SORT하라.
  SELECT *
  FROM emp
  ORDER BY sal DESC;
  
  -- 문제 급여가 높은 순으로 5명만 출력 
  SELECT * FROM emp
  WHERE ROWNUM <= 5
  ORDER BY sal DESC;
  -- 페이징 => 인라인뷰 
  SELECT empno,ename,sal,rownum
  FROM (SELECT empno,ename,sal FROM emp ORDER BY sal DESC)
  WHERE rownum<=5;
--<<31>>  부서 번호로 ASCENDING SORT한 후 급여가 많은 사람 순으로 출력하라.
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
