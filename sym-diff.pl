% diff(expr, var, dive)

% constant
diff(E, _, 0) :- number(E).

% the same variable
diff(E, V, 0) :- 
	atom(E),
	E \== V.
	
% other variables
diff(E, V, 1) :- 
	atom(E),
	E == V.
	
% sum
diff(E1 + E2, V, Ed1 + Ed2) :- 
	diff(E1, V, Ed1),
	diff(E2, V, Ed2).
	
% subtraction
diff(E1 - E2, V, Ed1 - Ed2) :- 
	diff(E1, V, Ed1),
	diff(E2, V, Ed2).
	

