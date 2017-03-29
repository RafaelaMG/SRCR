:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

:-op(900,xfy,'::').
:- dynamic '-'/1.

nao(Q) :- Q,!,fail.
nao(Q).

demo(Q,V) :- Q.
demo(Q,F) :- -Q.
demo(Q,D) :- nao(Q), nao(-Q).

voo(X) :- ave(X), nao(excepcao(voo(X))).
-voo(X) :- mamifero(X), nao(excepcao(-voo(X))).
-voo(tweety).

ave(pitigui).
ave(X) :- canario(X).
ave(X) :- periquito(X).

canario(piupiu).

mamifero(silvestre).
mamifero(X) :- cao(X).
mamifero(X) :- gato(X).

cao(boby).

ave(X) :- avestruz(X).
ave(X) :- pinguim(X).

avestruz(trux).
pinguim(pingu).

mamifero(X) :- morcego(X).

morcego(batememan).

excepcao(voo(X)) :- avestruz(X).
excepcao(voo(X)) :- pinguim(X).
excepcao(-voo(X)) :- morcego(X).

% Inserção de conhecimento
evolucao(Termo) :- solucoes(Invariante,+Termo::Invariante,Lista),
    		    inserir(T),
    			teste(L).

inserir(T) :- assert(T).
inserir(T) :- retract(T),!,fail.

teste([]).
teste([R|LR]) :- R, teste(LR).

solucoes (X,Y,Z) :- 
			findall(X,Y,Z). 

% consult('ficha06.pl').