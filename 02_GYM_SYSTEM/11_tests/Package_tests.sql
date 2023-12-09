DECLARE

BOOL BOOLEAN;
ID NUMBER;



BEGIN
BOOL := FALSE;

  --pkg_outside_control.ADD_CUSTOMER(N'György',N'Jandzsó',N'7621, Pécs, Nagy Imre út 2.',to_date('2000-12-28', 'yyyy-mm-dd'),to_date('2023-12-22', 'yyyy-mm-dd'));
  --pkg_outside_control.ADD_WORKER(N'György',N'Jandzsó',N'7621, Pécs, Nagy Imre út 2',to_date('2000-12-28', 'yyyy-mm-dd'));
  --pkg_outside_control.ADD_USER(233,'gyurci08','Gyuri123');
  
  --pkg_outside_control.remove_user(232);
  --pkg_outside_control.remove_worker(233);
  
  

  
  
  commit;

end;














/*
  pkg_data_manipulation.insert_people(people_seq.nextval,N'György',N'Jandzsó',N'Test',to_date('2000-12-28', 'yyyy-mm-dd'),ID);
  pkg_data_manipulation.insert_customer(customers_seq.currval,people_seq.currval,to_date('2023-12-28', 'yyyy-mm-dd'),ID);

*/
