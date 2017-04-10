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
:-dynamic cidade/1.
:-dynamic medico/2.
:-dynamic ut_inst_serv/3.
:-dynamic ut_serv_inst_data/5.
:-dynamic cuid_prestados/4.
:-dynamic act_medico/5.

%--------------------Base de conhecimento----------------------------------------------
% Extensao do predicado utente(IdUten,Nome,Idade,Morada) ->{V,F,D}

utente(1, rafaela, 24, rua).
utente(2, norberto, 22, apartamento).
utente(3, joao,22,vivenda).
utente(4, joaoM,22, moradia).
utente(5, pedro,20, moradia).
utente(10, rafaela, 25,rua).
-utente(15,manuel,58,vivenda).

-utente(Id,N,I,M):- nao(utente(Id,N,I,M)),
                    nao(excecao(utente(Id,N,I,M))).

%----------------------------------------------------------------------------------------
%Impossivel conhecer a morada do utente

utente(6,francisco,20,morada_desconhecida).
excecao(utente(Id,N,I,M)):- utente(Id,N,I,morada_desconhecida).
nulo(morada_desconhecida).
+utente(ID,NO,I,M):: ( solucoes( (ID,NO,I,M), (utente(6,francisco,20,M), nao(nulo(M))), S), comprimento(S,N), N==0 ).

%----------------------------------------------------------------------------------------
%Impossivel conhecer a idade do utente

utente(7,maria,idade_desconhecida,moradia).
excecao(utente(Id,N,I,M)):- utente(Id,N,idade_desconhecida,M).
nulo(idade_desconhecida).
+utente(ID,NO,I,M)::( solucoes((ID,NO,I,M), (utente(7,maria,I,moradia), nao(nulo(I))), S), comprimento(S,N), N==0 ).

%----------------------------------------------------------------------------------------
%Não se sabe ao certo o local o utente reside 

excecao(utente(8,beatriz,26,apartamento)).
excecao(utente(8,beatriz,26,moradia)).

%----------------------------------------------------------------------------------------
%Incerteza em relação a idade do utente

excecao(utente(9,duarte,I,apartamento)) :- I>=20,
                             			  I=<30.


%------Nome instituição------------------------------------------------------------------
% Extensao do predicado instituicao(Nome) ->{V,F}

instituicao(hospital_braga).
instituicao(hostpial_guimaraes).
instituicao(hospital_porto).
instituicao(hospital_porto_s_antonio).
instituicao(hospital_porto_s_joao).
instituicao(hospital_mirandela).
instituicao(hospital_lisboa).

%-----------Serviços----------------------------------------------------------------------
% Extensao do predicado servico(IDServico,Nome) ->{V,F}

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

%-----------Cidade-----------------------------------------------------------------------
% Extensao do predicado cidade(Nome) ->{V,F}

cidade(braga).
cidade(guimares).
cidade(mirandela).
cidade(porto).
cidade(lisboa).

%-----------Médico-----------------------------------------------------------------------
% Extensao do predicado médico(ID,Nome) ->{V,F}

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
% Extensao do predicado servico(IDServico,Nome) ->{V,F}

ut_serv_inst_data(1,isa, neurologia, hospital_mirandela, date(2017,01,01)).
ut_serv_inst_data(2,rita, ortopedia, hospital_braga, date(2017,01,02)).
ut_serv_inst_data(3,david, pediatria, hospital_guimaraes, date(2017,01,03)).
ut_serv_inst_data(4,luis, cirurgia, hospital_lisboa, date(2017,01,04)).



%------------------------------Cuidados prestados----------------------------
% Extensao do predicado cuid_prestados(IdServ,Descricao,Instituicao,Cidade) ->{V,F,D}


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

-cuid_prestados(Id,D,I,C):- nao(cuid_prestados(Id,D,I,C)),
							nao(excecao(cuid_prestados(Id,D,I,C))).

%----------------------------------------------------------------------------------------
%Não ser possivel saber se cirurgia é prestada no hospital_porto_s_antonio ou no hospital_porto_s_joao

excecao(cuid_prestados(12,cirurgia,hospital_porto_s_joao,porto)).
excecao(cuid_prestados(12,cirurgia,hospital_porto_s_antonio,porto)).


%----------------------------------Actos médicos----------------------------------
% Extensao do predicado act_medico(Data,IDUtente,IDServico,Instituicao,Custo) ->{V,F}
%date (ano,mes,dia)

act_medico(date(2017,01,10),1,1,hospital_porto,50).
act_medico(date(2017,01,10),1,2,hospital_porto,20).
act_medico(date(2016,02,11),2,2,hospital_lisboa,20).
act_medico(date(2015,03,12),3,3,hospital_guimaraes,25).
act_medico(date(2014,04,13),4,4,hospital_porto,35).
act_medico(date(2013,05,14),5,5,hospital_braga,40).
act_medico(date(2012,06,15),10,10,hospital_braga,15).


-act_medico(D,IdU,IdS,Inst,C):- nao(act_medico(D,IdU,IdS,Inst,C)),
							nao(excecao(act_medico(D,IdU,IdS,Inst,C))).


%----------------------------------------------------------------------------------------
%Impossivel de vir a conhecer a data em que o utente realizou determinado acto medico

act_medico(data_desconhecida,5,2,hospital_braga,45).
excecao(act_medico(D,IdU,IdS,Inst,C)):- act_medico(data_desconhecida,IdU,IdS,Inst,C). 
nulo(data_desconhecida).
+act_medico(D,IDU,IDS,Inst,C)::(solucoes((D,IDU,IDS,Inst,C), (act_medico(D,5,2,hospital_braga,45), nao(nulo(D))), S), comprimento(S,N), N==0 ).

%----------------------------------------------------------------------------------------
%Impossivel de vir a conhecer o custo de determinado servico que o utente realizou

act_medico(date(2017,04,01),5,2,hospital_porto,custo_desconhecido).
excecao(act_medico(D,IdU,IdS,Inst,C)):- act_medico(D,IdU,IdS,Inst,custo_desconhecido). 
nulo(custo_desconhecido).
+act_medico(D,IDU,IDS,Inst,C)::(solucoes( (D,IDU,IDS,Inst,C), (act_medico(date(2017,04,01),5,2,hospital_porto,C), nao(nulo(C))), S), comprimento(S,N), N==0 ).

%----------------------------------------------------------------------------------------
%Impossivel de vir a conhecer qual o servico que o utente usufruiu

act_medico(date(2017,03,01),4,servico_desconhecido,hospital_lisboa,24).
excecao(act_medico(D,IdU,IdS,Inst,C)):- act_medico(D,IdU,servico_desconhecido,Inst,C). 
nulo(servico_desconhecido).
+act_medico(D,IDU,IDS,Inst,C)::(solucoes( (D,IDU,IDS,Inst,C), (act_medico(date(2017,04,01),4,IDS,hospital_lisboa,24), nao(nulo(IdS))), S), comprimento(S,N), N==0 ).

%----------------------------------------------------------------------------------------
%Impossivel de vir a conhecer qual a instituicao a que o utente se dirigiu

act_medico(date(2017,01,01),4,2,hospital_desconhecido,24).
excecao(act_medico(D,IdU,IdS,Inst,C)):- act_medico(D,IdU,IdS,hospital_desconhecido,C). 
nulo(hospital_desconhecido).
+act_medico(D,IDU,IDS,Inst,C)::(solucoes( (D,IDU,IDS,Inst,C), (act_medico(date(2017,04,01),4,2,Inst,24), nao(nulo(Inst))), S), comprimento(S,N), N==0 ).

%----------------------------------------------------------------------------------------
%Não se sabe ao certo a instituicao a qual o utente se dirigiu


excecao(act_medico(date(2013,05,14),5,5,hospital_braga,40)).
excecao(act_medico(date(2013,05,14),5,5,hospital_guimaraes,40)).

%----------------------------------------------------------------------------------------
%Não saber ao certo quanto é que um utente dispendeu num determinado acto médico

excecao(act_medico(date(2017,02,15),1,3,hospital_mirandela,C)):- C>=10,
											  C=<50.



%-----------------------------------------------------------------------------------------------------------
% Contar o numero de utentes

conta_Utente(Numero):-(findall((ID,N,I,M),(utente(ID,N,I,M)),S),comprimento(S,Tamanho), Numero is Tamanho).


%------------------------------------------------------------------------------------------------------------
% Contar o numero de Servicos

conta_Cuidados(Numero):-(findall((ID,D,I,C),cuid_prestados(ID,D,I,C),S),comprimento(S,Tamanho), Numero is Tamanho).

%------------------------------------------------------------------------------------------------------------
% Contar o numero de Consultas

conta_Actos(Numero):-(findall((ID,U,S,I,C),act_medico(ID,U,S,I,C),S),comprimento(S,Tamanho), Numero is Tamanho).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite a evolucao do conhecimento e permite inserir conhecimento

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

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite a remoção de conhecimento

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


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado demo: Questao,Resposta -> {V,F}

demo( Questao,verdadeiro ) :-
    Questao.
demo( Questao,falso ) :-
    -Questao.
demo( Questao,desconhecido ) :-
    nao( Questao ),
    nao( -Questao ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

comprimento( S,N ) :-
    length( S,N ).

%---------------------------Invariantes------------------------------------------------------
%-------------------------------------------------------------------------------------------

%Não introduzir conhecimento repetido.
+utente(Codigo,_,_,_) :: (findall( K, utente(Codigo,_,_,_), S),comprimento(S,N),N==1 ).

%Não há serviços com códigos e nomes repetidos.
+servico(Codigo,Nome) :: (findall(K, (servico(Codigo,_), servico(_,Nome)), S), comprimento(S,N), N==1).

+instituicao(Nome) :: (findall(K, instituicao(Nome),S), comprimento(S,N), N==1).

+medico(Cod,_) :: (findall(K, medico(Cod,_), S),comprimento(S,N), N==1).

+cuid_prestados(ID,_,_,_) :: (findall((ID,_,_,_),cuid_prestados(ID,_,_,_),S),comprimento(S,N),N==1).

% So podemos adicionar um acto medico se o id do utente existir 
+act_medico(_,ID,_,_,_) :: (findall(NO,utente(ID,NO,_,_),S),comprimento(S,N),N==1).

% So podemos adicionar um acto medico se o id do servico existir
+act_medico(_,_,IDS,_,_) :: (findall(NO,servico(IDS,NO),S),comprimento(S,N),N==1).

% So podemos adicionar um acto medico se a instituicao existir
+act_medico(_,_,_,Inst,_) :: (findall(Inst,instituicao(Inst),S),comprimento(S,N),N==1).


%Não deixa remover instituições activas.
-instituicao(Nome):: (nao(ut_inst_serv(_,_,Nome,_))).


%Não deixa remover serviços activos.
-servico(Nome):: (nao(ut_inst_serv(_,_,_,Nome))).


% Nao deixar remover utentes que estejam nas consultas
-utente(Id,_,_,_) :: (nao(act_medico(_,Id,S,_,_)),nao(utente(Id,_,_,_))).