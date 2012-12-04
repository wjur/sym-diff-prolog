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
	
% (make_mul  (change_fun (first expr) (nth 1 expr)) (diff (nth 1 expr) var)))
% (h(g))' = h'(g) * g'
diff(F, X, Hd * Gd) :-
    functor(F, H, 1),
    arg(1, H, G),
    
    change_fun(H, Hd),
    
    diff(G, X, Gd).
    %diff(H, X, Hd),
    %functor(HdG, Hd, 1),
    %arg(1,Hd,G).
	
    

% (f^g)' = f^(g-1)*(gf' + g'f logf) 
diff(F^G, V, F^(G-1)*(G*Fd + Gd*F*log(F))) :-
    diff(F, V, Fd),
    diff(G, V, Gd).

% diff sin = cos
%diff(sin(E), V, Ed*cos(E)) :-
%    diff(E,V, Ed).
    
%diff(cos(E), V, -Ed*sin(E)) :-
%    diff(E,V, Ed).
    
%diff(exp(E), V, Ed*exp(E)) :-
%    diff(E,V, Ed).
    
%diff(log(E), V, 1/Ed) :-
%    diff(E,V, Ed).

%change_fun(log(E), _, 1/E) :-

change_fun(sin(E), cos(E)). 

diff2(F,X, Hp + Gp) :-
    change_fun(F, Hp),
    arg(1, F, G),
    diff(G, X, Gp),
    %functor(HpG, Hp, 1).
    arg(1, HpG, G).


