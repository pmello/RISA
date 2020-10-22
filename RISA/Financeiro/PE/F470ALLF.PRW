#include "rwmake.ch"
#include "protheus.ch"
/*
PE para trazer o Extrato Bancário Compartilhado
https://centraldeatendimento.totvs.com/hc/pt-br/articles/360016590352-MP-SIGAFIN-FINR470-Relat%C3%B3rio-Extrato-Banc%C3%A1rio-n%C3%A3o-apresenta-informa%C3%A7%C3%B5es-de-todas-as-filiais
https://tdn.totvs.com/pages/releaseview.action?pageId=6071573
*/

User Function F470ALLF

Local lAllFil := ParamIxb[1] //ParamIxb -- variavel do padrão que traz a situação atual das tabelas

//lAllFil := .T. //configuração RISA para trazer o Extrato compartilhado por Filial.

Return lAllFil
