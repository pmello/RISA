#include "rwmake.ch"
#include "protheus.ch"

//Ponto de Entrada que habilita outros campos na tela de Prestação de Contas, na rotina Movimentos (FINA560). 

User Function FT560CPC
Local aRet := {}
 aadd(aRet,"EU_FILORI")
 aadd(aRet,"EU_VIAGEM")
 aadd(aRet,"EU_CODDES")
Return aRet

 