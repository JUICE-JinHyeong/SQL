-- sql 2����


-- �ֿ��� ������ �Լ�

-- NULL�� ������ ������ ��ȯ�ϴ� �Լ� : NVL(), NVL2(A, B, C) - A�� NULL �� �ƴ϶�� B��, NULL�̶�� C

SELECT  *
FROM    EMPLOYEE ;


SELECT  EMP_NAME    ,
        SALARY      ,
        NVL(BONUS_PCT , 0) AS "BONUS"
FROM    EMPLOYEE ;


SELECT  EMP_NAME    ,
        SALARY      ,
        SALARY * 12 AS "����" ,
        (SALARY + (SALARY * NVL(BONUS_PCT, 1))) * 12 AS "���ʽ� ����"
FROM    EMPLOYEE ;

-- DECODE() : IF ~ ELSE ���� ���������� ����
-- DECODE(EXRP, SEARCH, RESULT, [SEARCH , RESULT] , DEFALUT)
-- �μ���ȣ�� 50��ȣ�� ����� �̸�, �ֹι�ȣ, ���� ��ȸ

SELECT  EMP_NAME    ,
        EMP_NO      ,
        DECODE(SUBSTR(EMP_NO , 8 ,1) , '1' , '����', '2' , '����', '����') AS ����
FROM    EMPLOYEE    
WHERE   DEPT_ID = 50;


SELECT  EMP_ID      ,
        EMP_NAME    
FROM    EMPLOYEE
WHERE   JOB_ID  = 'J4';     -- ���̺� �����Ͱ� ��/�� �������� ������ ��

SELECT  EMP_ID      ,
        EMP_NAME    ,
        NVL(MGR_ID , '������') AS "��� ��ȣ" ,
        DECODE(MGR_ID , NULL , '������' , MGR_ID) AS "��� ��ȣ" ,
        DECODE(MGR_ID , NULL , '������' , MGR_ID) AS "��� ��ȣ" 
FROM    EMPLOYEE
WHERE   JOB_ID  = 'J4';     

-- ������� ����(JOB_ID)�� Ȯ���ؼ� ������ J6 �̸� �޿��� 20% �λ� J7 �̸� �޿��� 15% �λ� \
-- ����̸�, ����, �޿�, �λ�� �޿��� ��ȸ

                
SELECT  EMP_NAME AS "��� �̸�" ,
        JOB_ID  AS "����" ,
        SALARY  AS "�� �޿�" ,
        DECODE(
        JOB_ID , 
        'J6' , SALARY * 1.2 , 
        'J7' , SALARY * 1.15 , 
        SALARY) AS "�λ� �޿�"
FROM    EMPLOYEE ;


-- CASE (���ڰ� ����.)
/* ���� 
    CASE EXPR WHEN SEARCH THEN RESULT 
    [WHEN SEATCH THEN RESULT] 
    ELSE DEFAULT END 
*/

-- ���� CASE ���� ������ ','�� ������� �ʴ´�.
SELECT  EMP_NAME AS "��� �̸�" ,
        JOB_ID  AS "����" ,
        SALARY  AS "�� �޿�" ,
        CASE    JOB_ID 
                WHEN 'J6' THEN SALARY * 1.2
                WHEN 'J7' THEN SALARY * 1.15
                ELSE SALARY
        END AS "�λ� �޿�"
FROM    EMPLOYEE ;

-- �޿��� ����� ����

SELECT  EMP_ID      ,
        EMP_NAME    ,
        SALARY      ,
        CASE WHEN SALARY <= 3000000 THEN '�ʱ�'
             WHEN SALARY <= 4000000 THEN '�߱�'
             ELSE '���' 
        END AS "�޿� ���"
FROM    EMPLOYEE ;

-- �׷��Լ� (SUM , AVG , MIN , MAX , COUNT)

SELECT  SUM(SALARY)             AS "�޿� ����" ,
        TRUNC(AVG(SALARY))      AS "�޿� ���" , 
        MIN(SALARY)             AS "�ּ� �޿�" ,
        MAX(SALARY)             AS "�ִ� �޿�" ,
        COUNT(BONUS_PCT)        AS "���ʽ� �޴� ��� ��" , 
        COUNT(*)                AS "��� ��" ,
        MIN(JOB_ID)
FROM    EMPLOYEE ;

-- �׷��� ����� ������� �׷쿡 ���踦 �ؾ��� ��찡 �߻�
/* GROUP BY�� �߰�
 GROUP BY ������ �ɸ���.
  1. SELECT ���� �Ϲ��÷��� ����� �� ����.
  2. GROUP BY�� ���� Į���� SELECT���� ����� �����Ѵ�.
  3. ��Ī�� �׷��� �������� ����� �� ����.
*/
-- �μ��� �޿� ����� Ȯ���ϰ� �ʹٸ�?

SELECT  AVG(SALARY)
FROM    EMPLOYEE
GROUP BY DEPT_ID ;  

-- ������ ���� �޿� ���

SELECT  TRUNC(AVG(SALARY)) ,
        CASE SUBSTR(EMP_NO , 8 , 1) 
              WHEN '1' THEN '����'
              WHEN '2' THEN '����'
              ELSE '����'
         END 
FROM    EMPLOYEE
GROUP BY CASE SUBSTR(EMP_NO , 8 , 1) 
              WHEN '1' THEN '����'
              WHEN '2' THEN '����'
              ELSE '����'
         END ;
        
        
-- �׷쿡 ���� ������ �ʿ�� �Ѵٸ�?
-- HAVING ��

SELECT  DEPT_ID ,
        SUM(SALARY) 
FROM    EMPLOYEE
GROUP BY DEPT_ID 
HAVING  SUM(SALARY) > 9000000 ; 
-- �׷��� ������� ���¿��� WHEREó�� ������ �־���� ��� HAVING�� ����Ѵ�.


-- �ּұ޿��� �޴� ����� �̸� �޿� ������ ��ȸ�Ѵٸ�?
SELECT  EMP_NAME ,
        SALARY   ,
        JOB_ID
FROM    EMPLOYEE
WHERE   SALARY = (SELECT MIN(SALARY)
                  FROM   EMPLOYEE) ;
                  
                  

-- ����

SELECT  *
FROM    EMPLOYEE 
ORDER BY DEPT_ID DESC , HIRE_DATE DESC;


SELECT  EMP_NAME    AS "�̸�"    ,
        HIRE_DATE   AS "�λ���"  ,
        DEPT_ID     AS "�μ��ڵ�"
FROM    EMPLOYEE 
ORDER BY 3 , "�̸�" ; -- Į�� ��� AS�� INDEX(SELECT�� ��õ� Į�� ����)�� ��� ��� �����ϴ�.


-- 1
SELECT  STUDENT_SSN AS "�й�" ,
        STUDENT_NAME AS "�̸�" ,
        TO_CHAR(TO_DATE(ENTRANCE_DATE , 'RR/MM/DD' ) , 'RRRR/MM/DD') AS "���г⵵"
FROM    TB_STUDENT 
WHERE   DEPARTMENT_NO = '002' 
ORDER BY ENTRANCE_DATE ;

-- 2
SELECT  PROFESSOR_NAME ,
        PROFESSOR_SSN
FROM    TB_PROFESSOR 
WHERE   LENGTH(PROFESSOR_NAME) < 3 OR LENGTH(PROFESSOR_NAME) > 3;

-- 3
SELECT  PROFESSOR_NAME AS "���� �̸�" ,
        TO_CHAR(SYSDATE , 'YYYY') - LPAD(SUBSTR(PROFESSOR_SSN , 1 , 2) , 4 , '19') AS "����"
        -- 19||SUBSTR(PROFESSOR_SSN , 1 , 2)
FROM    TB_PROFESSOR 
WHERE   SUBSTR(PROFESSOR_SSN , 8 , 1) = 1
ORDER BY "����" ;

-- 4

SELECT  SUBSTR(PROFESSOR_NAME , 2 , 2) AS "�̸�" 
FROM    TB_PROFESSOR ;

-- 5

SELECT  STUDENT_NO ,
        STUDENT_NAME 
FROM    TB_STUDENT 
WHERE   TO_CHAR(TO_DATE(ENTRANCE_DATE , 'RR/MM/DD' ) , 'RRRR') -
        LPAD(SUBSTR(STUDENT_SSN , 1 , 2) , 4 , '19') = 20
ORDER BY STUDENT_NAME ;

-- 6

SELECT  TO_CHAR(TO_DATE('20/12/25' , 'RR/MM/DD') , 'RR/MM/DD(DAY)') AS "ũ�������� ����"
FROM    DUAL ;


-- 7

SELECT  TO_CHAR(TO_DATE('99/10/11' , 'YY/MM/DD'), 'YYYY/MM/DD') AS "1",
        TO_CHAR(TO_DATE('49/10/11' , 'YY/MM/DD'), 'YYYY/MM/DD') AS "2",
        TO_CHAR(TO_DATE('99/10/11' , 'RR/MM/DD'), 'RRRR/MM/DD') AS "3",
        TO_CHAR(TO_DATE('49/10/11' , 'RR/MM/DD'), 'RRRR/MM/DD') AS "4"
FROM    DUAL ;


-- 8

SELECT  STUDENT_NO ,
        STUDENT_NAME
FROM    TB_STUDENT 
WHERE   SUBSTR(STUDENT_NO , 1 , 1) != 'A';


-- 9
SELECT  STUDENT_NO ,
        STUDENT_NAME
FROM    TB_STUDENT 
WHERE   STUDENT_NAME = '�ѾƸ�' ; 

-- �ѾƸ� A517178

SELECT  ROUND(SUM(POINT) / 8 , 1) AS "����"
FROM    TB_GRADE 
GROUP BY STUDENT_NO
HAVING STUDENT_NO = 'A517178'
ORDER BY STUDENT_NO ;

-- 10


SELECT  DEPARTMENT_NO AS "�а���ȣ" ,
        COUNT(STUDENT_NAME) AS "�л� ��(��)"         
FROM    TB_STUDENT 
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO ;
HAVING  COACH_PROFESSOR_NO = NULL 

-- 11

SELECT  COUNT(*) 
FROM    TB_STUDENT 
GROUP BY COACH_PROFESSOR_NO
HAVING  COACH_PROFESSOR_NO IS NULL ;

-- 12


SELECT  *
FROM    TB_GRADE 
WHERE   STUDENT_NO = 'A112113'
ORDER BY CLASS_NO;

SELECT  STUDENT_NAME ,
        STUDENT_NO 
FROM    TB_STUDENT
WHERE   STUDENT_NAME = '����' ;

-- ���� A112113

SELECT  LPAD(TERM_NO , 4)               AS "�⵵" ,
        ROUND(SUM(POINT) / COUNT(POINT) , 1)       AS "����" -- AVG(POINT)�� ��ü ����
FROM    TB_GRADE 
WHERE   STUDENT_NO = 'A112113' 
GROUP BY LPAD(TERM_NO , 4) 
ORDER BY LPAD(TERM_NO , 4);


-- 13 
-- SUM�� COUNT�� ����

SELECT  DEPARTMENT_NO AS "�а��ڵ��",
        SUM(CASE WHEN ABSENCE_YN = 'Y' THEN 1 ELSE 0 END) AS "���л� ��"   
FROM    TB_STUDENT
GROUP BY DEPARTMENT_NO 
ORDER BY DEPARTMENT_NO ;


-- 14

SELECT  STUDENT_NAME AS "���� �̸�" ,
        COUNT(STUDENT_NAME) AS "������ ��"
FROM    TB_STUDENT
GROUP BY STUDENT_NAME
HAVING  COUNT(STUDENT_NAME) = 2 ;


-- 15 ROLLUP()

SELECT      SUBSTR(TERM_NO , 1 , 4) AS "�⵵" ,
            SUBSTR(TERM_NO , 5 , 2) AS "�б�" ,
            ROUND(AVG(POINT), 1)    AS "����"
FROM        TB_GRADE
WHERE       STUDENT_NO = 'A112113'
GROUP BY    ROLLUP(SUBSTR(TERM_NO , 1 , 4) , SUBSTR(TERM_NO , 5 , 2))
HAVING      ROLLUP(SUBSTR(TERM_NO , 1 , 4) , SUBSTR(TERM_NO , 5 , 2)) 
ORDER BY    1 , 2 ;

SELECT      SUBSTR(TERM_NO , 1 , 4) AS "�⵵" ,
            SUBSTR(TERM_NO , 5 , 2) AS "�б�" ,
            ROUND(AVG(POINT), 1)    AS "����"
FROM        TB_GRADE
WHERE       STUDENT_NO = 'A112113'
GROUP BY    ROLLUP(SUBSTR(TERM_NO , 1 , 4) , SUBSTR(TERM_NO , 5 , 2))
HAVING      ROLLUP(SUBSTR(TERM_NO , 1 , 4) , SUBSTR(TERM_NO , 5 , 2)) 
ORDER BY    1 , 2 ;




SELECT      SUBSTR(TERM_NO , 1 , 4) AS "�⵵" ,
            SUBSTR(TERM_NO , 5 , 2) AS "�б�" ,
            ROUND(AVG(POINT), 1)    AS "����"
FROM        TB_GRADE
WHERE       STUDENT_NO = 'A112113'
GROUP BY    ROLLUP(SUBSTR(TERM_NO , 1 , 4) , SUBSTR(TERM_NO , 5 , 2))
;












