CREATE OR REPLACE VIEW vw_customers AS
SELECT
c.id, p.first_name, p.last_name, p.address, p.birthdate, c.bar_code, c.ms_lasts  
FROM people p INNER JOIN customers c ON p.id=c.people_id;


CREATE OR REPLACE VIEW vw_workers AS
SELECT
w.id, p.first_name, p.last_name, p.address, p.birthdate
FROM people p INNER JOIN workers w ON p.id=w.people_id;


CREATE OR REPLACE VIEW vw_users AS
SELECT
u.id, p.first_name, p.last_name, p.address, p.birthdate, u.username
FROM people p INNER JOIN workers w ON p.id=w.people_id INNER JOIN users u ON w.id=u.worker_id;


CREATE OR REPLACE VIEW vw_attendances AS
SELECT
a.id, p.first_name, p.last_name, a.type_of_att, a.created_at AS "TIME", a.origin
FROM people p INNER JOIN attendances a ON p.id=a.people_id;
