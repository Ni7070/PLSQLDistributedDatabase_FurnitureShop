create or replace function totalsal
	return V_job.salary%type
	is

	c V_job.salary%type;

begin
	select sum(mgr_salary) into c  from V_manager;
	return c;
end totalsal;
/