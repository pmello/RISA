#INCLUDE "RWMAKE.CH"
/*-----------------------------------------------------------------------------------------------------------------------------------
{Protheus.doc} DELSZ1
Ponto de entrada na exclusão da nota fiscal de entrada

@type    function
@author  TOTVS..
@since   Out/2020
@version P12

@project MAN0000001_EF_001
@obs     Projeto RISA
-----------------------------------------------------------------------------------------------------------------------------------*/
User Function SF1100E()
    
	//Função para verificar sem tem regitro na SZ1 e apagar.
	U_DELSZ1()

Return()

/*-----------------------------------------------------------------------------------------------------------------------------------
{Protheus.doc} DELSZ1
Ponto de entrada na exclusão da nota fiscal de entrada para verificar sem tem regitro na SZ1 e apagar.

@type    function
@author  TOTVS..
@since   Out/2020
@version P12

@project MAN0000001_EF_001
@obs     Projeto RISA
-----------------------------------------------------------------------------------------------------------------------------------*/
User Function DELSZ1()

Local aArea := GetArea()

dbSelectArea("SZ1")
dbSetOrder(1)
If dbSeek(xFilial("SZ1")+SF1->F1_DOC+SF1->F1_SERIE+SF1->F1_FORNECE+SF1->F1_LOJA)
	While !Eof() .And. SZ1->Z1_FILIAL+SZ1->Z1_NOTNUM+SZ1->Z1_NOTSER+SZ1->Z1_NOTFOR+SZ1->Z1_NOTLOJ == SF1->F1_FILIAL+SF1->F1_DOC+SF1->F1_SERIE+SF1->F1_FORNECE+SF1->F1_LOJA
		RecLock("SZ1",.F.)
			dbDelete()
		MsUnlock()

		dbSkip()
	EndDo
EndIf

RestArea(aArea)

Return()