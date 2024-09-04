
SET SERVEROUTPUT ON
DECLARE
    val NUMBER NOT NULL:=100;
    msg VARCHAR2(20) NOT NULL:='Hello';
    const CONSTANT VARCHAR2(10) := 'Hell';
BEGIN
    DBMS_OUTPUT.put_line(msg);
    DBMS_OUTPUT.put_line(val);
        DECLARE 
        msg2 VARCHAR2(100):= msg || 'World';
        BEGIN
        DBMS_OUTPUT.put_line(msg2 || ' ' ||const);
        END;
END;

DECLARE
    CUST_ID VARCHAR2(40);
BEGIN
    select BALANCE INTO CUST_ID 
    FROM ACCOUNT
    where ACCOUNT_ID = 'A-101';
    DBMS_OUTPUT.put_line(CUST_ID);
END;

-- -- CREATE OR REPLACE
-- -- PROCEDURE Hello
-- -- argument [IN]
-- -- AS
-- -- msg VARCHAR2(100):='Hello world yo'; 
-- -- BEGIN
-- --     DBMS_OUTPUT.put_line(msg);
-- -- END;

-- -- /
-- -- BEGIN 
-- --     Hello;
-- -- END;

-- -- /

-- CREATE PROCEDURE Ufindmin(x IN NUMBER,y IN NUMBER,z OUT NUMBER)
-- AS
-- BEGIN
--     IF x < y THEN
--     z:=x;
--     ELSE z:=y;
--     END IF;
-- END;


DECLARE
 FOR count IN start_val..end_val
 LOOP
    statements
 END LOOP

DECLARE
TYPE employee_type
IS
RECORD(

    )