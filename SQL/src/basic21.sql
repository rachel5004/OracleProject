-- 2021.02.17 �������� (basic)
/*
     ���������� ���� : �����͸� ���� �ʿ��� �����͸� ������ �� �ְ� ����� ���� 
     ======= ����ȭ�� ������ 
       *** ������ ����
       1. ����ȭ ������ (������ �Ǿ� �ִ� , �ʿ��� �����͸� ������ �Ǿ� �ִ�) : RDBMS
       2. ������ȭ ������ (������ �Ǿ� �ִ�) : HTML,XML,JSON
       3. ������ȭ ������ : txt , twitter ��� ���� ,������������������������
          =============
            �ʿ��� �����͸� ���� => ����ȭ�� �����ͷ� ���� ==> ��ǻ�Ϳ� �ν� (AI)
    1) ���������� ����
       = NOT NULL : NULL�� ������� �ʴ´� (������ * �ʼ��Է�, ���̾�α�) => nn
       = UNIQUE : �ߺ��� ���� ������ ���� (����: NULL���� ���) => �ĺ�Ű(ID�� �Ҿ������ ��� ��ü) => uk
                �̸��� , ��ȭ��ȣ 
       = PRIMARY KEY : NOT NULL + UNIQUE (�⺻Ű) => ��� ���̺� �⺻Ű�� �ݵ�� ������ ����
                       ������ ������ ���� (�⺻ 1��)
       = FOREIGN KEY : ����Ű (�ܷ�Ű) �ٸ� ���̺��� ���� ����ϱ� ���� Ű 
       = CHECK : �ʿ��� �����͸� ����� �����ϰ� ����  sex:����,���� , �μ��� ,�ٹ��� (����,�޺�)
       = DEFAULT : INSERT�ÿ� �ڵ����� ÷�εǴ� �� 
    2) �������� ���� ��� 
       = �÷� �ڿ� ���� 
       = ���̺� �ڿ� ���� 
       CREATE TABLE table_name
       (
           �÷��� �������� [��������] => �������� ���� �� �� �ִ� 
           �÷��� �������� [��������]
           �÷��� �������� (NULL�� ���),
           [��������]
       )
       ==> NOT NULL�̳� DEFAULT�� �÷� �ڿ� ���� 
       ==> ������ ������ �÷� �����Ŀ� ���߿� ���������� ���� �� �� �ִ�
       1. NOT NULL 
          �÷��� �������� NOT NULL
          �÷��� �������� CONSTRAINT �������Ǹ� NOT NULL => ���� ����
          name VARCHAR2(34) CONSTRAINT member_name_nn NOT NULL
                                       ====== ==== ==
                                       ���̺�� �÷��� �Ӽ�  ==> ���� �����ͺ��̽��ȿ����� 
                                                          ���� �������Ǹ��� ����� �� ����
        2. UNIQUE 
           �÷��� �������� UNIQUE
           �÷��� ��������,
           CONSTRAINT member_tel_uk UNIQUE(tel)  => tel�� ID�� �Ҿ������ IDã�� �÷�(�ĺ�Ű)
           
        3. PRIMARY KEY 
           �÷��� �������� PRIMARY KEY
           �÷��� ��������,
           CONSTRAINT member_id_pk PRIMARY KEY(id)
           
        4. FOREIGN KEY 
           �÷��� ��������,
           CONSTRAINT board_name_fk FOREIGN KEY(name)
           REFERENCES member(name)
        
        5. CHECK 
           �÷��� �������� CHECK(sex IN('����','����'))
           �÷��� ��������,
           CONSTRAINT member_sex_ck CHECK(sex IN('M','W'))
           
        6. DEFAULT 
           �÷��� �������� DEFAULT ��(���������� �°� ����)
           
        ���� 
          PK(Primary Key)
          FK(Foreign Key)
          CK(CHECK)
          UK(UNIQUE)
          NN(NOT NULL)
    3) �������� ����  
*/
/*
     ����� �Խ��� 
     ===========
     
     �Խ���       
      = ��ȣ PK
      = �̸� NN
      = ���� NN
      = ���� NN
      = ��й�ȣ NN (���� ���� Ȯ��)
      = ����� DEFAULT 
      = ��ȸ�� DEFAULT
      
     ���
      = ��ȣ PK
      = �Խ��ǹ�ȣ FK
      = ID NN
      = �̸� NN 
      = ��۳��� NN
      = �ۼ��� DEFAULT 
*/
-- NOT NULL�� �ߺ����(X)
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
-- ������ �߰� 
-- �Խ��� 
INSERT INTO replyBoard(no,name,subject,content,pwd) VALUES(2,'','�������� ������',
   '���������� ����� ������ �ʿ��� �����͸� �Է��� �ޱ� ���� ���','1234');
COMMIT;
SELECT * FROM replyBoard;
INSERT INTO reply VALUES(2,1,'hong','ȫ�浿','��� ���',SYSDATE);
COMMIT;
SELECT * FROM reply;
DROP TABLE reply;
DROP TABLE replyBoard;
-- ���������� �̸��� �ο� (����)
-- DEFAULT , NOT NULL : �÷��ڿ� ���� , ������ ���������� �÷��� ��ü �����Ŀ� ���߿� ���� 
-- PRIMARY KEY�� �Ѱ��� ������ �� �ִ� 
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
    Ÿ�� 
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
   CONSTRAINT uc_sex_ck CHECK(sex IN('����','����')),
   CONSTRAINT uc_email_uk UNIQUE(email) -- NULL ��� 
);

INSERT INTO uniquecheck VALUES('hong','����','');
-- ���������� �߰� 
ALTER TABLE dept ADD CONSTRAINT dept_dpetno_pk PRIMARY KEY(deptno);
DROP TABLE tcons;
-- FOREIGN KEY => �����ÿ� �ݵ�� PRIMARY KEY�� ���� 
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
   CONSTRAINT member_sex_ck CHECK(sex IN('����','����')),
   CONSTRAINT member_email_uk UNIQUE(email),
   CONSTRAINT member_tel1_ck CHECK(tel1 IN('SK','KT','LG'))
);


