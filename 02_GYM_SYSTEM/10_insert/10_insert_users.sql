--------------------------------- Users
-- It can be run after workers has data

/* -- Somethings feels strange
BEGIN
      FOR c IN (SELECT 'pkg_outside_control.ADD_USER(''' || w.id || ''',N''' || LOWER(CONCAT(CONCAT(p.first_name,p.last_name),w.id))
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
END;
/
*/

BEGIN
  pkg_outside_control.ADD_USER('9',N'gy�rgyjandzs�9','673fae34f8de3f5c68a27d2c3a9cb020');
  COMMIT;
END;









