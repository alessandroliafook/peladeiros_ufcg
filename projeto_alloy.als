module futebol

------------------------------------------------------------------------
-- PROJETO ALLOY: GESTÃO DE UM TIME DE FUTEBOL

-- GRUPO: 4

--	ALESSANDRO SANTOS
--	IONESIO JUNIOR
--	LUCAS XAVIER
-- 	RONNYLDO SILVA

-- CLIENTE: VICTOR EMANUEL FARIAS

-- PROFESSOR: TIAGO MASSONI

-------------------------------------------------------------------------


-- ASSINATURAS

one sig Clube {

	diretoria : one Diretoria,

	sub18 : one Sub18,
	sub20 : one Sub20,
	principal : one TimePrincipal
	
}
-------------------------------------------------------------------------------------------------------------------------------
abstract sig Time {
	treinador : one Treinador,
	esquema : one Esquema
}

one sig Sub18 extends Time {
	titulares : set JogadorSub18,
	reservas : set JogadorSub18
} {#titulares = 11 and #reservas >= 7 and #reservas <= 14}

one sig Sub20 extends Time {
	titulares : set JogadorSub20,
	reservas : set JogadorSub20
} {#titulares = 11 and #reservas >= 7 and #reservas <= 14}

one sig TimePrincipal extends Time {
	titulares : set Jogador,
	reservas : set Jogador
} {#titulares = 11 and #reservas >= 7 and #reservas <= 14}

sig Treinador {}

abstract sig Esquema {}

sig Esquema433 extends Esquema {}
sig Esquema352 extends Esquema {}
sig Esquema442 extends Esquema {}

sig Jogador {}

sig JogadorSub20 extends Jogador {}

sig JogadorSub18 extends Jogador {}

-------------------------------------------------------------------------------------------------------------------------------
one sig Diretoria {
	presidente : one Presidente,
	membro : one Membro
}

one sig Presidente {}

abstract sig Membro {}
sig DiretorAdministrativo extends Membro {}
sig GerenteDeFutebol extends Membro {}

-------------------------------------------------------------------------------------------------------------------------------
-- FATOS

fact ClubeFatos {
	#Esquema433 = 1
	#Esquema442 = 1
	#Esquema352 = 1
}

fact JogadorFatos{
	
}


-- CRIAÇAO DO DIAGRAMA

pred show[] { }

run show for 50

--TESTES
