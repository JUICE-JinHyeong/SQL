-- 1

-- MEMBER

CREATE TABLE MEMBER (
        MEMBER_ID   NUMBER(10)          PRIMARY KEY
    ,   NAME        VARCHAR2(25)        NOT NULL
    ,   ADDRESS     VARCHAR2(100)       
    ,   CITY        VARCHAR2(30)    
    ,   PHONE       VARCHAR2(15)
    ,   JOIN_DATE   DATE DEFAULT SYSDATE NOT NULL
) ;

SELECT  *
FROM    MEMBER ;

-- TITLE

CREATE TABLE TITLE (
        TITLE_ID    NUMBER(10)          PRIMARY KEY
    ,   TITLE       VARCHAR2(60)        NOT NULL
    ,   DESCRIPTION VARCHAR2(400)       NOT NULL
    ,   RATING      VARCHAR2(20) CHECK (RATING IN ('18��' , '15��' , '12��' , '��ü��'))
    ,   CATEGORY    VARCHAR2(20) CHECK (CATEGORY IN ('���' , '�׼�' , '�ڹ̵�' , '�Ƶ�' , 'SF' , '��ť���͸�'))
    ,   RELEASE_DATE    DATE
) ;

SELECT  *
FROM    TITLE ;
DROP TABLE TITLE;
ALTER TABLE TITLE RENAME COLUMN RELESASE TO RELEASE_DATE ;
-- TITLE_COPY

CREATE TABLE TITLE_COPY (
            COPY_ID     NUMBER(10)
        ,   TITLE_ID    NUMBER(10)          REFERENCES TITLE (TITLE_ID)
        ,   STATUS      VARCHAR2(20) CHECK (STATUS IN ('�뿩����' , '�ļ�' , '�뿩��' , '����')) NOT NULL 
        ,   PRIMARY KEY (COPY_ID , TITLE_ID) 
) ;

SELECT  *
FROM    TITLE_COPY ;
DROP TABLE TITLE_COPY ;
    
-- RENTAL

CREATE TABLE RENTAL (
            BOOK_DATE       DATE DEFAULT SYSDATE
        ,   MEMBER_ID       NUMBER(10)      REFERENCES MEMBER(MEMBER_ID)
        ,   COPY_ID         NUMBER(10)      
        ,   TITLE_ID        NUMBER(10)      
        ,   ACT_RET_DATE    DATE
        ,   EXP_RET_DATE    DATE DEFAULT SYSDATE+2
        ,   PRIMARY KEY     (BOOK_DATE , MEMBER_ID , COPY_ID , TITLE_ID)
        ,   FOREIGN KEY     (COPY_ID , TITLE_ID) REFERENCES TITLE_COPY(COPY_ID , TITLE_ID)
) ;        
        

SELECT  *
FROM    RENTAL ;

DROP TABLE RENTAL ;

-- RESERVATION

CREATE TABLE RESERVATION (
            RES_DATE        DATE
        ,   MEMBER_ID       NUMBER(10)      REFERENCES MEMBER(MEMBER_ID)
        ,   TITLE_ID        NUMBER(10)      REFERENCES TITLE(TITLE_ID)
        ,   PRIMARY KEY     (RES_DATE , MEMBER_ID , TITLE_ID)
) ;

SELECT  *
FROM    RESERVATION ;
        
DROP TABLE RESERVATION ;


-- 2
/*
CREATE SEQUENCE SEQ_TEST
INCREMENT BY 5              -- ������ ������(����)
START WITH  300              -- ������ ���� ��ġ
MAXVALUE    310
NOCYCLE
NOCACHE ;
*/

-- A

CREATE SEQUENCE MEMBER_ID_SEQ 
INCREMENT BY 1
START WITH 101
NOCYCLE
NOCACHE ;
DROP SEQUENCE MEMBER_ID_SEQ ;

-- B

CREATE SEQUENCE TITLE_ID_SEQ
INCREMENT BY 1
START WITH 92
NOCYCLE
NOCACHE ;

DROP SEQUENCE TITLE_ID_SEQ ;
        

-- 3


INSERT INTO TITLE VALUES (
        TITLE_ID_SEQ.NEXTVAL
    ,   '�ξ����'
    ,   '�ξ���� ����'
    ,   '��ü��'
    ,   '�Ƶ�'
    ,   '95/10/05'
) ;
INSERT INTO TITLE VALUES (
        TITLE_ID_SEQ.NEXTVAL
    ,   '��Ʈ����'
    ,   '��Ʈ���� ����'
    ,   '15��'
    ,   'SF'
    ,   '95/05/19'
) ;
INSERT INTO TITLE VALUES (
        TITLE_ID_SEQ.NEXTVAL
    ,   '���̸���'
    ,   '���̸��� ����'
    ,   '18��'
    ,   'SF'
    ,   '95/08/12'
) ;
INSERT INTO TITLE VALUES (
        TITLE_ID_SEQ.NEXTVAL
    ,   '���Ÿ����'
    ,   '���Ÿ���� ����'
    ,   '��ü��'
    ,   '�ڹ̵�'
    ,   '95/07/12'
) ;
INSERT INTO TITLE VALUES (
        TITLE_ID_SEQ.NEXTVAL
    ,   '���꽺�丮'
    ,   '���꽺�丮 ����'
    ,   '��ü��'
    ,   '���'
    ,   '95/09/12'
) ;
INSERT INTO TITLE VALUES (
        TITLE_ID_SEQ.NEXTVAL
    ,   '����'
    ,   '���� ����'
    ,   '18��'
    ,   '�׼�'
    ,   '95/06/01'
) ;
SELECT *
FROM    TITLE ;
        
        
-- 4

INSERT INTO MEMBER VALUES (
        MEMBER_ID_SEQ.NEXTVAL
    ,   '��ö��'
    ,   '������'
    ,   '����'
    ,   '899-6666'
    ,   '90/03/08'
) ;

INSERT INTO MEMBER VALUES (
        MEMBER_ID_SEQ.NEXTVAL
    ,   '�̿���'
    ,   '����'
    ,   '�λ�'
    ,   '355-8882'
    ,   '90/03/08'
) ;

INSERT INTO MEMBER VALUES (
        MEMBER_ID_SEQ.NEXTVAL
    ,   '������'
    ,   '������'
    ,   '����'
    ,   '852-5764'
    ,   '91/06/17'
) ;

INSERT INTO MEMBER VALUES (
        MEMBER_ID_SEQ.NEXTVAL
    ,   '����ȣ'
    ,   'ȫ����'
    ,   '����'
    ,   '559-7777'
    ,   '90/04/07'
) ;
        
INSERT INTO MEMBER VALUES (
        MEMBER_ID_SEQ.NEXTVAL
    ,   '�κ���'
    ,   '���ε�'
    ,   '����'
    ,   '559-8741'
    ,   '91/01/18'
) ;
INSERT INTO MEMBER VALUES (
        MEMBER_ID_SEQ.NEXTVAL
    ,   '���μ�'
    ,   '�ϱ�'
    ,   '����'
    ,   '542-9988'
    ,   '91/01/18'
) ;
SELECT  *
FROM    MEMBER ;


-- 5

INSERT INTO TITLE_COPY VALUES (
        1
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '�ξ����')
    ,   '�뿩����'
) ;

INSERT INTO TITLE_COPY VALUES (
        1
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '��Ʈ����')
    ,   '�뿩����'
) ;

UPDATE  TITLE
SET     TITLE = '��Ʈ����'
WHERE   TITLE_ID = 93;

-- ��Ʈ������ ��Ʈ������� ��� ��ħ

INSERT INTO TITLE_COPY VALUES (
        2
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '��Ʈ����')
    ,   '�뿩��'
) ;

INSERT INTO TITLE_COPY VALUES (
        1
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '���̸���')
    ,   '�뿩����'
) ;

INSERT INTO TITLE_COPY VALUES (
        1
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '���Ÿ����')
    ,   '�뿩����'
) ;

INSERT INTO TITLE_COPY VALUES (
        2
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '���Ÿ����')
    ,   '�뿩����'
) ;

INSERT INTO TITLE_COPY VALUES (
        3
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '���Ÿ����')
    ,   '�뿩��'
) ;

INSERT INTO TITLE_COPY VALUES (
        1
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '���꽺�丮')
    ,   '�뿩����'
) ;


INSERT INTO TITLE_COPY VALUES (
        1
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '����')
    ,   '�뿩����'
) ;

SELECT  *
FROM    TITLE_COPY ;


-- 6

INSERT INTO RENTAL VALUES (
        SYSDATE - 3
    ,   (SELECT MEMBER_ID FROM MEMBER WHERE NAME = '��ö��')
    ,   1
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '�ξ����')
    ,   SYSDATE - 2
    ,   SYSDATE - 1
) ;     

INSERT INTO RENTAL VALUES (
        SYSDATE - 1
    ,   (SELECT MEMBER_ID FROM MEMBER WHERE NAME = '������')
    ,   2
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '��Ʈ����')
    ,   NULL
    ,   SYSDATE + 1
) ;  

UPDATE  RENTAL
SET     ACT_RET_DATE = SYSDATE - 2 , EXP_RET_DATE = SYSDATE - 1
WHERE   MEMBER_ID = 101 ;
UPDATE  RENTAL
SET     ACT_RET_DATE = NULL , EXP_RET_DATE = SYSDATE + 1
WHERE   MEMBER_ID = 103 ;


INSERT INTO RENTAL VALUES (
        SYSDATE - 2
    ,   (SELECT MEMBER_ID FROM MEMBER WHERE NAME = '����ȣ')
    ,   3
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '���Ÿ����')
    ,   NULL
    ,   SYSDATE
) ;  

INSERT INTO RENTAL VALUES (
        SYSDATE - 4
    ,   (SELECT MEMBER_ID FROM MEMBER WHERE NAME = '�κ���')
    ,   1
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '����')
    ,   SYSDATE - 2
    ,   SYSDATE - 2
) ;        

SELECT  *
FROM    RENTAL ;

        
        
        
-- 7


SELECT      T.TITLE         AS "TITLE"
        ,   CP.COPY_ID      AS "COPY_ID"
        ,   CP.STATUS       AS "STATUS"
        ,   R.EXP_RET_DATE  AS "EXP_RET_DATE"
FROM        TITLE       T
LEFT JOIN        TITLE_COPY  CP  ON (T.TITLE_ID = CP.TITLE_ID)
LEFT JOIN        RENTAL      R   ON (CP.COPY_ID = R.COPY_ID AND CP.TITLE_ID = R.TITLE_ID) -- CP.TITLE_ID = R.TITLE_ID CP.COPY_ID = R.COPY_ID
ORDER BY    T.TITLE_ID , CP.COPY_ID  ;


            
SELECT  *
FROM    TITLE ;
SELECT  *
FROM    RENTAL ;
SELECT  *
FROM    TITLE_COPY ;
            
            
            
            
CREATE OR REPLACE VIEW TITLE_AVAIL (TITLE , COPY_ID , STATUS , EXP_RET_DATE)
AS
SELECT      T.TITLE         AS "TITLE"
        ,   CP.COPY_ID      AS "COPY_ID"
        ,   CP.STATUS       AS "STATUS"
        ,   R.EXP_RET_DATE  AS "EXP_RET_DATE"
FROM        TITLE       T
LEFT JOIN        TITLE_COPY  CP  ON (T.TITLE_ID = CP.TITLE_ID)
LEFT JOIN        RENTAL      R   ON (CP.COPY_ID = R.COPY_ID AND CP.TITLE_ID = R.TITLE_ID) 
ORDER BY    T.TITLE_ID , CP.COPY_ID  ;            
            

SELECT      *
FROM        TITLE_AVAIL ;




-- 8 

-- A

INSERT INTO TITLE VALUES (
        TITLE_ID_SEQ.NEXTVAL
    ,   '��Ÿ����'
    ,   '��Ÿ���� ����'
    ,   '��ü��'
    ,   'SF'
    ,   '77/07/07'
) ;

SELECT  *
FROM    TITLE ;

INSERT INTO TITLE_COPY VALUES (
        1
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '��Ÿ����')
    ,   '�뿩����'
) ;

INSERT INTO TITLE_COPY VALUES (
        2
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '��Ÿ����')
    ,   '�뿩����'
) ;

SELECT  *
FROM    TITLE_COPY ;



-- B


INSERT INTO RESERVATION VALUES (
        SYSDATE
    ,   (SELECT MEMBER_ID FROM MEMBER WHERE NAME = '�̿���')
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '��Ÿ����')
) ;

INSERT INTO RESERVATION VALUES (
        SYSDATE
    ,   (SELECT MEMBER_ID FROM MEMBER WHERE NAME = '���μ�')
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '���꽺�丮')
) ;
   
SELECT  *
FROM    RESERVATION ;


-- C


-- ����
DELETE RESERVATION 
WHERE  MEMBER_ID = 102 ;
-- �뿩����

INSERT INTO RENTAL VALUES (
        SYSDATE 
    ,   (SELECT MEMBER_ID FROM MEMBER WHERE NAME = '�̿���')
    ,   1
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '��Ÿ����')
    ,   SYSDATE
    ,   DEFAULT
) ;  


INSERT INTO RENTAL VALUES (
        SYSDATE 
    ,   (SELECT MEMBER_ID FROM MEMBER WHERE NAME = '�̿���')
    ,   1
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '��Ÿ����')
    ,   SYSDATE
    ,   DEFAULT
) ;  

UPDATE  TITLE_COPY
SET     STATUS = '�뿩��'
WHERE   TITLE_ID = 98 ;

UPDATE  TITLE_COPY
SET     STATUS = '�뿩����'
WHERE   TITLE_ID = 98 AND COPY_ID = '2';

SELECT  *
FROM    TITLE_COPY ;



SELECT      *
FROM        TITLE_AVAIL ;  -- ��



-- 9

-- Į�� ����

ALTER TABLE TITLE ADD (PRICE NUMBER(5)) ;

-- Į���� ������ �Է�




UPDATE  TITLE
SET     PRICE = 3000 
WHERE   TITLE = '�ξ����' ;

UPDATE  TITLE
SET     PRICE = 2500 
WHERE   TITLE = '��Ʈ����' ;

UPDATE  TITLE
SET     PRICE = 2000 
WHERE   TITLE = '���̸���' ;

UPDATE  TITLE
SET     PRICE = 3000 
WHERE   TITLE = '���Ÿ����' ;

UPDATE  TITLE
SET     PRICE = 3500 
WHERE   TITLE = '���꽺�丮' ;

UPDATE  TITLE
SET     PRICE = 2000 
WHERE   TITLE = '����' ;

UPDATE  TITLE
SET     PRICE = 1500 
WHERE   TITLE = '��Ÿ����' ;

SELECT *
FROM    TITLE ;


-- PRICE Į���� NOT NULL

ALTER TABLE TITLE
MODIFY (PRICE NUMBER(5) NOT NULL) ;



-- 10



SELECT      M.NAME          AS "ȸ����"
        ,   T.TITLE         AS "����"
        ,   R.BOOK_DATE     AS "�뿩��"
        ,   NVL (ROUND(R.ACT_RET_DATE - R.BOOK_DATE) , 0)     AS "�Ⱓ"        
FROM        TITLE       T
JOIN        TITLE_COPY  CP  ON (T.TITLE_ID = CP.TITLE_ID)
JOIN        RENTAL      R   ON (CP.COPY_ID = R.COPY_ID AND CP.TITLE_ID = R.TITLE_ID) 
JOIN        MEMBER      M   ON (R.MEMBER_ID = M.MEMBER_ID)  
ORDER BY    T.TITLE_ID , CP.COPY_ID  ; 


SELECT  *
FROM    RENTAL ;
SELECT  *
FROM    TITLE_COPY ;