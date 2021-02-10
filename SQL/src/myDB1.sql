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

select * from movie where actor like '%�۰�ȣ%';
select * from movie where regdate like '%�簳��%';
select title from movie where regexp_like (title,'[A-Za-z]');

select * from emp where ename like '%EN' or ename like '%IN';
select * from emp where regexp_like (ename,'(IN|EN)$'); 
-- $ ������ ���ڿ�, | or
select * from emp where ename like 'A%' or ename like 'B%';
select * from emp where regexp_like (ename,'^(A|B)'); 
-- ^ �����ϴ� ���ڿ�
select title from movie where title like '%.%';
select title from movie where regexp_like (title,'\.');
-- .�� ������ �ѱ��ڸ� ���ϹǷ� \�� �̽�������
select title from movie where regexp_like (title,'[.]{3}');
-- ...�� []�� ã�� ����,{}�� ����