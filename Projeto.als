module portos

sig Porto extends Armazenador{
	notificacao: lone Notificacao
}

abstract sig Transporte extends Armazenador{}

one sig Caminhao, Navio extends Transporte{}

sig Combustivel{}

sig Gasolina, Petroleo, Diesel extends Combustivel{}

sig Conteiner {
	nivel: one Nivel, 
	combustivel: one Combustivel
}

abstract sig Armazenador{
	conteiners: some Conteiner
}

sig Notificacao{}

abstract sig Nivel {}
sig Alto, Medio, Baixo extends Nivel{}

fact notificacaoExclusiva{
	all n: Notificacao | one n.~notificacao
}

fact conteinerNivel{
	all n: Nivel | one n.~nivel
}

fact conteinerExclusivo{
	all c: Conteiner | one (c.~conteiners) 
}

fact transporteCaminhao{
	all c: Combustivel | one c.~combustivel
}

fact existeNotificacao{
	all p: Porto | (one p.notificacao) <=> some(Baixo.~nivel&p.conteiners)
}

pred show[]{
}
run show for 5
