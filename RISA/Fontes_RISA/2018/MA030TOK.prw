//-----------------------------------------------------------------
//Inclusão da classe valor contábil através do cadastro de clientes
//-----------------------------------------------------------------
#include "protheus.ch"

User Function MA030TOK()
Local _aArea   := GetArea()
Local _cCodigo := "C"+Alltrim(M->A1_COD)+Alltrim(M->A1_LOJA)
Local _cNome   := Alltrim(M->A1_NOME)
Local _lRet    := .T.

	If M->A1_EST == 'EX' .and. !empty(alltrim(M->A1_CGC))
		MsgAlert("Cliente de exportação não deve ter CNPJ/CPF cadastrado")
		_lRet	:=.F.
		return _lRet
	EndIf
	If M->A1_EST <> 'EX' .and. empty(alltrim(M->A1_CGC))
		MsgAlert("Cliente nacional deve ter CNPJ/CPF cadastrado")
		_lRet	:=.F.
		return _lRet
	EndIf	

If INCLUI .and. _lRet
	DbSelectArea("CTH")
	CTH->(dbSetOrder(1))
	If !CTH->(dbSeek(xFilial("CTH")+_cCodigo,.T.))
		If RecLock("CTH",.T.)
			CTH->CTH_FILIAL := xFilial("CTH")
			CTH->CTH_CLVL   := _cCodigo
			CTH->CTH_CLASSE := "2"
			CTH->CTH_DESC01 := _cNome
			CTH->CTH_BLOQ   := "2"
			CTH->CTH_DTEXIS := Ctod("01/01/1980")
			CTH->CTH_CLVLLP := _cCodigo
			MsUnLock("CTH")
		Endif   
	Endif
EndIf

RestArea(_aArea)

Return(_lRet)