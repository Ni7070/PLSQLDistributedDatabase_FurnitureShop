
SET pages500;
SET linesize 132;
SET SERVEROUTPUT ON;

create or replace procedure emp_loc(i_sh_address V_Shop.sh_address%type)
		IS


begin 
	DBMS_OUTPUT.PUT_LINE('Emp Id'||'	'||'Emp Name'||'	'||'Location');
	for p in (select e_id, e_name, sh_address from V_employee join V_manager
				on V_employee.mgr_id = V_manager.mgr_id join V_Shop
				on V_manager.mgr_id = V_Shop.mgr_id
				where V_shop.sh_address = i_sh_address) loop 
		DBMS_OUTPUT.PUT_LINE(p.e_id||'	'||p.e_name||'	'||p.sh_address);
		end loop;
	
		
end emp_loc;


/