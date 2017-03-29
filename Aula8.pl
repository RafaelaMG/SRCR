:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

:-op(900,xfy,'::').
:- dynamic '-'/1.

-filho(F,P,M) :- nao(filho(F,P,M)), nao(excepcao(filho(F,P,M))).
+filho(F,P,M) :: (findall((P,M),filho(F,P,M),S), comprimento(S,L), L=<1).

-nasceu(N,D):-nao(nasceu(N,D)), nao(excepcao(nasceu(N,D))).
+nasceu(N,D)::(findall(D,nasceu(N,D),S), comprimento(S,L), L=<1).

excepcao(filho(F,P,M)):- filho(desconhecido,P,M).
excepcao(filho(F,P,M)):- filho(F,desconhecido,M).
excepcao(filho(F,P,M)):- filho(F,P,desconhecido).
excepcao(nasceu(N,data(dia,mes,ano))):- nasceu(N,data(desconhecido,mes,ano)).
excepcao(nasceu(N,data(dia,mes,ano))):- nasceu(N,data(dia,desconhecido,ano)).
excepcao(nasceu(N,data(dia,mes,ano))):- nasceu(N,data(dia,mes,desconhecido)).
excepcao(nasceu(N,D)):- nasceu(N,interdito).
nulo(interdito).

%-------------------------------------------Exe1-----------------------------------
filho(ana,abel,alice).
nasceu(ana,data(1,1,2010)).


%-------------------------------------------Exe2-----------------------------------
filho(anibal,antonio,alberta).
nasceu(anibal,data(2,1,2010)).


%-------------------------------------------Exe3-----------------------------------
filho(berta,bras,belem).
nasceu(berta,data(2,2,2010)).

filho(berto,bras,belem).
nasceu(berto,data(2,2,2010)).


%-------------------------------------------Exe4-----------------------------------

nasceu(catia,data(3,3,2010)).


%-------------------------------------------Exe5-----------------------------------

filho(crispim,desconhecido,catia).
excepcao(filho(crispim,celso,catia)).
excepcao(filho(crispim,caio,catia)).


%-------------------------------------------Exe6-----------------------------------


filho(danilo,daniel,desconhecido).
nasceu(danilo,data(4,4,2010)).


%-------------------------------------------Exe7-----------------------------------

filho(eurico,elias,elsa).
nasceu(eurico,data(desconhecido,5,2010)).
excepcao(nasceu(eurico,data(5,5,2010))).
excepcao(nasceu(eurico,data(15,5,2010))).
excepcao(nasceu(eurico,data(25,5,2010))).

%-------------------------------------------Exe8-----------------------------------

excepcao(filho(fabia,fausto,desconhecido)).
excepcao(filho(octavia,fausto,desconhecido)).



%-------------------------------------------Exe9-----------------------------------

filho(golias,guido,guida).
nasceu(golias,interdito).
+nasceu(N,D)::(findall(D,nasceu(golias,D),S),nao(nulo(D)),[]).


%-------------------------------------------Exe10-----------------------------------

-nasceu(helder,data(8,8,2010)).

%-----------------------------------------Exe11-------------------------------------

nasceu(ivo, data(desconhecido,6,2010)).
excepcao(nasceu(ivo,data(1, 6,2010))).
excepcao(nasceu(ivo,data(2, 6,2010))).
excepcao(nasceu(ivo,data(3, 6,2010))).



nao(Q) :- Q,!,fail.
nao(Q).

demo(Q,Verdadeiro) :- Q.
demo(Q,Falso) :- -Q.
demo(Q,Desconhecido) :- nao(Q), nao(-Q).

comprimento([],0).												
comprimento([X|Xs],R) :- comprimento(Xs,S), R is S+1.

% Inserção de conhecimento
evolucao(Termo) :- findall(Invariante,+Termo::Invariante,Lista),
    		    inserir(T),
    			teste(L).

inserir(T) :- assert(T).
inserir(T) :- retract(T),!,fail.

teste([]).
teste([R|LR]) :- R, teste(LR). 

