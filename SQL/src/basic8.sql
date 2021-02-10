-- ���� 
/*
   1|���ũ Ż��|���|
   https://movie-phinf.pstatic.net/20160119_278/14531650465287bcuk_JPEG/movie_image.jpg?type=m77_110_2
   |�� �κ�(�ص� ��������), ��� ������(������ ���̵� ���� ����)
   |2016 .02.24 �簳��, 1995 .01.28 ����
   |15�� ������
   |����ũ �ٶ�Ʈ

   1. ����Ŭ�� ������ ���� : ���̺�
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
-- �帣 => �׼�  => �Լ�  => substr()
SELECT *
FROM movie
WHERE SUBSTR(genre,1,2)='�׼�';

SELECT *
FROM movie
WHERE genre LIKE '%�׼�%';

-- �۰�ȣ�� �⿬�� ��ȭ ������ ��� 
SELECT title,poster
FROM movie
WHERE actor LIKE '%�۰�ȣ%';

-- ��ȭ�� �ι��̻� �󿵵� ��ȭ ã�� 
SELECT title,regdate
FROM movie
WHERE regdate LIKE '%�簳��%';

-- ��ȭ�����߿� ��� ���Ե� ��ȭ���� ��� 
SELECT title
FROM movie
WHERE REGEXP_LIKE(title,'[A-Za-z]');
/*
    ����  : �빮�� [A-Z], �ҹ��� [a-z] , �빮�ڼҹ��� : [A-Za-z]
    ����  : [0-9]
    �ѱ� : [��-�R]
*/
-- ��ȭ �����߿� ���ڰ� �� �ִ� ��� ��ȭ ���� ���
SELECT title
FROM movie
WHERE REGEXP_LIKE(title,'[0-9]');

-- emp���� in,en�� ���Ե� �̸��� ���� ����� �̸��� ��� 
SELECT * FROM emp;
SELECT ename
FROM emp
WHERE ename LIKE '%IN' OR ename LIKE '%EN';
/*
    $ => ������ ���ڿ� 
    | => OR
*/
SELECT ename
FROM emp
WHERE REGEXP_LIKE(ename,'(IN|EN)$');

-- A,B �� �����ϴ� �̸� ��� 
SELECT ename
FROM emp
WHERE ename LIKE 'A%' OR ename LIKE 'B%';
/*
   �����ϴ� ���ڿ�  '^���ڿ�'  => '���ڿ�%'
   ������ ���ڿ�    '���ڿ�$' => '%���ڿ�'
*/
SELECT ename
FROM emp
WHERE REGEXP_LIKE(ename,'^(A|B)');
-- 211.238.142.181 , 127.0.0.1 
-- [0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}
-- ��ȭ �����߿� .�� �����ϴ� ���� 
SELECT title
FROM movie
WHERE title LIKE '%...%';
/*
    . ������ �ѱ���  => _  S___T , S...T
    . ��ü�� ã�� ��� => \.
    [] ����,����
    {} ���� 
*/
SELECT title
FROM movie
WHERE REGEXP_LIKE(title,'[.]{3}');

-- .�� 3�� �ִ� ���� 
/*
    ����:100
    ����:Square (2017)
    ����:�鿹�� (Yerin Baek)
    �ٹ�:Every letter I sent you.
    ������://image.genie.co.kr/Y/IMAGE/IMG_ALBUM/081/329/064/81329064_1575961779895_1_140x140.JPG/dims/resize/Q_80,0
    ����:�ϰ�
    ����:4
*/
-- ���� genie_music  , melon_music
SELECT LENGTHB('ȫ�浿') FROM DUAL;
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










