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
% optymalizacja odejmowania
opt_sub(X, X, 0).
opt_sub(-Y, 0, Y).

opt_sub(W, X, Y) :-
	number(X),
	number(Y),
	W is X - Y.

opt_sub(0, X, Y) :- 
	X == Y.
	
opt_sub(X-Y, X, Y).

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

%%%%%%%%%%%%%%%%%%%%%%%%%%
% optymalizacja dzielenia
opt_div(_,_,0) :-
	throw(error(evaluation_error(zero_divisor),(is)/2)).
	
opt_div(0, 0, N).

opt_div(X, X, 1).

opt_div(1, X, Y) :-
	X == Y.
	
opt_div(W, X, Y) :-
	number(X),
	number(Y),
	W is X / Y.

opt_div(X/Y, X, Y).

%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%
% rozniczkowanie wlasciwe
%%%%%%%%%%%%%%%%%%%%%%%%%%
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
diff(E1 + E2, V, W) :- 
	diff(E1, V, Ed1),
	diff(E2, V, Ed2),
	opt_sum(W, Ed1, Ed2).

% subtraction
diff(E1 - E2, V, W) :- 
	diff(E1, V, Ed1),
	diff(E2, V, Ed2),
	opt_sub(W, Ed1, Ed2).
	
%%% iloczyn i optymalizacje
% (fg)' = f'g + fg'
diff(E1 * E2, V, W) :- 
	diff(E1, V, Ed1),
	diff(E2, V, Ed2),
	opt_mul(L, Ed1, E2),
	opt_mul(P, E1, Ed2),
	opt_sum(W, L, P).


%%% iloraz i optymalizacje	
% (f/g)' = (f'g - fg') / (g*g)
diff(E1 / E2, V, E) :- 
	diff(E1, V, Ed1),
	diff(E2, V, Ed2),
	opt_mul(A, Ed1,E2),
	opt_mul(B, E1,Ed2),
	opt_mul(C, E2,E2),
	opt_sub(D, A, B),
	opt_div(E, D,C).

% pochodne funkcji zgodnie ze wzorem
% (h(g))' = h'(g) * g'
diff(sin(E), V, M) :-
    diff(E,V, Ed),
	opt_mul(M, Ed, cos(E)).

diff(cos(E), V, K) :-
    diff(E,V, Ed),
	opt_mul(M, Ed,sin(E)),
	opt_sub(K, 0, M).
	
diff(tan(E), V, F) :-
    diff(E,V, Ed),
	opt_mul(A, Ed, 2),
	opt_mul(B, 2, E),
	opt_mul(C, 2, cos(B)),
	opt_sum(D, C, 1),
	opt_div(F, A, D).
	
diff(exp(E), V, F) :-
    diff(E,V, Ed),
	opt_mul(F, Ed, exp(E)).

diff(log(E), V, F) :-
    diff(E,V, Ed),
	opt_div(F, Ed, E).
	
% (f^g)' = f^(g-1)*(gf' + g'f logf) 
diff(F^G, V, FF) :-
    diff(F, V, Fd),
    diff(G, V, Gd),
	opt_sub(AA, G, 1),
	opt_mul(BB, G,Fd),
	opt_mul(CC, Gd, F),
	opt_mul(DD, CC, log(F)),
	opt_sum(EE, BB, DD),
	opt_mul(FF, F^(AA), EE).
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	



