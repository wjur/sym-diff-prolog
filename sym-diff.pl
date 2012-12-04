% diff(expr, var, div)

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

% cokolwiek + 0	
diff(E1 + E2, V, Ed1) :- 
	diff(E1, V, Ed1),
	diff(E2, V, Ed2),
	Ed2 == 0.
	
% 0 + cokolwiek	
diff(E1 + E2, V, Ed2) :- 
	diff(E1, V, Ed1),
	diff(E2, V, Ed2),
	Ed1 == 0.
	
% suma 2 liczb
diff(E1 + E2, V, Ed) :- 
	diff(E1, V, Ed1),
	diff(E2, V, Ed2),
	number(Ed1),
	number(Ed2),
	Ed == (Ed1 + Ed2).
	
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

% pochodne funkcji zgodnie ze wzorem
% (h(g))' = h'(g) * g'
diff(sin(E), V, Ed*cos(E)) :-
    diff(E,V, Ed).

diff(cos(E), V, -Ed*sin(E)) :-
    diff(E,V, Ed).
	
diff(tan(E), V, Ed*2/(2*cos(2*E)+1)) :-
    diff(E,V, Ed).

diff(exp(E), V, Ed*exp(E)) :-
    diff(E,V, Ed).	

diff(log(E), V, Ed/E) :-
    diff(E,V, Ed).		
	
% (f^g)' = f^(g-1)*(gf' + g'f logf) 
diff(F^G, V, F^(G-1)*(G*Fd + Gd*F*log(F))) :-
    diff(F, V, Fd),
    diff(G, V, Gd).



