CREATE OR REPLACE TRIGGER tr_users_before
  BEFORE INSERT OR UPDATE ON users
  FOR EACH ROW
BEGIN
  IF inserting
  THEN
    IF :new.id IS NULL
    THEN
      :new.id := users_seq.nextval;
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
CREATE OR REPLACE TRIGGER tr_users_after
  AFTER INSERT OR UPDATE OR DELETE ON users
  FOR EACH ROW
    DECLARE
      v_mod_user VARCHAR2(250 CHAR);
      v_mod_time TIMESTAMP;
BEGIN
IF deleting
  THEN
    v_mod_user := sys_context('USERENV', 'OS_USER');
    v_mod_time := systimestamp;
  
    INSERT INTO users_h
      (id
      ,worker_id
      ,username
      ,password
      ,created_at
      ,creator_user
      ,mod_user
      ,mod_time
      ,dml_flag
      ,version)
    VALUES
      (
       :old.id
      ,:old.worker_id
      ,:old.username
      ,:old.password
      ,:old.created_at
      ,:old.creator_user
      ,v_mod_user
      ,v_mod_time
      ,'D'
      ,:old.version + 1
      );
  
  
  ELSE 
    INSERT INTO users_h
      (
      id
      ,worker_id
      ,username
      ,password
      ,created_at
      ,creator_user
      ,mod_user
      ,mod_time
      ,dml_flag
      ,version
      )
    VALUES
      (:new.id
      ,:new.worker_id
      ,:new.username
      ,:new.password
      ,:new.created_at
      ,:new.creator_user
      ,:new.mod_user
      ,:new.mod_time
      ,:new.dml_flag
      ,:new.version);
  END IF;
END;
/
