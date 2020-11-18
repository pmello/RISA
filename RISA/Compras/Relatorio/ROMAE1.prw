#INCLUDE "PROTHEUS.CH" 
#INCLUDE "TOTVS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ROMAE      ³ Autor ³ Charlles Reis	     ³Data ³ 07/02/17 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relatório de Impressão do Romaneio de Entrada		      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Agro Baggio - Compras		                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
/*/
User Function ROMAE1() 
//Private _aArea1 := GetArea()

Private cPerg  := PadR("ROMAE1", Len(SX1->X1_GRUPO))

CriaSx1()
Pergunte(cPerg,.T.)

Processa( {|| ReportDef()  }, "ROMANEIO DE ENTRADA" )                    

Return()  

Static Function ReportDef()
Private oSessao1 := nil
Private oReport

//Pergunte(cPerg,.F.) 

//######################
//##Cria Objeto TReport#
//######################
oReport := TReport():New("ROMANEIO DE ENTRADA","ROMANEIO DE ENTRADA", cPerg ,{|| PrintReport()},"ROMANEIO DE ENTRADA")
//oReport:lParamPage := .F.   //Exibe parâmetros para impressão. 
//oReport:SetLandscape(.T.)   //Define orientação de página do relatório como paisagem. 
//oReport:nFontBody := 8.6  
//oReport:SetColSpace(1)
//oReport:cFontBody := 'Arial' 
//oReport:SetLineHeight(40)
                                 
oReport:SetTotalInLine(.F.)
oReport:SetLineHeight(35)
oReport:SetColSpace(1)
oReport:SetLeftMargin(0)
oReport:oPage:SetPageNumber(1)
//oReport:cFontBody := 'Courier New'
oReport:nFontBody := 8.5
oReport:lBold := .F.
oReport:lUnderLine := .F.
oReport:lHeaderVisible := .T.
oReport:lFooterVisible := .T.
oReport:lParamPage := .F.
//oReport:SetAutoSize := .T.




//###############
//##Cria Sessao1#
//###############    
//oSessao1 := TRSection():New(oReport, "ROMANEIO DE ENTRADA",3,4,5,6,7,.T.,9,10,11,12,13,14,15,16,17,18,19,20,21,22,)
oSessao1 := TRSection():New(oReport, "ROMANEIO DE ENTRADA",,,,,,.T.)    //A classe TRSection pode ser entendida como um layout do relatório, por conter células, quebras e totalizadores que darão um formato para sua impressão.
//oSessao1:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
//oSessao1:SetHeaderBreak(.F.)   //Define se imprime cabeçalho das células após uma quebra (TRBreak). lHeaderBreak Se verdadeiro, aponta que salta página na quebra                                      


oSessao1:SetTotalInLine(.F.)
//oSessao1:SetTotalText('Contas a Receber')
oSessao1:lUserVisible := .T.
oSessao1:lHeaderVisible := .F.
oSessao1:SetLineStyle(.F.)
oSessao1:SetLineHeight(35)
oSessao1:SetColSpace(1)
oSessao1:SetLeftMargin(0)
oSessao1:SetLinesBefore(0)
oSessao1:SetCols(120)
oSessao1:SetHeaderSection(.T.)
oSessao1:SetHeaderPage(.F.)
oSessao1:SetHeaderBreak(.F.)
oSessao1:SetLineBreak(.F.)
oSessao1:SetAutoSize(.T.)
oSessao1:SetPageBreak(.F.)
//oSessao1:SetClrBack(16777215)
//oSessao1:SetClrFore(0)
//oSessao1:SetBorder('')
//oSessao1:SetBorder('',,,.T.)

                       
//TRCell():New(oParent, cName , _cAlias, cTitle,     cPicture, nSize  ,lPixel  , bBlock  ,    cAlign      ,  lLineBreak  ,  cHeaderAlign ,  lCellBreak ,  nColSpace ,  lAutoSize ,  nClrBack ,  nClrFore ,  lBold,)                   
//TRCell():New(oSessao1,"FILIAL"   ,'TRB', "FIIIAL"       	,,TamSX3("F1_FILIAL")[1], , ,"CENTER", ,"CENTER", ,, , , , ,)

//TRCell():New(oSessao1,"EMISSA"   ,'TRB', "EMISSÃO"       	,,TamSX3("D1_EMISSAO")[1], , ,"LEFT", ,"LEFT", ,2, , , , ,)
//TRCell():New(oSessao1,"GRUPOO"   ,'TRB', "GRUPO"	  ,,16, , ,"LEFT", ,"LEFT", , , , , , ,)   
TRCell():New(oSessao1,"CODITE"   ,'TRB', "CÓD"	  	  ,,TamSX3("D1_COD")[1], , ,"LEFT", ,"LEFT", , , , , , ,) 
TRCell():New(oSessao1,"DESCRI"   ,'TRB', "DESC"  	  ,,16, , ,"LEFT", ,"LEFT", , , , , , ,)   
TRCell():New(oSessao1,"QUANTI"   ,'TRB', "QTD."   	  ,,4, , ,"CENTER", ,"CENTER", , , , , , ,)
TRCell():New(oSessao1,"LOCALI"   ,'TRB', "LOCALI"	  ,,8, , ,"LEFT", ,"LEFT", , , , , , ,)                   
TRCell():New(oSessao1,"EMISSA"	 ,'TRB', "EMISSÃO" 	  ,,10,.F.)                                                 
TRCell():New(oSessao1,"FORNEC"   ,'TRB', "NOME" 	  ,,17, , ,"LEFT", ,"LEFT", , , , , , ,) 
TRCell():New(oSessao1,"CIDADE"   ,'TRB', "CIDADE"	  ,,10, , ,"LEFT", ,"LEFT", , , , , , ,)
TRCell():New(oSessao1,"NUMNFI"   ,'TRB', "NUM NF"	  ,,TamSX3("D1_DOC")[1],,,"LEFT", ,"LEFT", , , , , , ,)

oBreak1 := TRBreak():New(oSessao1,'',"NOTAS",.F.)                                                                                                                                  
oBreak1 := TRBreak():New(oSessao1,{||TRB->NUMNFI},"TOTAL",.F.)
TRFunction():New(oSessao1:Cell("QUANTI"), ""	, "SUM"		, oBreak1, ""/*cTitle*/	, /*cPicture*/	, /*uFormula*/		, .F./*lEndSection*/, .F./*lEndReport*/, .F./*lEndPage*/) 


oReport:PrintDialog()

Return() 


Static Function PrintReport() 

Select1()///Seleciona Dados para o Relatório
oReport:SetMeter(TRB->(RecCount()))
oSessao1:Init() 

TRB->(DbGoTop())  //Move o cursor da área de trabalho ativa para o primeiro registro lógico.
While TRB->(!EOF())    
   
	oReport:IncMeter() //IncMeter() Incrementa a regua de progreção do relatório  
    oSessao1:PrintLine(.T.)
    
	TRB->(DBSKIP())        
ENDDO

oSessao1:Finish()
TRB->(DbCloseArea())
TMP3->(DbCloseArea())

Return()                       


//Static Function CriaPerg(cPerg)
//	PutSx1(cPerg,"01","Ordem de Impressão........:?","","","mv_ch1","C",1,00,0,"C","","","","","mv_par01","Locação","","","","Código","","","","","","")
//Return  

Static Function Select1() 
Local cQuery   := ''
Local cVetor   := ''
Local _QtdPDV  := 0 
Local _VlrPDV  := 0 
Local _cComp   := 0
Local _nQuant  := 0   
Local aArqTrab := {}   
Local cTabAux  := ""
Private aStru  := {}			
  
aadd(aArqTrab,{"EMISSA"  ,"D",10,0})
aadd(aArqTrab,{"NUMNFI"  ,"C",9,0})
aadd(aArqTrab,{"CODITE"  ,TamSX3("D1_COD")[3]       ,TamSX3("D1_COD")[1]  		,TamSX3("D1_COD")[2]})
aadd(aArqTrab,{"DESCRI"  ,TamSX3("B1_DESC")[3]  	,TamSX3("B1_DESC")[1]		,TamSX3("B1_DESC")[2]})   
aadd(aArqTrab,{"QUANTI"   ,TamSX3("D1_QUANT")[3]  	,TamSX3("D1_QUANT")[1]  	,TamSX3("D1_QUANT")[2]})
aadd(aArqTrab,{"LOCALI"  ,TamSX3("BZ_LOCALI2")[3]  	,TamSX3("BZ_LOCALI2")[1] 	,TamSX3("BZ_LOCALI2")[2]})  
aadd(aArqTrab,{"CIDADE"  ,"C",10,0})
aadd(aArqTrab,{"TIPNFI"  ,"C",1,0})
aadd(aArqTrab,{"FORNEC"  ,"C",17,0})
                                                                               	
cTabAux := CriaTrab(aArqTrab, .T.)     
DbCreate(cTabAux, aArqTrab)
cInd := LEFT(cTabAux, 7) + "1"

Iif(Select('TRB') > 0, TRB->(DbCloseArea()),)
DbUseArea(.T., , cTabAux, 'TRB', .F., .F.)
      
IndRegua('TRB', cInd, "NUMNFI")    //Indice de organização do relatório
TRB->(DbClearIndex())	
DbSetIndex(cInd + OrdBagExt())

 
//// Registros para a seção Total Consumo Via Requisições
Iif(Select("TMP3") > 0, TMP3->(DbCloseArea()),)

cQuery := " SELECT D1_COD CODITE, B1_DESC DESCRI, D1_QUANT QUANTI, BZ_LOCALI2 LOCALI, D1_EMISSAO EMISSAO, D1_DOC NUMNFI, D1_TIPO TIPNFI, D1_FORNECE+D1_LOJA FORNEC  " + CRLF
cQuery += " FROM   SD1110 D1, SB1110 B1, SBZ110 BZ  " + CRLF
cQuery += " WHERE  B1.D_E_L_E_T_='' AND D1.D_E_L_E_T_='' AND BZ.D_E_L_E_T_=''  " + CRLF
cQuery += " AND D1_COD = B1_COD  " + CRLF
cQuery += " AND B1_COD = BZ_COD  " + CRLF
cQuery += " AND B1_GRUPO = D1_GRUPO " + CRLF
cQuery += " AND D1_FILIAL = BZ_FILIAL  " + CRLF
cQuery += " AND D1_DOC = '"+ALLTRIM(SF1->F1_DOC)+"'  " + CRLF
cQuery += " AND D1_FILIAL = '"+SF1->F1_FILIAL+"' " + CRLF
cQuery += " AND D1_EMISSAO = '"+DTOS(SF1->F1_EMISSAO)+"'  " + CRLF
If 		MV_PAR01 == 2
	cQuery += " ORDER BY D1_COD  " + CRLF
ElseIf 	MV_PAR01 == 1                                 
	cQuery += " ORDER BY BZ_LOCALI2 " + CRLF
Endif  

dbUseArea(.T.,'TOPCONN',TcGenQry(,,cQuery),'TMP3',.T.,.T.)  
   
TMP3->(dbgotop())


While TMP3->(!Eof())                                                                   
		            
  	 	RecLock('TRB', .T.)    
  	 	                                                 
		TRB->EMISSA := STOD(TMP3->EMISSAO)  	//DATA DE EMISSÃO
	   	TRB->NUMNFI := ALLTRIM(TMP3->NUMNFI)	//CODUMENTO
		TRB->CODITE := ALLTRIM(TMP3->CODITE)    //CODIGO
		TRB->DESCRI := ALLTRIM(UPPER(TMP3->DESCRI))    //DESCRICAO DO PRODUTO
		TRB->QUANTI := TMP3->QUANTI  			//QUANTIDADE
		TRB->LOCALI := ALLTRIM(TMP3->LOCALI)	//LOCAÇÃO
	If 	TMP3->TIPNFI == "N"
		SA2->(DbSelectArea("SA2"))
		SA2->(DbSetOrder(1))
		SA2->(MsSeek(xFilial("SA2")+TMP3->FORNEC))   	   	
	   	TRB->FORNEC := ALLTRIM(SA2->A2_NOME)    //FORNECEDOR
		TRB->CIDADE := ALLTRIM(SA2->A2_MUN)     //CIDADE
	Else	         
		SA1->(DbSelectArea("SA1"))
		SA1->(DbSetOrder(1))
		SA1->(MsSeek(xFilial("SA1")+TMP3->FORNEC))   	   	
	   	TRB->FORNEC := ALLTRIM(SA1->A1_NOME)    //CLIENTE
		TRB->CIDADE := ALLTRIM(SA1->A1_MUN)     //CIDADE
	Endif								
	    TRB->(MsUnlock())
		TMP3->(DbSkip())
EndDo     

//RestArea(_aArea1)

Return()      

// # Cria perguntas

Static Function CRIASX1()

local _cAlias := Alias ()
local _aRegs  := {} 
local _i      := 0
local _j      := 0

/*
01 - Grupo           11 -  GSC          21 - DefENG2     31 - DefENG4      41 - Help
02 - Ordem           12 -  Valid        22 - CNT02       32 - CNT04
03 - Pergunt         13 -  Var01        23 - Var03       33 - Var05
04 - PergSPA         14 -  Def01        24 - Def03       34 - Def05
05 - PergING         15 -  DefSPA1      25 - DefSPA3     35 - DefSPA5
06 - Variavel        16 -  DefENG1      26 - DefENG3     36 - DefENG5
07 - Tipo            17 -  CNT01        27 - CNT03       37 - CNT05
08 - Tamanho         18 -  Var02        28 - Var04       38 - F3
09 - Decimal         19 -  Def02        29 - Def04       39 - PYME
10 - PRESEL          20 -  DefSPA2      30 - DefSPA4     40 - GRPSXG
*/                                                                                          
//               1       2            3                    4     5      6          7    8   9   10    11    12         13         14        15    16    17    18       19          20     21    22   23          24            25   26   27     28          29          30   31    32    33        34      35    36     37   38      39     40   41   42    43

aAdd( _aRegs , { cPerg , "01" , "Ordem de Impressão.....?", " " , " " , "mv_ch5" , "N" , 1 , 0 , 1 , "C" , "naovazio()","mv_par01" , "Locacao" , " " , " " , " " , " " , "Codigo" , " " , " " , " " , "" , "" , "" , "" , " " , " " , "" , "" , "" , " " , " " , "" , " " , " " , " " , ""       , "N" , "" , " " , "" , " "})

DbSelectArea ("SX1")
DbSetOrder (1)
For _i := 1 to Len (_aRegs)
	If ! DbSeek (cPerg + _aRegs [_i, 2])
		RecLock ("SX1", .T.)
	else
		RecLock ("SX1", .F.)
	endif
	For _j := 1 to FCount ()
		// Campos CNT nao sao gravados para preservar conteudo anterior.
		If _j <= Len (_aRegs [_i]) .and. left (fieldname (_j), 6) != "X1_CNT" .and. fieldname (_j) != "X1_PRESEL"
			FieldPut (_j, _aRegs [_i, _j])
		Endif
	Next
	MsUnlock ()
Next

// Deleta do SX1 as perguntas que nao constam em _aRegs
DbSeek (cPerg, .T.)
do while ! eof () .and. x1_grupo == cPerg
	if ascan (_aRegs, {|_aVal| _aVal [2] == sx1 -> x1_ordem}) == 0
		reclock ("SX1", .F.)
		dbdelete ()
		msunlock ()
	endif
	dbskip ()
enddo
DbSelectArea (_cAlias)
Return(.T.)         