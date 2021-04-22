
SET pages500;
SET linesize 132;
SET SERVEROUTPUT ON;

create or replace procedure emp_sal_calculate
		IS

	
begin 
	DBMS_OUTPUT.PUT_LINE('Emp Id'||'	'||'Emp Name'||'	'||'Job Name'||'		'||'Salary');
	for w in (select e_name, e_id, job_type, salary from V_employee, V_job 
				where v_employee.job_id = V_job.job_id) loop 
		DBMS_OUTPUT.PUT_LINE(w.e_id||'	'||w.e_name||'	'||w.job_type||'		'||w.salary);
		end loop;
		
		
end emp_sal_calculate;

/