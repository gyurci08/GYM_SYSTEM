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
        ID_TEST1 NUMBER;
        ID_TEST2 NUMBER;
      BEGIN
        pkg_data_manipulation.insert_people(people_seq.nextval,VAR_FIRST_NAME,VAR_LAST_NAME,VAR_ADDRESS,VAR_BIRTHDATE,ID_TEST1);
        pkg_data_manipulation.insert_customer(customers_seq.currval,people_seq.currval,VAR_MS_LASTS,ID_TEST2);
        IF ID_TEST1 IS NOT NULL AND ID_TEST1 IS NOT NULL
           THEN RETURN TRUE;
           ELSE RETURN FALSE;
        END IF;
      END;
      
    END ADD_CUSTOMER;
    
    
    
end pkg_outside_control;
/
