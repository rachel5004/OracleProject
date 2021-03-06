-- 응용 
/*
   1|쇼생크 탈출|드라마|
   https://movie-phinf.pstatic.net/20160119_278/14531650465287bcuk_JPEG/movie_image.jpg?type=m77_110_2
   |팀 로빈스(앤디 듀프레인), 모건 프리먼(엘리스 보이드 레드 레딩)
   |2016 .02.24 재개봉, 1995 .01.28 개봉
   |15세 관람가
   |프랭크 다라본트

   1. 오라클에 저장할 공간 : 테이블
*/
/*DROP TABLE movie;
CREATE TABLE movie(
   mno NUMBER(4),
   title VARCHAR2(100),
   genre VARCHAR2(100),
   poster VARCHAR2(200),
   actor VARCHAR2(300),
   regdate VARCHAR2(100),
   grade VARCHAR2(50),
   director VARCHAR2(100)
);
select count(*) from movie;
SELECT * FROM movie;
*/
-- 장르 => 액션  => 함수  => substr()
SELECT *
FROM movie
WHERE SUBSTR(genre,1,2)='액션';

SELECT *
FROM movie
WHERE genre LIKE '%액션%';

-- 송강호가 출연한 영화 제목을 출력 
SELECT title,poster
FROM movie
WHERE actor LIKE '%송강호%';

-- 영화가 두번이상 상영된 영화 찾기 
SELECT title,regdate
FROM movie
WHERE regdate LIKE '%재개봉%';

-- 영화제목중에 영어가 포함된 영화제목 출력 
SELECT title
FROM movie
WHERE REGEXP_LIKE(title,'[A-Za-z]');
/*
    영문  : 대문자 [A-Z], 소문자 [a-z] , 대문자소문자 : [A-Za-z]
    숫자  : [0-9]
    한글 : [가-힣]
*/
-- 영화 제목중에 숫자가 들어가 있는 모든 영화 제목 출력
SELECT title
FROM movie
WHERE REGEXP_LIKE(title,'[0-9]');

-- emp에서 in,en이 포함된 이름을 가진 사원의 이름을 출력 
SELECT * FROM emp;
SELECT ename
FROM emp
WHERE ename LIKE '%IN' OR ename LIKE '%EN';
/*
    $ => 끝나는 문자열 
    | => OR
*/
SELECT ename
FROM emp
WHERE REGEXP_LIKE(ename,'(IN|EN)$');

-- A,B 로 시작하는 이름 출력 
SELECT ename
FROM emp
WHERE ename LIKE 'A%' OR ename LIKE 'B%';
/*
   시작하는 문자열  '^문자열'  => '문자열%'
   끝나는 문자열    '문자열$' => '%문자열'
*/
SELECT ename
FROM emp
WHERE REGEXP_LIKE(ename,'^(A|B)');
-- 211.238.142.181 , 127.0.0.1 
-- [0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}
-- 영화 제목중에 .을 포함하는 제목 
SELECT title
FROM movie
WHERE title LIKE '%...%';
/*
    . 임의의 한글자  => _  S___T , S...T
    . 자체를 찾는 경우 => \.
    [] 글자,범위
    {} 갯수 
*/
SELECT title
FROM movie
WHERE REGEXP_LIKE(title,'[.]{3}');

-- .이 3개 있는 제목 
/*
    순위:100
    제목:Square (2017)
    가수:백예린 (Yerin Baek)
    앨범:Every letter I sent you.
    포스터://image.genie.co.kr/Y/IMAGE/IMG_ALBUM/081/329/064/81329064_1575961779895_1_140x140.JPG/dims/resize/Q_80,0
    상태:하강
    등폭:4
*/
-- 뮤직 genie_music  , melon_music
SELECT LENGTHB('홍길동') FROM DUAL;
DROP TABLE genie_music;
CREATE TABLE genie_music(
   no NUMBER(3),
   cno NUMBER(1),
   title VARCHAR2(300),
   singer VARCHAR2(200),
   album VARCHAR2(200),
   poster VARCHAR2(260),
   state CHAR(6),
   idcrement NUMBER(3)
);
DESC genie_music;

SELECT * FROM emp;

SELECT COUNT(*) FROM genie_music;
SELECT * FROM genie_music;










