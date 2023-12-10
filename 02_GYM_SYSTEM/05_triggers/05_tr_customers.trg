CREATE OR REPLACE TRIGGER tr_customers_before
  BEFORE INSERT OR UPDATE ON customers
  FOR EACH ROW
BEGIN
  IF inserting
  THEN
    IF :new.id IS NULL
    THEN
      :new.id := customers_seq.nextval;
    END IF;
    
    IF :new.bar_code IS NULL
    THEN
      :new.bar_code := bar_code_seq.nextval;
    END IF;
    
    :new.creator_user  := sys_context('USERENV', 'OS_USER');
    :new.created_at   := systimestamp;
    :new.version       := 1;
    :new.dml_flag      := 'I';
  ELSE
    :new.version := :old.version + 1;
  
    IF :new.dml_flag <> 'D'
    THEN
      :new.dml_flag := 'U';
    END IF;
  END IF;

  :new.mod_user := sys_context('USERENV', 'OS_USER');
  :new.mod_time := systimestamp;
END;
/
CREATE OR REPLACE TRIGGER tr_customers_after
  AFTER INSERT OR UPDATE OR DELETE ON customers
  FOR EACH ROW
    DECLARE
      v_mod_user VARCHAR2(250 CHAR);
      v_mod_time TIMESTAMP;
BEGIN
IF deleting
  THEN
    v_mod_user := sys_context('USERENV', 'OS_USER');
    v_mod_time := systimestamp;
  
    INSERT INTO customers_h
      (id
      ,people_id
      ,bar_code
      ,ms_lasts
      ,created_at
      ,creator_user
      ,mod_user
      ,mod_time
      ,dml_flag
      ,version)
    VALUES
      (
       :old.id
      ,:old.people_id
      ,:old.bar_code
      ,:old.ms_lasts
      ,:old.created_at
      ,:old.creator_user
      ,v_mod_user
      ,v_mod_time
      ,'D'
      ,:old.version + 1
      );
  
  
  ELSE 
    INSERT INTO customers_h
      (
      id
      ,people_id
      ,bar_code
      ,ms_lasts
      ,created_at
      ,creator_user
      ,mod_user
      ,mod_time
      ,dml_flag
      ,version
      )
    VALUES
      (:new.id
      ,:new.people_id
      ,:new.bar_code
      ,:new.ms_lasts
      ,:new.created_at
      ,:new.creator_user
      ,:new.mod_user
      ,:new.mod_time
      ,:new.dml_flag
      ,:new.version);
  END IF;
END;
/
