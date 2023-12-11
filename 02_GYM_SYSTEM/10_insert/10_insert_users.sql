--------------------------------- Users
-- It can be run after workers has data

 -- Somethings feels strange
 
DECLARE
V_QUERRY VARCHAR2(50 CHAR);
V_COUNT NUMBER;

BEGIN
  V_QUERRY := 'SELECT COUNT(ID) FROM WORKERS';
  EXECUTE IMMEDIATE V_QUERRY  INTO V_COUNT;


  IF V_COUNT > 0
    THEN
    BEGIN
            FOR c IN (SELECT 'CALL pkg_outside_control.ADD_USER(''' || w.id || ''',N''' || LOWER(CONCAT(CONCAT(p.first_name,p.last_name),w.id))
               ||''',' || '''673fae34f8de3f5c68a27d2c3a9cb020'')' AS COMMAND
          FROM people p INNER JOIN workers w ON p.id=w.people_id)
            LOOP
              
              DBMS_OUTPUT.PUT_line(c.command);
              
              BEGIN
                    EXECUTE IMMEDIATE c.command;
                    
                    EXCEPTION
                        WHEN pkg_error_messages.user_duplication_exc
                            THEN NULL;
              END;
              

              
            END LOOP;
        
            COMMIT;
   END;
   ELSE
            RAISE pkg_error_messages.worker_not_exists_exc;
   END IF;
   
   EXCEPTION
          WHEN pkg_error_messages.worker_not_exists_exc
            THEN raise_application_error(pkg_error_messages.worker_not_exists_exc_code,'There are no workers in worker.');
            
      
END;
/

/*
BEGIN
  pkg_outside_control.ADD_USER('9',N'györgyjandzsó9','673fae34f8de3f5c68a27d2c3a9cb020');
  COMMIT;
END;
*/








