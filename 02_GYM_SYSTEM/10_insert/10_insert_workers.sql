--------------------------------- Workers
BEGIN
  pkg_outside_control.ADD_WORKER(N'Gy�rgy',N'Jandzs�',N'7621, P�cs, Nagy S�ndor �t 2',to_date('2000-12-28', 'yyyy-mm-dd'));
  pkg_outside_control.ADD_WORKER(N'Lajos',N'Kis',N'7621, P�cs, Nagy S�ndor �t 3',to_date('2001-02-08', 'yyyy-mm-dd'));
  pkg_outside_control.ADD_WORKER(N'R�ka',N'Nagy',N'7621, P�cs, Nagy S�ndor �t 4',to_date('2002-10-18', 'yyyy-mm-dd'));
  pkg_outside_control.ADD_WORKER(N'Borb�la',N'Kov�cs',N'7621, P�cs, Nagy S�ndor �t 5',to_date('2002-05-11', 'yyyy-mm-dd'));
  EXCEPTION
            WHEN pkg_error_messages.worker_duplication_exc
                THEN NULL;
  commit;

END;





















