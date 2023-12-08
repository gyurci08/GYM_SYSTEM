ALTER TABLE CUSTOMERS ADD CONSTRAINT fk_customers_people_id FOREIGN KEY(people_id) REFERENCES people(id);

ALTER TABLE WORKERS ADD CONSTRAINT fk_workers_people_id FOREIGN KEY(people_id) REFERENCES people(id);

ALTER TABLE USERS ADD CONSTRAINT fk_users_worker_id FOREIGN KEY(worker_id) REFERENCES workers(id);
