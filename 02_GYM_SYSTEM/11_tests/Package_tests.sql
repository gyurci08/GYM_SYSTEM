DECLARE
CUSTOMER_VERSION NUMBER;



BEGIN

  --pkg_outside_control.ADD_CUSTOMER(N'György',N'Jandzsó',N'7621, Pécs, Nagy Sándor út 2.',to_date('2000-12-28', 'yyyy-mm-dd'),to_date('2023-12-22', 'yyyy-mm-dd'));
  --pkg_outside_control.ADD_WORKER(N'György',N'Jandzsó',N'7621, Pécs, Nagy Sándor út 2',to_date('2000-12-28', 'yyyy-mm-dd'));
  --pkg_outside_control.ADD_USER(233,'gyurci08','Asd123');
  
  --pkg_outside_control.ADD_ATTENDANCE(VAR_PEOPLE_ID   => 1,                 -- This is sent by the app which reads the barcode
  --                                   VAR_TYPE_OF_ATT => 'CHECK_IN',        -- CHECK_IN or CHECK_OUT, depends on the side of the gate
  --                                   VAR_ORIGIN      => 'CUSTOMER');       -- This depends on if is'ts customer or worker, right now there is only customer ( Future feature)
                                                                             -- REMOVE does NOT implemented as ATTENDANCE should not by edited by workforce
                                                                             
  
  
  pkg_outside_control.ADD_ATTENDANCE(VAR_PEOPLE_ID   => 1,                 
                                     VAR_TYPE_OF_ATT => 'CHECK_OUT',      
                                     VAR_ORIGIN      => 'CUSTOMER');  
                                     
                                     
                                         
  --pkg_outside_control.remove_user(232);
  --pkg_outside_control.remove_worker(234);
  --pkg_outside_control.remove_customer(228);
  
  --pkg_outside_control.update_customer( VAR_ID => 241,VAR_LAST_NAME => N'Jandzsó' ,VAR_MS_LASTS => to_date('2023-01-08', 'yyyy-mm-dd'));
  

  commit;

end;









