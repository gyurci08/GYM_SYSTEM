CREATE OR REPLACE PACKAGE pkg_data_manipulation IS
   FUNCTION IS_PRESENT_BY_NAME(
                            VAR_FIRST_NAME          VARCHAR2
                           ,VAR_LAST_NAME           VARCHAR2
                           ,VAR_CREATED_AT          TIMESTAMP
                            )
                           RETURN
                           INTEGER;
  
   FUNCTION IS_PRESENT_BY_ID(
                             VAR_TABLE_NAME           VARCHAR2
                             ,VAR_FIELD               VARCHAR2
                             ,VAR_ID                  NUMBER
                            )
                           RETURN
                           BOOLEAN;



   FUNCTION IS_PRESENT_BY_ID_NM(
                             VAR_TABLE_NAME               VARCHAR2
                             ,VAR_SEARCH_IN               VARCHAR2
                             ,VAR_TO_SEARCH               NUMBER
                             ,VAR_RETURN_FROM             VARCHAR2
                            )
                           RETURN
                           INTEGER;






  
  
  PROCEDURE insert_people(
                            VAR_ID                    NUMBER
                            ,VAR_FIRST_NAME           VARCHAR2
                            ,VAR_LAST_NAME            VARCHAR2
                            ,VAR_ADDRESS              VARCHAR2
                            ,VAR_BIRTHDATE            DATE
                            ,VAR_new_id               OUT NUMBER
                            );
                            
  PROCEDURE insert_customer(
                            VAR_ID                    NUMBER
                            ,VAR_PEOPLE_ID            NUMBER
                            ,VAR_MS_LASTS             DATE
                            ,VAR_new_id               OUT NUMBER     
                            );
                            
                            
  PROCEDURE insert_worker(
                            VAR_ID NUMBER
                            ,VAR_PEOPLE_ID NUMBER
                            ,VAR_NEW_ID OUT NUMBER
                            );

  PROCEDURE insert_user(
                            VAR_ID                   NUMBER
                            ,VAR_WORKER_ID           NUMBER
                            ,VAR_USERNAME            VARCHAR2
                            ,VAR_PASSWORD           VARCHAR2
                            ,VAR_NEW_ID       OUT    NUMBER
                            );


  PROCEDURE remove_user(
                      VAR_WORKER_ID                   NUMBER
                            );


  PROCEDURE remove_worker(
                      VAR_ID                   NUMBER
                            );



  PROCEDURE remove_customer(
                      VAR_ID                   NUMBER
                            );



 PROCEDURE update_customer(
                            VAR_ID                    NUMBER
                            ,VAR_FIRST_NAME           VARCHAR2 DEFAULT NULL
                            ,VAR_LAST_NAME            VARCHAR2 DEFAULT NULL
                            ,VAR_ADDRESS              VARCHAR2 DEFAULT NULL
                            ,VAR_BIRTHDATE            DATE     DEFAULT NULL
                            ,VAR_MS_LASTS             DATE     DEFAULT NULL
                            );






END pkg_data_manipulation;
/
CREATE OR REPLACE PACKAGE BODY pkg_data_manipulation IS


   ID     NUMBER;
   bool   BOOLEAN;
   
   
   
   
   FUNCTION IS_PRESENT_BY_NAME(                                 -- Should be depracated
                           VAR_FIRST_NAME           VARCHAR2
                           ,VAR_LAST_NAME           VARCHAR2
                           ,VAR_CREATED_AT          TIMESTAMP
                            )
                           RETURN
                           INTEGER                   
     IS
  
          CURSOR ToCheck
          IS
          SELECT p.id FROM people p
          WHERE 
                 p.last_name = VAR_LAST_NAME
          AND    p.first_name = VAR_FIRST_NAME
          AND    p.CREATED_AT = VAR_CREATED_AT;
          
        
     BEGIN
           ID := null;

           OPEN ToCheck;
           FETCH ToCheck INTO ID;
           CLOSE ToCheck;
          
           RETURN ID;
   END IS_PRESENT_BY_NAME;







  FUNCTION IS_PRESENT_BY_ID(
                             VAR_TABLE_NAME               VARCHAR2
                             ,VAR_FIELD                   VARCHAR2
                             ,VAR_ID                      NUMBER
                            )
                             RETURN
                             BOOLEAN
    IS
     BEGIN
           ID := null;
     
           bool := false;
           BEGIN
                execute immediate 'select t.id from ' || VAR_TABLE_NAME || ' t where t.' || VAR_FIELD || '=' || VAR_ID into ID;
                EXCEPTION
                WHEN no_data_found
                  THEN bool := FALSE;
           END;
 
           
           IF ID IS NOT NULL
              THEN bool := TRUE;
           END IF;
           
          RETURN bool;             
     END IS_PRESENT_BY_ID;


     

 FUNCTION IS_PRESENT_BY_ID_NM(
                             VAR_TABLE_NAME               VARCHAR2
                             ,VAR_SEARCH_IN               VARCHAR2
                             ,VAR_TO_SEARCH               NUMBER
                             ,VAR_RETURN_FROM             VARCHAR2
                            )
                             RETURN
                             INTEGER
    IS
    
    VAR_SQL VARCHAR2(250 CHAR);
    
    
     BEGIN
           ID := null;
           VAR_SQL := ('select ' || VAR_RETURN_FROM || ' from ' || VAR_TABLE_NAME || ' t where t.' || VAR_SEARCH_IN || '=' || VAR_TO_SEARCH);
           BEGIN
                execute immediate VAR_SQL into ID;
                EXCEPTION
                WHEN no_data_found
                  THEN RETURN NULL;
           END;

          RETURN ID;             
     END IS_PRESENT_BY_ID_NM;


































---
----   START OF INSERT
---------------------------------------------------------------



  
  PROCEDURE insert_people(  VAR_ID                    NUMBER
                            ,VAR_FIRST_NAME           VARCHAR2
                            ,VAR_LAST_NAME            VARCHAR2
                            ,VAR_ADDRESS              VARCHAR2
                            ,VAR_BIRTHDATE            DATE
                            ,VAR_new_id        OUT    NUMBER
                            )
      IS           
      BEGIN
        VAR_new_id := IS_PRESENT_BY_ID_NM(
                             VAR_TABLE_NAME      => 'PEOPLE'
                             ,VAR_SEARCH_IN      => 'ID'
                             ,VAR_TO_SEARCH      => VAR_ID
                             ,VAR_RETURN_FROM    => 'ID'
                           );
        IF VAR_new_id IS NULL -- THERE IS NO ID FROM RECORD
           THEN
               insert into people
                           (
                            ID
                            ,FIRST_NAME
                            ,LAST_NAME
                            ,ADDRESS
                            ,BIRTHDATE
                           )
               values 
                           (VAR_ID, VAR_FIRST_NAME, VAR_LAST_NAME, VAR_ADDRESS, VAR_BIRTHDATE); 
                           VAR_new_id := VAR_ID;
           ELSE 
            ---RAISE pkg_error_messages.people_duplication_exc; // To implement that a a worker could be also a customer.
            NULL;
      END IF;

      EXCEPTION
        WHEN pkg_error_messages.people_duplication_exc
          THEN raise_application_error('-20001','The person is already in the database.');
      END insert_people;






  PROCEDURE insert_customer(
                            VAR_ID NUMBER
                            ,VAR_PEOPLE_ID NUMBER
                            ,VAR_MS_LASTS DATE
                            ,VAR_new_id  OUT NUMBER
                            )
      IS           
 BEGIN
    bool := IS_PRESENT_BY_ID(
                 VAR_TABLE_NAME => 'people'
                 ,VAR_FIELD => 'ID'
                 ,VAR_ID =>VAR_PEOPLE_ID
                           );
   BEGIN
    IF bool -- TRUE
      THEN
         bool := null;
         bool := IS_PRESENT_BY_ID(
                    VAR_TABLE_NAME => 'customers'
                    ,VAR_FIELD => 'PEOPLE_ID'
                    ,VAR_ID => VAR_PEOPLE_ID
                    );

        IF NOT bool -- FALSE
          THEN
             insert into customers
                     (ID,PEOPLE_ID,BAR_CODE,MS_LASTS)
               values 
                     (VAR_ID, VAR_PEOPLE_ID,'',VAR_MS_LASTS);
          ELSE 
            RAISE pkg_error_messages.customer_duplication_exc;
        END IF;
      ELSE 
        RAISE pkg_error_messages.people_not_exists_exc;
    END IF;
  END;
    EXCEPTION
        WHEN pkg_error_messages.people_not_exists_exc
          THEN raise_application_error(pkg_error_messages.people_not_exists_exc_code,'The customer is not in people table of the database.');
          
        WHEN pkg_error_messages.customer_duplication_exc
          THEN raise_application_error(pkg_error_messages.customer_duplication_exc_code,'The customer is already in the database.');
        
        

     VAR_new_id := ID;
END insert_customer;



  PROCEDURE insert_worker(
                            VAR_ID NUMBER
                            ,VAR_PEOPLE_ID NUMBER
                            ,VAR_NEW_ID OUT NUMBER
                            )
    IS           
    BEGIN
      bool := IS_PRESENT_BY_ID(
                   VAR_TABLE_NAME => 'people'
                   ,VAR_FIELD => 'ID'
                   ,VAR_ID => VAR_PEOPLE_ID
                  );
        BEGIN
        IF bool -- TRUE
          THEN
            bool := null;
            bool := IS_PRESENT_BY_ID(
                         VAR_TABLE_NAME => 'workers'
                         ,VAR_FIELD => 'PEOPLE_ID'
                         ,VAR_ID => VAR_PEOPLE_ID
                        );

            IF NOT bool -- FALSE
                THEN
                insert into workers
                    (ID,PEOPLE_ID)
                    values 
                    (VAR_ID, VAR_PEOPLE_ID);
              ELSE 
                RAISE pkg_error_messages.worker_duplication_exc;
            END IF;
          ELSE 
            RAISE pkg_error_messages.people_not_exists_exc;
        END IF;
      END;
        EXCEPTION
          WHEN pkg_error_messages.people_not_exists_exc
            THEN raise_application_error(pkg_error_messages.people_not_exists_exc_code,'The worker is not in people table of the database.');
            
          WHEN pkg_error_messages.worker_duplication_exc
            THEN raise_application_error(pkg_error_messages.worker_duplication_exc_code,'The worker is already in the database.');

      VAR_NEW_ID := ID;
    END insert_worker;







PROCEDURE insert_user(
                      VAR_ID                   NUMBER
                      ,VAR_WORKER_ID           NUMBER
                      ,VAR_USERNAME            VARCHAR2
                      , VAR_PASSWORD           VARCHAR2
                      ,VAR_NEW_ID       OUT    NUMBER
                            )
    IS           
    BEGIN
      bool := IS_PRESENT_BY_ID(
                   VAR_TABLE_NAME => 'workers'
                   ,VAR_FIELD => 'ID'
                   ,VAR_ID => VAR_WORKER_ID
                  );
        BEGIN
      IF bool -- TRUE
        THEN
        bool := null;
        bool := IS_PRESENT_BY_ID(
               VAR_TABLE_NAME => 'users'
               ,VAR_FIELD => 'WORKER_ID'
               ,VAR_ID => VAR_WORKER_ID
              );

        IF NOT bool -- FALSE
          THEN
          insert into users
            (ID,WORKER_ID,USERNAME,PASSWORD)
            values 
            (VAR_ID, VAR_WORKER_ID,VAR_USERNAME,VAR_PASSWORD);
          ELSE 
          RAISE pkg_error_messages.user_duplication_exc;
        END IF;
        ELSE 
        RAISE pkg_error_messages.worker_not_exists_exc;
      END IF;
        END;
        EXCEPTION
          WHEN pkg_error_messages.worker_not_exists_exc
            THEN raise_application_error(pkg_error_messages.worker_not_exists_exc_code,'The user is not exists in worker.');
            
          WHEN pkg_error_messages.user_duplication_exc
            THEN raise_application_error(pkg_error_messages.user_duplication_exc_code,'The user is already in the database.');

      VAR_NEW_ID := ID;
    END insert_user;



---
----   END OF INSERT
---------------------------------------------------------------
















---
----   START OF REMOVE
---------------------------------------------------------------


PROCEDURE remove_user(
                      VAR_WORKER_ID                   NUMBER
                            )
    IS           
    BEGIN
                    bool := null;
                    bool := IS_PRESENT_BY_ID(
                           VAR_TABLE_NAME => 'users'
                           ,VAR_FIELD => 'WORKER_ID'
                           ,VAR_ID => VAR_WORKER_ID
                          );

                      IF bool -- TRUE
                      THEN
                           delete from users u where u.worker_id=VAR_WORKER_ID;
                      ELSE 
                           RAISE pkg_error_messages.user_not_exists_exc;
                    END IF;
                    EXCEPTION
                          WHEN pkg_error_messages.user_not_exists_exc
                            THEN raise_application_error(pkg_error_messages.user_not_exists_exc_code,'The user does NOT exists.');

    END remove_user;

    PROCEDURE remove_worker(
                      VAR_ID                   NUMBER
                            )
    IS           
    BEGIN
                    bool := IS_PRESENT_BY_ID(
                           VAR_TABLE_NAME => 'workers'
                           ,VAR_FIELD => 'ID'
                           ,VAR_ID => VAR_ID
                          );

                      IF bool -- TRUE
                      THEN
                              BEGIN
                                  pkg_data_manipulation.remove_user(VAR_ID);
                                  EXCEPTION                               
                                     /*WHEN pkg_error_messages.user_not_exists_exc                        --Does not catch the exception :(
                                          THEN NULL;*/
                                       WHEN OTHERS
                                          THEN NULL;
                              END;
                              delete from workers w where w.ID=VAR_ID;
                      ELSE 
                           RAISE pkg_error_messages.worker_not_exists_exc;
                    END IF;
                    EXCEPTION
                          WHEN pkg_error_messages.worker_not_exists_exc
                               THEN raise_application_error(pkg_error_messages.worker_not_exists_exc_code,'The worker does NOT exists.');

    END remove_worker;



    PROCEDURE remove_customer(
                      VAR_ID                   NUMBER
                            )
    IS           
    BEGIN
                    bool := IS_PRESENT_BY_ID(
                           VAR_TABLE_NAME => 'customers'
                           ,VAR_FIELD => 'ID'
                           ,VAR_ID => VAR_ID
                          );

                      IF bool -- TRUE
                      THEN
                              BEGIN
                                 delete from customers s where s.ID=VAR_ID;
                              END;
                      ELSE 
                           RAISE pkg_error_messages.customer_not_exists_exc;
                    END IF;
                    EXCEPTION
                          WHEN pkg_error_messages.customer_not_exists_exc
                               THEN raise_application_error(pkg_error_messages.customer_not_exists_exc_code,'The customer does NOT exists.');

    END remove_customer;


---
----   END OF REMOVE
---------------------------------------------------------------
















---
----   START OF UPDATE
---------------------------------------------------------------
 PROCEDURE update_customer(
                            VAR_ID                    NUMBER
                            ,VAR_FIRST_NAME           VARCHAR2 DEFAULT NULL
                            ,VAR_LAST_NAME            VARCHAR2 DEFAULT NULL
                            ,VAR_ADDRESS              VARCHAR2 DEFAULT NULL
                            ,VAR_BIRTHDATE            DATE     DEFAULT NULL
                            ,VAR_MS_LASTS             DATE     DEFAULT NULL
                            )
 IS
 
 COMMAND_PEOPLE VARCHAR2(250 CHAR);
 COMMAND_CUSTOMERS VARCHAR2(250 CHAR);
  
 VAR_SQL_PEOPLE VARCHAR2(250 CHAR);
 VAR_SQL_CUSTOMERS VARCHAR2(250 CHAR);
 
 VAR_PEOPLE_ID NUMBER;
 
 
 BEGIN
      BEGIN
            
            VAR_PEOPLE_ID := IS_PRESENT_BY_ID_NM(
                                     VAR_TABLE_NAME => 'customers'
                                     ,VAR_SEARCH_IN => 'ID'
                                     ,VAR_TO_SEARCH => VAR_ID
                                     ,VAR_RETURN_FROM => 'PEOPLE_ID'
                                     );
                                     
                                     
            COMMAND_PEOPLE := ('P.ID=' || VAR_PEOPLE_ID);
            COMMAND_CUSTOMERS := ('C.ID=' || VAR_ID);
            
            IF VAR_PEOPLE_ID IS NOT NULL -- THERE IS ID
                    THEN
                          IF VAR_FIRST_NAME IS NOT NULL
                                THEN COMMAND_PEOPLE := CONCAT(COMMAND_PEOPLE,', P.FIRST_NAME='|| '''' || VAR_FIRST_NAME || ''''); 
                          END IF;
                          
                          IF VAR_LAST_NAME IS NOT NULL
                                THEN COMMAND_PEOPLE := CONCAT(COMMAND_PEOPLE,', P.LAST_NAME='|| '''' || VAR_LAST_NAME || ''''); 
                          END IF;
                          
                          IF VAR_ADDRESS IS NOT NULL
                                THEN COMMAND_PEOPLE := CONCAT(COMMAND_PEOPLE,', P.ADDRESS='|| '''' || VAR_ADDRESS || ''''); 
                          END IF;
                          
                          IF VAR_BIRTHDATE IS NOT NULL
                                THEN COMMAND_PEOPLE := CONCAT(COMMAND_PEOPLE,', P.BIRTHDATE='|| '''' || VAR_BIRTHDATE || ''''); 
                          END IF;
                          
                          IF VAR_MS_LASTS IS NOT NULL
                                THEN COMMAND_CUSTOMERS := CONCAT(COMMAND_CUSTOMERS,', C.MS_LASTS='|| '''' || VAR_MS_LASTS || '''');
                          END IF;
                          
                          VAR_SQL_CUSTOMERS:=('UPDATE CUSTOMERS C SET ' || COMMAND_CUSTOMERS || ' WHERE C.ID=' || VAR_ID);
                          EXECUTE IMMEDIATE VAR_SQL_CUSTOMERS;
                          
                          VAR_SQL_PEOPLE := ('UPDATE PEOPLE P SET ' || COMMAND_PEOPLE || ' WHERE P.ID=' || VAR_PEOPLE_ID);
                          EXECUTE IMMEDIATE VAR_SQL_PEOPLE;
                            
                    ELSE
                          RAISE pkg_error_messages.customer_not_exists_exc;
            END IF;
            EXCEPTION
                          WHEN pkg_error_messages.customer_not_exists_exc
                               THEN raise_application_error(pkg_error_messages.customer_not_exists_exc_code,'The customer does NOT exists.');
      END;
 END update_customer;





---
----   END OF UPDATE
---------------------------------------------------------------



---
----   START OF QUERY
---------------------------------------------------------------










---
----   END OF QUERY
---------------------------------------------------------------

















END pkg_data_manipulation;
/
