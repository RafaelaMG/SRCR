:- dynamic filho/2.
:- dynamic pai/2.



filho(joao, jose).
filho(jose, manuel).
filho(carlos,jose).

pai(paulo, filipe).
pai(paulo, maria).

avo(antonio, nadia).

masculino(joao).
masculino(jose).
feminino(maria).
feminino(joana).

pai(P,F) :- 
	filho(F,P).

avo(A,N) :-
	filho(N,X),
	pai (A, X).


neto(N,A) :-
	avo(A,N).

% Extensao do predicado descendente: X,Y -> {V,F}

descendente(X,Y) :-
	filho(X,Y).
descendente(X,Y) :-
	filho (X,Z),
	descendente(Z,Y).

%-------------------------------------------------------------------------
% Extensao do predicado descendente: X,Y -> {V,F}

descendente(X,Y,1) :-
	filho(X,Y).
descendente(X,Y,N) :-
	filho(X,Z),
	descendente(Z,Y,G), N is G+1.

%----------------------------------------------------------------------
% Extensao do predicado avo: A,N -> {V,F}

avo(A,N) :-
	descendente(N,A,2).

%--------------------------------------------------------------------
% Extensao do predicado bisavo: X,Y -> {V,F}

bisavo(X,Y) :-
	descendente(Y,X,3).

%--------------------------------------------------------------------
% Extensao do predicado trisavo: X,Y -> {V,F}

trisavo(X,Y) :-
	descendente(Y,X,4).

%--------------------------------------------------------------------
% Extensao do predicado tetraneto: X,Y -> {V,F}

tetraneto(X,Y) :-
	trisavo(Y,X).













