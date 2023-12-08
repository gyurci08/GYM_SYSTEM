DECLARE

BOOL BOOLEAN;
ID NUMBER;



BEGIN
BOOL := FALSE;

  --BOOL := pkg_outside_control.ADD_CUSTOMER(N'György',N'Jandzsó',N'Test',to_date('2010-11-22', 'yyyy-mm-dd'),to_date('2023-12-22', 'yyyy-mm-dd'));
  --bool := pkg_outside_control.ADD_WORKER(N'György',N'Jandzsó',N'Test',to_date('2010-11-22', 'yyyy-mm-dd'));
  commit;

end;














/*
  pkg_data_manipulation.insert_people(people_seq.nextval,N'György',N'Jandzsó',N'Test',to_date('2010-11-22', 'yyyy-mm-dd'),ID);
  pkg_data_manipulation.insert_customer(customers_seq.currval,people_seq.currval,to_date('2023-12-28', 'yyyy-mm-dd'),ID);

*/
