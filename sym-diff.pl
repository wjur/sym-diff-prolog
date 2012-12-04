% diff(expr, var, div)

%%%%%%%%%%%%%%%%%%%%%%%%%%
% optymalizacja dodawania
opt_sum(X, X, 0).
opt_sum(Y, 0, Y).

opt_sum(W, X, Y) :-
	number(X),
	number(Y),
	W is X + Y.

opt_sum(2*X, X, Y) :- 
	X == Y.
	
opt_sum(X+Y, X, Y).

%%%%%%%%%%%%%%%%%%%%%%%%%%
% optymalizacja mnozenia
opt_mul(0, 0, _).
opt_mul(0, _, 0).

opt_mul(Y, 1, Y).
opt_mul(X, X, 1).

opt_mul(Y, X, Y) :-
	X == 1.

	
opt_mul(W, X, Y) :-
	number(X),
	number(Y),
	W is X * Y.

opt_mul(X*Y, X, Y).

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

%%%% sumy i optymalizacja sum	
% sum
diff(E1 + E2, V, Ed1pEd2) :- 
	diff(E1, V, Ed1),
	diff(E2, V, Ed2),
	opt_sum(Ed1pEd2, Ed1, Ed2).


%%% roznice i optymalizacja roznic	
diff(E1 - E2, V, Ed1) :- 
	diff(E1, V, Ed1),
	diff(E2, V, Ed2),
	Ed2 == 0.
	
diff(E1 - E2, V, Ed2) :- 
	diff(E1, V, Ed1),
	diff(E2, V, Ed2),
	Ed1 == 0.

diff(E1 - E2, V, Ed) :- 
	diff(E1, V, Ed1),
	diff(E2, V, Ed2),
	number(Ed1),
	number(Ed2),
	Ed == (Ed1 + Ed2).	

% subtraction
diff(E1 - E2, V, Ed1 - Ed2) :- 
	diff(E1, V, Ed1),
	diff(E2, V, Ed2).
	
%%% iloczyn i optymalizacje
% (fg)' = f'g + fg'
% mnozenie razy 0
diff(E1 * E2, V, E1*Ed2) :- 
	diff(E1, V, Ed1),
	diff(E2, V, Ed2),
	Ed1 == 0.
	
diff(E1 * E2, V, Ed1*E2) :- 
	diff(E1, V, Ed1),
	diff(E2, V, Ed2),
	Ed2 == 0.
	
diff(E1 * E2, V, 0) :- 
	diff(E1, V, Ed1),
	diff(E2, V, Ed2),
	Ed2 == 0,
	Ed1 == 0.

% mnozenie razy 1
diff(E1 * E2, V, E2 + E1*Ed2) :- 
	diff(E1, V, Ed1),
	diff(E2, V, Ed2),
	Ed1 == 1.
	
diff(E1 * E2, V, Ed1*E2 + E1) :- 
	diff(E1, V, Ed1),
	diff(E2, V, Ed2),
	Ed2 == 1.

diff(E1 * E2, V, E2 + E1) :- 
	diff(E1, V, Ed1),
	diff(E2, V, Ed2),
	Ed1 == 1,
	Ed2 == 1.
	


diff(E1 * E2, V, mEd1E2 + mE1Ed2) :- 
	diff(E1, V, Ed1),
	diff(E2, V, Ed2),
	opt_mul(mEd1E2, Ed1, E2),
	opt_mul(mE1Ed2, E1, Ed2).

%diff(E1 * E2, V, Ed1*E2 + E1*Ed2) :- 
%	diff(E1, V, Ed1),
%	diff(E2, V, Ed2).


%%% iloraz i optymalizacje	
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



