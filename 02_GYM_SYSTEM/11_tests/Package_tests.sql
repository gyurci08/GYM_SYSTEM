DECLARE

BOOL BOOLEAN;
ID NUMBER;



BEGIN
BOOL := FALSE;

  --bool := pkg_outside_control.ADD_CUSTOMER(N'György',N'Jandzsó',N'7621, Pécs, Nagy Imre út 2.',to_date('2000-12-28', 'yyyy-mm-dd'),to_date('2023-12-22', 'yyyy-mm-dd'));
  --bool := pkg_outside_control.ADD_WORKER(N'György',N'Jandzsó',N'7621, Pécs, Nagy Imre út 2',to_date('2000-12-28', 'yyyy-mm-dd'));
  --bool := pkg_outside_control.ADD_USER(7,'gyurci08','Gyuri123');

  
  

  
  
  commit;

end;














/*
  pkg_data_manipulation.insert_people(people_seq.nextval,N'György',N'Jandzsó',N'Test',to_date('2000-12-28', 'yyyy-mm-dd'),ID);
  pkg_data_manipulation.insert_customer(customers_seq.currval,people_seq.currval,to_date('2023-12-28', 'yyyy-mm-dd'),ID);

*/
