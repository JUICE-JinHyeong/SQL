-- SET , SUBQUERY
-- SET  - OPERATER : �� �� �̻��� ���� ����� �ϳ��� ���ս�Ű�� ������
-- UNION , UNION ALL , INTERSECT , MINUS
-- ��� : SELECT ����� �ݵ�� ���� (�÷� ����, ������ Ÿ��)

SELECT      EMP_ID
        ,   ROLE_NAME
FROM        EMPLOYEE_ROLE 
MINUS
SELECT      EMP_ID
        ,   ROLE_NAME
FROM        ROLE_HISTORY ;


-- �μ� ��ȣ�� 20���� ����� �̸� , ���� ���̵� , �Ի��� ��ȸ
-- �μ� ��ȣ�� 20���� �μ� �̸� , �μ� ���̵� ��ȸ


SELECT      E.EMP_NAME
        ,   E.JOB_ID
        ,   HIRE_DATE
FROM        EMPLOYEE E 
WHERE       DEPT_ID = '20' 
UNION
SELECT      D.DEPT_NAME     -- ������ Ÿ���� ���Ͽ°� ���� ���ƾ��Ѵ�. Į���� ������ ���ƾ��Ѵ�.
        ,   D.DEPT_ID
        ,   NULL            -- Į���� ������ �������� �ʾ� ������ ���Ƿ� ���� �� NULL�� �־��ش�.
FROM        DEPARTMENT D
WHERE       DEPT_ID = '20' ;


-- 50�� �μ��� ��� ������ ��� ���̵�� �̸� ��ȸ

-- UNION ������ �̿��Ͽ� 50�� �μ��� �μ����� �����ڿ� �������� �����Ͽ� ��ȸ�϶�

SELECT      EMP_ID
        ,   EMP_NAME
        ,   '������'
FROM        EMPLOYEE
WHERE       DEPT_ID = '50' AND EMP_ID = '141'
UNION
SELECT      EMP_ID
        ,   EMP_NAME
        ,   '����'
FROM        EMPLOYEE
WHERE       DEPT_ID = '50' AND EMP_ID != '141' ;


-- ������ �븮�� ����� ������ ����� ����� �̸� , ������ ��ȸ

SELECT  *
FROM    JOB ;
SELECT  *
FROM    EMPLOYEE 
ORDER BY JOB_ID;

SELECT      J.JOB_TITLE
        ,   E.EMP_NAME
FROM        JOB J
JOIN        EMPLOYEE E ON (J.JOB_ID = E.JOB_ID)
WHERE       J.JOB_TITLE = '�븮' 
UNION
SELECT      J.JOB_TITLE
        ,   E.EMP_NAME
FROM        JOB J
JOIN        EMPLOYEE E ON (J.JOB_ID = E.JOB_ID)
WHERE       J.JOB_TITLE = '���' ;



-- SRBQUERY : �ϳ��� ������ �ٸ� ������ ���ԵǴ� ����
-- ���� ����, �ܺ� ����
-- ������������ ����� ���� ��ȯ�ϴ� ����
-- SELECT(��Į��) , FROM(�ζ���) , WHERE(�ߺ�) �� ���ο� ����� �� �ִ�.   


-- ���¿��̶�� ����� ���� �μ���


SELECT      EMP_ID
        ,   EMP_NAME
FROM        EMPLOYEE
WHERE       DEPT_ID = ( SELECT DEPT_ID
                        FROM   EMPLOYEE
                        WHERE  EMP_NAME = '���¿�');
                        
                        
                        

-- SUBQUERY ���� ( ���� �� �������� , ���� �� ��������)
-- ������ ���� ����� �� �ִ� �����ڰ� �޶�����.
-- ���� �� ���� ���� ( IN , ALL , ANY )



-- ���¿��� ���ް� �����ϸ� ���¿����� ���� �޿��� �޴� ��� ����

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
                        
                        
-- �ּ� �޿��� �޴� ����� �̸�, ���� , �޿�

SELECT      E.EMP_NAME
        ,   J.JOB_TITLE
        ,   E.SALARY
FROM        JOB         J 
JOIN        EMPLOYEE    E ON(J.JOB_ID = E.JOB_ID)
WHERE       SALARY = (SELECT MIN(SALARY)
                      FROM   EMPLOYEE) ;
                      
                      

-- �μ��� �޿� ���� ��ȸ, �μ��� �̸� �޿� ���� 
-- �޿� ������ ���� ���� �μ� ��� 

SELECT      D.DEPT_NAME     
        ,   SUM(E.SALARY)
FROM        EMPLOYEE        E
JOIN        JOB             J ON (E.JOB_ID = J.JOB_ID)
JOIN        DEPARTMENT      D ON (E.DEPT_ID = D.DEPT_ID) 
GROUP BY    D.DEPT_NAME ;


SELECT      D.DEPT_NAME     
        ,   SUM(E.SALARY)  -- �� ���� ������ �ش�. ����  : where , having �׷��̹Ƿ� having�� ����
FROM        EMPLOYEE        E
JOIN        JOB             J ON (E.JOB_ID = J.JOB_ID)
JOIN        DEPARTMENT      D ON (E.DEPT_ID = D.DEPT_ID) 
GROUP BY    D.DEPT_NAME 
HAVING      SUM(E.SALARY) = (SELECT MAX(SUM(SALARY))
                             FROM   EMPLOYEE
                             GROUP BY DEPT_ID) ;


-- �μ��� �ּұ޿�

SELECT      DEPT_ID
        ,   EMP_NAME
        ,   SALARY
FROM        EMPLOYEE
WHERE      (DEPT_ID , SALARY) IN ( SELECT   DEPT_ID , MIN(SALARY)
                                   FROM     EMPLOYEE
                                   GROUP BY DEPT_ID ) ;


-- �߿�
-- ANY
/* ANY < �ǹ̿� > ���� �� �ִ�. �ִ񰪺��� �۴� , �ּڰ����� ũ��. ���� ������ ������ ����*/

-- ALL
/* ALL < �ǹ̿� < ���� �� �ִ�. �ִ񰪺��� ũ�� , �ּڰ����� �۴�. ���� ������ ������ ���� */

SELECT      MIN(SALARY)
        ,   DEPT_ID
FROM        EMPLOYEE        
GROUP BY    DEPT_ID ;      


-- ���� / �븮 ������ �޿� ������ ��� �̸�, �޿��� ��ȸ

SELECT      *
FROM        JOB ;

SELECT      E.EMP_NAME
        ,   E.SALARY
        ,   J.JOB_TITLE
FROM        EMPLOYEE    E
JOIN        JOB         J ON(E.JOB_ID = J.JOB_ID)
WHERE       J.JOB_ID = 'J5' ;



SELECT      E.EMP_NAME
        ,   E.SALARY
        ,   J.JOB_TITLE
FROM        EMPLOYEE    E
JOIN        JOB         J ON(E.JOB_ID = J.JOB_ID)
WHERE       J.JOB_ID = 'J6' ;


-- ���� ���� ���� ���� �޿��� �޴� �븮 ������ ��� ������ ��ȸ

SELECT      E.EMP_NAME
        ,   E.SALARY
        ,   J.JOB_TITLE
FROM        EMPLOYEE    E
JOIN        JOB         J ON(E.JOB_ID = J.JOB_ID)
WHERE       J.JOB_TITLE = '�븮'
AND         E.SALARY > ANY (SELECT      SALARY
                            FROM        EMPLOYEE    E
                            JOIN        JOB         J ON(E.JOB_ID = J.JOB_ID)
                            WHERE       J.JOB_TITLE = '����') ;
                            

-- �ڱ� ������ ��� �޿��� �޴� ����� �̸� , ���� , �޿��� ��ȸ

SELECT      E.EMP_NAME 
        ,   J.JOB_TITLE
        ,   E.SALARY
FROM        JOB     J
JOIN        EMPLOYEE E ON (J.JOB_ID = E.JOB_ID)
WHERE      (J.JOB_ID , E.SALARY) IN (SELECT      JOB_ID
                                             ,   TRUNC(AVG(SALARY) , -5)
                                     FROM        EMPLOYEE
                                     GROUP BY    JOB_ID) ;


SELECT      JOB_ID
        ,   TRUNC(AVG(SALARY) , -5)
FROM        EMPLOYEE
GROUP BY    JOB_ID ;
        
        
        
-- �ζ��� FROM ��������


SELECT      EMP_NAME
        ,   JOB_TITLE
        ,   SALARY
FROM        (   SELECT      JOB_ID
                        ,   TRUNC(AVG(SALARY) , -5) AS JOBAVG
                FROM        EMPLOYEE
                GROUP BY    JOB_ID ) V
JOIN        EMPLOYEE E ON ( V.JOBAVG = E.SALARY AND V.JOB_ID = E.JOB_ID )
JOIN        JOB      J ON ( E.JOB_ID = J.JOB_ID ) ;

-- ������� ��������

SELECT  EMP_NAME,
        JOB_TITLE,
        SALARY
FROM    EMPLOYEE E 
JOIN    JOB      J ON (E.JOB_ID = J.JOB_ID) 
WHERE   SALARY = ( SELECT   TRUNC(AVG(SALARY), -5)
                   FROM     EMPLOYEE
                   WHERE    JOB_ID = E.JOB_ID)   -- �ܺ� Ű�� ������ �� 
ORDER BY E.JOB_ID ;

-- TOP N �м� : ���ǿ� �´� ������ ã��
-- ������ Į�� : ROWNUM , ROWID

-- �μ��� ��� �޿����� ���� �޿��� �޴� ����� �̸� , �޿� ��ȸ
-- IN-LINE VIEW

SELECT      DEPT_ID
        ,   ROUND(AVG(SALARY) , -3) AS DEPTAVG
FROM        EMPLOYEE
GROUP BY    DEPT_ID ;

-- 

SELECT  ROWNUM,
        EMP_NAME,
        SALARY
FROM    (SELECT  EMP_NAME,
                SALARY
        FROM    (SELECT      DEPT_ID,
                        ROUND(AVG(SALARY), -3) AS DEPTAVG
                 FROM        EMPLOYEE
                 GROUP BY    DEPT_ID) INLV 
        JOIN    EMPLOYEE E ON( E.DEPT_ID = INLV.DEPT_ID) 
        WHERE   SALARY > INLV.DEPTAVG 
        ORDER BY SALARY DESC) 
WHERE   ROWNUM = 1 ;

-- RANK()
SELECT  *
FROM    (SELECT EMP_NAME, 
                SALARY,
                RANK() OVER(ORDER BY SALARY DESC) AS RANK 
        FROM    EMPLOYEE) 
WHERE   RANK = 2 ;
