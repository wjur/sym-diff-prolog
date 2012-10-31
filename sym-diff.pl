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
	
% (fg)' = f'g + fg'
diff(E1 * E2, V, Ed1*E2 + E1*Ed2) :- 
	diff(E1, V, Ed1),
	diff(E2, V, Ed2).
	
% (f/g)' = (f'g - fg') / (g*g)
diff(E1 / E2, V, (Ed1*E2 - E1*Ed2)/(E2*E2)) :- 
	diff(E1, V, Ed1),
	diff(E2, V, Ed2).
	
% (h(g))' = h'(g) * g'
%diff(F, X, Hd(G) * Gd) :-
%	functor(F, __, 2),
%	arg(0, F, G),
	
% (f^g)' = f^(g-1)*(gf' + g'f logf) 
