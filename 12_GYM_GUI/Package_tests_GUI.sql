DECLARE

BOOL BOOLEAN;
ID NUMBER;



BEGIN
BOOL := FALSE;

  GYM_SYSTEM.pkg_outside_control.ADD_CUSTOMER(N'György',N'Jandzsó',N'7621, Pécs, Nagy Imre út 2.',to_date('2000-12-28', 'yyyy-mm-dd'),to_date('2023-12-22', 'yyyy-mm-dd'));
  --GYM_SYSTEM.pkg_outside_control.ADD_WORKER(N'György',N'Jandzsó',N'7621, Pécs, Nagy Imre út 2',to_date('2000-12-28', 'yyyy-mm-dd'));
  --GYM_SYSTEM.pkg_outside_control.ADD_USER(233,'gyurci08','Gyuri123');
  
  --GYM_SYSTEM.pkg_outside_control.remove_user(232);
  --GYM_SYSTEM.pkg_outside_control.remove_worker(234);
  --GYM_SYSTEM.pkg_outside_control.remove_customer(228);
  

  
  
  commit;

end;









