CREATE OR REPLACE PACKAGE pkg_data_manipulation IS
   FUNCTION IS_PRESENT_BY_NAME(
                            VAR_FIRST_NAME          VARCHAR2
                           ,VAR_LAST_NAME           VARCHAR2
                           ,VAR_BIRTHDATE           DATE
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









END pkg_data_manipulation;
/
CREATE OR REPLACE PACKAGE BODY pkg_data_manipulation IS


   ID     NUMBER;
   bool   BOOLEAN;
   
   
   
   
   FUNCTION IS_PRESENT_BY_NAME(
                           VAR_FIRST_NAME           VARCHAR2
                           ,VAR_LAST_NAME           VARCHAR2
                           ,VAR_BIRTHDATE           DATE
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
          AND    p.birthdate = VAR_BIRTHDATE;
          
        
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
        VAR_new_id := IS_PRESENT_BY_NAME(
                           VAR_FIRST_NAME => VAR_FIRST_NAME
                           ,VAR_LAST_NAME => VAR_LAST_NAME
                           ,VAR_BIRTHDATE => VAR_BIRTHDATE  
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
                            ,CREATOR_USER
                            ,CREATED_AT
                            ,MOD_USER
                            ,MOD_TIME
                            ,DML_FLAG
                            ,VERSION
                           )
               values 
                           (VAR_ID, VAR_FIRST_NAME, VAR_LAST_NAME, VAR_ADDRESS, VAR_BIRTHDATE,'','','','','',''); 
                           VAR_new_id := VAR_ID;
           ELSE 
            ---RAISE pkg_error_messages.people_duplication_exc;
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
                     (ID,PEOPLE_ID,BAR_CODE,MS_LASTS,CREATOR_USER,CREATED_AT,MOD_USER,MOD_TIME,DML_FLAG,VERSION)
               values 
                     (VAR_ID, VAR_PEOPLE_ID,'',VAR_MS_LASTS, '', '', '','','','');
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
                    (ID,PEOPLE_ID,CREATOR_USER,CREATED_AT,MOD_USER,MOD_TIME,DML_FLAG,VERSION)
                    values 
                    (VAR_ID, VAR_PEOPLE_ID,'','', '', '', '','');
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
            (ID,WORKER_ID,USERNAME,PASSWORD,CREATOR_USER,CREATED_AT,MOD_USER,MOD_TIME,DML_FLAG,VERSION)
            values 
            (VAR_ID, VAR_WORKER_ID,VAR_USERNAME,VAR_PASSWORD,'','', '', '', '','');
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
                            THEN raise_application_error(pkg_error_messages.user_not_exists_exc_code,'The user does not exists.');

    END remove_user;









---
----   START OF REMOVE
---------------------------------------------------------------


















---
----   END OF REMOVE
---------------------------------------------------------------






























END pkg_data_manipulation;
/
