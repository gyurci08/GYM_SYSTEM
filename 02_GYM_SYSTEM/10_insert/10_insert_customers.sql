BEGIN

  pkg_outside_control.ADD_CUSTOMER(N'György',N'Jandzsó',N'7621, Pécs, Nagy Sándor út 2.',to_date('2000-12-20', 'yyyy-mm-dd'),to_date('2024-01-11', 'yyyy-mm-dd'));
  pkg_outside_control.ADD_CUSTOMER(N'István',N'Pintér',N'7621, Pécs, Nagy Sándor út 3.',to_date('2001-02-08', 'yyyy-mm-dd'),to_date('2024-01-11', 'yyyy-mm-dd'));
  pkg_outside_control.ADD_CUSTOMER(N'Sándor',N'Mezei',N'7621, Pécs, Nagy Sándor út 4.',to_date('2002-11-20', 'yyyy-mm-dd'),to_date('2024-01-11', 'yyyy-mm-dd'));
  pkg_outside_control.ADD_CUSTOMER(N'Anna',N'Kőrös',N'7621, Pécs, Nagy Sándor út 5.',to_date('2003-10-21', 'yyyy-mm-dd'),to_date('2024-01-11', 'yyyy-mm-dd'));
  
  
  
  
  --pkg_outside_control.ADD_WORKER(N'György',N'Jandzsó',N'7621, Pécs, Nagy Sándor út 2',to_date('2000-12-28', 'yyyy-mm-dd'));
  --pkg_outside_control.ADD_USER(233,'gyurci08','673fae34f8de3f5c68a27d2c3a9cb020'); -- MD4 ;)
  
  commit;

end;





















