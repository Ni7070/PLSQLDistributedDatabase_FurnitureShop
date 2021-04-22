DROP VIEW V_MANAGER;
DROP VIEW V_SHOP;
DROP VIEW V_CUSTOMER;
DROP VIEW V_JOB;
DROP VIEW V_EMPLOYEE;
DROP VIEW V_ITEM;
DROP VIEW V_STOCK;
DROP VIEW VV_ORDER1;
DROP VIEW VV_PAYMENT;


CREATE VIEW V_MANAGER as
select * from manager
union
select * from manager@site_link;

--select * from V_MANAGER;

CREATE VIEW V_CUSTOMER as
select * from customer
union
select * from customer@site_link;
select * from V_CUSTOMER;
select* from customer;
select* from customer@site_link;

CREATE VIEW V_SHOP as
select * from shop
union
select * from shop@site_link;


--select * from V_SHOP;
CREATE VIEW V_JOB as
select * from job
union
select * from job@site_link;
--select * from V_JOB;


CREATE VIEW V_EMPLOYEE as
select * from employee
union
select * from employee@site_link;
--select * from V_EMPLOYEE;


CREATE VIEW V_ITEM as
select * from item
union
select * from item@site_link;
--select * from V_ITEM;


CREATE VIEW V_STOCK as
select * from stock
union
select * from stock@site_link;
--select * from V_STOCK;
CREATE VIEW VV_PAYMENT as
select * from v_payment
union
select * from v_payment@site_link;
select * from VV_PAYMENT;
CREATE VIEW VV_ORDER1 as
select * from v_order1
union
select * from v_order1@site_link;
--select * from VV_ORDER1;


