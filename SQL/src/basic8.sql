-- ÀÀ¿ë 
/*
   1|¼î»ýÅ© Å»Ãâ|µå¶ó¸¶|
   https://movie-phinf.pstatic.net/20160119_278/14531650465287bcuk_JPEG/movie_image.jpg?type=m77_110_2
   |ÆÀ ·Îºó½º(¾Øµð µàÇÁ·¹ÀÎ), ¸ð°Ç ÇÁ¸®¸Õ(¿¤¸®½º º¸ÀÌµå ·¹µå ·¹µù)
   |2016 .02.24 Àç°³ºÀ, 1995 .01.28 °³ºÀ
   |15¼¼ °ü¶÷°¡
   |ÇÁ·©Å© ´Ù¶óº»Æ®

   1. ¿À¶óÅ¬¿¡ ÀúÀåÇÒ °ø°£ : Å×ÀÌºí
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
-- Àå¸£ => ¾×¼Ç  => ÇÔ¼ö  => substr()
SELECT *
FROM movie
WHERE SUBSTR(genre,1,2)='¾×¼Ç';

SELECT *
FROM movie
WHERE genre LIKE '%¾×¼Ç%';

-- ¼Û°­È£°¡ Ãâ¿¬ÇÑ ¿µÈ­ Á¦¸ñÀ» Ãâ·Â 
SELECT title,poster
FROM movie
WHERE actor LIKE '%¼Û°­È£%';

-- ¿µÈ­°¡ µÎ¹øÀÌ»ó »ó¿µµÈ ¿µÈ­ Ã£±â 
SELECT title,regdate
FROM movie
WHERE regdate LIKE '%Àç°³ºÀ%';

-- ¿µÈ­Á¦¸ñÁß¿¡ ¿µ¾î°¡ Æ÷ÇÔµÈ ¿µÈ­Á¦¸ñ Ãâ·Â 
SELECT title
FROM movie
WHERE REGEXP_LIKE(title,'[A-Za-z]');
/*
    ¿µ¹®  : ´ë¹®ÀÚ [A-Z], ¼Ò¹®ÀÚ [a-z] , ´ë¹®ÀÚ¼Ò¹®ÀÚ : [A-Za-z]
    ¼ýÀÚ  : [0-9]
    ÇÑ±Û : [°¡-ÆR]
*/
-- ¿µÈ­ Á¦¸ñÁß¿¡ ¼ýÀÚ°¡ µé¾î°¡ ÀÖ´Â ¸ðµç ¿µÈ­ Á¦¸ñ Ãâ·Â
SELECT title
FROM movie
WHERE REGEXP_LIKE(title,'[0-9]');

-- emp¿¡¼­ in,enÀÌ Æ÷ÇÔµÈ ÀÌ¸§À» °¡Áø »ç¿øÀÇ ÀÌ¸§À» Ãâ·Â 
SELECT * FROM emp;
SELECT ename
FROM emp
WHERE ename LIKE '%IN' OR ename LIKE '%EN';
/*
    $ => ³¡³ª´Â ¹®ÀÚ¿­ 
    | => OR
*/
SELECT ename
FROM emp
WHERE REGEXP_LIKE(ename,'(IN|EN)$');

-- A,B ·Î ½ÃÀÛÇÏ´Â ÀÌ¸§ Ãâ·Â 
SELECT ename
FROM emp
WHERE ename LIKE 'A%' OR ename LIKE 'B%';
/*
   ½ÃÀÛÇÏ´Â ¹®ÀÚ¿­  '^¹®ÀÚ¿­'  => '¹®ÀÚ¿­%'
   ³¡³ª´Â ¹®ÀÚ¿­    '¹®ÀÚ¿­$' => '%¹®ÀÚ¿­'
*/
SELECT ename
FROM emp
WHERE REGEXP_LIKE(ename,'^(A|B)');
-- 211.238.142.181 , 127.0.0.1 
-- [0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}
-- ¿µÈ­ Á¦¸ñÁß¿¡ .À» Æ÷ÇÔÇÏ´Â Á¦¸ñ 
SELECT title
FROM movie
WHERE title LIKE '%...%';
/*
    . ÀÓÀÇÀÇ ÇÑ±ÛÀÚ  => _  S___T , S...T
    . ÀÚÃ¼¸¦ Ã£´Â °æ¿ì => \.
    [] ±ÛÀÚ,¹üÀ§
    {} °¹¼ö 
*/
SELECT title
FROM movie
WHERE REGEXP_LIKE(title,'[.]{3}');

-- .ÀÌ 3°³ ÀÖ´Â Á¦¸ñ 
/*
    ¼øÀ§:100
    Á¦¸ñ:Square (2017)
    °¡¼ö:¹é¿¹¸° (Yerin Baek)
    ¾Ù¹ü:Every letter I sent you.
    Æ÷½ºÅÍ://image.genie.co.kr/Y/IMAGE/IMG_ALBUM/081/329/064/81329064_1575961779895_1_140x140.JPG/dims/resize/Q_80,0
    »óÅÂ:ÇÏ°­
    µîÆø:4
*/
-- ¹ÂÁ÷ genie_music  , melon_music
SELECT LENGTHB('È«±æµ¿') FROM DUAL;
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










