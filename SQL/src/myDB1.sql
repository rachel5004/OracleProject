create table movie(
MNO         NUMBER(4),     
TITLE       VARCHAR2(100), 
GENRE       VARCHAR2(100),
POSTER      VARCHAR2(200), 
ACTOR       VARCHAR2(300), 
REGDATE     VARCHAR2(100), 
GRADE       VARCHAR2(50), 
DIRECTOR    VARCHAR2(100)
);
select * from movie where rownum=1;
drop table movie;

select * from movie where actor like '%송강호%';
select * from movie where regdate like '%재개봉%';
select title from movie where regexp_like (title,'[A-Za-z]');

select * from emp where ename like '%EN' or ename like '%IN';
select * from emp where regexp_like (ename,'(IN|EN)$'); 
-- $ 끝나는 문자열, | or
select * from emp where ename like 'A%' or ename like 'B%';
select * from emp where regexp_like (ename,'^(A|B)'); 
-- ^ 시작하는 문자열
select title from movie where title like '%.%';
select title from movie where regexp_like (title,'\.');
-- .은 임의의 한글자를 뜻하므로 \로 이스케이프
select title from movie where regexp_like (title,'[.]{3}');
-- ...은 []에 찾을 글자,{}에 개수