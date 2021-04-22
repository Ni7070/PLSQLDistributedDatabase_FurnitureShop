--calculate due
SET pages500;
SET linesize 132;
SET SERVEROUTPUT ON;

create or replace procedure dueCal
		IS

	total_due VV_order1.due%type;
begin 
	DBMS_OUTPUT.PUT_LINE('Customer Name'||'		'||'Due');
	for x in (select c_name, due from V_customer, VV_order1 
				where v_customer.c_id = VV_order1.c_id) loop 
		DBMS_OUTPUT.PUT_LINE(x.c_name||'		'||x.due);
		end loop;
		
		select sum(due) into total_due from VV_order1;
	DBMS_OUTPUT.PUT_LINE('______________________________');
	DBMS_OUTPUT.PUT_LINE('Total due = 		'||Total_due||' bdt');

end dueCal;

/