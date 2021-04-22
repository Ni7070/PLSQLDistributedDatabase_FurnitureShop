declare 
	c number := &choice;
	X V_shop.sh_address%type;
	--user_input_error EXCEPTION;
	mgrsal V_job.salary%type;

begin
	--DBMS_OUTPUT.PUT_LINE('press 1 to know which employee belongs where, '||'press 2 to know the due, '||'Press 3 know Employee salary'||'press 4 to know total salary of the managers');
	--EXCEPTION
		--WHEN user_input_error THEN
			--DBMS_OUTPUT.PUT_LINE('Shop at '||X||' does not exist');
	if c = 1 then
		X := '&Address';
		if X != 'Dhaka' AND X != 'Chittagong' then
			--Raise user_input_error;
			DBMS_OUTPUT.PUT_LINE('Shop at '||X||' does not exist');
		else 
			emp_loc(X);
			DBMS_OUTPUT.PUT_LINE(chr(10));
		
		end if;
	elsif c = 2 then
		dueCal;
		DBMS_OUTPUT.PUT_LINE(chr(10));
	elsif c = 3 then
		emp_sal_calculate;
		DBMS_OUTPUT.PUT_LINE(chr(10));
		DBMS_OUTPUT.PUT_LINE(chr(10));
	elsif c = 4 then
		mgrsal := totalsal;
		DBMS_OUTPUT.PUT_LINE('Total salary of managers: '|| mgrsal||' bdt');
		DBMS_OUTPUT.PUT_LINE(chr(10));
	else 
		DBMS_OUTPUT.PUT_LINE('Wrong choice');
		
	end if;
	
	
	
end;
/