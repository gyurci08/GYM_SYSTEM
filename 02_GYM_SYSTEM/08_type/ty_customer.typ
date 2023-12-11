CREATE OR REPLACE TYPE ty_customer AS OBJECT
(
  ID            NUMBER
  ,PEOPLE_ID     NUMBER
  ,BAR_CODE      VARCHAR2(50 CHAR)      
  ,MS_LASTS      DATE         


  ,CONSTRUCTOR FUNCTION ty_customer RETURN SELF AS RESULT
)
/
CREATE OR REPLACE TYPE BODY ty_customer IS

  CONSTRUCTOR FUNCTION ty_customer RETURN SELF AS RESULT IS
  BEGIN
         SELF.ID := ID;
         SELF.PEOPLE_ID := PEOPLE_ID;
         SELF.BAR_CODE := BAR_CODE;  
         SELF.MS_LASTS := MS_LASTS;
    RETURN;
  END;
END;
/