-- 2021-02-18 DDL 
/*
    DDL ��ɾ� (DROP,CREATE,ALTER,REANME,TRUNCATE)
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

-- ������ �߰� 
INSERT INTO replyBoard VALUES(1,'ȫ�浿');
INSERT INTO replyBoard VALUES(2,'��û��');
INSERT INTO replyBoard VALUES(3,'�ڹ���');
COMMIT;
SELECT * FROM replyBoard;

-- ����߰�
INSERT INTO reply VALUES(1,1,'��� 1');
INSERT INTO reply VALUES(2,1,'��� 2');
INSERT INTO reply VALUES(3,2,'��� 3');
INSERT INTO reply VALUES(4,3,'��� 4');
INSERT INTO reply VALUES(5,4,'��� 5'); -- replyBoard�� �ִ� �Խù���ȣ�� ����� ����  
COMMIT;
SELECT * FROM reply;

-- ����
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
-- replyBoard=>2�� ����
DELETE FROM replyBoard
WHERE no=2;

-- NOT NULL 
CREATE TABLE test_member(
  id VARCHAR2(20),
  name VARCHAR2(34) CONSTRAINT tm_name_nn NOT NULL,
  email VARCHAR2(100) CONSTRAINT tm_email_nn NOT NULL,
  CONSTRAINT tm_id_pk PRIMARY KEY(id)
);

INSERT INTO test_member VALUES('hong','ȫ�浿','');
DELETE FROM test_member
WHERE id='hong';
COMMIT;
ALTER TABLE test_member
DISABLE CONSTRAINT tm_email_nn;
ALTER TABLE test_member
ENABLE CONSTRAINT tm_email_nn;
SELECT * FROM test_member;
/*
     7�� 
     page 332 : ���������� �����ϴ� ���� 
                �ʿ��� �����͸� ����Ŭ�� �߰��� �����ϰ� ���� ��Ģ (����ȭ�� ������ => ��� USER���� ������ ����)
     page 333 : ���������� ���� (��ǥ) 
     page 335 : ���̺� �������� ���� ����
                ���� ���� => �������� �̸� �ο� , ��� 
                            ===============
                            1. ���������� �����ϱ� ���ؼ� (����,����..) (ENABLE , DISABLE)
     page 336 : ���̺��� ���� �����ϰ� ���߿� ���������� ���� 
                ADD : PK,FK,CK,UK
                MODIFY : NOT NULL
     page 340 : ON DELETE CASCADE
     page 345 : �������� ���� => ENABLE(�������� ���), DISABLE(���������� ������� �ʴ´�) => GUEST
                ALTER TABLE table��
                ENABLE CONATRAINT �������Ǹ�
                ==> ���̺� ���������� ������ ���� => ENABLE
                ALTER TABLE table��
                DISABLE CONATRAINT �������Ǹ�
                
                id(PK) => DISABLE
                aaa
                bbb
                bbb
     page 358 : �������� �˻��ϱ� => user_constraints => ���̺�� (����ɶ� �빮�ڷ� ����ȴ�)
     page 360 : ���������� ���� 
                ALTER TABLE table��
                DROP CONSTRAINT ���������̸�
*/
CREATE TABLE myTable(
   no NUMBER PRIMARY KEY,
   name VARCHAR2(20) NOT NULL
);
INSERT INTO myTable VALUES(1,'ȫ�浿');
INSERT INTO myTable VALUES(2,'��û��');
INSERT INTO myTable VALUES(3,'��û��');
SELECT * FROM myTable;
ALTER TABLE myTable ADD addr VARCHAR2(100) DEFAULT ' ' NOT NULL;
-- �� �÷��� ���������� �Ѱ��� ����ϴ� ���� �ƴϴ� (PK/FK)
CREATE TABLE myTable2(
   id VARCHAR2(20),
   name VARCHAR2(20) CONSTRAINT mt_name_nn NOT NULL,
   email VARCHAR2(100) CONSTRAINT mt_email_nn NOT NULL,
   CONSTRAINT mt_id_nn PRIMARY KEY(id)
);

DESC myTable2;
-- �������� ���� 
ALTER TABLE myTable2
DROP CONSTRAINT mt_email_nn;
-- ALTER => �÷��߰�(ADD) ,���������߰�(ADD) ,MODIFY , DROP
-- �������Ǹ� ���̺�_�÷���_�Ӽ�
/*
     �䱸���׺м� ==> �����ͺ��̽� ���� ==> ������ ���� ===> ȭ�� UI ====> ���� (�ڹ�) ===> �׽�Ʈ ===> ����
     ==========    ==============================     =======      ==========     ======
      ��Ű����             DBA                          Front (JS)      Back        �׽���   
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
    addr VARCHAR2(260) CONSTRAINT fh_addr_nn NOT NULL, -- ����,��
    tel VARCHAR2(20) CONSTRAINT fh_tel_nn NOT NULL,
    type VARCHAR2(20) CONSTRAINT fh_type_nn NOT NULL,
    price VARCHAR2(20) DEFAULT '����',
    parking VARCHAR2(30) DEFAULT '����',
    time VARCHAR2(30) DEFAULT '����',
    menu VARCHAR2(4000) DEFAULT '����',
    good NUMBER(4) DEFAULT 0,
    soso NUMBER(4) DEFAULT 0,
    bad NUMBER(4) DEFAULT 0,
    CONSTRAINT fh_no_pk PRIMARY KEY(no),
    CONSTRAINT fh_cno_fk FOREIGN KEY(cno)
    REFERENCES foodCategory(cno)
);





