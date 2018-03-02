module portos

sig Porto extends Armazenador{
	notificacao: lone Notificacao
}

abstract sig Transporte extends Armazenador{
}

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

fact conteinerNivel{
	all n: Nivel | one n.~nivel
}

fact conteinerExclusivo{
	all c: Conteiner | one (c.~conteiners) 
}

fact transporteCaminhao{
	all c: Combustivel | one c.~combustivel
}

pred show[]{
	#Porto = 3
}
run show for 5
