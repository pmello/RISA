#Include 'Protheus.ch'
#INCLUDE 'FWMVCDEF.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRFINCTB     บAutor  ณTiago Malta        บ Data ณ 13/04/2020 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Relatorio de titulos x contabiliza็ใo                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function RFINCTB()

	Processa({|| fExProc() })

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRFINCTB     บAutor  ณTiago Malta        บ Data ณ 13/04/2020 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Relatorio de titulos x contabiliza็ใo                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function fExProc()

Local cQuery    := ""
Local oExcel
Local cArquivo  := AllTrim(GetTempPath())+"relatorio_"+Dtos(date())+"_"+StrTran(time(),":","")+".xls"
Local cAba      := "TITULOS"
Local cSheet    := "TITULOS"
Local aLinha    := {}
Local aParamBox := {}
Local aRet      := {}
Local cClForD   := space(06)
Local cClForA   := space(06)
Local dAxDt1    := Ctod("//")
Local dAxDt2    := Ctod("//")

Local oFields	:= FWFormStruct(1, 'CT2')
Local x
Local i
Local z 

Private __aLanCT2	:= {}
Private aCpoOri 	:= {} // Utilizar no MVC para mostrar campos do Doc.Original
Private nTipoTit	:= 0
Private cLancs		:= ""
Private nImpCtb	:= 0
Private aCpoCT2	:= {}

    aAdd(aParamBox ,{3,"Titulos",0,{"Receber","Pagar","Mov.Bancario","Nfs Saida","Nfs Entrada"},70,"",.T.}) 
	aAdd(aParamBox ,{1,"Data De"	,dAxDt1	,"","",""	,""	,50,.T.})
	aAdd(aParamBox ,{1,"Data Ate"	,dAxDt2	,"","",""	,""	,50,.T.})
    Aadd(aParamBox ,{1,"Cli/For De"	,cClForD ,"@!","",	,""	,0,.F.})
    Aadd(aParamBox ,{1,"Cli/For Ate",cClForA ,"@!","",	,""	,0,.T.})
	aAdd(aParamBox ,{3,"Imprime Contabilizados",0,{"Ambos","Sim","Nใo"},70,"",.T.})

    If ParamBox(aParamBox,"Parametros",@aRet)

        nTipoTit:= aRet[1]
        dAxDt1  := aRet[2]
        dAxDt2	:= aRet[3]
        cClForD := aRet[4]
        cClForA := aRet[5]
		nImpCtb	:= aRet[6]

		If nTipoTit == 3
			Pergunte("RFINCTB",.T.)
		Endif

		If nImpCtb <> 3
			If nTipoTit <> 3 .AND. nTipoTit <> 4 .AND. nTipoTit <> 5
				cLancs := fOpcCT5()
			Endif
		Endif

        If nTipoTit == 1
            cQuery := " SELECT E1_PREFIXO PREFIXO, E1_NUM NUMERO, E1_PARCELA PARCELA, E1_TIPO TIPO , E1_CLIENTE CLIFOR, E1_LOJA LOJA, E1_NOMCLI NOME, E1_EMIS1 EMISSAO, E1_VALOR+E1_CORREC VALOR, R_E_C_N_O_ RECNO, E1_NATUREZ NATUREZA FROM " + RetSqlName("SE1")
            cQuery += " WHERE D_E_L_E_T_ = ' ' "
			cQuery += " AND E1_EMIS1 >= '"+Dtos(dAxDt1)+"' AND E1_EMIS1 <= '"+Dtos(dAxDt2)+"'  "
			cQuery += " AND E1_CLIENTE >= '"+cClForD+"'      AND E1_CLIENTE <= '"+cClForA+"'  "
			cQuery += " AND LEFT(LTRIM(RTRIM(E1_ORIGEM)),4) <> 'MATA' "
        Elseif nTipoTit == 2
            cQuery := " SELECT E2_PREFIXO PREFIXO, E2_NUM NUMERO, E2_PARCELA PARCELA, E2_TIPO TIPO, E2_FORNECE CLIFOR, E2_LOJA LOJA, E2_NOMFOR NOME, E2_EMIS1 EMISSAO, E2_VALOR+E2_CORREC VALOR, R_E_C_N_O_ RECNO, E2_NATUREZ NATUREZA FROM " + RetSqlName("SE2")
            cQuery += " WHERE D_E_L_E_T_ = ' ' "
			cQuery += " AND E2_EMIS1 >= '"+Dtos(dAxDt1)+"' AND E2_EMIS1 <= '"+Dtos(dAxDt2)+"'  "
			cQuery += " AND E2_FORNECE >= '"+cClForD+"'      AND E2_FORNECE <= '"+cClForA+"'  "
			cQuery += " AND LEFT(LTRIM(RTRIM(E2_ORIGEM)),4) <> 'MATA' "
		Elseif nTipoTit == 3
            cQuery := " SELECT E5_PREFIXO PREFIXO, E5_NUMERO NUMERO, E5_PARCELA PARCELA, E5_TIPO TIPO, E5_CLIFOR CLIFOR, E5_LOJA LOJA, E5_BENEF NOME, E5_DTDISPO EMISSAO, E5_VALOR VALOR, E5_BANCO, E5_AGENCIA, E5_CONTA, E5_HISTOR, "
			cQuery += " CASE WHEN E5_TIPO = 'RA' THEN (SELECT R_E_C_N_O_ FROM " + RetSqlName("SE1") + " WHERE D_E_L_E_T_ = ' ' AND E1_FILIAL = E5_FILIAL AND E1_PREFIXO = E5_PREFIXO AND E1_NUM = E5_NUMERO AND E1_PARCELA = E5_PARCELA AND E1_TIPO = E5_TIPO AND E1_CLIENTE = E5_CLIFOR  ) "
			cQuery += "      WHEN E5_TIPO = 'PA' THEN (SELECT R_E_C_N_O_ FROM " + RetSqlName("SE2") + " WHERE D_E_L_E_T_ = ' ' AND E2_FILIAL = E5_FILIAL AND E2_PREFIXO = E5_PREFIXO AND E2_NUM = E5_NUMERO AND E2_PARCELA = E5_PARCELA AND E2_TIPO = E5_TIPO AND E2_FORNECE = E5_CLIFOR  ) "
			cQuery += " ELSE R_E_C_N_O_ END RECNO, E5_NATUREZ NATUREZA "
			cQuery += " FROM " + RetSqlName("SE5")
            cQuery += " WHERE D_E_L_E_T_ = ' ' AND E5_BANCO <> ' ' AND E5_TIPODOC <> 'CH'  "
			cQuery += " AND E5_DTDISPO     >= '"+Dtos(dAxDt1)+"' AND E5_DTDISPO     <= '"+Dtos(dAxDt2)+"'  "
			cQuery += " AND E5_CLIFOR	>= '"+cClForD+"'  AND E5_CLIFOR   <= '"+cClForA+"'  "
 			cQuery += " AND E5_BANCO	>= '"+MV_PAR01+"'    AND E5_BANCO	  <= '"+MV_PAR04+"' "
 			cQuery += " AND E5_AGENCIA	>= '"+MV_PAR02+"'    AND E5_AGENCIA   <= '"+MV_PAR05+"' "
 			cQuery += " AND E5_CONTA	>= '"+MV_PAR03+"'    AND E5_CONTA	  <= '"+MV_PAR06+"' "
 			cQuery += " AND E5_TIPODOC NOT IN ('DC','JR','MT','CM','D2','J2','M2','V2','C2','CP','TL','BA','I2','EI') "
 			cQuery += " AND NOT (E5_MOEDA IN ('C1','C2','C3','C4','C5','CH') AND E5_NUMCHEQ = '               ' "
  			cQuery += " AND (E5_TIPODOC NOT IN ('TR','TE'))) AND NOT (E5_TIPODOC IN ('TR','TE') "
  			cQuery += " AND ((E5_NUMCHEQ BETWEEN '*              '  AND '*ZZZZZZZZZZZZZZ') "
			cQuery += " OR ( E5_DOCUMEN BETWEEN '*                ' AND '*ZZZZZZZZZZZZZZZZ'))) "
			cQuery += " AND NOT (E5_TIPODOC IN ('TR','TE') AND E5_NUMERO = '      ' "
			cQuery += " AND E5_MOEDA NOT IN ('CC','CD','CH','CO','DOC','EST','FI','R$','TB','TC','VL','DO')) "
			cQuery += " AND E5_SITUACA <> 'C' AND E5_VALOR <> 0 "
			cQuery += " AND NOT (E5_NUMCHEQ BETWEEN '*              ' AND '*ZZZZZZZZZZZZZZ') "
		Elseif nTipoTit == 4  
            cQuery := " SELECT F2_FILIAL FILIAL, F2_SERIE PREFIXO, F2_DOC NUMERO, ' ' PARCELA, F2_TIPO TIPO, F2_CLIENTE CLIFOR, F2_LOJA LOJA, A1_NOME NOME, F2_EMISSAO EMISSAO, F2_VALBRUT VALOR, SF2.R_E_C_N_O_ RECNO, "
			cQuery += " ICMS, IPI, PISAPURADO, COFAPURADO, ICMSST, DIFAL, DESCONTO, INSSRETIDO, IRRFRETIDO, ISSAPURADO, SE1.E1_ISS ISSRETIDO "
			cQuery += " FROM " + RetSqlName("SF2") + " SF2 "
			cQuery += " LEFT JOIN " + RetSqlName("SA1") + " SA1 ON SA1.A1_COD = SF2.F2_CLIENTE AND SA1.A1_LOJA = SF2.F2_LOJA AND SA1.D_E_L_E_T_ = ' ' "
			cQuery += " LEFT JOIN ( SELECT D2_FILIAL, D2_DOC, D2_SERIE, D2_CLIENTE, D2_LOJA, "
			cQuery += "   SUM(FT_VALICM) ICMS, SUM(FT_VALIPI) IPI, SUM(D2_VALIMP6) PISAPURADO, SUM(D2_VALIMP5) COFAPURADO, "
			cQuery += "   SUM(D2_ICMSRET) ICMSST, SUM(D2_DIFAL) DIFAL, SUM(D2_DESC) DESCONTO, SUM(D2_VALIRRF) IRRFRETIDO, SUM(D2_VALINS) INSSRETIDO, SUM(D2_VALISS) ISSAPURADO "
			cQuery += "   FROM " + RetSqlName("SD2") + " SD2 "
			cQuery += "   INNER JOIN " + RetSqlName("SFT") + " SFT ON FT_FILIAL = D2_FILIAL AND FT_TIPOMOV = 'S' AND FT_SERIE = D2_SERIE AND FT_NFISCAL = D2_DOC AND FT_CLIEFOR = D2_CLIENTE AND FT_LOJA = D2_LOJA AND FT_ITEM = D2_ITEM AND FT_PRODUTO = D2_COD "
			cQuery += "   WHERE SD2.D_E_L_E_T_ = ' ' AND SFT.D_E_L_E_T_ = ' ' "
			cQuery += "   GROUP BY D2_FILIAL, D2_DOC, D2_SERIE, D2_CLIENTE, D2_LOJA ) TSD2 ON TSD2.D2_FILIAL = SF2.F2_FILIAL AND TSD2.D2_DOC = SF2.F2_DOC AND TSD2.D2_SERIE = SF2.F2_SERIE AND TSD2.D2_CLIENTE = SF2.F2_CLIENTE AND TSD2.D2_LOJA = SF2.F2_LOJA "
			cQuery += " LEFT JOIN " + RetSqlName("SE1") + " SE1 ON LEFT(SE1.E1_FILIAL,2) = LEFT(SF2.F2_FILIAL,2) AND SE1.E1_CLIENTE = SF2.F2_CLIENTE AND SE1.E1_LOJA = SF2.F2_LOJA AND SE1.E1_PREFIXO = SF2.F2_SERIE AND SE1.E1_NUM = SF2.F2_DOC AND SE1.E1_TIPO = 'NF' AND SE1.D_E_L_E_T_ = ' ' "
            cQuery += " WHERE SF2.D_E_L_E_T_ = ' ' "
			cQuery += " AND F2_EMISSAO >= '"+Dtos(dAxDt1)+"' AND F2_EMISSAO <= '"+Dtos(dAxDt2)+"'  "
			cQuery += " AND F2_CLIENTE >= '"+cClForD+"'      AND F2_CLIENTE <= '"+cClForA+"'  "
		Elseif nTipoTit == 5
            cQuery := " SELECT F1_FILIAL FILIAL, F1_SERIE PREFIXO, F1_DOC NUMERO, ' ' PARCELA, F1_TIPO TIPO, F1_FORNECE CLIFOR, F1_LOJA LOJA, A2_NOME NOME, F1_DTDIGIT EMISSAO, F1_VALBRUT VALOR, SF1.R_E_C_N_O_ RECNO, "
			cQuery += " ICMS, IPI, PISAPURADO, COFAPURADO, ICMSST, DIFAL, DESCONTO, INSSRETIDO, IRRFRETIDO, CASE WHEN A2_RECISS = 'N' THEN ISSAPURADO ELSE 0 END ISSRETIDO, CASE WHEN A2_RECISS <> 'N' THEN ISSAPURADO ELSE 0 END ISSAPURADO "
			cQuery += " FROM " + RetSqlName("SF1") + " SF1 "
			cQuery += " LEFT JOIN " + RetSqlName("SA2") + " SA2 ON SA2.A2_COD = SF1.F1_FORNECE AND SA2.A2_LOJA = SF1.F1_LOJA AND SA2.D_E_L_E_T_ = ' ' "
			cQuery += " LEFT JOIN ( SELECT D1_FILIAL, D1_DOC, D1_SERIE, D1_FORNECE, D1_LOJA, "
			cQuery += "   SUM(FT_VALICM) ICMS, SUM(FT_VALIPI) IPI, SUM(D1_VALIMP6) PISAPURADO, SUM(D1_VALIMP5) COFAPURADO, "
			cQuery += "   SUM(D1_ICMSRET) ICMSST, SUM(D1_DIFAL) DIFAL, SUM(D1_DESC) DESCONTO, SUM(D1_VALINS) INSSRETIDO, SUM(D1_VALISS) ISSAPURADO, SUM(D1_VALIRR) IRRFRETIDO "
			cQuery += "   FROM " + RetSqlName("SD1") + " SD1 "
			cQuery += "   INNER JOIN " + RetSqlName("SFT") + " SFT ON FT_FILIAL = D1_FILIAL AND FT_TIPOMOV = 'E' AND FT_SERIE = D1_SERIE AND FT_NFISCAL = D1_DOC AND FT_CLIEFOR = D1_FORNECE AND FT_LOJA = D1_LOJA AND FT_ITEM = D1_ITEM AND FT_PRODUTO = D1_COD "
			cQuery += "   WHERE SD1.D_E_L_E_T_ = ' ' AND SFT.D_E_L_E_T_ = ' ' "
			cQuery += "   GROUP BY D1_FILIAL, D1_DOC, D1_SERIE, D1_FORNECE, D1_LOJA ) TSD1 ON TSD1.D1_FILIAL = SF1.F1_FILIAL AND TSD1.D1_DOC = SF1.F1_DOC AND TSD1.D1_SERIE = SF1.F1_SERIE AND TSD1.D1_FORNECE = SF1.F1_FORNECE AND TSD1.D1_LOJA = SF1.F1_LOJA "			
			cQuery += " LEFT JOIN " + RetSqlName("SE2") + " SE2 ON LEFT(SE2.E2_FILIAL,2) = LEFT(SF1.F1_FILIAL,2) AND SE2.E2_FORNECE = SF1.F1_FORNECE AND SE2.E2_LOJA = SF1.F1_LOJA AND SE2.E2_PREFIXO = SF1.F1_SERIE AND SE2.E2_NUM = SF1.F1_DOC AND SE2.D_E_L_E_T_ = ' ' "			
            cQuery += " WHERE SF1.D_E_L_E_T_ = ' ' "
			cQuery += " AND F1_DTDIGIT >= '"+Dtos(dAxDt1)+"' AND F1_DTDIGIT <= '"+Dtos(dAxDt2)+"'  "
			cQuery += " AND F1_FORNECE >= '"+cClForD+"'      AND F1_FORNECE <= '"+cClForA+"'  "
        Endif

        If Select("TMPA") > 0 
            TMPA->( dbclosearea() )
        Endif

        dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TMPA",.F.,.F.)
		TcSetField("TMPA",'EMISSAO','D')

        TMPA->( dbgotop() )
        ProcRegua( TMPA->(ScopeCount()) )

        TMPA->( dbgotop() )

        oExcel	:= FwMsExcel():New()
        oExcel:AddWorkSheet(cAba)
        oExcel:AddTable(cAba,cSheet )
        oExcel:AddColumn(cAba,cSheet,"Prefixo",1,1)
        oExcel:AddColumn(cAba,cSheet,"Numero",1,1)
        oExcel:AddColumn(cAba,cSheet,"Parcela",1,1)
        oExcel:AddColumn(cAba,cSheet,"Tipo",1,1)
        oExcel:AddColumn(cAba,cSheet,"Codigo Cli/For",1,1)
        oExcel:AddColumn(cAba,cSheet,"Loja",1,1)
        oExcel:AddColumn(cAba,cSheet,"Nome",1,1)
        oExcel:AddColumn(cAba,cSheet,"Emissใo",1,1)
        oExcel:AddColumn(cAba,cSheet,"Valor",1,1)

		If nTipoTit <= 3
			oExcel:AddColumn(cAba,cSheet,"Natureza",1,1)
			oExcel:AddColumn(cAba,cSheet,"Desc.Natureza",1,1)
		Endif

		If nTipoTit == 3
			oExcel:AddColumn(cAba,cSheet,"Banco",1,1)
			oExcel:AddColumn(cAba,cSheet,"Agencia",1,1)
			oExcel:AddColumn(cAba,cSheet,"Conta",1,1)
			oExcel:AddColumn(cAba,cSheet,"Historico",1,1)
		ElseIf nTipoTit == 4 .OR. nTipoTit == 5
			oExcel:AddColumn(cAba,cSheet,"CFOP",1,1)
			oExcel:AddColumn(cAba,cSheet,"Icms",1,1)
			oExcel:AddColumn(cAba,cSheet,"Ipi",1,1)
			oExcel:AddColumn(cAba,cSheet,"Pis Apurado",1,1)
			oExcel:AddColumn(cAba,cSheet,"Cofins Apurado",1,1)
			oExcel:AddColumn(cAba,cSheet,"Icms ST",1,1)
			oExcel:AddColumn(cAba,cSheet,"Difal",1,1)
			oExcel:AddColumn(cAba,cSheet,"Desconto",1,1)
			oExcel:AddColumn(cAba,cSheet,"Inss Retido",1,1)
			oExcel:AddColumn(cAba,cSheet,"Irrf Retido",1,1)
			oExcel:AddColumn(cAba,cSheet,"Iss Retido",1,1)
			oExcel:AddColumn(cAba,cSheet,"Iss Apurado",1,1)
		Endif

		For i :=1 to Len(oFields:aFields)
			oExcel:AddColumn(cAba,cSheet,oFields:aFields[i][1],1,1)

			If Alltrim(oFields:aFields[i][3]) == "CT2_DEBITO"
				oExcel:AddColumn(cAba,cSheet,"Des.Cnt.Deb",1,1)
			ElseIf Alltrim(oFields:aFields[i][3]) == "CT2_CREDIT"
				oExcel:AddColumn(cAba,cSheet,"Des.Cnt.Cred",1,1)
			Endif
		Next i

        dbselectarea("TMPA")
        TMPA->( dbgotop() )

        While TMPA->( !eof() )

            Incproc()

			__aLanCT2 := {}

			If nTipoTit == 1
				U_CTBTRACKER( "SE1", TMPA->RECNO )
			Elseif nTipoTit == 2
				U_CTBTRACKER( "SE2", TMPA->RECNO )
			Elseif nTipoTit == 3
				If Alltrim(TMPA->TIPO) == "RA"
					U_CTBTRACKER( "SE1", TMPA->RECNO )
				Elseif Alltrim(TMPA->TIPO) == "PA"
					U_CTBTRACKER( "SE2", TMPA->RECNO )
				Else
					U_CTBTRACKER( "SE5", TMPA->RECNO )
				Endif
			Elseif nTipoTit == 4
				U_CTBTRACKER( "SF2", TMPA->RECNO )
			Elseif nTipoTit == 5
				U_CTBTRACKER( "SF1", TMPA->RECNO )				
			Endif

			If nImpCtb == 2 .AND. Len(__aLanCT2) == 0
				TMPA->( dbskip() )
				LOOP
			Elseif nImpCtb == 3 .AND. Len(__aLanCT2) > 0
				TMPA->( dbskip() )
				LOOP
			Endif

            aLinha := {}

            aAdd(aLinha, TMPA->PREFIXO )
            aAdd(aLinha, TMPA->NUMERO )
            aAdd(aLinha, TMPA->PARCELA )
            aAdd(aLinha, TMPA->TIPO )
            aAdd(aLinha, TMPA->CLIFOR )
            aAdd(aLinha, TMPA->LOJA )			
			aAdd(aLinha, TMPA->NOME )
			aAdd(aLinha, TMPA->EMISSAO )
			aAdd(aLinha, TMPA->VALOR )

			If nTipoTit <= 3

				aAdd(aLinha, TMPA->NATUREZA )

				If !Empty(TMPA->NATUREZA)
					aAdd(aLinha, Posicione("SED",1,xFilial("SED")+TMPA->NATUREZA,"ED_DESCRIC") )
				Else
					aAdd(aLinha, "" )
				Endif
			Endif

			If nTipoTit == 3
				aAdd(aLinha, TMPA->E5_BANCO )
				aAdd(aLinha, TMPA->E5_AGENCIA )
				aAdd(aLinha, TMPA->E5_CONTA )
				aAdd(aLinha, TMPA->E5_HISTOR )
			Elseif nTipoTit == 4 .OR. nTipoTit == 5
				aAdd(aLinha, RetCfop(nTipoTit) )
				aAdd(aLinha, TMPA->ICMS )
				aAdd(aLinha, TMPA->IPI )
				aAdd(aLinha, TMPA->PISAPURADO )
				aAdd(aLinha, TMPA->COFAPURADO )
				aAdd(aLinha, TMPA->ICMSST )
				aAdd(aLinha, TMPA->DIFAL )
				aAdd(aLinha, TMPA->DESCONTO )
				aAdd(aLinha, TMPA->INSSRETIDO )
				aAdd(aLinha, TMPA->IRRFRETIDO )
				aAdd(aLinha, TMPA->ISSRETIDO )
				aAdd(aLinha, TMPA->ISSAPURADO )

			Endif

			If Len(__aLanCT2) > 0
				For x :=1 to Len(__aLanCT2)
					
					If x > 1
						aLinha := {}

						aAdd(aLinha, "" )
						aAdd(aLinha, "" )
						aAdd(aLinha, "" )
						aAdd(aLinha, "" )
						aAdd(aLinha, "" )
						aAdd(aLinha, "" )			
						aAdd(aLinha, "" )
						aAdd(aLinha, "" )
						aAdd(aLinha, "" )

						If nTipoTit <= 3
							aAdd(aLinha, "" )
							aAdd(aLinha, "" )
						Endif

						If nTipoTit == 3
							aAdd(aLinha, "" )
							aAdd(aLinha, "" )
							aAdd(aLinha, "" )
							aAdd(aLinha, "" )
						Elseif nTipoTit == 4 .OR. nTipoTit == 5
							aAdd(aLinha, "" )
							aAdd(aLinha, "" )
							aAdd(aLinha, "" )
							aAdd(aLinha, "" )
							aAdd(aLinha, "" )
							aAdd(aLinha, "" )
							aAdd(aLinha, "" )
							aAdd(aLinha, "" )
							aAdd(aLinha, "" )
							aAdd(aLinha, "" )
							aAdd(aLinha, "" )
							aAdd(aLinha, "" )						
						Endif						

					Endif

					For z := 1 to len(__aLanCT2[x][2])
						If z <= Len(oFields:aFields)+2
							aAdd(aLinha, __aLanCT2[x][2][z] )
						Endif
					Next z

					oExcel:AddRow(cAba,cSheet, aLinha)
				Next x
			Else
				For i :=1 to Len(oFields:aFields)+2
					aAdd(aLinha, "" )
				Next i

				oExcel:AddRow(cAba,cSheet, aLinha)
			Endif
            
            TMPA->( dbskip() )
        Enddo

        oExcel:Activate()
        oExcel:GetXMLFile(cArquivo)
        ShellExecute( "Open", cArquivo,"" , "c:\", 1 )

    Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRFINCTB     บAutor  ณTiago Malta        บ Data ณ 13/04/2020 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Relatorio de titulos x contabiliza็ใo                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CTBTRACKER( cAlias, __nRecOri)

Local lRet				:= .F.
Local cSeq				:= ""
Local cChave			:= ""                                   
Local dDtCV3			:= ""
Local nInitCBox			:= 0
Local lDel				:= Set(_SET_DELETED) 
Local aArea   			:= GetArea()
Local aAreaSE2			:= {}
Local aAreaCT2			:= {}
Local aAreaCV3			:= {}
Local aAreaSF1			:= {}
Local aAreaSE5			:= {}
Local aAreaSEK			:= {}
Local aAreaSEZ			:= {}
Local aAreaSEV			:= {}
Local aAreaSEU			:= {}
Local aAreaSN3			:= {}
Local aAreaSN4			:= {}
Local aAreaF43          := {}
Local aAreaF36          := {}
Local aCbox				:= {}
Local cTabOri 			:= cAlias
Local aEnableButtons	:= {{.F.,Nil},{.F.,Nil},{.F.,Nil},{.F.,Nil},{.F.,Nil},{.F.,Nil},{.F.,Nil},{.F.,Nil},{.F.,Nil},{.F.,Nil},{.F.,Nil},{.T.,Nil}}
Local cChaveBsc			:= ""
Local cSN3KEY			:= "" 
Local nTamChave			:= 0
Local lRetCT2			:= .F.

PRIVATE __cAliasORI		:= cTabOri
PRIVATE __nRecProc 		:= __nRecOri
PRIVATE cCpoOri 		:= ""
PRIVATE __aRetItem		:= {}
PRIVATE __aDocOri		:= {}
PRIVATE __cLP			:= ""
PRIVATE cCadastro		:= OemToAnsi("Rastrear Lanรงamentos Contabeis") //"Rastrear Lanรงamentos Contabeis"
PRIVATE aCboxCT5		:= {}

SX3->(DbSetOrder(2))
SX3->(DbSeek("CT5_DC"))
aCbox := RetSX3Box(X3Cbox(),@nInitCBox,,SX3->X3_TAMANHO)
If Empty(aCbox)
	Aadd(aCboxCT5,"a debito")	//"a debito"
	Aadd(aCboxCT5,"a credito")	//"a credito"	
	Aadd(aCboxCT5,"partida dobrada")	//"partida dobrada"
Else
	For nInitCBox := 1 To Len(aCbox)
		Aadd(aCboxCT5,aCbox[nInitCBox,3])
	Next
Endif
SX3->(DbSetOrder(1))

Do Case

	Case cTabOri == "SE2" //FINA050
		dbSelectArea("SE2")
		dbSetOrder(1)
		DbGoto(__nRecProc)
		__cLP:="510" // Fixo para pegar os campos da SE2 que estรฃo na CTL
		CargaCTL(__cLP,"SE2")
		lRet:=CargaCT2(__cAliasORI,__nRecProc) // Seleciona os Lanctos Contรกbeis da SE2
		
		//Busca Baixas
		DbSelectArea("SE5")
		dbSetOrder(7)
		SE5->(DbSeek(SE2->( E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA)))
		While !(EOF()) .And. SE2->(E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA) == SE5->(E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA)

			//If !( Alltrim(SE5->E5_TIPODOC) $ 'DC*JR*MT*CM*D2*J2*M2*V2*C2*CP*TL*BA*I2*EI*') .AND. !(Alltrim(SE5->E5_MOEDA) $ 'C1*C2*C3*C4*C5*CH*') .AND. EMPTY(E5_NUMCHEQ) .AND. ;
			//	!(Alltrim(SE5->E5_TIPODOC) $ 'TR*TE*') .AND. !(Alltrim(SE5->E5_TIPODOC) $ 'TR*TE*')  .AND. !Empty(SE5->E5_NUMCHEQ) .OR. ;
			//	!Empty(SE5->E5_DOCUMEN)	.AND. !(Alltrim(SE5->E5_TIPODOC) $ 'TR*TE*') .AND. Empty(SE5->E5_NUMERO) .AND. ;
			//	!( Alltrim(SE5->E5_MOEDA) $ 'CC*CD*CH*CO*DOC*EST*FI*R$*TB*TC*VL*DO*') .AND. Alltrim(SE5->E5_SITUACA) <> 'C' .AND. SE5->E5_VALOR <> 0

				__cAliasORI:= "SE5"
				__nRecProc:=(__cAliasORI)->(Recno())
				aAreaSE5:= GetArea()
				lRet:= CargaCT2(__cAliasORI,__nRecProc) // Seleciona os Lanctos Contabeis da SE5
				RestArea(aAreaSE5)

			//Endif

			SE5->(DbSkip())
		End
		
		//Busca a Nota de Entrada
		DbSelectArea("SF1")
		SF1->(dbSetOrder(1))
		If SF1->(DbSeek(xFilial("SF1") + SE2->(E2_NUM + E2_PREFIXO + E2_FORNECE + E2_LOJA)))
			__cAliasORI:="SF1"
			__nRecProc:= (__cAliasORI)->(Recno())
			lRet:= CargaCT2(__cAliasORI,__nRecProc) // Seleciona os Lanctos Contรกbeis da SF1
		EndIf

		//Busca a Nota de Entrada (itens)
		DbSelectArea("SD1")
		SD1->(dbSetOrder(1))
		cChaveBsc := xFilial("SD1")+SE2->(E2_NUM + E2_PREFIXO + E2_FORNECE + E2_LOJA)
		If SD1->(DbSeek(cChaveBsc))
			__cAliasORI:="SD1"

			While !SD1->( Eof() ) .And. SD1->( D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA ) == cChaveBsc
				__nRecProc:= (__cAliasORI)->(Recno())
				lRet:= CargaCT2(__cAliasORI,__nRecProc) // Seleciona os Lanctos Contรกbeis da SF1
				SD1->( dbSkip() )
			EndDo
		EndIf
		
		//Busca a Nota de credito 
		DbSelectArea("SF2")
		SF2->(dbSetOrder(2))
		If SF2->(DbSeek(xFilial("SF2")+SE2->(E2_FORNECE + E2_LOJA + E2_NUM + E2_PREFIXO)))
			__cAliasORI:="SF2"
			__nRecProc:= (__cAliasORI)->(Recno())
			lRet:= CargaCT2(__cAliasORI,__nRecProc) // Seleciona os Lanctos Contรกbeis da SF1
		EndIf
		
		//Busca a Nota de credito (itens)
		DbSelectArea("SD2")
		SD2->(dbSetOrder(3))
		cChaveBsc :=  xFilial("SD2")+SE2->(E2_NUM + E2_PREFIXO + E2_FORNECE + E2_LOJA)
		If SD2->(DbSeek(cChaveBsc))
			__cAliasORI:="SD2"

			While !SD2->( Eof() ) .And. SD2->( D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA ) == cChaveBsc 
				__nRecProc:= (__cAliasORI)->(Recno())
				lRet:= CargaCT2(__cAliasORI,__nRecProc) // Seleciona os Lanctos Contรกbeis da SF1
				SD2->( dbSkip() )
			EndDo
		EndIf

		//Busca Rateio por Natureza com CC
		DbSelectArea("SE2")
		SE2->(dbSetOrder(1))
		SE2->(DbGoto(__nRecOri))
		cTabSEZ	  := GetNextAlias()
		cQuerY		:= ""
		cQuery		+= "SELECT"
		cQuery		+= " R_E_C_N_O_ "
		cQuery		+= " FROM "+RetSQLName("SEZ")+" TMP"
		cQuery		+= " WHERE"
		cQuery		+= " EZ_FILIAL = '"+xFilial("SEZ")+"' AND "
		cQuery		+= " EZ_PREFIXO = '"+E2_PREFIXO+"' AND "
		cQuery		+= " EZ_NUM = '"+E2_NUM+"' AND "
		cQuery		+= " EZ_PARCELA = '"+E2_PARCELA+"' AND "
		cQuery		+= " EZ_TIPO = '"+E2_TIPO+"' AND "
		cQuery		+= " EZ_CLIFOR = '"+E2_FORNECE+"' AND "
		cQuery		+= " EZ_LOJA = '"+E2_LOJA+"' AND "
		cQuery     += " TMP.D_E_L_E_T_ = ' ' "
		cQuery := ChangeQuery(cQuery)
		
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cTabSEZ,.T.,.T.)
		
		__cAliasORI:="SEZ"
		While !((cTabSEZ)->(Eof()))
			__nRecProc:= (cTabSEZ)->R_E_C_N_O_
			lRet:= CargaCT2(__cAliasORI,__nRecProc) // Seleciona os Lanctos Contรกbeis da SEZ
			(cTabSEZ)->(DbSkip())
		End
		DbSelectArea(cTabSEZ)
		DbCloseArea()
	
		//Busca Multiplas Naturezas por Titulo
		DbSelectArea("SE2")
		SE2->(dbSetOrder(1))
		SE2->(DbGoto(__nRecOri))
		cTabSEV	  := GetNextAlias()
		cQuerY		:= ""
		cQuery		+= "SELECT"
		cQuery		+= " R_E_C_N_O_ "
		cQuery		+= " FROM "+RetSQLName("SEV")+" TMP"
		cQuery		+= " WHERE"
		cQuery		+= " EV_FILIAL = '"+xFilial("SEV")+"' AND "
		cQuery		+= " EV_PREFIXO = '"+E2_PREFIXO+"' AND "
		cQuery		+= " EV_NUM = '"+E2_NUM+"' AND "
		cQuery		+= " EV_PARCELA = '"+E2_PARCELA+"' AND "
		cQuery		+= " EV_TIPO = '"+E2_TIPO+"' AND "
		cQuery		+= " EV_CLIFOR = '"+E2_FORNECE+"' AND "
		cQuery		+= " EV_LOJA = '"+E2_LOJA+"' AND "
		cQuery     += " TMP.D_E_L_E_T_ = ' ' "
		cQuery := ChangeQuery(cQuery)
		
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cTabSEV,.T.,.T.)
	
		__cAliasORI:="SEV"
		While !((cTabSEV)->(Eof()))
			__nRecProc:= (cTabSEV)->R_E_C_N_O_
			lRet:= CargaCT2(__cAliasORI,__nRecProc) // Seleciona os Lanctos Contรกbeis da SEV
			(cTabSEV)->(DbSkip())
		End
		DbSelectArea(cTabSEV)
		DbCloseArea()
	
			
	Case cTabOri == "SE1" //FINA040
	
		dbSelectArea("SE1")
		dbSetOrder(1)
		DbGoto(__nRecProc)
		__cLP:="500" // Fixo para pegar os campos da SE1 que estรฃo na CTL
		CargaCTL(__cLP,"SE1")
		lRet:=CargaCT2(__cAliasORI,__nRecProc) // Seleciona os Lanctos Contรกbeis da SF2
		
		//Busca Baixas
		DbSelectArea("SE5")
		dbSetOrder(7)
		SE5->(DbSeek(SE1->(E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO+E1_CLIENTE+E1_LOJA)))

		While !(EOF()) .And. SE1->(E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO+E1_CLIENTE+E1_LOJA) == SE5->(E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA)

			//If !( Alltrim(SE5->E5_TIPODOC) $ 'DC*JR*MT*CM*D2*J2*M2*V2*C2*CP*TL*BA*I2*EI*') .AND. !(Alltrim(SE5->E5_MOEDA) $ 'C1*C2*C3*C4*C5*CH*') .AND. EMPTY(E5_NUMCHEQ) .AND. ;
			//	!(Alltrim(SE5->E5_TIPODOC) $ 'TR*TE*') .AND. !(Alltrim(SE5->E5_TIPODOC) $ 'TR*TE*')  .AND. !Empty(SE5->E5_NUMCHEQ) .OR. ;
			//	!Empty(SE5->E5_DOCUMEN)	.AND. !(Alltrim(SE5->E5_TIPODOC) $ 'TR*TE*') .AND. Empty(SE5->E5_NUMERO) .AND. ;
			//	!( Alltrim(SE5->E5_MOEDA) $ 'CC*CD*CH*CO*DOC*EST*FI*R$*TB*TC*VL*DO*') .AND. Alltrim(SE5->E5_SITUACA) <> 'C' .AND. SE5->E5_VALOR <> 0

				__cAliasORI:= "SE5"
				__nRecProc:=(__cAliasORI)->(Recno())
				aAreaSE5:= GetArea()
				lRet:= CargaCT2(__cAliasORI,__nRecProc) // Seleciona os Lanctos Contabeis da SE2
				RestArea(aAreaSE5)

			//Endif

			SE5->(DbSkip())
		End
		
		//Busca a Nota de Saida
		DbSelectArea("SF2")
		SF2->(dbSetOrder(2))
		If SF2->(DbSeek(xFilial("SF2") + SE1->(E1_CLIENTE + E1_LOJA + E1_NUM + If(Empty(E1_SERIE),E1_PREFIXO,E1_SERIE))))
			__cAliasORI:="SF2"
			__nRecProc:= (__cAliasORI)->(Recno())
			lRet:= CargaCT2(__cAliasORI,__nRecProc) // Seleciona os Lanctos Contรกbeis da SF1
		EndIf
		
		//Busca a Nota de Saida (itens)
		DbSelectArea("SD2")
		SD2->(dbSetOrder(3))
		cChaveBsc := xFilial("SD2") + SE1->(E1_NUM + If(Empty(E1_SERIE),E1_PREFIXO,E1_SERIE) + E1_CLIENTE + E1_LOJA)
		If SD2->(DbSeek(cChaveBsc))
			__cAliasORI:="SD2"

			While !SD2->( Eof() ) .And. SD2->( D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA ) == cChaveBsc
				__nRecProc:= (__cAliasORI)->(Recno())
				lRet:= CargaCT2(__cAliasORI,__nRecProc) // Seleciona os Lanctos Contรกbeis da SF1
				SD2->( dbSkip() )
			EndDo
		EndIf

		//Busca a Nota de credito
		DbSelectArea("SF1")
		SF1->(dbSetOrder(1))
		If SF1->(DbSeek(xFilial("SF1") + SE1->(E1_NUM + If(Empty(E1_SERIE),E1_PREFIXO,E1_SERIE) + E1_CLIENTE + E1_LOJA)))
			__cAliasORI:="SF1"
			__nRecProc:= (__cAliasORI)->(Recno())
			lRet:= CargaCT2(__cAliasORI,__nRecProc) // Seleciona os Lanctos Contรกbeis da SF1
		EndIf

		//Busca a Nota de credito (itens)
		DbSelectArea("SD1")
		SD1->(dbSetOrder(1))
		cChaveBsc := xFilial("SD1") + SE1->(E1_NUM + If(Empty(E1_SERIE),E1_PREFIXO,E1_SERIE) + E1_CLIENTE + E1_LOJA)
		If SD1->(DbSeek(cChaveBsc))
			__cAliasORI:="SD1"

			While !SD1->( Eof() ) .And. SD1->( D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA ) == cChaveBsc 
				__nRecProc:= (__cAliasORI)->(Recno())
				lRet:= CargaCT2(__cAliasORI,__nRecProc) // Seleciona os Lanctos Contรกbeis da SF1
				SD1->( dbSkip() )
			EndDo
		EndIf

		//Busca a Rateios do Titulo
		DbSelectArea("SE1")
		SE1->(dbSetOrder(1))
		SE1->(DbGoto(__nRecProc))
		cTabSEZ	  := GetNextAlias()
		cQuerY		:= ""
		cQuery		+= "SELECT"
		cQuery		+= " R_E_C_N_O_ "
		cQuery		+= " FROM "+RetSQLName("SEZ")+" TMP"
		cQuery		+= " WHERE"
		cQuery		+= " EZ_FILIAL = '"+xFilial("SEZ")+"' AND "
		cQuery		+= " EZ_PREFIXO = '"+E1_PREFIXO+"' AND "
		cQuery		+= " EZ_NUM = '"+E1_NUM+"' AND "
		cQuery		+= " EZ_PARCELA = '"+E1_PARCELA+"' AND "
		cQuery		+= " EZ_TIPO = '"+E1_TIPO+"' AND "
		cQuery		+= " EZ_CLIFOR = '"+E1_CLIENTE+"' AND "
		cQuery		+= " EZ_LOJA = '"+E1_LOJA+"' AND "
		cQuery     += " TMP.D_E_L_E_T_ = ' ' "
		cQuery := ChangeQuery(cQuery)
		
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cTabSEZ,.T.,.T.)
		
		__cAliasORI:="SEZ"
		While !((cTabSEZ)->(Eof()))
			__nRecProc:= (cTabSEZ)->R_E_C_N_O_
			lRet:= CargaCT2(__cAliasORI,__nRecProc) // Seleciona os Lanctos Contรกbeis da SEZ
			(cTabSEZ)->(DbSkip())
		End
		DbSelectArea(cTabSEZ)
		DbCloseArea()
	
		//Busca Multiplas Naturezas por Titulo
		DbSelectArea("SE2")
		SE2->(dbSetOrder(1))
		SE2->(DbGoto(__nRecOri))
		cTabSEV	  := GetNextAlias()
		cQuerY		:= ""
		cQuery		+= "SELECT"
		cQuery		+= " R_E_C_N_O_ "
		cQuery		+= " FROM "+RetSQLName("SEV")+" TMP"
		cQuery		+= " WHERE"
		cQuery		+= " EV_FILIAL = '"+xFilial("SEV")+"' AND "
		cQuery		+= " EV_PREFIXO = '"+E2_PREFIXO+"' AND "
		cQuery		+= " EV_NUM = '"+E2_NUM+"' AND "
		cQuery		+= " EV_PARCELA = '"+E2_PARCELA+"' AND "
		cQuery		+= " EV_TIPO = '"+E2_TIPO+"' AND "
		cQuery		+= " EV_CLIFOR = '"+E2_FORNECE+"' AND "
		cQuery		+= " EV_LOJA = '"+E2_LOJA+"' AND "
		cQuery     += " TMP.D_E_L_E_T_ = ' ' "
		cQuery := ChangeQuery(cQuery)
		
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cTabSEV,.T.,.T.)
	
		__cAliasORI:="SEV"
		While !((cTabSEV)->(Eof()))
			__nRecProc:= (cTabSEV)->R_E_C_N_O_
			lRet:= CargaCT2(__cAliasORI,__nRecProc) // Seleciona os Lanctos Contรกbeis da SEV
			(cTabSEV)->(DbSkip())
		End
		DbSelectArea(cTabSEV)
		DbCloseArea()

	Case cTabOri == "SE5"

		dbSelectArea("SE5")
		dbSetOrder(1)
		DbGoto(__nRecProc)

		__cAliasORI:= "SE5"
		__nRecProc:=(__cAliasORI)->(Recno())
		aAreaSE5:= GetArea()
		lRet:= CargaCT2(__cAliasORI,__nRecProc) // Seleciona os Lanctos Contabeis da SE2
		RestArea(aAreaSE5)

	Case cTabOri == "SF2"

		//Busca a Nota de Saida
		dbSelectArea("SF2")
		dbSetOrder(1)
		DbGoto(__nRecProc)
		__cAliasORI:="SF2"
		__nRecProc:= SF2->(Recno())
		lRet:= CargaCT2(__cAliasORI,__nRecProc) // Seleciona os Lanctos Contรกbeis da SF2
		
		//Busca a Nota de Saida (itens)
		DbSelectArea("SD2")
		SD2->(dbSetOrder(3))
		cChaveBsc := SF2->( F2_FILIAL + F2_DOC + F2_SERIE + F2_CLIENTE + F2_LOJA)
		If SD2->(DbSeek(cChaveBsc))
			__cAliasORI:="SD2"

			While !SD2->( Eof() ) .And. SD2->( D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA ) == cChaveBsc
				__nRecProc:= SD2->(Recno())
				lRet:= CargaCT2(__cAliasORI,__nRecProc) // Seleciona os Lanctos Contรกbeis da SF2
				SD2->( dbSkip() )
			EndDo
		EndIf

	Case cTabOri == "SF1"

		//Busca a Nota de ENTRADA
		DbSelectArea("SF1")
		dbSetOrder(1)
		DbGoto(__nRecProc)
		__cAliasORI:="SF1"
		__nRecProc:= (__cAliasORI)->(Recno())
		lRet:= CargaCT2(__cAliasORI,__nRecProc) // Seleciona os Lanctos Contรกbeis da SF1
		
		//Busca a Nota de ENTRADA (itens)
		DbSelectArea("SD1")
		SD1->(dbSetOrder(1))
		cChaveBsc := SF1->( F1_FILIAL + F1_DOC + F1_SERIE + F1_FORNECE + F1_LOJA)
		If SD1->(DbSeek(cChaveBsc))
			__cAliasORI:="SD1"

			While !SD1->( Eof() ) .And. SD1->( D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA ) == cChaveBsc
				__nRecProc:=  SD1->(Recno())
				lRet:= CargaCT2(__cAliasORI,__nRecProc) // Seleciona os Lanctos Contรกbeis da SF1
				SD1->( dbSkip() )
			EndDo
		EndIf

	Otherwise
		dbSelectArea(__cAliasORI)
		(__cAliasORI)->(DbGoto(__nRecProc))
		__cLP:=""
		lRet:=CargaCT2(__cAliasORI,__nRecProc) // Seleciona os Lanctos Contรกbeis
EndCase

//If lRet == .F.
//	Help(" ",1,"NAOLANC",,STR0002,1,0)  //"Nรฃo se encontrou lanรงamentos contรกbeis para o documento"
//EndIf	

RestArea(aArea)
Set(_SET_DELETED, lDel)

//If lRet
//	FWExecView(STR0003,"CTBC662",3,, { || .T. },,,aEnableButtons )  // "Contรกbil"
//EndIF

Asize(aAreaSE2,0)
Asize(aAreaCT2,0)
Asize(aAreaCV3,0)
Asize(aAreaSF1,0)
Asize(aAreaSE5,0)
Asize(aAreaSEK,0)
Asize(aAreaSEZ,0)
Asize(aAreaSEV,0)
Asize(aAreaSEU,0)
Asize(aAreaSN3,0)
Asize(aAreaSN4,0)
Asize(aCbox,0)
Asize(aCboxCT5,0)

aAreaSE2 := Nil
aAreaCT2 := Nil
aAreaCV3 := Nil
aAreaSF1 := Nil
aAreaSE5 := Nil
aAreaSEK := Nil
aAreaSEZ := Nil
aAreaSEV := Nil
aAreaSEU := Nil
aAreaSN3 := Nil
aAreaSN4 := Nil
aCbox := Nil
aCboxCT5 := Nil

Return nil


//-------------------------------------------------------------------
/*/{Protheus.doc} CargaINI(__cAliasORI)
 Carga dos Campos da Tabela Origem para Mostrar na AddField 

@author wilson.possani

@since 02/04/2014
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function CargaINI()
	
	Local nX:= 0 
                                     
	For nX:=1 to Len(aCpoOri)
		aAdd(__aDocOri,&(__cAliasORI+"->"+aCpoOri[nX]))
	Next nX

Return __aDocOri


//-------------------------------------------------------------------
/*/{Protheus.doc} CargaCT2(__cAliasORI,__nRecProc)
Busca os Lanรงamentos Contรกbeis da CT2

@author wilson.possani

@since 02/04/2014
@version 1.0
/*/
//-------------------------------------------------------------------

Static Function CargaCT2(__cAliasORI,__nRecProc)

Local lRet		:= .T.
Local cQuery	:= ""
Local aArea		:= GetArea()
Local oFields	:= FWFormStruct(1, 'CT2')
Local aCpoExc	:= {} //{"CT2_CONVER","CT2_VALR02","CT2_VALR03","CT2_VALR04","CT2_VALR05","CT2_DTTX02","CT2_DTTX03","CT2_DTTX04","CT2_DTTX05"}
Local nX		:= 0         
Local nY		:= 0        
Local aAux		:= {}
Local cCampo 	:= ""
Local cTabCV3	:= ""
Local cTabCT2	:= ""
Local cChave	:= ""
Local cCT2_DC	:= ""
Local cQryCT2	:= ""
Local cAliasCT2	:= ""
	
	aCpoCT2 := {}

	DbSelectArea("CV3")
	CV3->(DbSetOrder(3))
	DbSeek(xFilial("CV3")+__cAliasORI+AllTrim(Str(__nRecProc)),.F.)
	If Empty(__cLP)
		__cLP:=CV3->(CV3_LP)
		CargaCTL(__cLP,__cAliasORI)
	EndIf

	cTabCV3	  := GetNextAlias()

	cQuerY		:= ""
	cQuery		+= "SELECT"
	cQuery		+= " CV3_LP, "
	cQuery		+= " CV3_LPSEQ, "
	cQuery		+= " CV3_RECDES, "
	cQuery		+= " R_E_C_N_O_ CV3REC "
	cQuery		+= " FROM "+RetSQLName("CV3")+" TMP"
	cQuery		+= " WHERE"               
	//cQuery		+= " CV3_FILIAL = '"+xFilial("CV3")+"' AND " 
	cQuery		+= " CV3_TABORI = '"+__cAliasORI+"' AND "	
	cQuery		+= " CV3_RECORI = '"+ALLTRIM(STR(__nRecProc))+"' AND "
	cQuery		+= " (CV3_MOEDLC = '01' OR CV3_MOEDLC = '') AND"
	cQuery     += " TMP.D_E_L_E_T_ = ' ' "
	cQuery := ChangeQuery(cQuery)
		
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cTabCV3,.T.,.T.)
														
	For nY := 1 to Len(oFields:aFields)

		aAdd(aCpoCT2, Alltrim(oFields:aFields[nY][3]) )
		If Alltrim(oFields:aFields[nY][3]) == "CT2_DEBITO"
			aAdd(aCpoCT2, "CT2_XVDESDB" )
		ElseIf Alltrim(oFields:aFields[nY][3]) == "CT2_CREDIT"
			aAdd(aCpoCT2, "CT2_XVDESCR" )
		Endif
		
	Next nY
	
	aAdd(aCpoCT2, "CT2_DEC" )
	aAdd(aCpoCT2, "R_E_C_N_O_" )
	
	While (cTabCV3)->(!EOF())
	
		If !Empty(StrTran(Alltrim(cLancs),"*",""))
			If !( Alltrim((cTabCV3)->CV3_LP) + "-" + Alltrim((cTabCV3)->CV3_LPSEQ) $ Alltrim(cLancs) ) //Alt
				(cTabCV3)->( DBSKIP() )
				LOOP
			Endif
		Endif

		nPos:= Ascan(__aLanCT2,{|x| x[2,Len(aCpoCT2)] == (cTabCV3)->CV3_RECDES })
		If nPos == 0
			lRet:= IIf(Empty(Val((cTabCV3)->CV3_RECDES)),.F.,.T.)
			If lRet
				aAux := Nil
				aAux := Array(Len(aCpoCT2)+1)
				CT2->(DbGoto(Val((cTabCV3)->CV3_RECDES)))
				
				If CT2->(eof())
					(cTabCV3)->(dbSkip())
					Loop 	
				EndIF
									
				If ! CT2->( Deleted() )

					If !( Alltrim(CT2->CT2_DC) $ "1*2*3*" ) //Alt
						(cTabCV3)->( DBSKIP() )
						LOOP					
					Endif

					If nTipoTit <> 4 .AND. nTipoTit <> 5
						If Alltrim(CT2->CT2_LOTE) <> "008850" //Alt
							(cTabCV3)->( DBSKIP() )
							LOOP
						Endif
					Endif

					If nTipoTit == 1
						If !(Alltrim(CT2->CT2_LP) $ "500*501*502*505*") //Alt
							(cTabCV3)->( DBSKIP() )
							LOOP
						Endif
					Elseif nTipoTit == 2
						If !(Alltrim(CT2->CT2_LP) $ "508*509*510*511*513*514*515*") //Alt
							(cTabCV3)->( DBSKIP() )
							LOOP
						Endif
					Elseif nTipoTit == 3
						If !(Alltrim(CT2->CT2_LP) $ "520*521*522*523*524*525*526*527*563*564*530*531*532*590*591*560*562*561*501*502*513*514*565*999*") //Alt
							(cTabCV3)->( DBSKIP() )
							LOOP
						Endif	
					Elseif nTipoTit == 4
						If !(Alltrim(CT2->CT2_LP) $ "610*620*630*") //Alt
							(cTabCV3)->( DBSKIP() )
							LOOP
						Endif		
					Elseif nTipoTit == 5
						If !(Alltrim(CT2->CT2_LP) $ "640*650*651*655*656*660*665*") //Alt
							(cTabCV3)->( DBSKIP() )
							LOOP
						Endif																	
					Endif

					aAux[len(aAux)] := (cTabCV3)->(CV3REC)

					For nX := 1 to Len(aCpoCT2)

						If aCpoCT2[nX] == "CT2_XVDESDB"
							If !Empty(Alltrim(CT2->CT2_DEBITO))
								aAux[nX] := Posicione("CT1",1,xFilial("CT1")+Alltrim(CT2->CT2_DEBITO),"CT1_DESC01")
							Else
								aAux[nX] := ""
							Endif
						ElseIf aCpoCT2[nX] == "CT2_XVDESCR"
							If !Empty(Alltrim(CT2->CT2_CREDIT))
								aAux[nX] := Posicione("CT1",1,xFilial("CT1")+Alltrim(CT2->CT2_CREDIT),"CT1_DESC01")
							Else
								aAux[nX] := ""
							Endif
						Else
							If aCpoCT2[nX] == "CT2_DC"
								cCampo   := aCpoCT2[nX]
								cCT2_DC := aCboxCT5[Val(CT2->&(cCampo))]
							EndIf
	//						If AScan(aCpoExc, { |x| UPPER(x) == aCpoCT2[nX]})== 0    // Nรฃo pegar esses campos Virtuais
							If CT2->(FieldPos(aCpoCT2[nX])) > 0 .Or. Alltrim(aCpoCT2[nX]) == "R_E_C_N_O_" .Or. AllTrim(aCpoCT2[nX]) == "CT2_DEC"

								If aCpoCT2[nX] = 'R_E_C_N_O_'
									cCampo   := aCpoCT2[nX]
									aAux[nX] := (cTabCV3)->(CV3_RECDES)
								ElseIf aCpoCT2[nX] = 'CT2_DEC'
									cCampo   := aCpoCT2[nX]
									aAux[nX] := cCT2_DC
								ElseIf aCpoCT2[nX] = 'CT2_HIST'
									cCampo := aCpoCT2[nX]
									cQryCT2 := "select CT2_HIST from " + RetSQLName("CT2")
									cQryCT2 += " where " //CT2_FILIAL='" + xFilial("CT2") + "' and"
									cQryCT2 += " CT2_DATA='" + Dtos(CT2->CT2_DATA) + "'"
									cQryCT2 += " and CT2_LOTE='" + CT2->CT2_LOTE + "'"
									cQryCT2 += " and CT2_SBLOTE='" + CT2->CT2_SBLOTE + "'"
									cQryCT2 += " and CT2_DOC='" + CT2->CT2_DOC + "'" 
									cQryCT2 += " and CT2_SEQLAN='" + CT2->CT2_SEQLAN + "'"
									cQryCT2 += " and CT2_FILORI='" + CT2->CT2_FILORI + "'"
									cQryCT2 += " and CT2_EMPORI='" + CT2->CT2_EMPORI + "'"
									cQryCT2 += " and CT2_MOEDLC='01'"
									cQryCT2 += " and D_E_L_E_T_=' '"
									cQryCT2 += " order by R_E_C_N_O_"
									cQryCT2 := ChangeQuery(cQryCT2)
									cAliasCT2 := GetNextAlias()
									DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQryCT2),cAliasCT2,.F.,.T.)
									aAux[nX] := ""

									While !((cAliasCT2)->(Eof())) 
										aAux[nX] += (cAliasCT2)->CT2_HIST
										(cAliasCT2)->(DbSkip())
									Enddo

									DbSelectArea(cAliasCT2)
									DbCloseArea()
									DbSelectArea(cTabCV3)
								Else
									cCampo   := aCpoCT2[nX]
									aAux[nX] := CT2->&(cCampo)
								EndIf
							EndIF
						Endif
					Next nX
					 
					aAdd(__aLanCT2,{0 ,aAux })
				EndIf
			EndIf
		EndIf
		(cTabCV3)->(dbSkip())
	EndDo    

	If Select(cTabCV3) > 0
		DbSelectArea(cTabCV3)
		(cTabCV3)->(DbCloseArea())
	Endif

	If lRet
		If Empty(__aLanCT2)
			lRet := .F.
		Else
			lRet:= .T.
		EndIf
	EndIf

Return lRet
	
/*/{Protheus.doc} CargaCTL(__cLP)
Carga do Lanรงamento Padrรฃo, pega os campos a exibir na AddField

@author wilson.possani

@since 02/04/2014
@version 1.0
/*/

Static Function CargaCTL(__cLP,cTabOri)	

	Local aArea	:= {}
	
	aArea := GetArea()

	//procura o LP na CTL e Adicionar campos do CTL_KEY para mostrar na tela de Documento Original no MVC
	dbSelectArea("CTL")
	dbSetOrder(1)

	If CTL->(dbSeek(xFilial("CTL")+__cLP))
		If CTL->(CTL_ALIAS) == cTabOri 
			cCpoOri:= ALLTRIM(CTL_KEY)
		Else
			cCpoOri := Alltrim((cTabOri)->(IndexKey(1)))
		Endif
	Else
		cCpoOri := Alltrim((cTabOri)->(IndexKey(1)))
	Endif

	cCpoOri:= Replace(cCpoOri,'DTOS', '')
	cCpoOri:= Replace(cCpoOri,'(', '')
	cCpoOri:= Replace(cCpoOri,')', '')

	if cPaisLoc = "RUS"
		cCpoOri:= Replace(cCpoOri,' ', '')
	Endif

	cCpoOri:= '{"' +Replace(cCpoOri,'+','","')+  '"}'
	aCpoOri :=&(cCpoOri)
	CargaINI() // Carrega os Dados
	RestArea(aArea)
	Asize(aArea,0)
	aArea := Nil

Return


Static Function fOpcCT5()

Local i := 0
Local aLancs := {}
Local nTotElem := 0

Private nTam      := 0
Private aLCs      := {}
Private MvRet     := ""
Private MvPar     := ""
Private cTitulo   := ""
Private MvParDef  := ""

#IFDEF WINDOWS
	oWnd := GetWndDefault()
#ENDIF

If nTipoTit == 1
	aLancs := {"500","501","502","505"} 
Elseif nTipoTit == 2
	aLancs := {"508","509","510","511","513","514","515"}
Elseif nTipoTit == 3
	aLancs := {"520","521","522","523","524","525","526","527","563","564","530","531","532","590","591","560","562","561","501","502","513","514","565","999"}
//Elseif nTipoTit == 4
//	aLancs := {"610","620","630"}
//Elseif nTipoTit == 5
//	aLancs := {"650","651","655","660","665"}
Endif

//Tratamento para carregar variaveis da lista de opcoes
nTam:=7
cTitulo := "Lan็amentos"

CT5->(DbSetOrder(1))

For i := 1 to Len(aLancs)

	CT5->(DbSeek(XFilial("CT5")+aLancs[i]))
	While CT5->(!Eof()) .And. AllTrim(CT5->CT5_LANPAD) == aLancs[i]

		If CT5->CT5_STATUS <> "2"
			MvParDef += AllTrim(CT5->CT5_LANPAD)+"-"+AllTrim(CT5->CT5_SEQUEN)
			aAdd(aLCs,AllTrim(CT5->CT5_LANPAD)+"-"+AllTrim(CT5->CT5_SEQUEN)+" - "+AllTrim(CT5->CT5_DESC))

			nTotElem++
		Endif

		CT5->(DbSkip())
	Enddo
	
Next i

//Executa funcao que monta tela de opcoes
f_Opcoes(@MvPar,cTitulo,aLCs,MvParDef,12,49,.F.,nTam,nTotElem)

//Tratamento para separar retorno com barra "/"
/*&MvRet := ""
For i:=1 to Len(MvPar)
	If !(SubStr(MvPar,i,1) $ " |*")
		&MvRet  += SubStr(MvPar,i,1) + ";"
	EndIf
Next	

//Trata para tirar o ultimo caracter
&MvRet := SubStr(&MvRet,1,Len(&MvRet)-1)

//Guarda numa variavel private o retorno da fun็ใo
cRetSX5SL := &MvRet
*/

Return(MvPar) 

Static Function RetCfop(nTipoTit)

Local cQuery := ""
Local cRet	 := ""

	If nTipoTit == 4
		cQuery += " SELECT D2_CF CFOP FROM " + RetSqlName("SD2")
		cQuery += " WHERE D_E_L_E_T_ = ' ' "
		cQuery += " AND D2_FILIAL = '"+TMPA->FILIAL+"' AND D2_DOC = '"+TMPA->NUMERO+"' AND D2_SERIE = '"+TMPA->PREFIXO+"' AND D2_CLIENTE = '"+TMPA->CLIFOR+"' AND D2_LOJA = '"+TMPA->LOJA+"' "
	Elseif nTipoTit == 5
		cQuery += " SELECT D1_CF CFOP FROM " + RetSqlName("SD1")
		cQuery += " WHERE D_E_L_E_T_ = ' ' "
		cQuery += " AND D1_FILIAL = '"+TMPA->FILIAL+"' AND D1_DOC = '"+TMPA->NUMERO+"' AND D1_SERIE = '"+TMPA->PREFIXO+"' AND D1_FORNECE = '"+TMPA->CLIFOR+"' AND D1_LOJA = '"+TMPA->LOJA+"' "	
	Endif

	If Select("TCFO") > 0
		TCFO->( dbclosearea() )
	Endif

	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TCFO",.F.,.T.)

	TCFO->( dbgotop() ) 

	While TCFO->( !Eof() ) 

		If !(Alltrim(TCFO->CFOP) $ cRet)
			cRet += Alltrim(TCFO->CFOP)+"/"
		Endif

		TCFO->( DbSkip() )
	Enddo

Return cRet
