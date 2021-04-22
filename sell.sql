SET SERVEROUTPUT ON;
SET VERIFY OFF;
DECLARE 
	u_i_id item.i_id%type;
	u_quantity stock.i_quantity%type;
	u_sh_id stock.sh_id%type;
	var_quantity stock.i_quantity%type;
	u_c_name customer.c_name%type;
	u_c_address customer.c_address%type;
	u_c_phno customer.c_phno%type;
	u_p_method payment.p_method%type;
	casecon int;
	u_advance order1.advance%type;
	

BEGIN
	u_i_id := &item_id;
	u_quantity := &item_quantity;
	u_sh_id := &which_shop;
	for i in(select i_quantity from stock@site_link where i_id = 
		(select i_id from item@site_link where i_id = u_i_id and sh_id = u_sh_id))LOOP
		IF i.i_quantity >= u_quantity THEN
			DBMS_OUTPUT.PUT_LINE('ITEM available in STOCK');
			var_quantity := i.i_quantity - u_quantity;
			DBMS_OUTPUT.PUT_LINE('New stock ' || var_quantity);
			--update stock@site_link
			--set i_quantity = var_quantity
			--where i_id = u_i_id and u_sh_id = sh_id;
			update stock
			set i_quantity = var_quantity
			where i_id = u_i_id and u_sh_id = sh_id;
			
			u_c_phno := '&customer_phno';
			u_c_name := '&customer_name';
			u_c_address := '&customer_address';
					
			
			insert into CUSTOMER(c_id, c_name, c_address, c_phno, sh_id) values (100, u_c_name, u_c_address, u_c_phno, u_sh_id); 
			insert into CUSTOMER@site_link(c_id, c_name, c_address, c_phno, sh_id) values (100, u_c_name, u_c_address, u_c_phno, u_sh_id); 
			u_p_method := '&payment_method';
			insert into PAYMENT(p_id, c_id, i_id, p_method, quantity, p_date) values (100, 100, u_i_id, u_p_method, u_quantity, sysdate); 
			insert into PAYMENT@site_link(p_id, c_id, i_id, p_method, quantity, p_date) values (100, 100, u_i_id, u_p_method, u_quantity, sysdate); 
			
			
		else
			DBMS_OUTPUT.PUT_LINE('Not available in current stock, But you can order');
			DBMS_OUTPUT.PUT_LINE('Press 1 to order, press 2 to end');
			casecon := &choose_1_or_2;
			if casecon = 1 Then
				u_c_phno:= '&customer_phno1';
				u_c_name := '&customer_name1';
				u_c_address := '&customer_address1';
				insert into CUSTOMER(c_id, c_name, c_address, c_phno, sh_id) values (100, u_c_name, u_c_address, u_c_phno, u_sh_id); 
				--insert into CUSTOMER@site_link(c_id, c_name, c_address, c_phno, sh_id) values (100, u_c_name, u_c_address, u_c_phno, u_sh_id); 
				u_advance := &pay_advance;
				u_p_method := '&payment_method1';
				insert into ORDER1(o_id, c_id, i_id, advance, quantity, o_method, delivery_date ) values (100, 100, u_i_id, u_advance, u_quantity, u_p_method, sysdate + 7); 
				--insert into ORDER1@site_link(o_id, c_id, i_id, advance, quantity, o_method, delivery_date ) values (100, 100, u_i_id, u_advance, u_quantity, u_p_method, sysdate + 7); 
			elsif casecon = 2 Then
				DBMS_OUTPUT.PUT_LINE('Thank you for coming!');
			else
				DBMS_OUTPUT.PUT_LINE('Wrong input');
			end if;
	
		end if;
	end loop;

end;
/

select * from stock;
select * from stock@site_link;
select * from customer;
select * from customer@site_link;
select * from payment;
select * from payment@site_link;
select * from order1;
select * from payment@site_link;