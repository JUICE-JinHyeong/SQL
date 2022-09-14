SELECT  *
FROM    EMPLOYEE ;

SELECT  EMP_NAME
FROM    EMPLOYEE ;

SELECT  EMP_NAME AS "����"
FROM    EMPLOYEE ; 

SELECT  EMP_NAME
FROM    EMPLOYEE
WHERE   MARRIAGE = 'N' ;

SELECT  DISTINCT JOB_ID
FROM    EMPLOYEE ;


SELECT  EMP_NAME    AS "�̸�"        ,
        SALARY      AS "�޿�"        ,
        SALARY * 12 AS "����"     
FROM    EMPLOYEE ;

SELECT  EMP_NAME AS "�̸�"        ,
        SALARY AS "�޿�"          ,
        SALARY * 12 AS "����"     ,
        (SALARY + (SALARY * BONUS_PCT)) * 12 AS "���ʽ�"
FROM    EMPLOYEE
WHERE   BONUS_PCT IS NOT NULL ;


-- �޿��� 4�鸸 �̻��� ������� ��ȯ
SELECT  EMP_NAME    ,
        SALARY      
FROM    EMPLOYEE
WHERE   SALARY  >= 4000000 ;


-- �޿��� 300�� �̻�, 5�鸸 ������ ������� ��ȯ
SELECT  EMP_NAME    ,
        SALARY      
FROM    EMPLOYEE
WHERE   SALARY BETWEEN 3000000 AND 5000000 ;

-- �达 ���� ���� ���� ��ȸ
SELECT  EMP_NAME
FROM    EMPLOYEE
WHERE   EMP_NAME LIKE ('��%') ;

-- 9000���� 4�ڸ� ������ ��ȭ��ȣ�� ����ϴ� ����� ��ȭ��ȣ�� ��ȸ
SELECT  EMP_NAME    ,
        PHONE
FROM    EMPLOYEE
WHERE   PHONE LIKE ('___9%') ; -- '_' �� �տ� 3�� ����Ǿ� 3���ڰ� ���´ٴ� ���� �ǹ�
  
  
-- ���ʽ��� ���� ����� ��ȸ
SELECT  EMP_NAME
FROM    EMPLOYEE
WHERE   BONUS_PCT IS NULL ;


-- ���ʽ��� �ִ� ������� ���� �� �̸� ��ȸ
SELECT  EMP_NAME AS "�̸�"        ,
        SALARY AS "�޿�"          ,
        SALARY * 12 AS "����"     ,
        (SALARY + (SALARY * BONUS_PCT)) * 12 AS "���ʽ�"
FROM    EMPLOYEE
WHERE   BONUS_PCT IS NOT NULL ;

-- 60�� �μ��� 90�� �μ������� �̸�, �μ��ڵ�, �޿��� ��ȸ
SELECT  EMP_NAME    ,  
        DEPT_ID     ,
        SALARY
FROM    EMPLOYEE
WHERE   DEPT_ID IN ('60' , '90') ;


-- �Լ� LENGTH
SELECT  LENGTH('ABCDEF') 
FROM    DUAL ;

-- �Լ� INSTER
SELECT  INSTR('ORANGE GAME' , 'G' , 1,2) AS "INSTR"
-- ORANGE GAME ���ڿ��� 2��° G ��ġ�� ��ȯ�Ѵ�.
FROM DUAL ;

-- �Լ� LPAD, RPAD(���ڿ�, ���� ��, ���鿡 ���� ����)
SELECT  LPAD('ALPHA', 15, '1234 ') , -- ���� ������ ���ڿ��� ���̰� ���Եȴ�.
        LPAD('ALPHA', 1, '1234 ')  ,
        RPAD('ALPHA', 15, '1234 ')
FROM    DUAL ;

-- �Լ� LTRIM, RTRIM, TRIM
SELECT  LTRIM('    ALPHA')      AS "1",     -- ���� ���� ����
        LTRIM('AAAAALPHA', 'A') AS "2",     -- ���� A ����
        RTRIM('ALPHA    ')      AS "3",     -- ���� ���� ����
        RTRIM('ALPHAAAAA', 'A') AS "4",     -- ���� A ����
        TRIM('    ALPHA    ')   AS "5"      -- ���� ���� ����
FROM    DUAL ;

-- �Լ� SUBSTR
SELECT  SUBSTR('MY NAME IS ALPHA', 1, 7)    AS "1" ,    -- ù��° ���ڿ����� 7��°���� ��ȯ 
        SUBSTR('MY NAME IS ALPHA', 4, 4)    AS "2" ,    -- 4��° ���ڿ����� 4��°���� ��ȯ
        SUBSTR('MY NAME IS ALPHA', -2, 1)   AS "3"      -- �������� 2��° ���ڿ����� �� ù��° ���ڿ� ��ȯ
FROM    DUAL ;

-- ���� EMPLOYEE TABLE�� ������ ������� �̸��� @ �� �κи� ��ȯ
SELECT  EMP_NAME    ,
        EMAIL       ,
        SUBSTR(EMAIL , 1, INSTR(EMAIL, '@') -1)     -- INSTR�� ����Ͽ� @�κ��� ��ġ�� ��ȯ�ϰ� -1�� ���־� @ ���� ��ġ�� ��ȯ�Ѵ�.
FROM    EMPLOYEE ;                                  -- �׷��Ƿ� SUBSTR�� ������ 1(ù����)���� @���� ���� ������ ������ ���̴�.

-- ROUND
SELECT  ROUND(1.56789, 3)
FROM    DUAL ;

-- TRUNC
SELECT  TRUNC(1.56789, 3)
FROM    DUAL ;

-- SYSDATE
SELECT  SYSDATE
FROM    DUAL ;

-- MONTHS_BETWEEN()
SELECT  MONTHS_BETWEEN(SYSDATE, '2020/12/24') 
FROM    DUAL ;


SELECT  EMP_NAME    AS "��� �̸�" ,
        HIRE_DATE   AS "�Ի� ��"   ,
        TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12 ) AS "�ٹ���" -- ���� �⵵�� 2������ ��� ���� �������� ������ �߻��Ѵ�. 20����� 21���� ����
FROM    EMPLOYEE ;


SELECT  TO_CHAR(1234) + '5'       AS "1" , -- ���ڰ� �� , �����̹Ƿ� '' ���
        TO_NUMBER('1234') + 5     AS "2" , -- ���ڰ� �� , �����̹Ƿ� '' ��� x
        TO_CHAR(SYSDATE, 'MM / DD / YYYY / HH:MI:SS , YEAR , Q ')   AS "3"            
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