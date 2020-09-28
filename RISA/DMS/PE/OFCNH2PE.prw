User Function OFCNH2PE()
Local oSql   := DMS_SqlHelper():New()
Local cQuery := ""
//
cQuery := " UPDATE " + RetSqlName('SB1')
cQuery += " SET B1_XNEGOCI = '2' , B1_MSBLQL = '2' "
cQuery += "  WHERE R_E_C_N_O_ IN ("
cQuery += " SELECT SB1.R_E_C_N_O_ "
cQuery += "   FROM "+oSql:NoLock('SB1')+" "
cQuery += "   JOIN "+oSql:NoLock('SBM')+" ON SBM.BM_FILIAL = '"+xFilial("SBM")+"' AND SBM.BM_GRUPO = SB1.B1_GRUPO AND SBM.D_E_L_E_T_ = ' ' "
cQuery += "  WHERE SB1.B1_FILIAL = '"+xFilial("SB1")+"' "
cQuery += "    AND SB1.D_E_L_E_T_ = ' ' "
cQuery += "    AND SB1.B1_XNEGOCI = ' ' "
cQuery += "    AND SBM.BM_TIPGRU = '1' "
cQuery += ") AND B1_XNEGOCI = ' ' "
if TCSqlExec(cQuery) < 0
	conout(TCSQLError())
endif
//
Return