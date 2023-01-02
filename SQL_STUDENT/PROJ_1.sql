-- 1
-- customers
CREATE TABLE CUSTOMERS (
        CNO     NUMBER(5)       PRIMARY KEY
    ,   CNAME   VARCHAR2(10)    NOT NULL 
    ,   ADDRESS VARCHAR2(50)    NOT NULL
    ,   EMAIL   VARCHAR2(20)    NOT NULL
    ,   PHONE   VARCHAR2(20)    NOT NULL
) ;

SELECT *
FROM CUSTOMERS ;
-- DROP TABLE CUSTOMERS ;

-- orders
CREATE TABLE ORDERS (
        ORDERNO     NUMBER(10)              PRIMARY KEY
    ,   ORDERDATE   DATE DEFAULT SYSDATE    NOT NULL 
    ,   ADDRESS     VARCHAR2(50)            NOT NULL
    ,   PHONE       VARCHAR2(20)            NOT NULL
    ,   STATUS      VARCHAR2(20) CHECK (
                                        STATUS LIKE '�����Ϸ�' OR STATUS LIKE '�����' OR STATUS LIKE '��ۿϷ�'
                                        )   NOT NULL
    ,   CNO         NUMBER(5)               NOT NULL
                                            REFERENCES CUSTOMERS(CNO)
) ;

SELECT  *
FROM    ORDERS ;

-- products

CREATE TABLE PRODUCTS (
        PNO     NUMBER(5)           PRIMARY KEY
    ,   PNAME   VARCHAR2(20)        NOT NULL
    ,   COST    NUMBER(8) DEFAULT 0 NOT NULL
    ,   STOCK   NUMBER(5) DEFAULT 0 NOT NULL
) ;    
SELECT  *
FROM    PRODUCTS ;



-- ordertail

CREATE TABLE ORDERTAIL (
        ORDERNO     NUMBER(10)          REFERENCES ORDERS(ORDERNO)
    ,   PNO         NUMBER(5)           REFERENCES PRODUCTS(PNO)
    ,   QTY         NUMBER(5) DEFAULT 0
    ,   COST        NUMBER(8) DEFAULT 0
    ,   PRIMARY KEY (ORDERNO , PNO)
) ;

SELECT  *
FROM    ORDERTAIL ;

-- 2


INSERT INTO PRODUCTS VALUES (1001 , '�����' , 1000 , 200) ;
INSERT INTO PRODUCTS VALUES (1002 , '�����' , 1500 , 500) ;
INSERT INTO PRODUCTS VALUES (1003 , '������' , 2000 , 350) ;
INSERT INTO PRODUCTS VALUES (1004 , '������' , 2000 , 700) ;
INSERT INTO PRODUCTS VALUES (1005 , '��ī�ݶ�' , 1800 , 550) ;
INSERT INTO PRODUCTS VALUES (1006 , 'ȯŸ' , 1600 , 300) ;


SELECT  *
FROM    PRODUCTS ;


-- 3

INSERT INTO CUSTOMERS VALUES (101 , '��ö��' , '���� ������' , 'cskim@naver.com' , '899-6666') ;
INSERT INTO CUSTOMERS VALUES (102 , '�̿���' , '�λ� ����' , 'yhlee@empal.com' , '355-8882') ;
INSERT INTO CUSTOMERS VALUES (103 , '������' , '���� ������' , 'jkchoi@gmail.com' , '852-5764') ;
INSERT INTO CUSTOMERS VALUES (104 , '����ȣ' , '���� ȫ����' , 'jhkang@hanmail.com' , '559-7777') ;
INSERT INTO CUSTOMERS VALUES (105 , '�κ���' , '���� ���ε�' , 'bgmin@hotmail.com' , '559-8747') ;
INSERT INTO CUSTOMERS VALUES (106 , '���μ�' , '���� �ϱ�' , 'msoh@microsoft.com' , '542-9988') ;

SELECT  *
FROM    CUSTOMERS ;

-- 4 '��ö��(101) �� 3�� ���� �����(1001)�� ���� 1õ���� 50�� �ֹ��Ͽ���.'

SELECT      CNO
FROM        CUSTOMERS 
WHERE       CNAME = '��ö��';

SELECT  SYSDATE -3
FROM DUAL ;

INSERT INTO ORDERS (ORDERNO , ORDERDATE , ADDRESS , PHONE , STATUS , CNO) VALUES (
            1
        ,   SYSDATE - 3
        ,   ( SELECT ADDRESS FROM CUSTOMERS WHERE CNAME = '��ö��' )
        ,   ( SELECT PHONE FROM CUSTOMERS WHERE CNAME = '��ö��' )
        ,   '�����Ϸ�'
        ,   ( SELECT CNO FROM CUSTOMERS WHERE CNAME = '��ö��' )
 ) ;

SELECT  *
FROM    ORDERS ;

INSERT INTO ORDERTAIL VALUES ( 1 , 1001 , 50 , 1000) ;


SELECT  DISTINCT *
FROM    ORDERTAIL ;          

SELECT      O.ORDERNO
        ,   O.ORDERDATE
        ,   C.CNAME
        ,   C.ADDRESS
        ,   C.PHONE
        ,   O.STATUS
        ,   P.PNAME
        ,   P.COST
        ,   OT.QTY
FROM        CUSTOMERS       C
LEFT JOIN        ORDERS          O  ON (C.CNO = O.CNO)
LEFT JOIN        ORDERTAIL       OT ON (O.ORDERNO = OT.ORDERNO AND OT.ORDERNO = O.ORDERNO)
JOIN        PRODUCTS        P  ON (OT.PNO = P.PNO) 
WHERE       C.CNAME = '��ö��' ;
--
CREATE TABLE CALCULATE
AS
SELECT      O.ORDERNO
        ,   O.ORDERDATE
        ,   C.CNAME
        ,   C.ADDRESS
        ,   C.PHONE
        ,   O.STATUS
        ,   P.PNAME
        ,   P.COST
        ,   OT.QTY
FROM        CUSTOMERS       C
JOIN        ORDERS          O  ON (C.CNO = O.CNO)
JOIN        ORDERTAIL       OT ON (O.ORDERNO = OT.ORDERNO AND OT.ORDERNO = O.ORDERNO)
JOIN        PRODUCTS        P  ON (OT.PNO = P.PNO) ;
--


-- 5

UPDATE      PRODUCTS
SET         STOCK = 150 
WHERE       PNAME = '�����' ;

SELECT  *
FROM    PRODUCTS ;


-- 6



INSERT INTO ORDERS (ORDERNO , ORDERDATE , ADDRESS , PHONE , STATUS , CNO) VALUES (
            2
        ,   SYSDATE - 2
        ,   ( SELECT ADDRESS FROM CUSTOMERS WHERE CNAME = '�̿���' )
        ,   ( SELECT PHONE FROM CUSTOMERS WHERE CNAME = '�̿���' )
        ,   '�����Ϸ�'
        ,   ( SELECT CNO FROM CUSTOMERS WHERE CNAME = '�̿���' )
 ) ;
 
INSERT INTO ORDERTAIL VALUES ( 2 , 1002 , 100 , 1500) ;
INSERT INTO ORDERTAIL VALUES ( 2 , 1003 , 150 , 2000) ;
 SELECT     *
 FROM       ORDERS ;
 SELECT     *
 FROM       ORDERTAIL ;
 
 
SELECT      O.ORDERNO
        ,   O.ORDERDATE
        ,   C.CNAME
        ,   C.ADDRESS
        ,   C.PHONE
        ,   O.STATUS
        ,   P.PNAME
        ,   P.COST
        ,   OT.QTY
FROM        CUSTOMERS       C
JOIN        ORDERS          O  ON (C.CNO = O.CNO)
JOIN        ORDERDETAIL       OT ON (O.ORDERNO = OT.ORDERNO AND OT.ORDERNO = O.ORDERNO)
JOIN        PRODUCTS        P  ON (OT.PNO = P.PNO) ;


-- 7


UPDATE      PRODUCTS
SET         STOCK = 500 - 400 
WHERE       PNAME = '�����' ;

UPDATE      PRODUCTS
SET         STOCK = 350 - 150  
WHERE       PNAME = '������' ;


SELECT  *
FROM    PRODUCTS ;

-- 8

ALTER TABLE ORDERTAIL RENAME TO ORDERDETAIL ;

SELECT      O.ORDERNO
        ,   O.ORDERDATE
        ,   C.CNAME
        ,   C.ADDRESS
        ,   C.PHONE
        ,   O.STATUS
        ,   P.PNAME
        ,   P.COST
        ,   OT.QTY
FROM        CUSTOMERS       C
JOIN        ORDERS          O  ON (C.CNO = O.CNO)
JOIN        ORDERDETAIL     OT ON (O.ORDERNO = OT.ORDERNO AND OT.ORDERNO = O.ORDERNO)
JOIN        PRODUCTS        P  ON (OT.PNO = P.PNO) ;


INSERT INTO ORDERS (ORDERNO , ORDERDATE , ADDRESS , PHONE , STATUS , CNO) VALUES (
            3
        ,   SYSDATE - 1
        ,   ( SELECT ADDRESS FROM CUSTOMERS WHERE CNAME = '���μ�' )
        ,   ( SELECT PHONE FROM CUSTOMERS WHERE CNAME = '���μ�' )
        ,   '�����Ϸ�'
        ,   ( SELECT CNO FROM CUSTOMERS WHERE CNAME = '���μ�' )
 ) ;

INSERT INTO ORDERDETAIL VALUES ( 3 , 1004 , 100 , 2000) ;
INSERT INTO ORDERDETAIL VALUES ( 3 , 1005 , 50 , 1800) ;

 SELECT     *
 FROM       ORDERS ;
 
 
 
-- 9

UPDATE      PRODUCTS
SET         STOCK = 700 - 100
WHERE       PNAME = '������' ;

UPDATE      PRODUCTS
SET         STOCK = 550 - 50  
WHERE       PNAME = '��ī�ݶ�' ;


SELECT  *
FROM    PRODUCTS ;


-- 10


CREATE OR REPLACE VIEW V_SHOPPING (ORDERNO , ORDERDATE , CNAME , ADDRESS , PHONE , STATUS , PNAME , COST , QTY , SUM)
AS
SELECT      O.ORDERNO
        ,   O.ORDERDATE
        ,   C.CNAME
        ,   C.ADDRESS
        ,   C.PHONE
        ,   O.STATUS
        ,   P.PNAME
        ,   P.COST
        ,   OT.QTY
        ,   P.COST * OT.QTY 
FROM        CUSTOMERS       C
JOIN        ORDERS          O  ON (C.CNO = O.CNO)
JOIN        ORDERDETAIL     OT ON (O.ORDERNO = OT.ORDERNO AND OT.ORDERNO = O.ORDERNO)
JOIN        PRODUCTS        P  ON (OT.PNO = P.PNO) ;


SELECT  *
FROM    V_SHOPPING ;
-- 11


SELECT      O.ORDERDATE
        ,   P.COST * OT.QTY AS "SUM"
FROM        CUSTOMERS       C
JOIN        ORDERS          O  ON (C.CNO = O.CNO)
JOIN        ORDERDETAIL     OT ON (O.ORDERNO = OT.ORDERNO AND OT.ORDERNO = O.ORDERNO)
JOIN        PRODUCTS        P  ON (OT.PNO = P.PNO) ;



-- 12


INSERT INTO PRODUCTS VALUES(
            1007 
        ,   '��ĵ��'
        ,   3000
        ,   500
) ;

SELECT  *
FROm    PRODUCTS ;

-- 13

INSERT INTO ORDERS (ORDERNO , ORDERDATE , ADDRESS , PHONE , STATUS , CNO) VALUES (
            4
        ,   SYSDATE 
        ,   ( SELECT ADDRESS FROM CUSTOMERS WHERE CNAME = '������' )
        ,   ( SELECT PHONE FROM CUSTOMERS WHERE CNAME = '������' )         -- ��ȭ��ȣ�� 1������ �Է��� ���̶� Ʋ����. �׳� ���� ��ȭ��ȣ�� ����
        ,   '�����Ϸ�'
        ,   ( SELECT CNO FROM CUSTOMERS WHERE CNAME = '������' )
 ) ;

SELECT  *
FROm    ORDERS ;

UPDATE      PRODUCTS
SET         STOCK = 500 - 200
WHERE       PNAME = '��ĵ��' ;

INSERT INTO ORDERDETAIL VALUES ( 4 , 1007 , 200 , 3000) ;

SELECT      O.ORDERNO
        ,   O.ORDERDATE
        ,   C.CNAME
        ,   C.ADDRESS
        ,   C.PHONE
        ,   O.STATUS
        ,   P.PNAME
        ,   P.COST
        ,   OT.QTY
        ,   P.COST * OT.QTY 
FROM        CUSTOMERS       C
JOIN        ORDERS          O  ON (C.CNO = O.CNO)
JOIN        ORDERDETAIL     OT ON (O.ORDERNO = OT.ORDERNO AND OT.ORDERNO = O.ORDERNO)
JOIN        PRODUCTS        P  ON (OT.PNO = P.PNO) ;

SELECT  *
FROM    V_SHOPPING ;



CREATE TABLE CART_MILK_YOGURT (
        CART_ID_NO  NUMBER(5)
    ,   NAME_MILK   VARCHAR2(10)
    ,   NAME_YOUGRT VARCHAR2(10)
);
