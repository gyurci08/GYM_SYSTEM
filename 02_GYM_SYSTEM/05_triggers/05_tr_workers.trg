CREATE OR REPLACE TRIGGER tr_workers_before
  BEFORE INSERT OR UPDATE ON workers
  FOR EACH ROW
BEGIN
  IF inserting
  THEN
    IF :new.id IS NULL
    THEN
      :new.id := workers_seq.nextval;
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
CREATE OR REPLACE TRIGGER tr_workers_after_audit
  AFTER INSERT OR UPDATE OR DELETE ON workers
  FOR EACH ROW
    DECLARE
      v_mod_user VARCHAR2(250 CHAR);
      v_mod_time TIMESTAMP;
BEGIN
IF deleting
  THEN
    v_mod_user := sys_context('USERENV', 'OS_USER');
    v_mod_time := systimestamp;
  
    INSERT INTO workers_h
      (id
      ,people_id
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
      ,:old.created_at
      ,:old.creator_user
      ,v_mod_user
      ,v_mod_time
      ,'D'
      ,:old.version + 1
      );
  
  
  ELSE 
    INSERT INTO workers_h
      (
      id
      ,people_id
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
      ,:new.created_at
      ,:new.creator_user
      ,:new.mod_user
      ,:new.mod_time
      ,:new.dml_flag
      ,:new.version);
  END IF;
END;
