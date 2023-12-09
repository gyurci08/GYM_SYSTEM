DECLARE


BEGIN

  --GYM_SYSTEM.pkg_outside_control.ADD_CUSTOMER(N'György',N'Jandzsó',N'7621, Pécs, Nagy Imre út 2.',to_date('2000-12-28', 'yyyy-mm-dd'),to_date('2023-12-22', 'yyyy-mm-dd'));
  --GYM_SYSTEM.pkg_outside_control.ADD_WORKER(N'György',N'Jandzsó',N'7621, Pécs, Nagy Imre út 2',to_date('2000-12-28', 'yyyy-mm-dd'));
  --GYM_SYSTEM.pkg_outside_control.ADD_USER(233,'gyurci08','Gyuri123');
  
  --GYM_SYSTEM.pkg_outside_control.remove_user(232);
  --GYM_SYSTEM.pkg_outside_control.remove_worker(234);
  --GYM_SYSTEM.pkg_outside_control.remove_customer(238);
  
  
  GYM_SYSTEM.PKG_OUTSIDE_CONTROL.update_customer( VAR_ID => 239,VAR_LAST_NAME => N'Jandzsó' ,VAR_MS_LASTS => to_date('2024-01-08', 'yyyy-mm-dd'));
  
  
  
  commit;

end;









