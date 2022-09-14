/*
SQL(Strurcture Query Languange)

�����ݷ��� ������ �������� ���

�˻� - SELECT
��������
1. SELECT * |(�Ǵ�) COLUMN_NAME | EXPRESSION
2. FROM     TABLE_NAME
3. WHERE    SEARCH_CONDITION

���� - UPDATE 
���� - DELETE
���� - INSERT
*/
SELECT *
FROM    EMPLOYEE;

SELECT *
FROM    JOB;

SELECT *
FROM SAL_GRADE;

SELECT SLEVEL
FROM SAL_GRADE;

SELECT SLEVEL AS "�޿����",
       LOWEST,
       HIGHEST
FROM SAL_GRADE;

SELECT *
FROM    EMPLOYEE
WHERE   MARRIAGE = 'N';

SELECT *
FROM    department ;

SELECT *
FROM    EMPLOYEE ;

SELECT *
FROM    LOCATION ;

SELECT *
FROM    COUNTRY ;

SELECT *
FROM    JOB ;

SELECT *
FROM    SAL_GRADE ;

-- �÷��� ���� ���� ǥ����
-- ���� Ȯ��?
SELECT EMP_NAME ,
       SALARY   ,
       SALARY * 12 AS "����" , -- AS�� ��Ī�̴�.
       (SALARY + (SALARY * BONUS_PCT)) * 12 AS "���ʽ�" --���ڿ��� Ư����ȣ�� ������ ��� "" �� ������Ѵ�.
FROM EMPLOYEE ;

-- 220819 --

-- �ߺ����� �� ������ ��� DISTINCT
-- SELECT���� DISTINCT �� �� ���� ��� ����

SELECT  DISTINCT JOB_ID, DEPT_ID
FROM    EMPLOYEE;


-- ���ͷ� ''(�̱� �����̼�)

SELECT  EMP_ID ,
        EMP_NAME ,
        '����' AS "�ٹ�����"
FROM    EMPLOYEE ;

-- WHERE : �࿡ ���� ����

SELECT  *
FROM    EMPLOYEE
WHERE   DEPT_ID = '90';

-- �޿��� 500�� �̻��� ����� ���

SELECT  *
FROM    EMPLOYEE
WHERE   SALARY >= 5000000; -- Į���� �����Ͱ� ���ڿ����� �������� Ȯ���� ��

-- �μ��ڵ尡 90�̰� �޿��� 200�� ���� ���� �޴� ����� �̸�, �μ� �ڵ�. �޿� ��ȸ

SELECT  DEPT_ID AS "�μ� �ڵ�" ,
        EMP_NAME AS "��� �̸�" ,
        SALARY AS "�޿�"
FROM    EMPLOYEE
WHERE   SALARY > 2000000 AND DEPT_ID = '90';

-- ������  ||(�÷��� �÷��� ������ ���)
SELECT  EMP_NAME||'�� �޿��� '||SALARY||'(��) �Դϴ�.' AS "INFO" -- ���� ������
FROM    EMPLOYEE;

-- ��������(TRUE / FALSE / NULL)
-- AND, OR, NOT
-- = , > , < , >= , <= , != , <> , ^=
-- BETWEEN AND , LIKE , NOT LIKE , IS NULL , IS NOT NULL , IN

-- �޿��� 350�� �̻� 550�� ������ ����� �̸��� �޿� ��ȸ
-- ���ǰ� ����� �� ������ ��
SELECT  EMP_NAME,
        SALARY
FROM    EMPLOYEE
WHERE   SALARY >= 3500000 AND SALARY <= 5500000;

SELECT  EMP_NAME,
        SALARY
FROM    EMPLOYEE
WHERE   SALARY BETWEEN 3500000 AND 5500000;

SELECT *
FROM EMPLOYEE ;

-- �达 ���� ���� ����� �̸��� �޿� ��ȸ
-- LIKE �����ڸ� �̿��� ���� �˻� %(0�� �̻��� ����) , _ (���� 1���� �ǹ�)
SELECT  EMP_NAME,
        SALARY
FROM    EMPLOYEE
WHERE   EMP_NAME LIKE '��%';

-- 9000���� 4�ڸ� ������ ��ȭ��ȣ�� ����ϴ� ����� ��ȭ��ȣ�� ��ȸ

SELECT  EMP_NAME,
        PHONE
FROM    EMPLOYEE
WHERE   PHONE LIKE '___9%' ;
        
-- NULL ���θ� ���ϴ� ������
SELECT  *
FROM    EMPLOYEE ;

-- ���ʽ��� ���� �ʴ� ����� ��� ������ ��ȸ
-- IS NULL

SELECT  *
FROM    EMPLOYEE
WHERE   BONUS_PCT IS NULL;

-- 60q�� �μ��� 90�� �μ������� �̸�, �μ� �ڵ�, �޿��� ��ȸ


SELECT  EMP_NAME,
        DEPT_ID,
        SALARY
FROM    EMPLOYEE
WHERE   DEPT_ID = '60' or DEPT_ID = '90' ;


SELECT  EMP_NAME,
        DEPT_ID,
        SALARY
FROM    EMPLOYEE
WHERE   DEPT_ID IN ( '60' , '90') ;


-- ������ �켱 ����


SELECT  EMP_NAME,
        SALARY,
        DEPT_ID
FROM    EMPLOYEE
WHERE   (DEPT_ID IN( '20' , '90')) AND SALARY > 3000000;

-- ������ �켱 ������ �����ϳ� () �Ұ�ȣ�� ������������� �ܿ��� �ʾƵ� ������.


-- 1

SELECT  DEPARTMENT_NAME AS "�а� ��",
        CATEGORY AS "�迭"
FROM    TB_DEPARTMENT ;


-- 2

SELECT  DEPARTMENT_NAME||'�� ������ '||CAPACITY||'�� �Դϴ�.'
FROM    TB_DEPARTMENT ;
        
 
-- 3

SELECT  DEPARTMENT_NAME,
        DEPARTMENT_NO
FROM    TB_DEPARTMENT
WHERE   DEPARTMENT_NAME LIKE '����%' ;

SELECT  STUDENT_NAME
FROM    TB_STUDENT
WHERE   ABSENCE_YN = 'Y' AND DEPARTMENT_NO = '001' AND STUDENT_SSN LIKE '%-2%';


-- 4


SELECT  STUDENT_NAME
FROM    TB_STUDENT
WHERE   STUDENT_NO IN ( 'A513079', 'A513090', 'A513091', 'A513110', 'A513119');


-- 5

SELECT  DEPARTMENT_NAME,
        CATEGORY
FROM    TB_DEPARTMENT
WHERE   CAPACITY BETWEEN 20 AND 30;


-- 6

SELECT  PROFESSOR_NAME
FROM    TB_PROFESSOR
WHERE   DEPARTMENT_NO IS NULL;

-- 7


SELECT  STUDENT_NAME
FROM    TB_STUDENT
WHERE   DEPARTMENT_NO IS NULL;


-- 8

SELECT  CLASS_NO
FROM    TB_CLASS
WHERE   PREATTENDING_CLASS_NO IS NOT NULL;


-- 9

SELECT  DISTINCT CATEGORY
FROM    TB_DEPARTMENT ;

-- 10

SELECT  STUDENT_NO,
        STUDENT_NAME,
        STUDENT_SSN
FROM    TB_STUDENT
WHERE   STUDENT_ADDRESS LIKE '����%' AND ABSENCE_YN = 'N' AND ( ENTRANCE_DATE LIKE '02/%/%' );





/* 

�Լ� : ����, ����, ��¥
���� : ������, �׷�

��� �Լ��� ����� ���̳�?
- SELECT, WHERE
FROM�� TABLE�� ���� ������ ��� �Ұ�.

���ڿ� �Լ�
 1. LENGTH(): ���ڿ� ���̸� ��ȯ
 2. INSTR(): ã�� ���ڿ��� ������ ��ġ���� ������ Ƚ����ŭ ��Ÿ�� ���� ��ġ�� ��ȯ
    (index string)
 3. LPAD() , RPAD() : ���ڿ��� ������ ������ ���ڷ� ���ٿ� ��ȯ�ϴ� �Լ� 
 4. SUBSTR(���ڿ� , ���� , ����) : ���ڿ����� ������ ��ġ���� ������ ������ŭ �߶󳻼� ��ȯ
 5. ROUND (���� , ǥ���� �Ҽ���) : �ڸ������� �ݿø�
 6. TRUNC () : �ڸ������� ����
 7. SYSDATE : ���� ��¥ ��ȯ
 8. ADD_MONTHS(��¥ , +-�� ����) : �� ���
 9. MONTHS_BETWEEN(��¥ , ��¥) : Ư�� ��¥ ������ ���� ��
*/

-- LENGTH()

SELECT  EMAIL,
        LENGTH(EMAIL)
FROM    EMPLOYEE ;

-- INSTR(���ڿ�, ã�� ����, ��ġ, �ݺ� Ƚ��) 

SELECT  EMAIL,
        INSTR(EMAIL, 'c') ,
        INSTR(EMAIL, 'c', -1) ,
        INSTR(EMAIL, 'c', -1, 2) ,
        INSTR(EMAIL, 'c', INSTR(EMAIL , '.')-1) -- . ���� c�� ��ġ ��ȯ
FROM    EMPLOYEE ;


-- LPAD() , RPAD() : ���ڿ��� ������ ������ ���ڷ� ���ٿ� ��ȯ�ϴ� �Լ�

SELECT  EMAIL ,
        LPAD(EMAIL, 20, '.') ,
        RPAD(EMAIL, 20, '.')
FROM    EMPLOYEE ;

-- LTRIM() , RTRIM(), TRIM() : ���ڿ��� ����(Ȥ�� Ư�� ����)�� �����ϰ� ��ȯ�ϴ� �Լ�

SELECT  LENGTH('    TECH') ,
        LTRIM('    TECH') , -- ������ ������
        LENGTH(LTRIM('    TECH')) -- ������ ������ ��, ���� 4���� ���̸� ��ȯ
FROM    DUAL ;

SELECT  LTRIM('000123' , '0')
FROM    DUAL ;

SELECT  LTRIM('xxxyyyxzzzTRIM' , 'xyz')
FROM    DUAL ;

SELECT  TRIM('    TECH    ') ,
        LENGTH(TRIM('    TECH    '))
FROM    DUAL ;

-- (�߿�) SUBSTR(���ڿ�, ����, ����) : ���ڿ����� ������ ��ġ���� ������ ������ŭ �߶󳻼� ��ȯ 

SELECT  SUBSTR('THIS IS A TEST' , 6) , -- 6��° �ε��� ���� ���ڸ� ������
        SUBSTR('THIS IS A TEST' , 6 , 2) , -- 6��° ���� 2����
        SUBSTR('THIS IS A TEST', -4 , 4) -- �ڿ��� 4��°����(��4���� ����) 4����
FROM    DUAL ;

-- ����� �̸��� �� ���̵� ����Ѵ�

SELECT  SUBSTR(EMAIL , 1 , INSTR(EMAIL,'@')-1) -- @�� ��ġ�� ã��, ��ġ-1 ���� ��ġ���� SUBSTR�� �־� @�� email�� ����Ѵ�.
FROM    EMPLOYEE ;


-- ���� �Լ�
-- ROUND () : �ڸ������� �ݿø� TRUNC () : �ڸ������� ����

SELECT  ROUND(125.331, 0) ,
        ROUND(125.531, 1) ,
        ROUND(125.531, -1)
FROM    DUAL ;


SELECT  TRUNC(125.331, 0) ,
        TRUNC(125.531, 1) ,
        TRUNC(125.531, -1)
FROM    DUAL ;

-- ��¥ �Լ�

SELECT  HIRE_DATE ,
        SUBSTR(HIRE_DATE , 1, 2)||'�� '||
        SUBSTR(HIRE_DATE , 4, 2)||'�� '||
        SUBSTR(HIRE_DATE , 7, 2)||'��'
FROM    EMPLOYEE ;

-- SYSDATE : ���� ��¥ ��ȯ
-- ADD_MONTHS(��¥, +-�� ����) : �� ���

SELECT  SYSDATE ,
        SYSDATE + 1 ,
        ADD_MONTHS(SYSDATE , 1)
        
FROM    DUAL ;

-- ���� ��¥�� �������� �Ի����� 20���� �Ѵ� ������ �ٹ��� �� ��ȸ

SELECT  EMP_NAME ,
        MONTHS_BETWEEN('00/01/01', '99/12/15')
FROM    EMPLOYEE ;

SELECT  EMP_NAME ,
        TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) AS "�ٹ����"
FROM    EMPLOYEE 
WHERE   MONTHS_BETWEEN(SYSDATE, HIRE_DATE) > 240 ;


SELECT  SYSDATE + (INTERVAL '2' YEAR) ,
        SYSDATE + (INTERVAL '2' MONTH)
FROM    DUAL ;


-- Ÿ�� ��ȯ �Լ�
-- TO_NUMBER() , TO_CHAR() , TO_DATE()

SELECT  *
FROM    EMPLOYEE
WHERE   DEPT_ID = 90; -- ������ ������ ��� ���

SELECT  TO_CHAR(1234) + '5' ,       -- ���ڰ� �� , �����̹Ƿ� '' ���
        TO_NUMBER('1234') + 5 ,     -- ���ڰ� �� , �����̹Ƿ� '' ��� x
        TO_CHAR(SYSDATE, 'MM / DD / YYYY / HH:MI:SS , YEAR , Q ')            
        -- ��¥ ���� TO_CHAR MM DD YY HH MI SS ��
FROM    DUAL ;


SELECT  HIRE_DATE ,
        TO_CHAR(HIRE_DATE , 'YYYY-MM-DD') --20, 21���� ǥ���� ������ ����
FROM    EMPLOYEE ;

SELECT  SYSDATE ,
        '95/08/19' , -- ������ ��¥ ���� ������ �߰�
        TO_CHAR(TO_DATE('95/08/19' , 'YY/MM/DD') , 'YYYY/MM/DD') AS "DATE", -- 2095���� �Ǵ� ������ �����.
        TO_CHAR(TO_DATE('95/08/19' , 'RR/MM/DD') , 'RRRR/MM/DD') AS "DATE" -- ��¥�� ��ȯ�� �� ���� �����̼��� RR�� �ԷµǸ� ���� ����� ����������.
FROM    DUAL ;
