CREATE TABLE people
(
  ID            NUMBER                PRIMARY KEY,
  FIRST_NAME    VARCHAR2(50 CHAR)     NOT NULL,
  LAST_NAME     VARCHAR2(50 CHAR)     NOT NULL,
  ADDRESS       VARCHAR2(250 CHAR)    NULL,
  BIRTHDATE     DATE                  NULL,
  CREATOR_USER  VARCHAR2(50 CHAR),                       -- KI K�SZ�TETTE
  CREATED_AT    TIMESTAMP(6),                            -- MIKOR K�SZ�LT
  MOD_USER      VARCHAR2(50 CHAR),                       -- KI M�DOS�TOTTA
  MOD_TIME      TIMESTAMP(6),                            -- MIKOR M�DOSULT
  DML_FLAG      CHAR(1),                                 -- D, I
  VERSION       NUMBER                                   -- HANYADIK M�DOS�T�S
) TABLESPACE users;

CREATE TABLE users -- Webalkalmaz�s-felhaszn�l�k ( bel�ptet�s, b�rlet-kezel�s )
(
  ID            NUMBER                PRIMARY KEY,
  WORKER_ID     NUMBER                NOT NULL,
  USERNAME      VARCHAR2(50 CHAR),
  PASSWORD      VARCHAR2(100 CHAR),
  CREATOR_USER  VARCHAR2(50 CHAR),                                
  CREATED_AT    TIMESTAMP(6),                              
  MOD_USER      VARCHAR2(50 CHAR),                       
  MOD_TIME      TIMESTAMP(6),                              
  DML_FLAG      CHAR(1),                           
  VERSION       NUMBER                                
) TABLESPACE users;

CREATE TABLE workers 
(
  ID            NUMBER                PRIMARY KEY,
  PEOPLE_ID     NUMBER                NOT NULL,
  CREATOR_USER  VARCHAR2(50 CHAR),                            
  CREATED_AT    TIMESTAMP(6),                           
  MOD_USER      VARCHAR2(50 CHAR),                   
  MOD_TIME      TIMESTAMP(6),                               
  DML_FLAG      CHAR(1),                                 
  VERSION       NUMBER                                 
) TABLESPACE users;


CREATE TABLE customers 
(
  ID            NUMBER                PRIMARY KEY,
  PEOPLE_ID     NUMBER                NOT NULL,
  BAR_CODE      VARCHAR2(50 CHAR)     UNIQUE NOT NULL,         -- Vonalk�d a bel�ptet�sn�l (k�rtya)
  CREATOR_USER  VARCHAR2(50 CHAR),                                       
  CREATED_AT    TIMESTAMP(6),                                       
  MOD_USER      VARCHAR2(50 CHAR),                                
  MOD_TIME      TIMESTAMP(6),                                       
  DML_FLAG      CHAR(1),                                         
  VERSION       NUMBER                                          
) TABLESPACE users;







CREATE TABLE people_h
(
  ID            NUMBER,               
  FIRST_NAME    VARCHAR2(50 CHAR),     
  LAST_NAME     VARCHAR2(50 CHAR),     
  ADDRESS       VARCHAR2(250 CHAR)     NULL,
  BIRTHDATE     DATE                   NULL,
  CREATOR_USER  VARCHAR2(50 CHAR),                              
  CREATED_AT    TIMESTAMP(6),                               
  MOD_USER      VARCHAR2(50 CHAR),                      
  MOD_TIME      TIMESTAMP(6),                              
  DML_FLAG      CHAR(1),                               
  VERSION       NUMBER                                  
) TABLESPACE users;

CREATE TABLE users_h -- Webalkalmaz�s-felhaszn�l�k ( bel�ptet�s, b�rlet-kezel�s )
(
  ID            NUMBER,               
  WORKER_ID     NUMBER,               
  USERNAME      VARCHAR2(50 CHAR),
  PASSWORD      VARCHAR2(100 CHAR),
  CREATOR_USER  VARCHAR2(50 CHAR),                                
  CREATED_AT    TIMESTAMP(6),                                     
  MOD_USER      VARCHAR2(50 CHAR),                                
  MOD_TIME      TIMESTAMP(6),                                     
  DML_FLAG      CHAR(1),                                          
  VERSION       NUMBER                                           
) TABLESPACE users;

CREATE TABLE workers_h
(
  ID            NUMBER,               
  PEOPLE_ID     NUMBER,               
  CREATOR_USER  VARCHAR2(50 CHAR),
  CREATED_AT    TIMESTAMP(6),       
  MOD_USER      VARCHAR2(50 CHAR),                           
  MOD_TIME      TIMESTAMP(6),                                  
  DML_FLAG      CHAR(1),                                  
  VERSION       NUMBER                                            
) TABLESPACE users;

CREATE TABLE customers_h
(
  ID            NUMBER,               
  PEOPLE_ID     NUMBER,               
  BAR_CODE      VARCHAR2(50 CHAR),                      
  MS_LASTS      DATE,                                   
  CREATOR_USER  VARCHAR2(50 CHAR),                               
  CREATED_AT    TIMESTAMP(6),                               
  MOD_USER      VARCHAR2(50 CHAR),                     
  MOD_TIME      TIMESTAMP(6),                   
  DML_FLAG      CHAR(1),                              
  VERSION       NUMBER                           
) TABLESPACE users;