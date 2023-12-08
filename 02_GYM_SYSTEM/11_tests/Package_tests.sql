DECLARE
BOOL BOOLEAN;

begin
  BOOL := FALSE;

  BOOL := pkg_outside_control.ADD_CUSTOMER( N'György',N'Jandzsó',N'Test',to_date('2000-12-28', 'yyyy-mm-dd'),to_date('2023-01-08', 'yyyy-mm-dd'));
  IF BOOL
    THEN   dbms_output.put_line('The user created.');
    ELSE   dbms_output.put_line('The user could NOT be created.');
  END IF;
  commit;
  
end;














/*
  pkg_data_manipulation.insert_people(people_seq.nextval,N'György',N'Jandzsó',N'Test',to_date('2010-11-22', 'yyyy-mm-dd'),VAR_new_id => ID);
  pkg_data_manipulation.insert_customer(customers_seq.currval,people_seq.currval,to_date('2023-12-28', 'yyyy-mm-dd'),ID);

*/
