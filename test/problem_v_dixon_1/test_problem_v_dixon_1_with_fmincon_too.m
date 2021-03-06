function test_problem_v_dixon_1_with_fmincon_too()
	u = [2; 2; 2; 2; 2; 2; 2; 2; 2; 2];
	v = [10; 10; 10; 10; 10; 10; 10; 10; 10; 10];
	x0 = [10; 10; 10; 10; 10; 10; 10; 10; 10; 10];
	tol = 0.00001;
	itmax = 100;
    A = [];
    b = [];
	G = [];
	r = [];
	G = [ G; -eye(length(u)); eye(length(v)) ];
	r = [ r; -u; v ];
	tic;
    [x_ssn,fval_ssn,it_ssn] = semismooth_newton('func_for_problem_v_dixon_1','grad_func_for_problem_v_dixon_1','hess_func_for_problem_v_dixon_1',A,b,G,r,x0,itmax,tol);
	t_ssn = toc;
	x1 = sprintf('%.3f ',x_ssn);
	f1 = sprintf('f(x_ssn) = %.3f',fval_ssn);
	t1 = sprintf('solved in %.2f ms.',t_ssn*1000);
	str1 = ['x_ssn = [ ', x1, '], ', f1, ', it = ', num2str(it_ssn), ', ', t1];
	tic;
    [x_sqp,fval_sqp,it_sqp] = seq_quad_prog('func_for_problem_v_dixon_1','grad_func_for_problem_v_dixon_1','hess_func_for_problem_v_dixon_1',A,b,G,r,x0,itmax,tol);
	t_sqp = toc;
	x2 = sprintf('%.3f ',x_sqp);
	f2 = sprintf('f(x_sqp) = %.3f',fval_sqp);
	t2 = sprintf('solved in %.2f ms.',t_sqp*1000);
	str2 = ['x_sqp = [ ', x2, '], ', f2, ', it = ', num2str(it_sqp), ', ', t2];
	options = optimset('Algorithm','active-set','Display','off');
	tic;
	[x_fmc,fval_fmc,exitflag,output] = fmincon('func_for_problem_v_dixon_1',x0,G,r,A,b,[],[],[],options);
	t_fmc = toc;
	x3 = sprintf('%.3f ',x_fmc);
	f3 = sprintf('f(x_fmc) = %.3f',fval_fmc);
	t3 = sprintf('solved in %.2f ms.',t_fmc*1000);
	str3 = ['x_fmc = [ ', x3, '], ', f3, ', ', t3];
	x0 = sprintf('%.3f ',x0);
	str0 = ['x0 = [ ', x0, ']'];
	disp(str0);
	disp(str1);
	disp(str2);
	disp(str3);
end
