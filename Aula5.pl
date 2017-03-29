% Extensão do predicado  par: N->{V,F,D}

par(0).
par(X):- par(X-2).

-par(1).
-par(X):- par(X-2).

%-----------------------------------------------------------------
% Extensão do predicado par2: N->{V,F,D}

par(0).
par(X):-
	N is X-2,
	N>=0,
	par(N).

-par(X) :-
	nao(par(X)).

%---------------------------------------------------
% As diferenças entre os dois predicados par está na negação e na parte do desconhecido uma vez que o segundo diz que é falso quando não há provas positivas (nunca há desconhecidos).
% No primeiro pode haver provas falsas mesmo que não haja provas verdadeiras.



%----------------------------------------------------------------------



