-- Data Definition Language
-- DDL
-- (create , alter , drop)

-- TABLE (�⺻Ű , �ܷ�Ű)
-- ���� ������ ����Ͽ� �������� ���Ἲ�� ����
-- ���Ἲ : �����Ͱ� �ջ�ǰų� ������ �ǹ̸� ���� �ʰ� �����ϴ� ����


/*
NOT NULL
UNIQUE
PRIMARY KEY (NOT NULL + UNIQUE)
REFERENCES (FROEIGN KEY)
CHECK : �ش� �÷��� Ư�� ������ �����ϵ��� �ϴ� �÷�

���̺� ���� ���� ����
(CREATE TABLE TABLE_NAME(
        COLUMN_NAME DATATYPE(SIZE) [DEFAULT] [CONSTRAINT] 
        COLUMN_NAME DATATYPE(SIZE) [DEFAULT] [CONSTRAINT]
        COLUMN_NAME DATATYPE(SIZE) [DEFAULT] [CONSTRAINT]
                        )
)
*/
-- test
CREATE TABLE NOTNULL_TBL(
    ID      VARCHAR2(20) NOT  NULL ,
    SNAME   VARCHAR2(20)
) ;

-- �Է±���
-- INSERT INTO TABLE_NAME VALUES();

INSERT INTO NOTNULL_TBL VALUES('JSLIM' , '������') ;
SELECT  *
FROM    NOTNULL_TBL ;

-- ERROR CASE

INSERT INTO NOTNULL_TBL VALUES(NULL , '������') ;
-- -> ���� NOTNILL_TBL�� �������־��� ������ NULL�� �� �� ����. (test ����Ȯ��)

INSERT INTO NOTNULL_TBL VALUES('������' , NULL ) ;
-- -> ���� ���� test �������� SNAME���� NOT NULL�� �������� �ʾұ� ����

CREATE TABLE PK_TBL(
    ID      VARCHAR2(20)    PRIMARY KEY ,
    SNAME   VARCHAR2(20)
) ;

INSERT INTO PK_TBL VALUES('JUICE' , '������') ;
INSERT INTO PK_TBL VALUES('JUICE' , '������') ;
SELECT  *
FROM    PK_TBL ;

-- ID�� PRIMARY KEY �� �����صθ� �ߺ��� NULL �� �������� �ʴ´�.



CREATE TABLE PK_TBL2(
    ID      VARCHAR2(20)    ,
    SSN     VARCHAR2(20)    ,
    SNAME   VARCHAR2(20)    ,
    PRIMARY KEY (ID , SSN)
) ;

INSERT INTO PK_TBL2 VALUES('JUICE' , '111' , '������') ;
SELECT  *
FROM    PK_TBL2 ;




DELETE FROM PK_TBL ;
DROP TABLE PK_TBL ;


CREATE TABLE DEPT_TBL(
    DEPT_ID         VARCHAR2(50)    PRIMARY KEY ,
    DEPT_NAME       VARCHAR2(50)  
);
INSERT INTO DEPT_TBL VALUES('10', '������');
INSERT INTO DEPT_TBL VALUES('20', '������');
INSERT INTO DEPT_TBL VALUES('30', '�λ���');
SELECT  *
FROM    DEPT_TBL ;

CREATE TABLE JOB_TBL(
    JOB_ID      VARCHAR2(50)    PRIMARY KEY ,
    JOB_TITLE   VARCHAR2(50)  
);
INSERT INTO JOB_TBL VALUES('J1', '��ǥ�̻�');
INSERT INTO JOB_TBL VALUES('J2', '����');
INSERT INTO JOB_TBL VALUES('J3', '����');
INSERT INTO JOB_TBL VALUES('J5', '����');
INSERT INTO JOB_TBL VALUES('J6', '�븮');
INSERT INTO JOB_TBL VALUES('J7', '���');

SELECT  *
FROM    JOB_TBL ;



-- �ܷ�Ű
-- [DEFAULT] = NULL���� ���� ��� DEFAULT�� ������ ���� ��� ��ȯ
CREATE TABLE EMPLOYEE_TBL(
    EMP_ID      VARCHAR2(50) PRIMARY KEY    ,
    EMP_NAME    VARCHAR2(50)                ,
    HIRE_DATE   DATE DEFAULT SYSDATE        ,       -- �����ʹ� DATE�� NULL�� ��� ���� ��¥ �Է�
    SALARY      NUMBER CHECK( SALARY > 0 )          -- �����ʹ� NUMBER �� SALARY > 0 ����
);



INSERT INTO EMPLOYEE_TBL (EMP_ID , EMP_NAME , SALARY)
VALUES('100' , '������' , 10000000) ;
SELECT  *
FROM    EMPLOYEE_TBL ;


-- ���̺� ����
DROP TABLE EMPLOYEE_TBL ;


-- �ܷ�Ű


CREATE TABLE EMPLOYEE_TBL(
            EMP_ID      VARCHAR2(50) PRIMARY KEY    
        ,   EMP_NAME    VARCHAR2(50)                
        ,   HIRE_DATE   DATE DEFAULT SYSDATE               
        ,   SALARY      NUMBER CHECK( SALARY > 0 )  
        ,   JOB_ID      VARCHAR2(50) REFERENCES JOB_TBL(JOB_ID)
        ,   DEPT_ID     VARCHAR2(50) REFERENCES DEPT_TBL(DEPT_ID)
);

INSERT INTO EMPLOYEE_TBL (EMP_ID , EMP_NAME , SALARY , JOB_ID , DEPT_ID)
VALUES('JUICE' , '������' , 100000000 , 'J2' , '10') ;

SELECT  *
FROM    EMPLOYEE_TBL ;

SELECT  *
FROM    EMPLOYEE_TBL    E 
JOIN    DEPT_TBL        D ON (E.DEPT_ID = D.DEPT_ID)
JOIN    JOB_TBL         J ON (E.JOB_ID = J.JOB_ID)
;






CREATE TABLE COMPOSIT_PK_TBL(
        JOB_ID      VARCHAR2(50)    REFERENCES   JOB_TBL(JOB_ID)
    ,   DEPT_ID     VARCHAR2(50)    REFERENCES   DEPT_TBL(DEPT_ID)
    ,   MSG         VARCHAR2(50)
    ,   PRIMARY KEY (JOB_ID , DEPT_ID)
) ;

CREATE TABLE SUB_TBL(
        TEST_ID     VARCHAR2(50)    PRIMARY KEY 
    ,   JOB_ID      VARCHAR2(50)    
    ,   DEPT_ID     VARCHAR2(50)
    ,   FOREIGN KEY (JOB_ID , DEPT_ID) REFERENCES COMPOSIT_PK_TBL(JOB_ID , DEPT_ID)
) ;
-- �߿� : ���� REFERENCES�� ���� ���̺��� Ű�� �ܷ�Ű�� ������ ��� , �ϳ��� REFERENCES �� �Ұ��ϰ� FOREIGN KEY�� ����Ͽ� �������־���Ѵ�.

SELECT  *
FROM    SUB_TBL ;


-- CREATE [TABLE_NAME] AS [SELECT FROM] ���� �������� Ŭ�� ����

CREATE TABLE EMP
AS 
SELECT  *
FROM    EMPLOYEE ;





/*
ALTER TABLE TABLE_NAME

ALTER TABLE TALBE_NAME
ADD [COLUMN_NAME TYPE[DATA] [DEFAULT] [CONSTRAINT]]

ADD (COLIMN_NAME TYPE [DEFAULT] [CONSTRAINT])
���̺� Į���� �߰���


ALTER TABLE TALBE_NAME
DROP [COLUMN_NAME]
���̺��� Į���� ������
DROP TABLE TABLE_NAME
���̺��� ������

MODIFY(COLUMN_NAME TYPE [DEFAULT] [CONSTRAINT])
���̺� �ִ� Į���� ������

[�̸� ���� ����]
���̺� �̸� ����
ALTER TABLE OLD_TABLE_NAME RENAME TO NEW_TABLE_NAME ;

Į�� �̸� ����
ALTER TABLE TABLE_NAME RENAME COLUMN OLD_COLUMN TO NEW_COLUMN ;
*/






SELECT  *
FROM    EMP_NAME ;

-- Į�� �߰�

ALTER   TABLE   EMP
ADD (STATUS CHAR(1) DEFAULT 'N') ;


ALTER TABLE EMP
MODIFY  (STATUS VARCHAR2(10) DEFAULT 'Y') ;
-- �����尪�� ������ �̹� ���� ������� ��� ������ ���� �ʴ´�. NULL �� ��츸 ����

ALTER TABLE EMP
DROP COLUMN STATUS ;



-- ���̺� �̸� ����
ALTER TABLE EMP RENAME TO EMP_NAME ;


-- �θ� ���̺��� ������ �� ����.

DROP TABLE JOB_TBL ;

-- �ڽ� ���̺���� ���������� �����ؾ��Ѵ�.
-- �� , ������ �ָ� �θ� ���̺� ������ �����ϴ�.

DROP TABLE JOB_TBL  CASCADE CONSTRAINTS ;
DROP TABLE DEPT_TBL  CASCADE CONSTRAINTS ;
DROP TABLE EMP_NAME  CASCADE CONSTRAINTS ;



-- VIEW : VIRTUAL TABLE , STORDE QUERY
-- ������ ������ �ִ� ���� ���̺�
-- ���� : �κ������� ���� ���� �� ������ �ܼ�ȭ�� ���ؼ� ���

/* CREATE OR REPLACE VIEW VIEW_NAME
   AS SUBQUERY */
   
-- ������ �������� �ܼ�ȭ

CREATE OR REPLACE VIEW V_EMP_90
AS
SELECT      EMP_NAME    
        ,   SALARY
        ,   DEPT_ID
FROM        EMPLOYEE
WHERE       DEPT_ID = '90' ;

SELECT     *
FROM        V_EMP_90 ;

CREATE OR REPLACE VIEW V_EMP_GENDER(NAME , GENDER)  -- ��Ī ���� ����
AS
SELECT      EMP_NAME
        ,   CASE SUBSTR(EMP_NO , 8 , 1) 
                WHEN '1' THEN 'MAN'
                WHEN '3' THEN 'MAN'
                ELSE 'WOMAN'
            END
FROM        EMPLOYEE ;


-- �� ���� : DROP VIEW V_EMP_GENDER ;


-- DROP VIEW V_EMP_GENDER ;

-- ������(SEQUENCE) : ���������� ���� ���� �ڵ����� �����ϴ� ��ü
/*
NEXTVAL : ���ο� ������ ���� ��ȯ
CURVAL : ���� ���� ��ȯ

CREATE SEQUENCE [SEQUENCE_NAME]
INCREMENT BY N      ������ ������(����)
START WITH N        ������ ���� ��ġ
[NOCYCLE]           �ݺ��� �� ������ (�⺻ ����)

*/


CREATE  SEQUENCE EMP_SEQ ;
SELECT  EMP_SEQ.NEXTVAL FROM DUAL ;

-- EMP_SEQ ��ü ���� �� ��ü�� �����ϰ� �ִ� �Ӽ�(NEXTVAL) ��ȯ - �Է½ø��� ����� �ٲ�� ���� �� �� �ִ�.

SELECT  EMP_SEQ.CURRVAL FROM DUAL ;

-- EMP_SEQ�� ���� �� Ȥ�� �Ӽ� ��ȯ (CURRVAL)


CREATE SEQUENCE SEQ_TEST
INCREMENT BY 5              -- ������ ������(����)
START WITH  300              -- ������ ���� ��ġ
MAXVALUE    310
NOCYCLE
NOCACHE ;

SELECT  SEQ_TEST.NEXTVAL FROM DUAL ;
SELECT  SEQ_TEST.CURRVAL FROM DUAL ;

-- ������ 300 �ִ��� 310 �̹Ƿ� 310�� ��쿡 NEXTVAL�� ����� �Ұ��ϴ�.
-- �������� PRIMARY KEY���� ���� ���ȴ�.
-- DROP SEQUENCE SEQUENCE_NAME ������ ����

DROP  SEQUENCE SEQ_TEST ;

CREATE SEQUENCE TEST_SEQ ;
CREATE TABLE SEQ_TEST_TBL (
        ID      VARCHAR2(20) PRIMARY KEY
    ,   NAME    VARCHAR2(20)
    ,   SALARY  NUMBER
) ;

INSERT INTO SEQ_TEST_TBL VALUES(
    TO_CHAR(TEST_SEQ.NEXTVAL) , '������'  , 100
) ;

SELECT  *
FROM    SEQ_TEST_TBL ;


-- ������ ���� ����

/*
UPDATE  TABLE_NAME
SET     COLUMN = VALUE , [COLUMN = VALUE]
WHERE   CONDITION ;
*/

UPDATE  SEQ_TEST_TBL
SET     NAME = '������' , SALARY = SALARY - 50
WHERE   ID = '1' ;

-- ������ ���� ����
/*DELETE FROM TABLE_NAME
WHERE   CONDITION ; */

DELETE FROM SEQ_TEST_TBL
WHERE   ID = '1' ;




-- INSERT , UPDATE , DELETE (DML) : ������ ���۾�
-- ���̺� ���ο� ���� ������ �� �ִ�.



-- UPDATE
/*
UPDATE      TABLE_NAME
SET         COLUMN = VALUE OR DEFAULT(COLUMN�� DEFAULT ���� ��� ��� ����)  ,   [COLUMN = ��������]
WHERE       CONDITION ;
*/


-- 90�� �μ��� �̸��� ������ȹ������ ����
SELECT      *
FROM        DEPARTMENT ;

UPDATE      DEPARTMENT
SET         DEPT_NAME = '������ȹ��'       
WHERE       DEPT_ID = '90' ;


-- ���ϱ� ����� ���ް� �޿��� ���ر� ����� ����� ���� ������ �����Ѵ�


SELECT      *
FROM        EMPLOYEE ;

SELECT      *
FROM        JOB ;

UPDATE      EMPLOYEE
SET         SALARY = (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '���ر�')
        ,   JOB_ID = (SELECT JOB_ID FROM EMPLOYEE WHERE EMP_NAME = '���ر�') 
WHERE       EMP_NAME = '���ϱ�' ;

SELECT      JOB_ID , SALARY
FROM        EMPLOYEE
WHERE       EMP_NAME = '���ر�' OR EMP_NAME = '���ϱ�' ;

-- DEFAULT�� �̿��� ������Ʈ
UPDATE  EMPLOYEE
SET     MARRIAGE = DEFAULT
WHERE   EMP_NAME = '���ϱ�' ;

SELECT      *
FROM        EMPLOYEE 
;


-- �ؿ� ���� 2���� ������ ���ʽ� ������ ������Ʈ 0.3


UPDATE  EMPLOYEE
SET     BONUS_PCT = 0.3
WHERE   DEPT_ID = 
(   SELECT      DEPT_ID
    FROM        DEPARTMENT
    WHERE       DEPT_NAME = '�ؿܿ���2��') ;

SELECT      DEPT_ID
FROM        DEPARTMENT
WHERE       DEPT_NAME = '�ؿܿ���2��' ;


-- UPDATE�� �θ�Ű�� ���� �ڽ�Ű�� �����Ѵ�. ���� �ڽ�Ű ����� �θ�Ű�� ��õ� ������ ����ؾ��Ѵ�.

-- INSERT
-- ���� (�������� Ÿ�� , ���� , ���� ��ġ)
/*
INSERT INTO TABLE_NAME([COLUMN_NAME])
VALUES (VALUE) ;
*/

-- INSERT ������ �Է½� , ������ �Է��� �����ϸ� ������ NULL ���� �Էµȴ�.
-- �ݸ� ���������� NULL ���� �Է��ϸ� ����� NULL �Ҵ��� �ȴ�. �ݸ� DEFAULT ���� ������ ��� DEFAULT�� �� ���� �ִ�.


CREATE TABLE EMP_INFO_TBL (
        EMP_ID      CHAR(3)
    ,   EMP_NAME    VARCHAR2(20)
    ,   DEPT_NAME   VARCHAR2(20)
) ;

-- VALUE ��� ���������� ��밡��
-- ROLEBACK = CONTORL + Z
-- DELETE

/*
DELETE FROM TABLE_NAME
WHERE  [] 
TRUNCATE TABLE TABLE_NAME (ROLLBACK �Ұ�)
*/

DELETE FROM EMP_INFO_TBL ;

-- �θ�Ű �����ϰ� ���� DROP/DELETE TABLE_NAME CASCADE CONSTRAINTS

-- ON DELETE SET NULL   �θ�Ű ������ �ڽ��� NULL �� ��ü
-- ON DELETE CASCADE    �θ�Ű ������ �ڽĵ� ����

ALTER 	TABLE EMPLOYEE
DROP 	CONSTRAINTS FK_JOBID ; 


ALTER 	TABLE EMPLOYEE
ADD		CONSTRAINTS FK_JOBID FOREIGN KEY(JOB_ID) 
REFERENCES JOB ON DELETE SET NULL ;


SELECT  *
FROM    EMPLOYEE ;



-- Ʈ����� : �������� �ϰ����� �����ϱ� ���ؼ� ����ϴ� ������ �۾��� ����
-- ROLLBACK , COMMIT ;

/*

SQL > INSERT INTO ~ Ʈ������ ����
SQL > UPDATE
SQL > COMMIT ;      Ʈ������ ����

SQL > INSERT INTO ~ Ʈ������ ����
SQL > UPDATE
SQL > CREATE OR REPLACE VIEW ~ DDL ������ ���� �ڵ� COMMIT Ŀ���� �Ǹ� �ѹ��� �Ұ�

*/

-- LOCK













