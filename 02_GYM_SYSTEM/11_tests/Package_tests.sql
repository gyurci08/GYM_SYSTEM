DECLARE




BEGIN

  --pkg_outside_control.ADD_CUSTOMER(N'György',N'Jandzsó',N'7621, Pécs, Nagy Imre út 2.',to_date('2000-12-28', 'yyyy-mm-dd'),to_date('2023-12-22', 'yyyy-mm-dd'));
  --pkg_outside_control.ADD_WORKER(N'György',N'Jandzsó',N'7621, Pécs, Nagy Imre út 2',to_date('2000-12-28', 'yyyy-mm-dd'));
  --pkg_outside_control.ADD_USER(233,'gyurci08','Gyuri123');
  
  --pkg_outside_control.remove_user(232);
  --pkg_outside_control.remove_worker(234);
  --pkg_outside_control.remove_customer(228);
  
  --pkg_data_manipulation.update_customer( VAR_ID => 1,VAR_LAST_NAME => N'Jandzsó' ,VAR_MS_LASTS => to_date('2023-01-08', 'yyyy-mm-dd'));
  
  
  commit;

end;














/*
  pkg_data_manipulation.insert_people(people_seq.nextval,N'György',N'Jandzsó',N'Test',to_date('2000-12-28', 'yyyy-mm-dd'),ID);
  pkg_data_manipulation.insert_customer(customers_seq.currval,people_seq.currval,to_date('2023-12-28', 'yyyy-mm-dd'),ID);

*/
