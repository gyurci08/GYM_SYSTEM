create or replace package pkg_outside_control is

   PROCEDURE ADD_CUSTOMER(
                            VAR_FIRST_NAME            VARCHAR2
                            ,VAR_LAST_NAME            VARCHAR2
                            ,VAR_ADDRESS              VARCHAR2
                            ,VAR_BIRTHDATE            DATE
                            ,VAR_MS_LASTS             DATE
                            );


   PROCEDURE ADD_WORKER(
                              VAR_FIRST_NAME            VARCHAR2
                              ,VAR_LAST_NAME            VARCHAR2
                              ,VAR_ADDRESS              VARCHAR2
                              ,VAR_BIRTHDATE            DATE
                              );
                             
                             
                             
  PROCEDURE ADD_USER(
                              VAR_WORKER_ID             NUMBER
                              ,VAR_USERNAME             VARCHAR2
                              ,VAR_PASSWORD             VARCHAR2
                              );                           
                             
                             
                             
  PROCEDURE remove_user(
                         VAR_WORKER_ID                   NUMBER
                         );                     
                             
                             
  procedure remove_worker(
                         VAR_ID                   NUMBER
                         );                          
                             
                             
  procedure  REMOVE_CUSTOMER(
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
                            
                            
       
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                             
end pkg_outside_control;
/
create or replace package body pkg_outside_control is

  PROCEDURE ADD_CUSTOMER(
                              VAR_FIRST_NAME           VARCHAR2
                              ,VAR_LAST_NAME            VARCHAR2
                              ,VAR_ADDRESS              VARCHAR2
                              ,VAR_BIRTHDATE            DATE
                              ,VAR_MS_LASTS             DATE
                              )
  IS
    BEGIN
      DECLARE 
        R_PEOPLE_ID NUMBER;
        R_CUSTOMER_ID NUMBER;
      BEGIN
          pkg_data_manipulation.insert_people(people_seq.nextval,VAR_FIRST_NAME,VAR_LAST_NAME,VAR_ADDRESS,VAR_BIRTHDATE,R_PEOPLE_ID);
          pkg_data_manipulation.insert_customer(customers_seq.nextval,R_PEOPLE_ID,VAR_MS_LASTS,R_CUSTOMER_ID);
      END;
      
    END ADD_CUSTOMER;
    
    
    
    
  PROCEDURE ADD_WORKER(
                              VAR_FIRST_NAME           VARCHAR2
                              ,VAR_LAST_NAME            VARCHAR2
                              ,VAR_ADDRESS              VARCHAR2
                              ,VAR_BIRTHDATE            DATE
                              )
  IS
    BEGIN
      DECLARE 
        R_PEOPLE_ID NUMBER;
        R_WORKER_ID NUMBER;
      BEGIN
        pkg_data_manipulation.insert_people(people_seq.nextval,VAR_FIRST_NAME,VAR_LAST_NAME,VAR_ADDRESS,VAR_BIRTHDATE,R_PEOPLE_ID);
        pkg_data_manipulation.insert_WORKER(customers_seq.nextval,R_PEOPLE_ID,R_WORKER_ID);
      END;
      
    END ADD_WORKER;
    
    
    
    
    
      PROCEDURE ADD_USER(
                              VAR_WORKER_ID        NUMBER
                              ,VAR_USERNAME        VARCHAR2
                              ,VAR_PASSWORD        VARCHAR2
                              )
  IS
    BEGIN
      DECLARE 
        R_USER_ID NUMBER;
      BEGIN
        pkg_data_manipulation.insert_USER(users_seq.nextval,VAR_WORKER_ID,VAR_USERNAME,VAR_PASSWORD,R_USER_ID);
      END;
      
    END ADD_USER;
    
    
    
    procedure remove_user(
                         VAR_WORKER_ID                   NUMBER
                         )
    IS
    BEGIN
      BEGIN
        pkg_data_manipulation.REMOVE_USER(VAR_WORKER_ID);
      END; 
    END remove_user;



    
    procedure remove_worker(
                         VAR_ID                   NUMBER
                         )
    IS
    BEGIN
      BEGIN
        pkg_data_manipulation.REMOVE_WORKER(VAR_ID);
      END; 
    END remove_worker;
    
    
    

    
    
    
    
    
    procedure  REMOVE_CUSTOMER(
                         VAR_ID                   NUMBER
                         )
    IS
    BEGIN
      BEGIN
        pkg_data_manipulation.REMOVE_CUSTOMER(VAR_ID);
      END; 
    END REMOVE_CUSTOMER;
    
    
    
    
    
    
    
     PROCEDURE update_customer(
                            VAR_ID                    NUMBER
                            ,VAR_FIRST_NAME           VARCHAR2 DEFAULT NULL
                            ,VAR_LAST_NAME            VARCHAR2 DEFAULT NULL
                            ,VAR_ADDRESS              VARCHAR2 DEFAULT NULL
                            ,VAR_BIRTHDATE            DATE     DEFAULT NULL
                            ,VAR_MS_LASTS             DATE     DEFAULT NULL
                            )
     IS
     BEGIN
       pkg_data_manipulation.update_customer(VAR_ID, VAR_FIRST_NAME, VAR_LAST_NAME, VAR_ADDRESS, VAR_BIRTHDATE, VAR_MS_LASTS);
     END update_customer;
    
    
    

    
    
end pkg_outside_control;
/
