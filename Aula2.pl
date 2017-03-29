:- dynamic soma/2.
:- dynamic soma2/2.


% 1- Extensão do predicado soma: A,N,G -> {V,F}

soma(X,Y,Z) :-
	Z is X+Y.

% 2- Extensão do predicado op: A,N,OP,G -> {V,F}

op(X,Y,+,Z):-
	Z is X+Y.

op(X,Y,-,Z):-
	Z is X-Y.

op(X,Y,*,Z):-
	Z is X*Y.

op(X,Y,/,Z):-
	Y\=0,
	Z is X/Y.

% 3 - Extensão do predicado somat: A,N,G,W -> {V,F}

somat(X,Y,Z,R):-
	R is X+Y+Z.

 
% 4- Extensao do predicado soma2: L,R -> {V,F}
 
soma2([],0).
soma2([X | Tail],R) :-
    soma2(Tail, R2), R is X + R2 .

% 5- Extensao do predicado op_conj: L,OP,R -> {V,F}

op_conj([], + , 0).
op_conj([], - , 0).
op_conj([], * , 1).
op_conj([], / , 1) .
op_conj([X | Rest], OP, R) :-
    op(Rest, OP, R2),
    op(R2, X, OP, R).

% 6- Extensao do predicado maior: L,R->{V,F}

maior([X],X).
maior([Y | L], X) :-
	maior(L,N),
	X>N.

maior([Y| L], N) :-
	maior(L,N)
	X<=N.