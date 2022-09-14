-- JOIN , SUBQUERY

/*
JOIN : ������ �������� ������ �ְ� ���� �ٸ� ���̺� �����ϴ� �÷����� �� ���� ��ȸ�ϱ� ���� ���
EQUAL - JOIN
- �������� = ����ϴ� ����
NON EQUAL - JOIN
- �������� = ������� �ʴ� ����
*/

-- ����Ŭ ���� ����

SELECT  *
FROM    DEPARTMENT ;

SELECT  *
FROM    EMPLOYEE ;

-- ���������� JOIN ����

SELECT  EMP_NAME ,  
        DEPT_NAME 
FROM    EMPLOYEE , DEPARTMENT ;

-- JOIN�� �ݵ�� ����(WHERE)�� �ʿ��ϴ�.

SELECT  EMP_NAME ,
        DEPT_NAME
FROM    EMPLOYEE E , DEPARTMENT D , JOB J
WHERE   E.DEPT_ID = D.DEPT_ID AND J.JOB_ID = E.JOB_ID ;

-- ANSI ǥ�� ���� (USING , ON)
-- USING    : �θ��� �⺻Ű�� �ڽ��� �ܷ�Ű�� Į�� �̸��� ������ �� ��� �����ϴ�.
-- USING ���̺� ��Ī�� ����� �� ����.
-- ON       : �θ��� �⺻Ű�� �ڽ��� �ܷ�Ű Į���� �������� ���� ��   

SELECT  EMP_NAME ,  
        DEPT_NAME ,
        JOB_TITLE
FROM    EMPLOYEE E
JOIN    DEPARTMENT D USING(DEPT_ID) 
JOIN    JOB J USING(JOB_ID) 
WHERE   JOB_ID = 'J6' ;


SELECT      JOB_TITLE   ,
            AVG(SALARY)
FROM        EMPLOYEE E
JOIN        DEPARTMENT D USING(DEPT_ID) 
JOIN        JOB J USING(JOB_ID) 
GROUP BY    JOB_TITLE ;

-- ON ���

SELECT  DEPT_NAME ,
        LOC_DESCRIBE
FROM    DEPARTMENT D
JOIN    LOCATION L ON(LOCATION_ID = LOC_ID) ;

SELECT  EMP_NAME ,
        DEPT_NAME
FROM    DEPARTMENT D
JOIN    EMPLOYEE   E ON(D.DEPT_ID = E.DEPT_ID) ;

-- DEPT_ID�� NULL�� �����ϹǷ� ��� ����� �����ȴ�.

-- ������ ������ ǥ���Ű�¹�
-- OUTER JOIN ( LEFT | RIGHT | FULL )
SELECT  EMP_NAME ,
        DEPT_NAME
FROM    DEPARTMENT D
RIGHT JOIN    EMPLOYEE   E ON(D.DEPT_ID = E.DEPT_ID) ;

SELECT  EMP_NAME ,
        DEPT_NAME
FROM    DEPARTMENT D
LEFT JOIN    EMPLOYEE   E ON(D.DEPT_ID = E.DEPT_ID) ;

SELECT  EMP_NAME ,
        DEPT_NAME
FROM    DEPARTMENT D
FULL JOIN    EMPLOYEE   E ON(D.DEPT_ID = E.DEPT_ID) ;

-- ����� � �޿� ��޿� �ش��ϴ��� Ȯ��

SELECT   *
FROM     SAL_GRADE ;


SELECT  EMP_NAME ,
        SALARY   ,
        SLEVEL
FROM    EMPLOYEE  E
JOIN    SAL_GRADE S ON(SALARY BETWEEN LOWEST AND HIGHEST) ;


-- SELP JOIN
-- ����� �̸��� ����� �̸��� ��ȸ

SELECT  E.EMP_NAME ,
        NVL(S.EMP_NAME , '*������') AS "������ �� �� ������"
FROM    EMPLOYEE E
LEFT JOIN    EMPLOYEE S  ON(E.MGR_ID = S.MGR_ID) ;


-- JOB , EMPLOYEE , DEPARTMENT���� Į�� ��������

SELECT  JOB_TITLE    AS "����"         ,
        EMP_NAME     AS "��� �̸�"     ,
        DEPT_NAME    AS "�繫��"        ,
        SLEVEL       AS "�޿� ���"     ,
        LOC_DESCRIBE AS "���� ����"     ,
        COUNTRY_NAME AS "���� ����"
FROM    EMPLOYEE   A                                       -- �� ���迡�� �������� Į���� FROM�� �� �� ����. 
FULL JOIN    JOB        B ON(A.JOB_ID = B.JOB_ID) 
FULL JOIN    DEPARTMENT C ON(A.DEPT_ID = C.DEPT_ID)
JOIN    SAL_GRADE  D ON(SALARY BETWEEN LOWEST AND HIGHEST) -- �ܺ� Į��
FULL JOIN    LOCATION   E ON(C.LOC_ID = E.LOCATION_ID)
FULL JOIN    COUNTRY    F ON(E.COUNTRY_ID = F.COUNTRY_ID) 
ORDER BY "�޿� ���" ;


-- �� ����� ������ ������ �븮, ������ �ƽþƷ� �����ϴ� ��� ���� ��ȸ


SELECT    JOB_TITLE    AS "����"         
        , EMP_NAME     AS "��� �̸�"    
        , DEPT_NAME    AS "�繫��"       
        , SLEVEL       AS "�޿� ���"     
        , LOC_DESCRIBE AS "���� ����"     
        , COUNTRY_NAME AS "���� ����"
FROM    EMPLOYEE   A                                       -- �� ���迡�� �������� Į���� FROM�� �� �� ����. 
JOIN    JOB        B ON(A.JOB_ID = B.JOB_ID) 
JOIN    DEPARTMENT C ON(A.DEPT_ID = C.DEPT_ID)
JOIN    SAL_GRADE  D ON(SALARY BETWEEN LOWEST AND HIGHEST) -- �ܺ� Į��
JOIN    LOCATION   E ON(C.LOC_ID = E.LOCATION_ID)
JOIN    COUNTRY    F ON(E.COUNTRY_ID = F.COUNTRY_ID) 
WHERE   JOB_TITLE = '�븮' AND LOC_DESCRIBE LIKE '�ƽþ�%'  -- ������ �� ��, ��Ī�� ������� �ʾƵ� �ȴ�. ��Ī�� Į�� �̸� �ձ���
ORDER BY "�޿� ���" ;




-- 1 �л� �̸��� �ּ��� ǥ��, ��� ��� : �л� �̸� , �ּ��� , ������ �̸����� ������

SELECT      STUDENT_NAME        AS "�л� �̸�"
        ,   STUDENT_ADDRESS     AS "�ּ���"
FROM        TB_STUDENT
ORDER BY    1 ;


-- 2 �������� �л����� �̸��� �ֹι�ȣ�� ���̰� ���� ������ ȭ�鿡 ���

SELECT      STUDENT_NAME        AS "�л� �̸�"
        ,   STUDENT_SSN         AS "�л� �ֹι�ȣ"
FROM        TB_STUDENT
WHERE       ABSENCE_YN = 'Y'
ORDER BY    2 DESC ;

-- 3  �ּ����� �������� ��⵵�� �л��� �� 1900��� �й��� ���� �л����� �̸��� �й�, �ּҸ� �̸��� ������ ������ ȭ�鿡 ���
--      �� ��� ������� �л��̸�, �й� , ������ �ּҰ� ��� - ��Ī

SELECT      STUDENT_NAME        AS "�л� �̸�"
        ,   STUDENT_NO          AS "�л� ��ȣ"
        ,   STUDENT_ADDRESS 
FROM        TB_STUDENT
WHERE       SUBSTR(STUDENT_NO , 1 , 1) = '9' AND (STUDENT_ADDRESS LIKE '����%' OR STUDENT_ADDRESS LIKE '���%')
ORDER BY    1 ;

-- 4 ���� ���а� ���� �� ���� ���̰� ���� ������� �̸��� Ȯ���� �� �ִ� SQL ������ �ۼ�

SELECT      PROFESSOR_NAME 
FROM        TB_PROFESSOR
ORDER BY    PROFESSOR_SSN ;

-- 5 2004�� 2�б⿡ C3118100 ������ ������ �л����� ������ ��ȸ , ������ ���� �л����� ǥ�� , ������ ������ �й��� ���� �л����� ǥ��

SELECT      STUDENT_NO
        ,   POINT
FROM        TB_GRADE
WHERE       CLASS_NO = 'C3118100'
ORDER BY    POINT , STUDENT_NO ;

-- 6 �л� ��ȣ, �л� �̸�, �а� �̸��� �л� �̸����� �������� ����

SELECT      STUDENT_NO          AS "�л� ��ȣ"
        ,   STUDENT_NAME        AS "�л� �̸�"
        ,   DEPARTMENT_NAME     AS "�а� �̸�"
FROM        TB_DEPARTMENT D
JOIN        TB_STUDENT S ON(D.DEPARTMENT_NO = S.DEPARTMENT_NO) ;

-- 7 �� ������� ���� �̸��� ������ �а� �̸��� ���

SELECT      CLASS_NAME          AS "����"
        ,   DEPARTMENT_NAME     AS "�а�"
FROM        TB_DEPARTMENT D
JOIN        TB_CLASS C ON(D.DEPARTMENT_NO = C.DEPARTMENT_NO) ;

-- 8 ���� ���� �̸��� ã������ �Ѵ�. ���� �̸��� ���� �̸��� ����϶�


SELECT      CLASS_NAME          AS "����"
        ,   PROFESSOR_NAME      AS "����"
        ,   C. CLASS_NO
FROM        TB_CLASS            C
JOIN        TB_CLASS_PROFESSOR  CP ON(CP.CLASS_NO = C.CLASS_NO)
JOIN        TB_PROFESSOR        P  ON(P.PROFESSOR_NO = CP.PROFESSOR_NO)
ORDER BY    C.CLASS_NO ;


SELECT      CLASS_NAME          AS "����"
        ,   PROFESSOR_NAME      AS "����"
FROM        TB_PROFESSOR    P
JOIN        TB_DEPARTMENT   D ON(P.DEPARTMENT_NO = D.DEPARTMENT_NO)
JOIN        TB_CLASS        C ON(D.DEPARTMENT_NO = C.DEPARTMENT_NO) 
GROUP BY    CLASS_NAME , PROFESSOR_NAME
ORDER BY    "����" , "����" ;


SELECT  *
FROM    TB_CLASS ;
SELECT  *
FROM    TB_PROFESSOR 
ORDER BY professor_name;
SELECT  *
FROM    TB_CLASS_PROFESSOR 
ORDER BY professor_no;
SELECT  *
FROM    TB_DEPARTMENT ;
-- 9 8���� ��� �� �ι���ȸ �迭�� ���� ������ ���� �̸��� ã������ �Ѵ�. �ش��ϴ� ���� �̸��� ���� �̸��� ���

SELECT      CLASS_NAME          AS "����"
        ,   PROFESSOR_NAME      AS "����"
        ,   CATEGORY            AS "�迭"
FROM        TB_DEPARTMENT D
JOIN        TB_CLASS C ON(D.DEPARTMENT_NO = C.DEPARTMENT_NO) 
JOIN        TB_PROFESSOR P ON(D.DEPARTMENT_NO = P.DEPARTMENT_NO)
WHERE       CATEGORY = '�ι���ȸ'
ORDER BY    "����" ;

-- 10 �����а� �л����� ������ ���Ϸ����Ѵ�. �����а� �л����� �й� �̸� ��ü ������ ���

SELECT      S.STUDENT_NO            AS "�й�"
        ,   S.STUDENT_NAME          AS "�л� �̸�"
        ,   ROUND(AVG(G.POINT), 1)  AS "��ü ����"
FROM        TB_STUDENT      S
JOIN        TB_DEPARTMENT   D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
JOIN        TB_GRADE        G ON(S.STUDENT_NO = G.STUDENT_NO)
WHERE       DEPARTMENT_NAME = '�����а�' 
GROUP BY    S.STUDENT_NO , S.STUDENT_NAME ;

/* 11 �й��� A313047�� �л��� �б��� ������ ���� �ʴ�. ���� �������� ������ �����ϱ� ���� �а� �̸�
        �л� �̸��� ���� ���� �̸��� �ʿ��ϴ�
        �������� �а��̸� �л��̸� �������� �̸����� ��µǵ��� �Ѵ�. */
SELECT      DISTINCT 
            D.DEPARTMENT_NAME
        ,   S.STUDENT_NAME
        ,   P.PROFESSOR_NAME
FROM        TB_DEPARTMENT   D
JOIN        TB_STUDENT      S ON(D.DEPARTMENT_NO = S.DEPARTMENT_NO)
JOIN        TB_PROFESSOR    P ON(S.COACH_PROFESSOR_NO = P.PROFESSOR_NO)
WHERE       STUDENT_NO = 'A313047' ;

-- 12 2007�⵵�� �ΰ������ ������ ������ �л��� ã�� �л��̸��� ������ �б⸦ ǥ���ϼ���
-- GRADE , STUDENT , CLASS

SELECT      *
FROM        TB_GRADE ;

SELECT      S.STUDENT_NAME
        ,   G.TERM_NO
        ,   C.CLASS_NAME
FROM        TB_GRADE    G
JOIN        TB_STUDENT  S ON(G.STUDENT_NO = S.STUDENT_NO)
JOIN        TB_CLASS    C ON(G.CLASS_NO = C.CLASS_NO)
WHERE       G.TERM_NO LIKE '2007%' AND C.CLASS_NAME = '�ΰ������' ;

-- 13 ��ü�� �迭 ���� �� ���� ��米���� �� �� �������� ���� ������ ã�� �� ���� �̸��� �а� �̸��� ���
--    CLASS PROFESSOR DEPARTMENT


SELECT      D.DEPARTMENT_NAME     AS "�а� �̸�"
        ,   C.CLASS_NAME          AS "���� �̸�"
FROM        TB_CLASS            C
FULL JOIN   TB_CLASS_PROFESSOR  CP ON(C.CLASS_NO = CP.CLASS_NO)
FULL JOIN   TB_PROFESSOR        P  ON(CP.PROFESSOR_NO = P.PROFESSOR_NO) 
FULL JOIN   TB_DEPARTMENT       D  ON(D.DEPARTMENT_NO = C.DEPARTMENT_NO)
WHERE       D.CATEGORY = '��ü��' AND CP.PROFESSOR_NO IS NULL
ORDER BY 1;

SELECT      D.DEPARTMENT_NAME
        ,   C.CLASS_NAME
FROM        TB_DEPARTMENT       D 
JOIN        TB_CLASS            C  ON(D.DEPARTMENT_NO = C.DEPARTMENT_NO)
LEFT JOIN   TB_CLASS_PROFESSOR  CP ON(C.CLASS_NO = CP.CLASS_NO)
WHERE       CATEGORY = '��ü��' AND PROFESSOR_NO IS NULL
ORDER BY 1 , 2;

-- ERD�� �ڼ��� ���� �θ� �ڽ� ���踦 Ȯ���� ��

/* 14 �� ������б� ���ݾƾ��а� �л����� ���������� �Խ��ϰ��� ����. �л��̸���
�������� �̸��� ã�� ���� ���� ������ ���� �л��� ��� "�������� ������?����
ǥ���ϵ��� �ϴ� SQL ���� �ۼ��Ͻÿ�. ��, �������� ?�л��̸�?, ?��������?��
ǥ���ϸ� ���й� �л��� ���� ǥ�õǵ��� �Ѵ�. */


SELECT      S.STUDENT_NAME                                          AS "�л� �̸�"
        ,   NVL(P.PROFESSOR_NAME , '���� ���� ������')                AS "���� ����"
FROM        TB_STUDENT      S
JOIN        TB_DEPARTMENT   D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO) 
LEFT JOIN   TB_PROFESSOR    P ON(P.PROFESSOR_NO = S.COACH_PROFESSOR_NO) 
WHERE       D.DEPARTMENT_NAME = '���ݾƾ��а�' 
ORDER BY    STUDENT_NO ;


-- 15 ���л��� �ƴ� �л� �� ������ 4.0 �̻��� �л��� ã�� �л��� (�й� �̸� �а� �̸� ����)�� ���


SELECT      S.STUDENT_NO            AS "�й�"
        ,   S.STUDENT_NAME          AS "�̸�"
        ,   D.DEPARTMENT_NAME       AS "�а� �̸�"
        ,   V.GRADE_AVG             AS "����"
FROM        ( SELECT    ROUND(AVG(POINT) , 6) AS "GRADE_AVG"
                     ,  G.STUDENT_NO          AS "STUDENT_NU"
              FROM      TB_GRADE G
              JOIN      TB_STUDENT S ON (G.STUDENT_NO = S.STUDENT_NO)
              GROUP BY  G.STUDENT_NO ) V
JOIN        TB_STUDENT      S ON(V.STUDENT_NU = S.STUDENT_NO)
JOIN        TB_DEPARTMENT   D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE       GRADE_AVG >= 4.0 
AND         STUDENT_NU IN       (SELECT        STUDENT_NO
                                 FROM          TB_STUDENT
                                 WHERE         ABSENCE_YN = 'N')
ORDER BY S.STUDENT_NO ;


-- 16 ȯ�������а� ����������� ���� �� ������ �ľ��ϱ�

-- ���� �� ����

SELECT      ROUND(AVG(POINT) , 8)
        ,   G.CLASS_NO
        ,   G.STUDENT_NO
FROM        TB_GRADE G
JOIN        TB_CLASS C ON (G.CLASS_NO = C.CLASS_NO)
GROUP BY    G.STUDENT_NO , G.CLASS_NO ;

-- 16

SELECT      C.CLASS_NO                                AS "�����ȣ"
        ,   C.CLASS_NAME                              AS "�����̸�"
        ,   V.AVG_POINT                               AS "�������"
FROM        (
                    SELECT      ROUND(AVG(POINT) , 8) AS "AVG_POINT"
                            ,   G.CLASS_NO
                    FROM        TB_GRADE G
                    JOIN        TB_CLASS C ON (G.CLASS_NO = C.CLASS_NO)
                    GROUP BY    G.CLASS_NO 
            ) V
JOIN        TB_CLASS        C ON(V.CLASS_NO = C.CLASS_NO)
JOIN        TB_DEPARTMENT   D ON(C.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE       D.DEPARTMENT_NAME = 'ȯ�������а�' AND C.CLASS_TYPE = '��������'
ORDER BY    C.CLASS_NO ;


-- 17 �� ������б��� �ٴϰ��ִ� / �ְ��� �л��� / ���� �� �л� / ���� �̸��� �ּҸ� ���
SELECT      EMP_ID
        ,   EMP_NAME
FROM        EMPLOYEE
WHERE       JOB_ID =  ( SELECT JOB_ID
                        FROM   EMPLOYEE
                        WHERE  EMP_NAME = '���¿�') 
AND
            SALARY > ( SELECT  SALARY
                        FROM   EMPLOYEE
                        WHERE  EMP_NAME = '���¿�');
                        
-- �ְ��� �л��� ���� �� �л�

SELECT      D.DEPARTMENT_NO
FROM        TB_STUDENT S
JOIN        TB_DEPARTMENT D ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE       STUDENT_NAME = '�ְ���' ;

-- 17

SELECT      S.STUDENT_NAME
        ,   S.STUDENT_ADDRESS
FROM        TB_DEPARTMENT   D
JOIN        TB_STUDENT      S ON (D.DEPARTMENT_NO = S.DEPARTMENT_NO)
WHERE       D.DEPARTMENT_NO 
IN          (   SELECT      D.DEPARTMENT_NO
                FROM        TB_STUDENT S
                JOIN        TB_DEPARTMENT D ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
                WHERE       STUDENT_NAME = '�ְ���' 
            );

-- 18 ������а����� / �������� / ���� ���� �л� / �̸��� �й�

-- ������а�

SELECT      DEPARTMENT_NO
FROM        TB_DEPARTMENT
WHERE       DEPARTMENT_NAME = '������а�' ;

-- ������

SELECT      ROUND(AVG(POINT), 2)
        ,   STUDENT_NO
FROM        TB_GRADE
GROUP BY    STUDENT_NO 
ORDER BY    1 DESC;

SELECT      *
FROM        TB_STUDENT
WHERE       DEPARTMENT_NO =  '001';

-- �� 2�� ����

SELECT      *
FROM        TB_GRADE        G
JOIN        TB_STUDENT      S ON (G.STUDENT_NO = S.STUDENT_NO)
JOIN        TB_DEPARTMENT   D ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
;

-- 18�� �ش� ----------------------------------

SELECT      S.STUDENT_NAME
        ,   S.STUDENT_NO
        ,   AVG(G.POINT)
FROM        TB_GRADE        G
JOIN        TB_STUDENT      S ON (G.STUDENT_NO = S.STUDENT_NO)
JOIN        TB_DEPARTMENT   D ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE       D.DEPARTMENT_NO 
        IN 
            (   SELECT      DEPARTMENT_NO
                FROM        TB_DEPARTMENT
                WHERE       DEPARTMENT_NAME = '������а�' 
            )                  
GROUP BY    S.STUDENT_NAME , S.STUDENT_NO 
HAVING      AVG(G.POINT) 
        >= 
            (   SELECT      ROUND(MAX(AVG(G.POINT)) , 2)
                FROM        TB_GRADE        G
                JOIN        TB_STUDENT      S ON (G.STUDENT_NO = S.STUDENT_NO)
                JOIN        TB_DEPARTMENT   D ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
                WHERE       D.DEPARTMENT_NO 
                        IN 
                        (   SELECT      DEPARTMENT_NO
                            FROM        TB_DEPARTMENT
                            WHERE       DEPARTMENT_NAME = '������а�' )            
                GROUP BY    S.STUDENT_NO 
            )               
;

-----------------------------------------------
 
--���̺�� ������ ����?
 
SELECT      AVG(G.POINT)                                AS "AVG_POINT"
        ,   RANK() OVER(ORDER BY AVG(G.POINT) DESC)     AS "RANK"
        ,   S.STUDENT_NO                                AS "STUDEMT_NO"
FROM        TB_GRADE        G
JOIN        TB_STUDENT      S ON (G.STUDENT_NO = S.STUDENT_NO)
JOIN        TB_DEPARTMENT   D ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE       D.DEPARTMENT_NO 
        IN 
            (   SELECT      DEPARTMENT_NO
                FROM        TB_DEPARTMENT
                WHERE       DEPARTMENT_NAME = '������а�' )            
GROUP BY    S.STUDENT_NO ;

--------------------------------------------------

SELECT      STUDENT_NAME
        ,   STUDENT_NO
FROM        (
                SELECT      AVG(G.POINT)                                AS "AVG_POINT"
                        ,   RANK() OVER(ORDER BY AVG(G.POINT) DESC)     AS "RANK"
                        ,   S.STUDENT_NO                                AS "STUDENT_NO"
                        ,   S.STUDENT_NAME                              AS "STUDENT_NAME"
                FROM        TB_GRADE        G
                JOIN        TB_STUDENT      S ON (G.STUDENT_NO = S.STUDENT_NO)
                JOIN        TB_DEPARTMENT   D ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
                WHERE       D.DEPARTMENT_NO 
                        IN 
                            (   SELECT      DEPARTMENT_NO
                                FROM        TB_DEPARTMENT
                                WHERE       DEPARTMENT_NAME = '������а�' )           
                GROUP BY    S.STUDENT_NO , S.STUDENT_NAME 
            )          
WHERE       RANK = 1 ;

-- RANK() OVER(ORDER BY SALARY DESC) AS RANK 
--- 18
      
SELECT  S.STUDENT_NO,
        S.STUDENT_NAME
FROM    TB_STUDENT S
/*(SELECT      S.STUDENT_NO,
                    S.STUDENT_NAME
        FROM        TB_STUDENT    S
        JOIN        TB_GRADE      G ON (G.STUDENT_NO = S.STUDENT_NO)
        JOIN        TB_DEPARTMENT D ON (D.DEPARTMENT_NO = S.DEPARTMENT_NO)
        WHERE       DEPARTMENT_NAME = '������а�'
        GROUP BY    S.STUDENT_NO, S.STUDENT_NAME )  A 
        */
JOIN        TB_GRADE      G ON (G.STUDENT_NO = S.STUDENT_NO)
WHERE       DEPARTMENT_NO LIKE '001'
GROUP BY    S.STUDENT_NO, S.STUDENT_NAME 
HAVING      AVG(G.POINT) = ( SELECT     MAX(AVG(G.POINT))
                             FROM       TB_GRADE G
                             JOIN       TB_STUDENT S ON (S.STUDENT_NO = G.STUDENT_NO)
                             WHERE      S.DEPARTMENT_NO LIKE '001'
                             GROUP BY   S.STUDENT_NO );
               
-- 19  ȯ�������а� / ����  ���� �迭 �а� / �а��� �������� ���� /

SELECT      CATEGORY
FROM        TB_DEPARTMENT
WHERE       DEPARTMENT_NAME = 'ȯ�������а�' ;

-- ���� �迭 �а�

SELECT  *
FROM    TB_DEPARTMENT
WHERE   CATEGORY 
IN      (   SELECT      CATEGORY
            FROM        TB_DEPARTMENT
            WHERE       DEPARTMENT_NAME = 'ȯ�������а�'
         ) ;
         
-- �а���

SELECT      ROUND(AVG(POINT) , 1) AS "AVG"
FROM        TB_GRADE
GROUP BY    CLASS_NO ;

-- 

SELECT      DEPARTMENT_NAME             AS "�迭 �а���"
        ,   ROUND(AVG(G.POINT) , 1)     AS "��������"
FROM        TB_DEPARTMENT   D
JOIN        TB_CLASS        C ON (D.DEPARTMENT_NO = C.DEPARTMENT_NO)
JOIN        TB_GRADE        G ON (C.CLASS_NO = G.CLASS_NO)
WHERE   
            D.CATEGORY 
                        IN      (   
                                    SELECT      CATEGORY
                                    FROM        TB_DEPARTMENT
                                    WHERE       DEPARTMENT_NAME = 'ȯ�������а�'
                                ) 
AND     
            G.POINT 
                        IN      (   
                                    SELECT      ROUND(AVG(G.POINT) , 1) AS "AVG"
                                    FROM        TB_GRADE    G
                                    JOIN        TB_CLASS    C ON (G.CLASS_NO = C.CLASS_NO)
                                    WHERE       C.CLASS_TYPE LIKE '����%'
                                    GROUP BY    G.CLASS_NO 
                                )

GROUP BY    DEPARTMENT_NAME ;

