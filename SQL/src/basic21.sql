-- 2021.02.17 薦鉦繕闇 (basic)
/*
     薦鉦繕闇税 曽嫌 : 汽戚斗研 薦嬢 琶推廃 汽戚斗幻 煽舌拝 呪 赤惟 幻球澗 引舛 
     ======= 舛莫鉢吉 汽戚斗 
       *** 汽戚斗 曽嫌
       1. 舛莫鉢 汽戚斗 (姥歳戚 鞠嬢 赤陥 , 琶推廃 汽戚斗幻 煽舌戚 鞠嬢 赤陥) : RDBMS
       2. 鋼舛莫鉢 汽戚斗 (姥歳戚 鞠嬢 赤陥) : HTML,XML,JSON
       3. 搾舛莫鉢 汽戚斗 : txt , twitter 奇越 ぞぞ ,せせせせせせせせせせせせ
          =============
            琶推廃 汽戚斗研 蓄窒 => 舛莫鉢吉 汽戚斗稽 痕井 ==> 陳濃斗拭 昔縦 (AI)
    1) 薦鉦繕闇税 曽嫌
       = NOT NULL : NULL聖 買遂馬走 省澗陥 (察娃事 * 琶呪脊径, 陥戚杖稽益) => nn
       = UNIQUE : 掻差戚 蒸澗 汽戚斗 竺舛 (舘繊: NULL葵聖 買遂) => 板左徹(ID研 籍嬢獄携聖 井酔 企端) => uk
                戚五析 , 穿鉢腰硲 
       = PRIMARY KEY : NOT NULL + UNIQUE (奄沙徹) => 乞窮 砺戚鷺拭 奄沙徹澗 鋼球獣 竺舛聖 映舌
                       食君鯵 竺舛戚 亜管 (奄沙 1鯵)
       = FOREIGN KEY : 凧繕徹 (須掘徹) 陥献 砺戚鷺税 葵聖 紫遂馬奄 是廃 徹 
       = CHECK : 琶推廃 汽戚斗幻 紫遂戚 亜管馬惟 走舛  sex:害切,食切 , 採辞誤 ,悦巷走 (虞巨神,爪左)
       = DEFAULT : INSERT獣拭 切疑生稽 歎採鞠澗 葵 
    2) 薦鉦繕闇 竺舛 号狛 
       = 鎮軍 及拭 竺舛 
       = 砺戚鷺 及拭 竺舛 
       CREATE TABLE table_name
       (
           鎮軍誤 汽戚斗莫 [薦鉦繕闇] => 食君鯵研 竺舛 拝 呪 赤陥 
           鎮軍誤 汽戚斗莫 [薦鉦繕闇]
           鎮軍誤 汽戚斗莫 (NULL聖 買遂),
           [薦鉦繕闇]
       )
       ==> NOT NULL戚蟹 DEFAULT澗 鎮軍 及拭 竺舛 
       ==> 蟹袴走 繕闇精 鎮軍 持失板拭 蟹掻拭 薦鉦繕闇聖 竺舛 拝 呪 赤陥
       1. NOT NULL 
          鎮軍誤 汽戚斗莫 NOT NULL
          鎮軍誤 汽戚斗莫 CONSTRAINT 薦鉦繕闇誤 NOT NULL => 呪舛 映舌
          name VARCHAR2(34) CONSTRAINT member_name_nn NOT NULL
                                       ====== ==== ==
                                       砺戚鷺誤 鎮軍誤 紗失  ==> 旭精 汽戚斗今戚什照拭辞澗 
                                                          旭精 薦鉦繕闇誤聖 紫遂拝 呪 蒸陥
        2. UNIQUE 
           鎮軍誤 汽戚斗莫 UNIQUE
           鎮軍誤 汽戚斗莫,
           CONSTRAINT member_tel_uk UNIQUE(tel)  => tel戚 ID研 籍嬢獄軒檎 ID達澗 鎮軍(板左徹)
           
        3. PRIMARY KEY 
           鎮軍誤 汽戚斗莫 PRIMARY KEY
           鎮軍誤 汽戚斗莫,
           CONSTRAINT member_id_pk PRIMARY KEY(id)
           
        4. FOREIGN KEY 
           鎮軍誤 汽戚斗莫,
           CONSTRAINT board_name_fk FOREIGN KEY(name)
           REFERENCES member(name)
        
        5. CHECK 
           鎮軍誤 汽戚斗莫 CHECK(sex IN('害切','食切'))
           鎮軍誤 汽戚斗莫,
           CONSTRAINT member_sex_ck CHECK(sex IN('M','W'))
           
        6. DEFAULT 
           鎮軍誤 砺戚斗莫 DEFAULT 葵(汽戚斗莫聖 限惟 竺舛)
           
        鉦切 
          PK(Primary Key)
          FK(Foreign Key)
          CK(CHECK)
          UK(UNIQUE)
          NN(NOT NULL)
    3) 薦鉦繕闇 呪舛  
*/
/*
     奇越莫 惟獣毒 
     ===========
     
     惟獣毒       
      = 腰硲 PK
      = 戚硯 NN
      = 薦鯉 NN
      = 鎧遂 NN
      = 搾腔腰硲 NN (沙昔 食採 溌昔)
      = 去系析 DEFAULT 
      = 繕噺呪 DEFAULT
      
     奇越
      = 腰硲 PK
      = 惟獣毒腰硲 FK
      = ID NN
      = 戚硯 NN 
      = 奇越鎧遂 NN
      = 拙失析 DEFAULT 
*/
-- NOT NULL精 掻差買遂(X)
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
-- 汽戚斗 蓄亜 
-- 惟獣毒 
INSERT INTO replyBoard(no,name,subject,content,pwd) VALUES(2,'','薦鉦繕闇 呪穣掻',
   '薦鉦繕闇聖 幻球澗 戚政澗 琶推廃 汽戚斗幻 脊径聖 閤奄 是廃 号狛','1234');
COMMIT;
SELECT * FROM replyBoard;
INSERT INTO reply VALUES(2,1,'hong','畠掩疑','奇越 去系',SYSDATE);
COMMIT;
SELECT * FROM reply;
DROP TABLE reply;
DROP TABLE replyBoard;
-- 薦鉦繕闇税 戚硯聖 採食 (映舌)
-- DEFAULT , NOT NULL : 鎮軍及拭 竺舛 , 蟹袴走 薦鉦繕闇精 鎮軍誤 穿端 識情板拭 蟹掻拭 竺舛 
-- PRIMARY KEY澗 廃鯵幻 竺舛拝 呪 赤陥 
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
    展脊 
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
   CONSTRAINT uc_sex_ck CHECK(sex IN('害切','食切')),
   CONSTRAINT uc_email_uk UNIQUE(email) -- NULL 買遂 
);

INSERT INTO uniquecheck VALUES('hong','害切','');
-- 薦鉦繕闇聖 蓄亜 
ALTER TABLE dept ADD CONSTRAINT dept_dpetno_pk PRIMARY KEY(deptno);
DROP TABLE tcons;
-- FOREIGN KEY => 凧繕獣拭 鋼球獣 PRIMARY KEY研 凧繕 
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
   CONSTRAINT member_sex_ck CHECK(sex IN('害切','食切')),
   CONSTRAINT member_email_uk UNIQUE(email),
   CONSTRAINT member_tel1_ck CHECK(tel1 IN('SK','KT','LG'))
);


