CREATE TABLE people
(
  ID            NUMBER                PRIMARY KEY,
  FIRST_NAME    VARCHAR2(50 CHAR)     NOT NULL,
  LAST_NAME     VARCHAR2(50 CHAR)     NOT NULL,
  ADDRESS       VARCHAR2(250 CHAR)    NULL,
  BIRTHDATE     DATE                  NULL,
  CREATOR_USER  VARCHAR2(50 CHAR)     NULL,                       -- KI KÉSZÍTETTE
  CREATED_AT    TIMESTAMP(6)          NULL,                            -- MIKOR KÉSZÜLT
  MOD_USER      VARCHAR2(50 CHAR)     NULL,                       -- KI MÓDOSÍTOTTA
  MOD_TIME      TIMESTAMP(6)          NULL,                            -- MIKOR MÓDOSULT
  DML_FLAG      CHAR(1)               NULL,                                 -- D, I
  VERSION       NUMBER                NULL                                    -- HANYADIK MÓDOSÍTÁS
) TABLESPACE users;

CREATE TABLE users -- Webalkalmazás-felhasználók ( beléptetés, bérlet-kezelés )
(
  ID            NUMBER                PRIMARY KEY,
  WORKER_ID     NUMBER                NOT NULL,
  USERNAME      VARCHAR2(120 CHAR),
  PASSWORD      VARCHAR2(120 CHAR),
  CREATOR_USER  VARCHAR2(50 CHAR)     NULL,                       
  CREATED_AT    TIMESTAMP(6)          NULL,                           
  MOD_USER      VARCHAR2(50 CHAR)     NULL,                     
  MOD_TIME      TIMESTAMP(6)          NULL,                            
  DML_FLAG      CHAR(1)               NULL,                               
  VERSION       NUMBER                NULL                                                 
) TABLESPACE users;


CREATE TABLE ATTENDANCES(
  ID            INTEGER               PRIMARY KEY
  ,PEOPLE_ID     INTEGER               NOT NULL
  ,TYPE_OF_ATT   VARCHAR2(50 CHAR)     NOT NULL        -- CHECK_IN / CHECK_OUT
  ,ORIGIN        VARCHAR2(50 CHAR)     NOT NULL
  ,CREATOR_USER  VARCHAR2(50 CHAR)     NULL 
  ,CREATED_AT    TIMESTAMP             NULL                 
  ,MOD_USER      VARCHAR2(50 CHAR)     NULL                
  ,MOD_TIME      TIMESTAMP             NULL                 
  ,DML_FLAG      CHAR(1)               NULL                  
  ,VERSION       NUMBER                NULL       
)
TABLESPACE USERS
;




CREATE TABLE workers 
(
  ID            NUMBER                PRIMARY KEY,
  PEOPLE_ID     NUMBER                NOT NULL,
  CREATOR_USER  VARCHAR2(50 CHAR)     NULL,                       
  CREATED_AT    TIMESTAMP(6)          NULL,                           
  MOD_USER      VARCHAR2(50 CHAR)     NULL,                     
  MOD_TIME      TIMESTAMP(6)          NULL,                            
  DML_FLAG      CHAR(1)               NULL,                               
  VERSION       NUMBER                NULL                                                      
) TABLESPACE users;




CREATE TABLE customers 
(
  ID            NUMBER                PRIMARY KEY,
  PEOPLE_ID     NUMBER                NOT NULL,
  BAR_CODE      VARCHAR2(50 CHAR)     UNIQUE NOT NULL,         -- Vonalkód a beléptetésnél (kártya)
  MS_LASTS      DATE,         
  CREATOR_USER  VARCHAR2(50 CHAR)     NULL,                       
  CREATED_AT    TIMESTAMP(6)          NULL,                           
  MOD_USER      VARCHAR2(50 CHAR)     NULL,                     
  MOD_TIME      TIMESTAMP(6)          NULL,                            
  DML_FLAG      CHAR(1)               NULL,                               
  VERSION       NUMBER                NULL                                                           
) TABLESPACE users;



CREATE TABLE people_h
(
  ID            NUMBER,               
  FIRST_NAME    VARCHAR2(50 CHAR),     
  LAST_NAME     VARCHAR2(50 CHAR),     
  ADDRESS       VARCHAR2(250 CHAR)     NULL,
  BIRTHDATE     DATE                   NULL,
   CREATOR_USER  VARCHAR2(50 CHAR)     NULL,                       
  CREATED_AT    TIMESTAMP(6)          NULL,                           
  MOD_USER      VARCHAR2(50 CHAR)     NULL,                     
  MOD_TIME      TIMESTAMP(6)          NULL,                            
  DML_FLAG      CHAR(1)               NULL,                               
  VERSION       NUMBER                NULL                                                            
) TABLESPACE users;

CREATE TABLE users_h -- Webalkalmazás-felhasználók ( beléptetés, bérlet-kezelés )
(
  ID            NUMBER,               
  WORKER_ID     NUMBER,               
  USERNAME      VARCHAR2(50 CHAR),
  PASSWORD      VARCHAR2(100 CHAR),
  CREATOR_USER  VARCHAR2(50 CHAR)     NULL,                       
  CREATED_AT    TIMESTAMP(6)          NULL,                           
  MOD_USER      VARCHAR2(50 CHAR)     NULL,                     
  MOD_TIME      TIMESTAMP(6)          NULL,                            
  DML_FLAG      CHAR(1)               NULL,                               
  VERSION       NUMBER                NULL                                                                
) TABLESPACE users;

CREATE TABLE workers_h
(
  ID            NUMBER,               
  PEOPLE_ID     NUMBER,               
  CREATOR_USER  VARCHAR2(50 CHAR)     NULL,                       
  CREATED_AT    TIMESTAMP(6)          NULL,                           
  MOD_USER      VARCHAR2(50 CHAR)     NULL,                     
  MOD_TIME      TIMESTAMP(6)          NULL,                            
  DML_FLAG      CHAR(1)               NULL,                               
  VERSION       NUMBER                NULL                                                  
) TABLESPACE users;

CREATE TABLE customers_h
(
  ID            NUMBER,               
  PEOPLE_ID     NUMBER,               
  BAR_CODE      VARCHAR2(50 CHAR),                      
  MS_LASTS      DATE,                                   
  CREATOR_USER  VARCHAR2(50 CHAR)     NULL,                       
  CREATED_AT    TIMESTAMP(6)          NULL,                           
  MOD_USER      VARCHAR2(50 CHAR)     NULL,                     
  MOD_TIME      TIMESTAMP(6)          NULL,                            
  DML_FLAG      CHAR(1)               NULL,                               
  VERSION       NUMBER                NULL                                         
) TABLESPACE users;

CREATE TABLE ATTENDANCES_H(
  ID            INTEGER               
  ,PEOPLE_ID     INTEGER               
  ,TYPE_OF_ATT   VARCHAR2(50 CHAR)            -- CHECK_IN / CHECK_OUT
  ,ORIGIN        VARCHAR2(50 CHAR) 
  ,CREATOR_USER  VARCHAR2(50 CHAR)     NULL    
  ,CREATED_AT    TIMESTAMP             NULL                 
  ,MOD_USER      VARCHAR2(50 CHAR)     NULL                
  ,MOD_TIME      TIMESTAMP             NULL                 
  ,DML_FLAG      CHAR(1)               NULL                  
  ,VERSION       NUMBER                NULL       
)
TABLESPACE USERS
;
