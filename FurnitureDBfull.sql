clear screen;

SET pages500;
SET linesize 132;

DROP TABLE CUSTOMER CASCADE CONSTRAINTS; 
DROP TABLE MANAGER CASCADE CONSTRAINTS; 
DROP TABLE SHOP CASCADE CONSTRAINTS; 
DROP TABLE JOB CASCADE CONSTRAINTS; 
DROP TABLE EMPLOYEE CASCADE CONSTRAINTS; 
DROP TABLE ITEM CASCADE CONSTRAINTS; 
DROP TABLE STOCK CASCADE CONSTRAINTS; 
DROP TABLE PAYMENT CASCADE CONSTRAINTS; 
DROP TABLE ORDER1 CASCADE CONSTRAINTS; 
DROP VIEW V_PAYMENT;
DROP VIEW V_ORDER1;

DROP SEQUENCE smanager;
DROP SEQUENCE scustomer;
DROP SEQUENCE sjob;
DROP SEQUENCE semployee;
DROP SEQUENCE sitem;
DROP SEQUENCE sstock;
DROP SEQUENCE spayment;
DROP SEQUENCE sorder1;

CREATE SEQUENCE smanager
MINVALUE 1
START WITH 1
INCREMENT BY 1
NOCACHE;
CREATE SEQUENCE scustomer
MINVALUE 1
START WITH 1
INCREMENT BY 1
NOCACHE;
CREATE SEQUENCE sjob
MINVALUE 1
START WITH 1
INCREMENT BY 1
NOCACHE;
CREATE SEQUENCE semployee
MINVALUE 1
START WITH 1
INCREMENT BY 1
NOCACHE;
CREATE SEQUENCE sitem
MINVALUE 1
START WITH 1
INCREMENT BY 1
NOCACHE;
CREATE SEQUENCE sstock
MINVALUE 1
START WITH 1
INCREMENT BY 1
NOCACHE;
CREATE SEQUENCE sorder1
MINVALUE 1
START WITH 1
INCREMENT BY 1
NOCACHE;
CREATE SEQUENCE spayment
MINVALUE 1
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE TABLE MANAGER (
	mgr_id int, 
	mgr_name varchar2(20), 
	mgr_email varchar2(20), 
	mgr_salary number(5), 
	mgr_phno varchar2(15), 
        PRIMARY KEY(mgr_id));


CREATE TABLE SHOP (
	sh_id int, 
	sh_name varchar2(20), 
	sh_address varchar2(30), 
	mgr_id int , 
        PRIMARY KEY(sh_id),
		FOREIGN KEY(mgr_id) REFERENCES MANAGER(mgr_id));

CREATE TABLE CUSTOMER (
	c_id int, 
	c_name varchar2(20), 
	c_address varchar2(20), 
	c_phno varchar2(15), 
	sh_id int,
        PRIMARY KEY(c_id),
		FOREIGN KEY(sh_id) REFERENCES SHOP(sh_id));
		
CREATE TABLE JOB(
	job_id int,
	job_type varchar2(20),
	salary int,
		PRIMARY KEY(job_id));
	
CREATE TABLE EMPLOYEE(
	e_id int,
	e_name varchar2(20), 
	e_phno varchar2(15), 
	e_hiringDate date,
	mgr_id int,
	job_id int,
		PRIMARY KEY(e_id),
		FOREIGN KEY(mgr_id) REFERENCES MANAGER(mgr_id),
		FOREIGN KEY(job_id) REFERENCES JOB(job_id));
		


CREATE TABLE ITEM(
	i_id int,
	i_type varchar2(20),
	i_price number,
		PRIMARY KEY(i_id));
		
CREATE TABLE STOCK(
	stock_id int,
	i_id int,
	i_quantity int,
	sh_id int,
		PRIMARY KEY(stock_id),
		FOREIGN KEY(i_id) REFERENCES ITEM(i_id),
		FOREIGN KEY(sh_id) REFERENCES SHOP(sh_id));

 
CREATE TABLE PAYMENT(
	p_id int,
	c_id int,
	i_id int,
	p_method varchar2(10),
	quantity int,
	p_date date,
		PRIMARY KEY(p_id),
		FOREIGN KEY(c_id) REFERENCES CUSTOMER(c_id),
		FOREIGN KEY(i_id) REFERENCES ITEM(i_id));
		

		
CREATE VIEW V_PAYMENT as
SELECT PAYMENT.p_id, PAYMENT.c_id, PAYMENT.i_id, PAYMENT.quantity,
		ITEM.i_price AS per_price, PAYMENT.quantity*ITEM.i_price As Amount
FROM PAYMENT, ITEM
WHERE PAYMENT.i_id = ITEM.i_id;

column per_price format 99,999.99 hea 'Per_price';
column Amount format 99,999.99 hea 'Amount';


CREATE TABLE ORDER1(
	o_id int,
	c_id int, 
	i_id int,
	advance int,
	quantity int,
	o_method varchar2(10),
	delivery_date date,
		PRIMARY KEY(o_id),
		FOREIGN KEY(c_id) REFERENCES CUSTOMER(c_id),
		FOREIGN KEY(i_id) REFERENCES ITEM(i_id)
		);
		
CREATE VIEW V_ORDER1 as
SELECT ORDER1.o_id, ITEM.i_type, ORDER1.c_id, ORDER1.quantity, ORDER1.quantity*ITEM.i_price As Amount, 
		ORDER1.advance, ORDER1.quantity*ITEM.i_price-ORDER1.advance AS Due
FROM ORDER1, ITEM
WHERE ORDER1.i_id = ITEM.i_id;	

column Amount format 99,999.99 hea 'Amount';
column ORDER1.advance format 99,999.99 hea 'Advanced';
column Due format 99,999.99 hea 'Due';

insert into MANAGER(mgr_id, mgr_name, mgr_email, mgr_salary, mgr_phno) values (smanager.nextval, 'Saiful Alam', 'saiful@gmail.com', 20000, '01511229603'); 
insert into MANAGER(mgr_id, mgr_name, mgr_email, mgr_salary, mgr_phno) values (smanager.nextval, 'Sazid Khan', 'sazid@gmail.com', 20000, '01911226653'); 		

column mgr_salary format 99,999.99 hea 'MgrSalary';


insert into SHOP(sh_id, sh_name, sh_address, mgr_id) values (1, 'AKHTER', 'Dhaka', 1); 
insert into SHOP(sh_id, sh_name, sh_address, mgr_id) values (2, 'AKHTER', 'Chittagong', 2); 

insert into CUSTOMER(c_id, c_name, c_address, c_phno, sh_id) values (scustomer.nextval, 'Shakil Islam', 'Kurmitola', '01711234603', 1); 
insert into CUSTOMER(c_id, c_name, c_address, c_phno, sh_id) values (scustomer.nextval, 'Shams Islam', 'Kunipara', '01611234603', 1); 
insert into CUSTOMER(c_id, c_name, c_address, c_phno, sh_id) values (scustomer.nextval, 'Riaz Alam', 'Tejgaon', '01511354403', 1); 
insert into CUSTOMER(c_id, c_name, c_address, c_phno, sh_id) values (scustomer.nextval, 'Bini Ismam', 'Kather pul', '01617234603', 1); 
insert into CUSTOMER(c_id, c_name, c_address, c_phno, sh_id) values (scustomer.nextval, 'Tuku Khan', 'Gazipur', '01911274603',1); 
insert into CUSTOMER(c_id, c_name, c_address, c_phno, sh_id) values (scustomer.nextval, 'Torab Ali', 'Tatibazar', '01912344603',1); 
insert into CUSTOMER(c_id, c_name, c_address, c_phno, sh_id) values (scustomer.nextval, 'John Dowson Khan', 'Tatibazar', '01914564603',1); 
insert into CUSTOMER(c_id, c_name, c_address, c_phno, sh_id) values (scustomer.nextval, 'Pinky Rahman', 'Nobab Bari', '01911766031',2); 
insert into CUSTOMER(c_id, c_name, c_address, c_phno, sh_id) values (scustomer.nextval, 'Nadim Babu', 'Bandorban', '01987658603',2); 
insert into CUSTOMER(c_id, c_name, c_address, c_phno, sh_id) values (scustomer.nextval, 'Helal Khan', 'Lalpur', '01911274100',2); 
insert into CUSTOMER(c_id, c_name, c_address, c_phno, sh_id) values (scustomer.nextval, 'Ashraf Mia', 'Lokkhipur', '01911432323',2); 
insert into CUSTOMER(c_id, c_name, c_address, c_phno, sh_id) values (scustomer.nextval, 'Jobayda Anan', 'Feni', '01613254603',2); 
insert into CUSTOMER(c_id, c_name, c_address, c_phno, sh_id) values (scustomer.nextval, 'Tony Diaz', 'Lokkhipur', '01098274603',2); 
insert into CUSTOMER(c_id, c_name, c_address, c_phno, sh_id) values (scustomer.nextval, 'Tom Holland', 'Feni', '01910987603',2); 



insert into JOB(job_id, job_type, salary) values (sjob.nextval, 'Carpenter', 12000); 
insert into JOB(job_id, job_type, salary) values (sjob.nextval, 'Woodsman', 10000); 
insert into JOB(job_id, job_type, salary) values (sjob.nextval, 'Designer', 9000);
insert into JOB(job_id, job_type, salary) values (sjob.nextval, 'Shop Assistant', 7000); 
insert into JOB(job_id, job_type, salary) values (sjob.nextval, 'Cleaner', 6000);  

column salary format 99,999.99 hea 'EmpSalary';

insert into EMPLOYEE(e_id, e_name, e_phno, e_hiringDate, mgr_id, job_id) values (semployee.nextval, 'Hasibul Islam',  '01665287303', DATE '2018-9-17', 1,1); 
insert into EMPLOYEE(e_id, e_name, e_phno, e_hiringDate, mgr_id, job_id) values (semployee.nextval, 'Rofikul Shah', '01798873035', DATE '2019-12-02', 1,2); 
insert into EMPLOYEE(e_id, e_name, e_phno, e_hiringDate, mgr_id, job_id) values (semployee.nextval, 'Himanshu Dey',  '01911254253', DATE '2017-11-15', 1,3); 
insert into EMPLOYEE(e_id, e_name, e_phno, e_hiringDate, mgr_id, job_id) values (semployee.nextval, 'Horopodo Shaha', '01853257303', DATE '2018-10-27', 1,4); 
insert into EMPLOYEE(e_id, e_name, e_phno, e_hiringDate, mgr_id, job_id) values (semployee.nextval, 'Shamim Islam', '01911212343', DATE '2020-09-06', 1,5); 
insert into EMPLOYEE(e_id, e_name, e_phno, e_hiringDate, mgr_id, job_id) values (semployee.nextval, 'Rnoy Roy', '01910035303', DATE '2017-12-28', 2,1); 
insert into EMPLOYEE(e_id, e_name, e_phno, e_hiringDate, mgr_id, job_id) values (semployee.nextval, 'Amin Hossain', '01722963203', DATE '2019-09-22', 2,2); 
insert into EMPLOYEE(e_id, e_name, e_phno, e_hiringDate, mgr_id, job_id) values (semployee.nextval, 'Rubel Khan', '01611284503', DATE '2019-03-12', 2,3); 
insert into EMPLOYEE(e_id, e_name, e_phno, e_hiringDate, mgr_id, job_id) values (semployee.nextval, 'Robi Bhowmik', '01811765403', DATE '2020-06-19', 2,4); 
insert into EMPLOYEE(e_id, e_name, e_phno, e_hiringDate, mgr_id, job_id) values (semployee.nextval, 'Romim Khan', '01511280024', DATE '2018-08-10', 2,5); 

insert into ITEM(i_id, i_type, i_price) values (sitem.nextval, 'Chair-1', 1000); 
insert into ITEM(i_id, i_type, i_price) values (sitem.nextval, 'Chair-2', 1100); 
insert into ITEM(i_id, i_type, i_price) values (sitem.nextval, 'Bed-1', 20000); 
insert into ITEM(i_id, i_type, i_price) values (sitem.nextval, 'Dinig Table-1', 12000); 
insert into ITEM(i_id, i_type, i_price) values (sitem.nextval, 'Dining Table-2', 15000); 
insert into ITEM(i_id, i_type, i_price) values (sitem.nextval, 'Bed-2', 16000); 
insert into ITEM(i_id, i_type, i_price) values (sitem.nextval, 'Tool-1', 2000); 
insert into ITEM(i_id, i_type, i_price) values (sitem.nextval, 'Tool-2', 1500); 
insert into ITEM(i_id, i_type, i_price) values (sitem.nextval, 'Reading Table-1', 10000); 
insert into ITEM(i_id, i_type, i_price) values (sitem.nextval, 'Almirah-1', 12500); 
insert into ITEM(i_id, i_type, i_price) values (sitem.nextval, 'Almirah-2', 14500); 

insert into STOCK(stock_id, i_id, i_quantity, sh_id) values (sstock.nextval, 1, 20, 1); 
insert into STOCK(stock_id, i_id, i_quantity, sh_id) values (sstock.nextval, 2, 20, 1); 
insert into STOCK(stock_id, i_id, i_quantity, sh_id) values (sstock.nextval, 3, 20, 1); 
insert into STOCK(stock_id, i_id, i_quantity, sh_id) values (sstock.nextval, 4, 20, 1); 
insert into STOCK(stock_id, i_id, i_quantity, sh_id) values (sstock.nextval, 5, 20, 1); 
insert into STOCK(stock_id, i_id, i_quantity, sh_id) values (sstock.nextval, 6, 20, 1); 
insert into STOCK(stock_id, i_id, i_quantity, sh_id) values (sstock.nextval, 7, 20, 1); 
insert into STOCK(stock_id, i_id, i_quantity, sh_id) values (sstock.nextval, 8, 20, 1); 
insert into STOCK(stock_id, i_id, i_quantity, sh_id) values (sstock.nextval, 9, 20, 1); 
insert into STOCK(stock_id, i_id, i_quantity, sh_id) values (sstock.nextval, 10, 20, 1); 
insert into STOCK(stock_id, i_id, i_quantity, sh_id) values (sstock.nextval, 11, 20, 1); 
insert into STOCK(stock_id, i_id, i_quantity, sh_id) values (sstock.nextval, 1, 20, 2); 
insert into STOCK(stock_id, i_id, i_quantity, sh_id) values (sstock.nextval, 2, 20, 2); 
insert into STOCK(stock_id, i_id, i_quantity, sh_id) values (sstock.nextval, 3, 20, 2); 
insert into STOCK(stock_id, i_id, i_quantity, sh_id) values (sstock.nextval, 4, 20, 2); 
insert into STOCK(stock_id, i_id, i_quantity, sh_id) values (sstock.nextval, 5, 20, 2); 
insert into STOCK(stock_id, i_id, i_quantity, sh_id) values (sstock.nextval, 6, 20, 2); 
insert into STOCK(stock_id, i_id, i_quantity, sh_id) values (sstock.nextval, 7, 20, 2); 
insert into STOCK(stock_id, i_id, i_quantity, sh_id) values (sstock.nextval, 8, 20, 2); 
insert into STOCK(stock_id, i_id, i_quantity, sh_id) values (sstock.nextval, 9, 20, 2); 
insert into STOCK(stock_id, i_id, i_quantity, sh_id) values (sstock.nextval, 10, 20, 2); 
insert into STOCK(stock_id, i_id, i_quantity, sh_id) values (sstock.nextval, 11, 20, 2); 

insert into PAYMENT(p_id, c_id, i_id, p_method, quantity, p_date) values (spayment.nextval, 2, 2, 'Bkash', 1, DATE '2020-1-17'); 
insert into PAYMENT(p_id, c_id, i_id, p_method, quantity, p_date) values (spayment.nextval, 1, 3, 'Cash', 2, DATE '2020-3-27'); 
insert into PAYMENT(p_id, c_id, i_id, p_method, quantity, p_date) values (spayment.nextval, 7, 1, 'Rocket', 1, DATE '2020-2-7'); 
insert into PAYMENT(p_id, c_id, i_id, p_method, quantity, p_date) values (spayment.nextval, 9, 5, 'Cash', 3, DATE '2020-2-10'); 
insert into PAYMENT(p_id, c_id, i_id, p_method, quantity, p_date) values (spayment.nextval, 11, 7, 'Bkash', 1, DATE '2020-7-17');

insert into ORDER1(o_id, c_id, i_id, advance, quantity, o_method, delivery_date ) values (sorder1.nextval, 1, 5, 500, 2, 'Bkash', DATE '2018-9-17'); 
insert into ORDER1(o_id, c_id, i_id, advance, quantity, o_method, delivery_date ) values (sorder1.nextval, 2, 3, 1500, 1, 'Cash', DATE '2018-9-17'); 
insert into ORDER1(o_id, c_id, i_id, advance, quantity, o_method, delivery_date ) values (sorder1.nextval, 5, 9, 1800, 3, 'Ucash', DATE '2018-9-17'); 
insert into ORDER1(o_id, c_id, i_id, advance, quantity, o_method, delivery_date ) values (sorder1.nextval, 8, 9, 2000, 3, 'Rocket', DATE '2020-8-27'); 
insert into ORDER1(o_id, c_id, i_id, advance, quantity, o_method, delivery_date ) values (sorder1.nextval, 10, 9, 1000, 2, 'Cash', DATE '2020-9-7'); 

column advance format 99,999.99;

SELECT * FROM CUSTOMER;		
SELECT * FROM MANAGER;
SELECT * FROM SHOP;
SELECT * FROM JOB;
SELECT * FROM EMPLOYEE;
SELECT * FROM ITEM;
SELECT * FROM STOCK;
SELECT * FROM PAYMENT;
SELECT * FROM V_PAYMENT;
SELECT * FROM ORDER1;
SELECT * FROM V_ORDER1;