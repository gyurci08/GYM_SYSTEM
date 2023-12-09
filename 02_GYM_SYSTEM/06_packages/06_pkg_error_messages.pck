create or replace package pkg_error_messages is
        
        people_duplication_exc   EXCEPTION;
                                 people_duplication_exc_code CONSTANT NUMBER := -20001;
        
        customer_duplication_exc EXCEPTION;
                                 customer_duplication_exc_code CONSTANT NUMBER := -20002;
        
        people_not_exists_exc EXCEPTION;
                                 people_not_exists_exc_code CONSTANT NUMBER := -20003; 
        
        worker_duplication_exc   EXCEPTION;
                                 worker_duplication_exc_code CONSTANT NUMBER := -20004;
        
        worker_not_exists_exc EXCEPTION;
                                 worker_not_exists_exc_code CONSTANT NUMBER := -20005; 
        
        user_duplication_exc EXCEPTION;
                                 user_duplication_exc_code CONSTANT NUMBER := -20006;
        
        user_not_exists_exc EXCEPTION;
                                 user_not_exists_exc_code CONSTANT NUMBER := -20007;
                                 
                                 
                                 
                                 
end pkg_error_messages;
/
create or replace package body pkg_error_messages is
        
        people_duplication_exc   EXCEPTION;
           PRAGMA EXCEPTION_INIT (people_duplication_exc, -20001); 
        
        customer_duplication_exc EXCEPTION;
           PRAGMA EXCEPTION_INIT (customer_duplication_exc, -20002);
        
        people_not_exists_exc EXCEPTION;
           PRAGMA EXCEPTION_INIT (customer_duplication_exc, -20003);
        
        worker_duplication_exc   EXCEPTION;
           PRAGMA EXCEPTION_INIT (customer_duplication_exc, -20004);
           
        worker_not_exists_exc EXCEPTION;
           PRAGMA EXCEPTION_INIT (customer_duplication_exc, -20005);
           
        user_duplication_exc EXCEPTION;
           PRAGMA EXCEPTION_INIT (customer_duplication_exc, -20006);
           
        user_not_exists_exc EXCEPTION;
           PRAGMA EXCEPTION_INIT (user_not_exists_exc, -20007);
           
            

end pkg_error_messages;
/
