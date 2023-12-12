select t.id,
       t.first_name,
       t.last_name,
       t.address,
       t.birthdate,
       t.creator_user,
       t.created_at,
       t.mod_user,
       t.mod_time,
       t.dml_flag,
       t.version,rowid from PEOPLE t;
       
select c.id,
       c.people_id,
       c.bar_code,
       c.ms_lasts,
       c.creator_user,
       c.created_at,
       c.mod_user,
       c.mod_time,
       c.dml_flag,
       c.version,rowid from customers c;

select w.id,
       w.people_id,
       w.creator_user,
       w.created_at,
       w.mod_user,
       w.mod_time,
       w.dml_flag,
       w.version, rowid from workers w;

select u.id,
       u.worker_id,
       u.username,
       u.password,
       u.creator_user,
       u.created_at,
       u.mod_user,
       u.mod_time,
       u.dml_flag,
       u.version,rowid from users u;
       
 SELECT A.ID,
        A.PEOPLE_ID,
        A.TYPE_OF_ATT,
        A.ORIGIN,
        A.CREATOR_USER,
        A.CREATED_AT
        ,rowid FROM ATTENDANCES A;



select * from people_h;
select * from customers_h;
select * from workers_h;
select * from users_h;


select * from vw_customers;
select * from vw_workers;
select * from vw_users;
select * from vw_attendances;



commit;
