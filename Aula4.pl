%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Ficha4

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

:- op(900,xfy,'::').
:- dynamic (filho/2, pai/2, neto/2, avo/2, descendente/3, temp/1).

%------1
filho(joao, jose).
filho(jose, manuel).
filho(carlos,jose).

pai(paulo,filipe). 									
pai(paulo,maria).									
pai(P,F) :- filho(F,P). 

neto(N,A) :- avo(A,N).

descendente(D,A,1) :- filho(D,A).							
descendente(D,A,1) :- pai(A,D). 							
descendente(D,A,G) :- filho(D,Z), descendente(Z,A,N), G is N+1. 	
descendente(D,A,G) :- pai(Z,D), descendente(Z,A,N), G is N+1. 	

comprimento([],0).												
comprimento([X|Xs],R) :- comprimento(Xs,S), R is S+1.

%-------Resolução------------------------------------

+filho(F,P) :: (findall((F,P),filho(F,P),S), comprimento(S,L), L==1).

+pai(P,F) :: (findall((P,F),pai(P,F),S), comprimento(S,L), L==1). 	

+neto(N,A) :: (findall((N,A),neto(N,A),S), comprimento(S,L), L==1). 		

+avo(A,N) :: (findall((A,N),avo(A,N),S), comprimento(S,L), L==1). 

+descendente(D,A,G)::
		(findall((D,A,G),descendente(D,A,G),S), comprimento(S,L), L==1).

+filho(F,P) :: (findall(P2,(filho(F,P2)),S), comprimento(S,L), L=<2).

+pai(P,F):: (findall(F2, pai(P,F2)),S), comprimento (S,L), L<=2).

+neto(N,A) :: (findall(N2,(filho(N2,A)),S), comprimento(S,L), L=<4).

+avo(A,N) :: (findall(A2,(filho(A2,N)),S), comprimento(S,L), L=<4).

+descendente(X,Y,Z):: number(Z).










% Invariante Estrutural:  nao permitir a insercao de conhecimento
%                         repetido

+filho( F,P ) :: (solucoes( (F,P),(filho( F,P )),S ),
                  comprimento( S,N ), 
				  N == 1
                  ).