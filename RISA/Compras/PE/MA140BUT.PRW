#include "Protheus.ch"
/*-----------------------------------------------------------------------------------------------------------------------------------
{Protheus.doc} MA140BUT
PE para incluir botao na enchoicebar na pre-nota

@type    function
@author  TOTVS..
@since   Out/2020
@version P12

@project MAN0000001_EF_001
@obs     Projeto RISA
-----------------------------------------------------------------------------------------------------------------------------------*/
User Function MA140BUT()
Local aRet := {}

aadd(aRet,{"BUDGET",   {|| U_ManSZ1()},"Dados do CTe","Dados do CTe" })

Return(aRet)