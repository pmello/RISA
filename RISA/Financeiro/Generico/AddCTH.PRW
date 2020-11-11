#include "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณU_AddCTH  บAutor  ณStanko              บ Data ณ  29/01/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAdiciona registros na tabela CTH.                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function AddCTH()
If MsgYesNo("Confirma carga da tabela de classe de valor (CTH)?")
	Processa( {|| AtuClasse()}	,"Aguarde" ,"Atualizando classe de valor...")
EndIf

Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหอออSอออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAtuClasse บAutor  ณMicrosiga           บ Data ณ  10/30/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function AtuClasse()
Local cQuery
Local cEnter := Chr(13)

cQuery := "SELECT A1_FILIAL FILIAL, A1_CGC CGC , A1_NOME NOME, 'C' TIPO, A1_COD COD, A1_LOJA LOJA FROM "+RetSQLName("SA1")+" SA1 "
cQuery += "WHERE SA1.D_E_L_E_T_ = ' ' "
cQuery += "AND A1_FILIAL = '"+xFilial("SA1")+"' "
//cQuery += "AND A1_CGC <> '' "
cQuery += "AND ( A1_CGC <> ' ' AND A1_CGC NOT IN "
cQuery += "(SELECT SUBSTRING(CTH_CLVL,1,14) FROM "+RetSQLName("CTH")+" CTH WHERE CTH.D_E_L_E_T_ = ' ' AND CTH_FILIAL = '"+xFilial("CTH")+"' ) "
cQuery += " OR "
cQuery += "A1_CGC = ' ' AND "
cQuery += " 'C'+A1_COD+A1_LOJA NOT IN (SELECT SUBSTRING(CTH_CLVL,1,9) FROM "+RetSQLName("CTH")+" CTH "
cQuery += "WHERE CTH.D_E_L_E_T_ = ' ' AND CTH_FILIAL = '"+xFilial("CTH")+"' ) ) "

cQuery += "UNION ALL "

cQuery += "SELECT A2_FILIAL FILIAL, A2_CGC CGC, A2_NOME NOME, 'F' TIPO, A2_COD COD, A2_LOJA LOJA FROM "+RetSQLName("SA2")+" SA2 "
cQuery += "WHERE SA2.D_E_L_E_T_ = '' "
cQuery += "AND A2_FILIAL = '"+xFilial("SA2")+"' "

//cQuery += "AND A2_CGC <> '' "
cQuery += "AND ( A2_CGC <> ' ' AND A2_CGC NOT IN "
cQuery += "(SELECT SUBSTRING(CTH_CLVL,1,14) FROM "+RetSQLName("CTH")+" CTH WHERE CTH.D_E_L_E_T_ = ' ' AND CTH_FILIAL = '"+xFilial("CTH")+"' ) "
cQuery += " OR "
cQuery += "A2_CGC = ' ' AND "
cQuery += " 'C'+A2_COD+A2_LOJA NOT IN (SELECT SUBSTRING(CTH_CLVL,1,9) FROM "+RetSQLName("CTH")+" CTH "
cQuery += "WHERE CTH.D_E_L_E_T_ = ' ' AND CTH_FILIAL = '"+xFilial("CTH")+"' ) ) "

cQuery := ChangeQuery(cQuery)

dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), "TMP", .F., .T. )


ProcRegua(RecCount())

While !EOF()

	//IncProc()

	cChave := AllTrim(TMP->CGC)
	If Empty(cChave)
		cChave := TMP->TIPO+TMP->COD+TMP->LOJA //"88888888888888"
	EndIf

	dbSelectArea("CTH")
	dbSetOrder(1)
	If !dbSeek(xFilial()+cChave)
		RecLock("CTH",.T.)
		CTH->CTH_FILIAL := xFilial()
		CTH->CTH_CLVL   := AllTrim(cChave)
		CTH->CTH_DESC01 := Substr(TMP->NOME,1,30)
		CTH->CTH_CLASSE := "2"
		CTH->CTH_BLOQ   := "2"
		MsUnLock()
	EndIf


	dbSelectArea("TMP")
	dbSkip()
EndDo
dbSelectArea("TMP")
dbCloseArea()

Return Nil



