module portos

abstract sig Armazenador{
	conteiners: some Conteiner
}

abstract sig ContemCombustivel{
	combustivel: one Combustivel
}

abstract sig Combustivel{}

abstract sig Transporte extends ContemCombustivel {
	fonte: lone Porto
}

abstract sig Nivel {}

sig Alto, Medio, Baixo extends Nivel{}

sig Porto extends Armazenador{}

one sig Caminhao, Navio extends Transporte{}

sig Gasolina, Petroleo, Diesel extends Combustivel{}

sig Conteiner extends ContemCombustivel{
	nivel: one Nivel,
	notificacao: lone Notificacao
}

sig Notificacao{
	transporte: one Transporte
}

fact notificacaoExclusiva{
	all n: Notificacao | one n.~notificacao
}

fact conteinerNivel{
	all n: Nivel | one n.~nivel
}

fact conteinerExclusivo{
	all c: Conteiner | one (c.~conteiners) 
}

fact combustivelPai{
	all c: Combustivel | one c.~combustivel
}

fact existeNotificacao{
	all c: Conteiner | (one c.notificacao) <=> some(c.nivel&Baixo)
}

fact notificacaoTransporteOrigemUnica{
	all n: Notificacao | (one obterFonte[n]) and (obterFonte[n] != n.~notificacao.~conteiners) 
}

fact caminhaoNotificacaoUnico{
	all t: Transporte | one t.~transporte
}

fact notificacaoCombustivelTipo{
	all n: Notificacao |  testaTipo[Petroleo, n] and testaTipo[Diesel, n] and testaTipo[Gasolina, n]
}

fact notificacaoCombustivelNecessario{
	all n: Notificacao | testaTipoPedido[Gasolina, n] and testaTipoPedido[Petroleo, n] and testaTipoPedido[Diesel, n] 
}

pred testaTipoPedido[c : Combustivel, n: Notificacao]{
	one(c & n.~notificacao.combustivel) => some(c & n.transporte.combustivel)
}

fun obterFonte [n : Notificacao] : one Porto {
	n.transporte.fonte
}

fun obtemCombustivel[c : Combustivel, p: Porto]: some Combustivel{
	p.conteiners.combustivel & c
}


pred testaTipo[c : Combustivel, n: Notificacao]{
	one(c & n.transporte.combustivel) => some(obtemCombustivel[c, obterFonte[n]]) and obtemCombustivel[c,obterFonte[n]].~combustivel.nivel in (Alto+Medio)  }

pred show[]{
 	#Notificacao = 2
}

run show for 5
