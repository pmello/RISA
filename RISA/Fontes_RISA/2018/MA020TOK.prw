#include "protheus.ch" 

/*
+----------------------------------------------------------------------------+
!                         FICHA TECNICA DO PROGRAMA                          !
+----------------------------------------------------------------------------+
!                             DADOS DO PROGRAMA                              !
+------------------+---------------------------------------------------------+
!Tipo              ! Ponto de Entrada                                        !
+------------------+---------------------------------------------------------+
!Modulo            ! Financeiro                                              !
+------------------+---------------------------------------------------------+
!Nome              ! MA020TOK                                                 !
+------------------+---------------------------------------------------------+
!Descricao         !                                                         !
!                  !                                                         !
+------------------+---------------------------------------------------------+
!Autor             ! VALDINEY APARECIDO DA SILVA                             !
+------------------+---------------------------------------------------------+
!Data de Criacao   ! 05/10/2015                                              !
+------------------+---------------------------------------------------------+
*/
User Function MA020TOK()
Local _lRet    := .T.
Local _aArea   := GetArea()
Local _cCodigo := "F" + Alltrim(M->A2_COD)+Alltrim(M->A2_LOJA)
Local _cNome   := Alltrim(M->A2_NOME)

	//Alert('MA020TOK')

	If M->A2_EST == 'EX'
	    M->A2_CGC := ' '
	EndIf
                        	
	dbSelectArea("CTH")
	CTH->(dbSetOrder(1))
	CTH->(dbGotop())
	If !CTH->(dbSeek(xFilial("CTH")+_cCodigo,.T.))
		If RecLock("CTH",.T.)
			CTH->CTH_FILIAL := xFilial("CTH")
			CTH->CTH_CLVL   := _cCodigo
			CTH->CTH_CLASSE := "2"
			CTH->CTH_DESC01 := _cNome
			CTH->CTH_BLOQ   := "2"
			CTH->CTH_DTEXIS := Ctod("01/01/10")
			CTH->CTH_CLVLLP := _cCodigo
			MsUnLock("CTH")
		Endif    
	Endif

	RestArea(_aArea)

Return( _lRet )
