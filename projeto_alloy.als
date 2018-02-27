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
{
sub18.treinador != sub20.treinador 
and sub20.treinador != principal.treinador 
and sub18.treinador != principal.treinador
}
-------------------------------------------------------------------------------------------------------------------------------
abstract sig Time {
	treinador : one Treinador,
	esquema : one Esquema,
	titulares : set Jogador,
	reservas : set Jogador,
	capitao :  one Jogador
}

one sig Sub18 extends Time {}
one sig Sub20 extends Time {}
one sig TimePrincipal extends Time {}

sig Treinador {}
sig Jogador {}

abstract sig Esquema {}

one sig Esquema433 extends Esquema {}
one sig Esquema352 extends Esquema {}
one sig Esquema442 extends Esquema {}

-------------------------------------------------------------------------------------------------------------------------------
one sig Diretoria {
	presidente : one Presidente,
	membro : one Membro
}

one sig Presidente {}

abstract sig Membro {}
sig DiretorAdministrativo extends Membro {}
sig GerenteDeFutebol extends Membro {}

-- FATOS

fact ClubeFatos {
}

fact TimeFatos {
	all sub20 : Sub20, sub18 : Sub18, j1:Jogador, j2: Jogador | (verificaJogador[j1, sub18] and verificaJogador[j2, sub20]) => j1 != j2
	all t:Time, j1:Jogador, j2: Jogador | (verificaTitular[j1, t] and verificaReserva[j2, t]) => j1 != j2
	all t:Time | #getTitulares[t] = 11 and #getReservas[t] >= 7 and #getReservas[t] <= 14
	all t: Time | verificaCapitao[t] 
}

fact JogadorFatos{
}

-- PREDICADOS

pred verificaJogador[j:Jogador, t:Time] {
	j in getJogadores[t]
}

pred verificaTitular[j:Jogador, t:Time] {
	j in t.titulares
}

pred verificaReserva[j:Jogador, t:Time] {
	j in t.reservas
}

pred verificaCapitao[t:Time] {
	t.capitao in getTitulares[t]
}

-- FUNCOES

fun getJogadores[t:Time] : set Jogador {
	t.titulares + t.reservas
}

fun getTitulares[t:Time] : set Jogador {
	t.titulares
}

fun getReservas[t:Time] : set Jogador {
	t.reservas
}

-- CRIAÇAO DO DIAGRAMA

pred show[] { }

run show for 50

--TESTES

assert temJogadoresSuficientes {
	all t: Time | #(getTitulares[t]) = 11
	all t: Time | #(getReservas[t]) >= 7 and #(getReservas[t]) =< 14
	all t:Time | #(getJogadores[t]) >= 18 and #(getJogadores[t]) <= 25
}

assert todoTimeTemUmCapitao {
	all t: Time | one t.capitao and t.capitao in getTitulares[t] and not t.capitao in getReservas[t]  
}

assert peloMenosUmCargo {
	all c: Clube | one c.diretoria.presidente and one c.diretoria.membro
}

assert jogadoresDiferentes {
	all j:Jogador, sub20:Sub20, sub18:Sub18 | not(j in getJogadores[sub20] and j in getJogadores[sub18])
}

assert jogadoresTitularesEReservasDiferentes {
	all j:Jogador, t:Time | not(j in getTitulares[t] and j in getReservas[t])
}

check temJogadoresSuficientes for 50
check todoTimeTemUmCapitao for 50
check peloMenosUmCargo for 50
check jogadoresDiferentes for 50
check jogadoresTitularesEReservasDiferentes for 50
