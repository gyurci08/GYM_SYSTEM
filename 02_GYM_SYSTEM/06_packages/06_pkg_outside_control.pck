create or replace package pkg_outside_control is

   FUNCTION ADD_CUSTOMER(
                            VAR_FIRST_NAME           VARCHAR2
                            ,VAR_LAST_NAME            VARCHAR2
                            ,VAR_ADDRESS              VARCHAR2
                            ,VAR_BIRTHDATE            DATE
                            ,VAR_MS_LASTS             DATE
                            )
                           RETURN
                           BOOLEAN;


   FUNCTION ADD_WORKER(
                              VAR_FIRST_NAME           VARCHAR2
                              ,VAR_LAST_NAME            VARCHAR2
                              ,VAR_ADDRESS              VARCHAR2
                              ,VAR_BIRTHDATE            DATE
                              )
                             RETURN
                             BOOLEAN;
                             
                             
                             
end pkg_outside_control;
/
create or replace package body pkg_outside_control is

  FUNCTION ADD_CUSTOMER(
                              VAR_FIRST_NAME           VARCHAR2
                              ,VAR_LAST_NAME            VARCHAR2
                              ,VAR_ADDRESS              VARCHAR2
                              ,VAR_BIRTHDATE            DATE
                              ,VAR_MS_LASTS             DATE
                              )
                             RETURN
                             BOOLEAN
  IS

  
    BEGIN
      DECLARE 
        R_PEOPLE_ID NUMBER;
        R_CUSTOMER_ID NUMBER;
      BEGIN
        pkg_data_manipulation.insert_people(people_seq.nextval,VAR_FIRST_NAME,VAR_LAST_NAME,VAR_ADDRESS,VAR_BIRTHDATE,R_PEOPLE_ID);
        pkg_data_manipulation.insert_customer(customers_seq.nextval,R_PEOPLE_ID,VAR_MS_LASTS,R_CUSTOMER_ID);
        IF R_PEOPLE_ID IS NOT NULL AND R_CUSTOMER_ID IS NOT NULL
           THEN RETURN TRUE;
           ELSE RETURN FALSE;
        END IF;
      END;
      
    END ADD_CUSTOMER;
    
    
    
    
  FUNCTION ADD_WORKER(
                              VAR_FIRST_NAME           VARCHAR2
                              ,VAR_LAST_NAME            VARCHAR2
                              ,VAR_ADDRESS              VARCHAR2
                              ,VAR_BIRTHDATE            DATE
                              )
                             RETURN
                             BOOLEAN
  IS

  
    BEGIN
      DECLARE 
        R_PEOPLE_ID NUMBER;
        R_WORKER_ID NUMBER;
      BEGIN
        pkg_data_manipulation.insert_people(people_seq.nextval,VAR_FIRST_NAME,VAR_LAST_NAME,VAR_ADDRESS,VAR_BIRTHDATE,R_PEOPLE_ID);
        pkg_data_manipulation.insert_WORKER(customers_seq.nextval,R_PEOPLE_ID,R_WORKER_ID);
        IF R_PEOPLE_ID IS NOT NULL AND R_WORKER_ID IS NOT NULL
           THEN RETURN TRUE;
           ELSE RETURN FALSE;
        END IF;
      END;
      
    END ADD_WORKER;
    
    
    
end pkg_outside_control;
/
