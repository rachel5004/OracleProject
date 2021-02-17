-- 2021.02.17 제약조건 (basic)
/*
     제약조건의 종류 : 데이터를 제어 필요한 데이터만 저장할 수 있게 만드는 과정 
     ======= 정형화된 데이터 
       *** 데이터 종류
       1. 정형화 데이터 (구분이 되어 있다 , 필요한 데이터만 저장이 되어 있다) : RDBMS
       2. 반정형화 데이터 (구분이 되어 있다) : HTML,XML,JSON
       3. 비정형화 데이터 : txt , twitter 댓글 ㅎㅎ ,ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ
          =============
            필요한 데이터를 추출 => 정형화된 데이터로 변경 ==> 컴퓨터에 인식 (AI)
    1) 제약조건의 종류
       = NOT NULL : NULL을 허용하지 않는다 (빨간색 * 필수입력, 다이얼로그) => nn
       = UNIQUE : 중복이 없는 데이터 설정 (단점: NULL값을 허용) => 후보키(ID를 잃어버렸을 경우 대체) => uk
                이메일 , 전화번호 
       = PRIMARY KEY : NOT NULL + UNIQUE (기본키) => 모든 테이블에 기본키는 반드시 설정을 권장
                       여러개 설정이 가능 (기본 1개)
       = FOREIGN KEY : 참조키 (외래키) 다른 테이블의 값을 사용하기 위한 키 
       = CHECK : 필요한 데이터만 사용이 가능하게 지정  sex:남자,여자 , 부서명 ,근무지 (라디오,콤보)
       = DEFAULT : INSERT시에 자동으로 첨부되는 값 
    2) 제약조건 설정 방법 
       = 컬럼 뒤에 설정 
       = 테이블 뒤에 설정 
       CREATE TABLE table_name
       (
           컬럼명 데이터형 [제약조건] => 여러개를 설정 할 수 있다 
           컬럼명 데이터형 [제약조건]
           컬럼명 데이터형 (NULL을 허용),
           [제약조건]
       )
       ==> NOT NULL이나 DEFAULT는 컬럼 뒤에 설정 
       ==> 나머지 조건은 컬럼 생성후에 나중에 제약조건을 설정 할 수 있다
       1. NOT NULL 
          컬럼명 데이터형 NOT NULL
          컬럼명 데이터형 CONSTRAINT 제약조건명 NOT NULL => 수정 권장
          name VARCHAR2(34) CONSTRAINT member_name_nn NOT NULL
                                       ====== ==== ==
                                       테이블명 컬럼명 속성  ==> 같은 데이터베이스안에서는 
                                                          같은 제약조건명을 사용할 수 없다
        2. UNIQUE 
           컬럼명 데이터형 UNIQUE
           컬럼명 데이터형,
           CONSTRAINT member_tel_uk UNIQUE(tel)  => tel이 ID를 잃어버리면 ID찾는 컬럼(후보키)
           
        3. PRIMARY KEY 
           컬럼명 데이터형 PRIMARY KEY
           컬럼명 데이터형,
           CONSTRAINT member_id_pk PRIMARY KEY(id)
           
        4. FOREIGN KEY 
           컬럼명 데이터형,
           CONSTRAINT board_name_fk FOREIGN KEY(name)
           REFERENCES member(name)
        
        5. CHECK 
           컬럼명 데이터형 CHECK(sex IN('남자','여자'))
           컬럼명 데이터형,
           CONSTRAINT member_sex_ck CHECK(sex IN('M','W'))
           
        6. DEFAULT 
           컬럼명 테이터형 DEFAULT 값(데이터형을 맞게 설정)
           
        약자 
          PK(Primary Key)
          FK(Foreign Key)
          CK(CHECK)
          UK(UNIQUE)
          NN(NOT NULL)
    3) 제약조건 수정  
*/
/*
     댓글형 게시판 
     ===========
     
     게시판       
      = 번호 PK
      = 이름 NN
      = 제목 NN
      = 내용 NN
      = 비밀번호 NN (본인 여부 확인)
      = 등록일 DEFAULT 
      = 조회수 DEFAULT
      
     댓글
      = 번호 PK
      = 게시판번호 FK
      = ID NN
      = 이름 NN 
      = 댓글내용 NN
      = 작성일 DEFAULT 
*/
-- NOT NULL은 중복허용(X)
CREATE TABLE replyBoard(
   no NUMBER PRIMARY KEY,
   name VARCHAR2(34) NOT NULL,
   subject VARCHAR2(2000) NOT NULL,
   content CLOB NOT NULL,
   pwd VARCHAR2(10) NOT NULL,
   regdate DATE DEFAULT SYSDATE,
   hit NUMBER DEFAULT 0
);
CREATE TABLE reply(
   no NUMBER PRIMARY KEY,
   bno NUMBER REFERENCES replyBoard(no),
   id VARCHAR2(20) NOT NULL,
   name VARCHAR2(34) NOT NULL,
   msg CLOB NOT NULL,
   regdate DATE DEFAULT SYSDATE
);
-- 데이터 추가 
-- 게시판 
INSERT INTO replyBoard(no,name,subject,content,pwd) VALUES(2,'','제약조건 수업중',
   '제약조건을 만드는 이유는 필요한 데이터만 입력을 받기 위한 방법','1234');
COMMIT;
SELECT * FROM replyBoard;
INSERT INTO reply VALUES(2,1,'hong','홍길동','댓글 등록',SYSDATE);
COMMIT;
SELECT * FROM reply;
DROP TABLE reply;
DROP TABLE replyBoard;
-- 제약조건의 이름을 부여 (권장)
-- DEFAULT , NOT NULL : 컬럼뒤에 설정 , 나머지 제약조건은 컬럼명 전체 선언후에 나중에 설정 
-- PRIMARY KEY는 한개만 설정할 수 있다 
-- table can have only one primary key
/*
DROP TABLE test;
CREATE TABLE test(
  no NUMBER,
  id VARCHAR2(20),
  CONSTRAINT test_no_id_pk PRIMARY KEY(no,id)
);
*/
CREATE TABLE replyBoard(
   no NUMBER,
   name VARCHAR2(34) CONSTRAINT rb_name_nn NOT NULL,
   subject VARCHAR2(2000) CONSTRAINT rb_subject_nn NOT NULL,
   content CLOB CONSTRAINT rb_content_nn NOT NULL,
   pwd VARCHAR2(10) CONSTRAINT rb_pwd_nn NOT NULL,
   regdate DATE DEFAULT SYSDATE,
   hit NUMBER DEFAULT 0,
   CONSTRAINT rb_no_pk PRIMARY KEY(no)
);
CREATE TABLE reply(
   no NUMBER,
   bno NUMBER,
   id VARCHAR2(20) CONSTRAINT reply_id_nn NOT NULL,
   name VARCHAR2(34) CONSTRAINT reply_name_nn NOT NULL,
   msg CLOB CONSTRAINT reply_msg_nn NOT NULL,
   regdate DATE DEFAULT SYSDATE,
   CONSTRAINT reply_no_pk PRIMARY KEY(no),
   CONSTRAINT reply_bno_fk FOREIGN KEY(bno)
   REFERENCES replyBoard(no)
);
/*
    타입 
    C : NOT NULL, CHECK
    P : PRIAMRY KEY
    R : FOREIGN KEY
    U : UNIQUE
*/
SELECT owner,constraint_name,constraint_type,status
FROM user_constraints
WHERE table_name='REPLY';

SELECT owner,constraint_name,table_name,column_name
FROM user_cons_columns
WHERE table_name='REPLYBOARD';

CREATE TABLE uniqueCheck(
   id VARCHAR2(20),
   sex VARCHAR2(10),
   email VARCHAR2(100),
   CONSTRAINT uc_id_pk PRIMARY KEY(id), -- NOT NULL+UNIQUE
   CONSTRAINT uc_sex_ck CHECK(sex IN('남자','여자')),
   CONSTRAINT uc_email_uk UNIQUE(email) -- NULL 허용 
);

INSERT INTO uniquecheck VALUES('hong','남자','');
-- 제약조건을 추가 
ALTER TABLE dept ADD CONSTRAINT dept_dpetno_pk PRIMARY KEY(deptno);
DROP TABLE tcons;
-- FOREIGN KEY => 참조시에 반드시 PRIMARY KEY를 참조 
CREATE TABLE tcons(
  no NUMBER(5),
  name VARCHAR2(20) CONSTRAINT tcons_name_nn NOT NULL,
  jumin VARCHAR2(13) CONSTRAINT tcons_jumin_nn NOT NULL,
  area NUMBER(1),
  deptno NUMBER(2),
  CONSTRAINT tcons_no_pk PRIMARY KEY(no),
  CONSTRAINT tcons_jumin_uk UNIQUE(jumin),
  CONSTRAINT tcons_area_ck CHECK(area BETWEEN 1 AND 4), -- CHECK(area IN(1,2,3,4))
  CONSTRAINT tcons_deptno_fk FOREIGN KEY(deptno)
  REFERENCES dept(deptno)
);
DROP TABLE member;

CREATE TABLE member(
   id VARCHAR2(20),
   pwd VARCHAR2(10) CONSTRAINT member_pwd_nn NOT NULL,
   name VARCHAR2(34) CONSTRAINT member_name_nn NOT NULL,
   sex VARCHAR2(6),
   email VARCHAR2(200),
   addr1 VARCHAR2(100) CONSTRAINT member_addr1_nn NOT NULL,
   addr2 VARCHAR2(100),
   tel1 VARCHAR2(10),
   tel2 VARCHAR2(20),
   interest VARCHAR2(100),
   content CLOB CONSTRAINT member_content_nn NOT NULL,
   CONSTRAINT member_id_pk PRIMARY KEY(id),
   CONSTRAINT member_sex_ck CHECK(sex IN('남자','여자')),
   CONSTRAINT member_email_uk UNIQUE(email),
   CONSTRAINT member_tel1_ck CHECK(tel1 IN('SK','KT','LG'))
);


