%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de Conhecimento do registo de eventos numa instituição de saúde

%--------------------------------- - - - - - - - - - - - - - - -
% SICStus PROLOG: Declaracoes iniciais

:- op( 900,xfy,'::' ).
:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

/* permitir adicionar a base de conhecimento	*/

:-dynamic utente/4.
:-dynamic instituicao/1.
:-dynamic servico/2.
:-dynamic date_time_value/3.
:-dynamic maior/2.
:-dynamic cidade/1.
:-dynamic medico/2.
:-dynamic ut_inst_serv/3.
:-dynamic ut_serv_inst_data/5.
:-dynamic cuid_prestados/4.

%--------------------Base de conhecimento----------------------------------------------

%----(codigo de utente, nome,idade,morada)--------

utente(1, rafaela, 24, rua).
utente(2, norberto, 22, apartamento).
utente(3, joao,22,vivenda).
utente(4, joaoM,22, moradia).
utente(5, pedro,20, moradia).
utente(10, rafaela, 25,rua).

%------Nome instituição-----------------------------------------------------------------

instituicao(hospital_braga).
instituicao(hostpial_guimaraes).
instituicao(hospital_porto).
instituicao(hospital_mirandela).
instituicao(hospital_lisboa).

%-----------Serviços-----------------------------------------------------------------------

servico(1,neurologia).
servico(2,ortopedia).
servico(3,pediatria).
servico(4,cirurgia).
servico(5,psiquiatria).
servico(6,oncologia).
servico(7,endocrinologia).
servico(8,urologia).
servico(9,cardiologia).
servico(10,psiquiatria).

cidade(braga).
cidade(guimares).
cidade(mirandela).
cidade(porto).
cidade(lisboa).

medico(1,isa).
medico(2,rita).
medico(3,david).
medico(4,luis).

%---------------------------------Actos por utente/instituiçao/serviço------------------------------
%-----------------------------(código de utente, medico, instituição, serviço)---------------------------

ut_inst_serv(1, isa, hospital_mirandela, pediatria).
ut_inst_serv(2, isa, hospital_mirandela, ortopedia).
ut_inst_serv(4, rita, hospital_mirandela, cirurgia).
ut_inst_serv(1, rita, hospital_mirandela, ortopedia).
ut_inst_serv(2, david, hospital_braga, ortopedia).
ut_inst_serv(4, david, hospital_braga, ortopedia).
ut_inst_serv(3, luis, hospital_guimaraes, pediatria).
ut_inst_serv(4, luis, hospital_lisboa, cirurgia).

%-----------------Actos por utente/serviço/instituição/data-----------------
%-----------------(código de utente, serviço, instituição, data)------------

ut_serv_inst_data(1,isa, neurologia, hospital_mirandela, date(2017,01,01)).
ut_serv_inst_data(2,rita, ortopedia, hospital_braga, date(2017,01,02)).
ut_serv_inst_data(3,david, pediatria, hospital_guimaraes, date(2017,01,03)).
ut_serv_inst_data(4,luis, cirurgia, hospital_lisboa, date(2017,01,04)).

%------------------------------Cuidados prestados----------------------------
%--------------------------(idServiço,descrição,instituição,cidade)----------

cuid_prestados(1, neurologia,hospital_braga,braga).
cuid_prestados(2, ortopedia,hospital_guimaraes,guimaraes).
cuid_prestados(3,pediatria,hospital_lisboa,lisboa).
cuid_prestados(4,cirurgia,hospital_mirandela,mirandela).
cuid_prestados(5,ortopedia,hospital_mirandela,mirandela).
cuid_prestados(6,cirurgia,hospital_lisboa,lisboa).
cuid_prestados(7, neurologia,hospital_guimaraes,guimaraes).
cuid_prestados(8, pediatria,hospital_porto,porto).
cuid_prestados(9, neurologia,hospital_porto,porto).
cuid_prestados(10, cirurgia,hospital_porto,porto).
cuid_prestados(11, psiquiatria,hospital_porto,porto).



%----------------------------------Actos médicos----------------------------------
%-----------------------(data,idUtente,idServ,Custo)-----------------------------------

act_medico(date(2017,01,01),1,1,50).
act_medico(date(2017,01,01),2,1,50).
act_medico(date(2017,01,01),3,1,50).
act_medico(date(2017,01,01),4,1,50).
act_medico(date(2017,01,01),1,2,50).

%---------------1-Registar utentes, cuidados prestados e atos médicos-------------------------------------------
%---------------------------------------------------------------------------------------------------------------
 
inserirConhecimento( Termo ) :-
    solucoes( Invariante,+Termo::Invariante,Lista ),
    insercao( Termo ),
    teste( Lista ).
 
insercao( Termo ) :-
    assert( Termo ).
insercao( Termo ) :-
    retract( Termo ),!,fail.
 
teste( [] ).
teste( [A|B] ) :-
    A,
    teste( B ).
 
solucoes( X,Y,Z ) :-
    findall( X,Y,Z ).



%---------------2-Identificar os utentes por critério de selecção (Idade,Código,Nome,Morada) -----------------------------------------------
%-------------------------------------------------------------------------------------------------------------------------------------------


%selec_idade: X,Y->{V,F}

selec_idade(X,Uten):-findall((Cod,Nome),utente(Cod,Nome,X,_), Uten).



%selec_cod: X,Y->{V,F}

selec_cod(Cod,Uten):- findall((Cod,Nome), utente(Cod,Nome,_,_),Uten).



%selec_nome X,Y->{V,F}
	
selec_nome(Nome,Uten):-findall((Cod,Nome),utente(Cod,Nome,_,_),Uten). 


%selec_morada X,Y->{V,F}

selec_morada(Morada,Uten):- findall((Cod,Nome), utente(Cod,Nome,_,Morada),Uten).





%---------------3- Identificar as instituições prestadoras de cuidados de saúde---------------------------------
%---------------------------------------------------------------------------------------------------------------
% Extensao do predicado  instCuid  : cuid_prestados,[Instituições]->{V,F}

instCuid(Instituicao,Cuid):-findall(K,cuid_prestados(_,K,Instituicao,_),L),
											eliminarRepetidos(L,Cuid).      






%---------------4-Identificar os cuidados prestados por instituição/cidade--------------------------------------
%---------------------------------------------------------------------------------------------------------------

% Extensao do predicado  cuidInst  : cuid_prestados,[Instituições]->{V,F}

cuidInst(Cuidado,Inst):-findall(K,cuid_prestados(_,Cuidado,K,_),L),
											eliminarRepetidos(L,Inst).      



% Extensao do predicado  cuidCid  : cuid_prestados,[Cidades]->{V,F}


cuidCid(Cuidado,Cid):-findall(K,cuid_prestados(_,Cuidado,_,K),L),
											eliminarRepetidos(L,Cid).      






%---------------5-Identificar os utentes de uma instituição/serviço---------------------------------------------
%---------------------------------------------------------------------------------------------------------------
% Extensao do predicado  instUtentes : Instituicao,[utentes]->{V,F}

instUtentes(Inst,Uten):-findall((K,J),(ut_inst_serv(K,_,Inst,_),utente(K,J,_,_)),L),
														eliminarRepetidos(L,Uten).      



% Extensao do predicado  serUtentes  : Serviço,[utentes]->{V,F}

serUtentes(Serv,Uten):-findall((K,J),(ut_inst_serv(K,_,_,Serv),utente(K,J,_,_)),L), 
											eliminarRepetidos(L,Uten).      







%---------------6-Identificar os atos médicos realizados, por utente/instituição/serviço------------------------
%---------------------------------------------------------------------------------------------------------------


medUtentes(Cod,Uten):-findall((Cod,Nome,Tipo,Medico),(ut_inst_serv(Cod,Medico,Tipo,_),utente(Cod,Nome,_,_)),L), 
											eliminarRepetidos(L,Uten). 


medInst(Nome, Inst):- findall((Nome,Tipo,Medico), ut_inst_serv(_,Medico,Tipo,Nome), L),
													eliminarRepetidos(L,Inst).											


medServ(Nome,Serv):- findall((Nome, Local, Medico), ut_inst_serv(_,Medico,Nome,Local), L),
													eliminarRepetidos(L,Serv).







%---------------7-Determinar todas as instituições/serviços a que um utente já recorreu-------------------------
%---------------------------------------------------------------------------------------------------------------
% Extensao do predicado  utentesInst  : utente,[Instituicao]->{V,F}
ut_inst_serv(1, hospital_mirandela, pediatria).

utentesInst(Cod,Inst):- findall(K,ut_inst_serv(Cod,_,K,_),L),
                                    eliminarRepetidos(L,Inst).


% Extensao do predicado  instSer  : utente,[Serviço]->{V,F}

utentesServ(Cod,Inst):- findall(K,ut_inst_serv(Cod,_,_,K),L),
                                    eliminarRepetidos(L,Inst).





%---------------8-Calcular o custo total dos atos médicos por utente/serviço/instituição/data-------------------
%---------------------------------------------------------------------------------------------------------------

custoUten(Cod,Uten):- -findall((Cod,Total), act_medico(_,Cod,_,Total),L),
									Total is Total + Total.









%---------------9-Remover utentes, cuidados e atos médicos------------------------------------------------------
%---------------------------------------------------------------------------------------------------------------

removerConhecimento( Termo ) :-
    solucoes( Invariante,-Termo::Invariante,Lista ),
    remover( Termo ),
    teste( Lista ).
 
remover( Termo ) :-
    retract( Termo ).
remover( Termo ) :-
    assert( Termo ),!,fail.
 
teste( [] ).
teste( [A|B] ) :-
    A,
    teste( B ).
 
solucoes( X,Y,Z ) :-
    findall( X,Y,Z ).

%-----------------------------------------------------------------------------------------------------------------------

% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

 
comprimento( S,N ) :-
    length( S,N ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado eliminarRepetidos: Lista,Resultados -> {V, F}

eliminarRepetidos( [],[] ) .
eliminarRepetidos( [H|T],[H|R] ) :- eliminaElemento( H,T,T2 ),
					eliminarRepetidos( T2,R ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado eliminaElemento: Elemento,Lista,Resultados -> {V, F}
	
eliminaElemento( _,[],[] ) .
eliminaElemento( E,[E|T],T1 ) :- eliminaElemento( E,T,T1 ).
eliminaElemento( E,[H|T],[H|T1] ) :- E\==H,
					eliminaElemento( E,T,T1 ).



%---------------------------Invariantes------------------------------------------------------
%-------------------------------------------------------------------------------------------

%Não introduzir conhecimento repetido.


+utente(Codigo,_,_,_) :: (findall( K, utente(Codigo,_,_,_), S),comprimento(S,N),N==1 ).


%Não há serviços com códigos e nomes repetidos.
+servico(Codigo,Nome) :: (findall(K, (servico(Codigo,_), servico(_,Nome)), S), comprimento(S,N), N==1).




+instituicao(Nome) :: (findall(K, instituicao(Nome),S), comprimento(S,N), N==1).




+medico(Cod,_) :: (findall(K, medico(Cod,_), S),comprimento(S,N), N==1).




%Não deixa remover instituições activas.
-instituicao(Nome):: (nao(ut_inst_serv(_,_,Nome,_))).




%Não deixa remover serviços activos.
-servico(Nome):: (nao(ut_inst_serv(_,_,_,Nome))).