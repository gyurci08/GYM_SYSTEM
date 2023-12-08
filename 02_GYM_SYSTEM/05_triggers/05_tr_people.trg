﻿CREATE OR REPLACE TRIGGER tr_people_before
  BEFORE INSERT OR UPDATE ON people
  FOR EACH ROW
BEGIN
  IF inserting
  THEN
    IF :new.id IS NULL
    THEN
      :new.id := people_seq.nextval;
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
CREATE OR REPLACE TRIGGER tr_people_after
  AFTER INSERT OR UPDATE OR DELETE ON people
  FOR EACH ROW
    DECLARE
      v_mod_user VARCHAR2(250 CHAR);
      v_mod_time TIMESTAMP;
BEGIN
IF deleting
  THEN
    v_mod_user := sys_context('USERENV', 'OS_USER');
    v_mod_time := systimestamp;
  
    INSERT INTO people_h
      (id
      ,first_name
      ,last_name
      ,address
      ,birthdate
      ,created_at
      ,creator_user
      ,mod_user
      ,mod_time
      ,dml_flag
      ,version)
    VALUES
      (
       :old.id
      ,:old.first_name
      ,:old.last_name
      ,:old.address
      ,:old.birthdate
      ,:old.created_at
      ,:old.creator_user
      ,v_mod_user
      ,v_mod_time
      ,'D'
      ,:old.version + 1
      );
  
  
  ELSE 
    INSERT INTO people_h
      (
      id
      ,first_name
      ,last_name
      ,address
      ,birthdate
      ,created_at
      ,creator_user
      ,mod_user
      ,mod_time
      ,dml_flag
      ,version
      )
    VALUES
      (:new.id
      ,:new.first_name
      ,:new.last_name
      ,:new.address
      ,:new.birthdate
      ,:new.created_at
      ,:new.creator_user
      ,:new.mod_user
      ,:new.mod_time
      ,:new.dml_flag
      ,:new.version);
  END IF;
END;
/
