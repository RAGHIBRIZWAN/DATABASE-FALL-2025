1) 
CREATE OR REPLACE TRIGGER trg_students_uppername
BEFORE INSERT ON students
FOR EACH ROW
BEGIN
  :NEW.student_name := UPPER(:NEW.student_name);
END;
/

2)
CREATE OR REPLACE TRIGGER trg_no_delete_weekend
BEFORE DELETE ON employees
BEGIN
  IF TO_CHAR(SYSDATE, 'DY') IN ('SAT', 'SUN') THEN
    RAISE_APPLICATION_ERROR(-20001, 'Deletion not allowed during weekends.');
  END IF;
END;
/

3)
CREATE OR REPLACE TRIGGER trg_salary_update_audit
AFTER UPDATE OF salary ON employees
FOR EACH ROW
BEGIN
  INSERT INTO log_salary_audit
    (emp_id, old_salary, new_salary, changed_on)
  VALUES
    (:OLD.emp_id, :OLD.salary, :NEW.salary, SYSDATE);
END;
/

4)
CREATE OR REPLACE TRIGGER trg_no_negative_price
BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
  IF :NEW.price < 0 THEN
    RAISE_APPLICATION_ERROR(-20002, 'Price cannot be negative.');
  END IF;
END;
/

5)
CREATE OR REPLACE TRIGGER trg_courses_userstamp
BEFORE INSERT ON courses
FOR EACH ROW
BEGIN
  :NEW.created_by := USER;
  :NEW.created_on := SYSDATE;
END;
/

6)
CREATE OR REPLACE TRIGGER trg_emp_default_dept
BEFORE INSERT ON emp
FOR EACH ROW
BEGIN
  IF :NEW.department_id IS NULL THEN
    :NEW.department_id := 10;
  END IF;
END;
/

7)
CREATE OR REPLACE PACKAGE sales_pkg AS
  total_before NUMBER := 0;
  total_after  NUMBER := 0;
END;
/

CREATE OR REPLACE TRIGGER trg_sales_before
BEFORE INSERT ON sales
BEGIN
  SELECT NVL(SUM(amount), 0) INTO sales_pkg.total_before FROM sales;
END;
/

CREATE OR REPLACE TRIGGER trg_sales_after
AFTER INSERT ON sales
BEGIN
  SELECT NVL(SUM(amount), 0) INTO sales_pkg.total_after FROM sales;

  DBMS_OUTPUT.PUT_LINE('Total Sales Before Insert = ' || sales_pkg.total_before);
  DBMS_OUTPUT.PUT_LINE('Total Sales After Insert  = ' || sales_pkg.total_after);
END;
/  

8)
CREATE OR REPLACE TRIGGER trg_schema_ddl_audit
AFTER CREATE OR DROP ON SCHEMA
BEGIN
  INSERT INTO schema_ddl_log
    (username, ddl_type, object_type, object_name, event_date)
  VALUES
    (USER, ORA_SYSEVENT, ORA_DICT_OBJ_TYPE, ORA_DICT_OBJ_NAME, SYSDATE);
END;
/

9)
CREATE OR REPLACE TRIGGER trg_no_update_shipped
BEFORE UPDATE ON orders
FOR EACH ROW
BEGIN
  IF :OLD.order_status = 'SHIPPED' THEN
    RAISE_APPLICATION_ERROR(-20003, 'Cannot update a shipped order.');
  END IF;
END;
/

10)
CREATE OR REPLACE TRIGGER trg_logon_audit
AFTER LOGON ON DATABASE
BEGIN
  INSERT INTO login_audit
    (username, login_time)
  VALUES
    (USER, SYSDATE);
END;
/
