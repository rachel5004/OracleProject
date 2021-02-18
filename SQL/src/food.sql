-- 2021-02-18 DDL 
/*
    DDL 명령어 (DROP,CREATE,ALTER,REANME,TRUNCATE)
*/
DROP TABLE reply;
DROP TABLE replyBoard;

CREATE TABLE replyBoard(
  no NUMBER,
  name VARCHAR2(34) CONSTRAINT rb_name_nn NOT NULL,
  CONSTRAINT rb_no_pk PRIMARY KEY(no)
);
CREATE TABLE reply(
  no NUMBER,
  bno NUMBER,
  msg CLOB CONSTRAINT reply_msg_nn NOT NULL,
  CONSTRAINT reply_no_pk PRIMARY KEY(no),
  CONSTRAINT reply_bno_fk FOREIGN KEY(bno)
  REFERENCES replyBoard(no)
);

-- 데이터 추가 
INSERT INTO replyBoard VALUES(1,'홍길동');
INSERT INTO replyBoard VALUES(2,'심청이');
INSERT INTO replyBoard VALUES(3,'박문수');
COMMIT;
SELECT * FROM replyBoard;

-- 댓글추가
INSERT INTO reply VALUES(1,1,'댓글 1');
INSERT INTO reply VALUES(2,1,'댓글 2');
INSERT INTO reply VALUES(3,2,'댓글 3');
INSERT INTO reply VALUES(4,3,'댓글 4');
INSERT INTO reply VALUES(5,4,'댓글 5'); -- replyBoard에 있는 게시물번호만 사용이 가능  
COMMIT;
SELECT * FROM reply;

-- 삭제
DELETE FROM reply
WHERE bno=1;
DELETE FROM replyBoard 
WHERE no=1;
COMMIT;

DROP TABLE reply;
CREATE TABLE reply(
  no NUMBER,
  bno NUMBER,
  msg CLOB CONSTRAINT reply_msg_nn NOT NULL,
  CONSTRAINT reply_no_pk PRIMARY KEY(no)
);
ALTER TABLE reply
ADD CONSTRAINT reply_bno_fk FOREIGN KEY(bno)
REFERENCES replyBoard(no) 
ON DELETE CASCADE;

INSERT INTO reply VALUES(1,2,'Hello');
COMMIT;
--SELECT * FROM replyBoard;
SELECT * FROM reply;
-- replyBoard=>2번 삭제
DELETE FROM replyBoard
WHERE no=2;

-- NOT NULL 
CREATE TABLE test_member(
  id VARCHAR2(20),
  name VARCHAR2(34) CONSTRAINT tm_name_nn NOT NULL,
  email VARCHAR2(100) CONSTRAINT tm_email_nn NOT NULL,
  CONSTRAINT tm_id_pk PRIMARY KEY(id)
);

INSERT INTO test_member VALUES('hong','홍길동','');
DELETE FROM test_member
WHERE id='hong';
COMMIT;
ALTER TABLE test_member
DISABLE CONSTRAINT tm_email_nn;
ALTER TABLE test_member
ENABLE CONSTRAINT tm_email_nn;
SELECT * FROM test_member;
/*
     7장 
     page 332 : 제약조건을 설정하는 이유 
                필요한 데이터만 오라클에 추가가 가능하게 만든 규칙 (정형화된 데이터 => 모든 USER에게 공유가 가능)
     page 333 : 제약조건의 종류 (도표) 
     page 335 : 테이블에 제약조건 설정 벙법
                예제 참조 => 제약조건 이름 부여 , 약식 
                            ===============
                            1. 제약조건을 관리하기 위해서 (수정,삭제..) (ENABLE , DISABLE)
     page 336 : 테이블을 먼저 생성하고 나중에 제약조건을 설정 
                ADD : PK,FK,CK,UK
                MODIFY : NOT NULL
     page 340 : ON DELETE CASCADE
     page 345 : 제약조건 관리 => ENABLE(제약조건 사용), DISABLE(제약조건을 사용하지 않는다) => GUEST
                ALTER TABLE table명
                ENABLE CONATRAINT 제약조건명
                ==> 테이블에 제약조건을 설정후 생성 => ENABLE
                ALTER TABLE table명
                DISABLE CONATRAINT 제약조건명
                
                id(PK) => DISABLE
                aaa
                bbb
                bbb
     page 358 : 제약조건 검색하기 => user_constraints => 테이블명 (저장될때 대문자로 저장된다)
     page 360 : 제약조건을 삭제 
                ALTER TABLE table명
                DROP CONSTRAINT 제약조건이름
*/
CREATE TABLE myTable(
   no NUMBER PRIMARY KEY,
   name VARCHAR2(20) NOT NULL
);
INSERT INTO myTable VALUES(1,'홍길동');
INSERT INTO myTable VALUES(2,'심청이');
INSERT INTO myTable VALUES(3,'심청이');
SELECT * FROM myTable;
ALTER TABLE myTable ADD addr VARCHAR2(100) DEFAULT ' ' NOT NULL;
-- 각 컬럼에 제약조건이 한개만 사용하는 것은 아니다 (PK/FK)
CREATE TABLE myTable2(
   id VARCHAR2(20),
   name VARCHAR2(20) CONSTRAINT mt_name_nn NOT NULL,
   email VARCHAR2(100) CONSTRAINT mt_email_nn NOT NULL,
   CONSTRAINT mt_id_nn PRIMARY KEY(id)
);

DESC myTable2;
-- 제약조건 삭제 
ALTER TABLE myTable2
DROP CONSTRAINT mt_email_nn;
-- ALTER => 컬럼추가(ADD) ,제약조건추가(ADD) ,MODIFY , DROP
-- 제약조건명 테이블_컬럼명_속성
/*
     요구사항분석 ==> 데이터베이스 설계 ==> 데이터 수집 ===> 화면 UI ====> 구현 (자바) ===> 테스트 ===> 배포
     ==========    ==============================     =======      ==========     ======
      아키텍쳐             DBA                          Front (JS)      Back        테스터   
*/
DESC emp;
SELECT * FROM emp;
SELECT ename,job,hiredate,sal 
FROM emp
WHERE ename LIKE '%A%';

conn hr/happy
SELECT * FROM emp;
SELECT ename,sal,comm,sal+NVL(comm,0) FROM emp;
SELECT ename,hiredate,sal FROM emp
WHERE SUBSTR(hiredate,1,2)=81;
CREATE TABLE foodCategory(
   cno NUMBER,
   tno NUMBER CONSTRAINT fc_tno_nn NOT NULL,
   title VARCHAR2(300) CONSTRAINT fc_title_nn NOT NULL,
   subject VARCHAR2(300) CONSTRAINT fc_subject_nn NOT NULL,
   poster VARCHAR2(260) CONSTRAINT fc_poster_nn NOT NULL,
   link VARCHAR2(260) CONSTRAINT fc_link_nn NOT NULL,
   CONSTRAINT fc_cno_pk PRIMARY KEY(cno)
);
CREATE TABLE foodHouse(
    no NUMBER, -- Primary Key
    cno NUMBER,
    poster VARCHAR2(1500) CONSTRAINT fh_poster_nn NOT NULL,
    name VARCHAR2(300) CONSTRAINT fh_name_nn NOT NULL,
    score NUMBER(2,1) CONSTRAINT fh_score_nn NOT NULL,
    loc VARCHAR2(20) CONSTRAINT fh_loc_nn NOT NULL,
    addr VARCHAR2(260) CONSTRAINT fh_addr_nn NOT NULL, -- 지번,길
    tel VARCHAR2(20) CONSTRAINT fh_tel_nn NOT NULL,
    type VARCHAR2(20) CONSTRAINT fh_type_nn NOT NULL,
    price VARCHAR2(20) DEFAULT '없음',
    parking VARCHAR2(30) DEFAULT '없음',
    time VARCHAR2(30) DEFAULT '없음',
    menu VARCHAR2(4000) DEFAULT '없음',
    good NUMBER(4) DEFAULT 0,
    soso NUMBER(4) DEFAULT 0,
    bad NUMBER(4) DEFAULT 0,
    CONSTRAINT fh_no_pk PRIMARY KEY(no),
    CONSTRAINT fh_cno_fk FOREIGN KEY(cno)
    REFERENCES foodCategory(cno)
);





