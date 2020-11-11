#include 'totvs.ch
#include 'rwmake.ch'
#include 'protheus.ch'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออฑฑ
ฑฑบPrograma  ณCXESP01    บAutor  ณ Marcelo Joner      บ Data ณ 31/10/2020 บฑฑ
ฑฑอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออฑฑ
ฑฑบDesc.     ณFun็ใo responsแvel por verificar เ exist๊ncia de Pesagem    บฑฑ
ฑฑบ          ณฺnica para o contrato informado por parโmetro.              บฑฑ
ฑฑอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออฑฑ
ฑฑบUso       ณ Gestใo de Cereais                                          บฑฑ
ฑฑอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
*/
User Function CXESP01(cNumCt)

Local lRet			:= .F.
Local cQuery		:= ""
Local cAliasTMP		:= GetNextAlias()

Default cNumCt		:= ""

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
//ณExecuta regras, caso tenha sido informado o n๚mero do contratoณ
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
If !EMPTY(cNumCt)

    //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
    //ณAjusta o n๚mero do contrato ao tamanho do campo de consultaณ
    //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
    cNumCt := PADR(cNumCt, TAMSX3("Z01_DOCUME")[1])

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
	//ณComposi็ใo da consulta SQL de anแlise de Romaneiosณ
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
	cQuery := "SELECT COUNT(*) REGISTROS						" + CRLF
	cQuery += "FROM " + RetSQLName("Z01") + " Z01				" + CRLF
	cQuery += "WHERE Z01.Z01_DOCUME  = '" + cNumCt + "'			" + CRLF
	cQuery += "  AND Z01.Z01_STATUS <> '4'						" + CRLF
	cQuery += "  AND Z01.D_E_L_E_T_ <> '*'						" + CRLF
	
	If Select(cAliasTMP) > 0
		(cAliasTMP)->(dbCloseArea())
	EndIf

	dBUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAliasTMP, .F., .T.)

	lRet := (cAliasTMP)->REGISTROS > 0

	If Select(cAliasTMP) > 0
		(cAliasTMP)->(dbCloseArea())
	EndIf
EndIf

Return lRet
