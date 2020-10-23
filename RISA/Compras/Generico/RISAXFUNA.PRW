#include "protheus.ch"
/*-----------------------------------------------------------------------------------------------------------------------------------
{Protheus.doc} ConfSel
Confirma selecao em browse especifico.

@type    function
@author  TOTVS..
@since   Out/2020
@version P12

@project MAN0000001_EF_001
@obs     Projeto RISA
-----------------------------------------------------------------------------------------------------------------------------------*/
User Function ConfSel()

nOpcSel := 1

If Type("oWind") == "O"
	oWind:End()
Else
	oWnd:End()
EndIf

Return( Nil )
