﻿select t.id,
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


commit;
