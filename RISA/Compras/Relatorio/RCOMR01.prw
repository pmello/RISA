#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH" 
#INCLUDE "PROTHEUS.CH"
#include "DBSTRUCT.ch"

//Consulta da documentacao - https://tdn.totvs.com/display/public/PROT/FWMsExcel
/* 
Sintaxe
FWMsExcel():AddColumn(< cWorkSheet >, < cTable >, < cColumn >, < nAlign >, < nFormat >, < lTotal >)

Descrição
Adiciona uma coluna a tabela de uma Worksheet.

Parâmetros

Nome		Tipo		Descrição
cWorkSheet	Caracteres	Nome da planilha	
cTable		Caracteres	Nome da planilha	
cColumn		Caracteres	Titulo da coluna	
nAlign		Numérico	Alinhamento da coluna ( 1-Left,2-Center,3-Right )	
nFormat		Numérico	Codigo de formatação ( 1-General,2-Number,3-Monetário,4-DateTime )	
lTotal		Lógico		Indica se a coluna deve ser totalizada	

*/

/*-----------------------------------------------------------------------------------------------------------------------------------
{Protheus.doc} RCOMR01
Rotina para gerar excel trazendo informaçõe complementares de frete (SZ1)

@type    function
@author  TOTVS..
@since   Out/2020
@version P12

@project MAN0000001_EF_001
@obs     Projeto
-----------------------------------------------------------------------------------------------------------------------------------*/

User Function RCOMR01()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa variaveis                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private nOpca    	:= 0
Private aSays    	:= {}
Private aButtons	:= {}
Private cCadastro 	:= "Gera arquivo excel"
Private aRet 		:= {}
Private aParamBox 	:= {}
Private cAli 		:= GetNextAlias() //Carrega o proximo alias disponivel

Private cArquivo    
Private dEmisDe     
Private dEmisAte  	
Private cNotaDe
Private cNotaAte

#IFDEF TOP
        TCInternal(5,"*OFF")   // Desliga Refresh no Lock do Top
#ENDIF

aAdd(aParamBox,{1,"Diretorio\Arquivo" ,Space(120),"","","","",80,.T.})
aAdd(aParamBox,{1,"Emissao de"	,CriaVar("F1_EMISSAO"),"","","","",50,.T.}) 
aAdd(aParamBox,{1,"Emissao ate"	,CriaVar("F1_EMISSAO"),"","","","",50,.T.}) 
aAdd(aParamBox,{1,"Nota de"		,CriaVar("F1_DOC"),"","","","",50,.F.})
aAdd(aParamBox,{1,"Nota até"	,CriaVar("F1_DOC"),"","","","",50,.T.})

// Tipo 1 -> MsGet()
//           [2]-Descricao
//           [3]-String contendo o inicializador do campo
//           [4]-String contendo a Picture do campo
//           [5]-String contendo a validacao
//           [6]-Consulta F3
//           [7]-String contendo a validacao When
//           [8]-Tamanho do MsGet
//           [9]-Flag .T./.F. Parametro Obrigatorio ?

aadd(aSays,OemToAnsi("Este programa tem como objetivo gerar um arquivo em"))
aadd(aSays,OemToAnsi("formato excel, contendo as informacoes complementares"))
aadd(aSays,OemToAnsi("do conhecimento de frete."))
//aadd(aButtons, { 5,.T.,{|| ParamBox(aParamBox,"Titulo",@aRet) } } )
aadd(aButtons, { 1,.T.,{|| nOpca:= 1, If( Ver(), FechaBatch(), nOpca:=0 ) }} )
aadd(aButtons, { 2,.T.,{|| FechaBatch() }} )

FormBatch(cCadastro,aSays,aButtons)

If  nOpca == 1
    msAguarde({||MProc()})
Endif

Return()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Ver                                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica se pode efetuar o processamento                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Ver()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz a chamada da tela de pergunte do parambox                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ParamBox(aParamBox,"Titulo",@aRet)
	cArquivo	:= Alltrim(aRet[1])
	dEmisDe   	:= dTOS(aRet[2])
	dEmisAte  	:= dTOS(aRet[3])
	cNotaDe		:= Alltrim(aRet[4])
	cNotaAte 	:= Alltrim(aRet[5])
Else
	Return(.F.)
EndIf

If  "." $ cArquivo .or. ;
    "xls" $ upper(cArquivo)
    msgstop("Nao informe extensao para o nome do arquivo. Sera gerado sempre como XLS.")
    Return(.F.)
Endif   

cArquivo := alltrim(cArquivo) + ".xls"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Solicita confirmacao                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cExp := "Confirma a geracao do arquivo " + upper(alltrim(cArquivo)) + " ?"

If  ! MsgYesNo(cExp,"Confirma ?")
    Return(.F.)
Endif   

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MProc                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Processa                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function MProc()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ mensagem de processamento                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
msProcTxt("Carregando informacoes ... ")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta consulta              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

BeginSQL Alias cAli

	SELECT
		F1_EMISSAO AS EMISSAO,
		Z1_NOTNUM AS NOTA,
		Z1_NOTSER AS SERIE,
		Z1_NOTFOR AS FORNECEDOR,
		Z1_NOTLOJ AS LOJA,
		A2_NOME AS NOME,
		D1_XPESFIM AS PESOFIM,
		D1_XVLQUEB AS VALORQUEBRA,
		Z1_XNFEORI AS ENTRADAORIGEM,
		Z1_XNESEOR AS SERIEORIGEM,
		Z1_XFORORI AS FORORIGEM,
		Z1_XLJFORI AS LOJAFORORIGEM,
		Z1_XNFSORI AS SAIDAORIGEM,
		Z1_XNSSEOR AS SERIEORIGEM,
		Z1_XCLIORI AS CLIORIGEM,
		Z1_XLJCORI AS LOJACLIORIGEM,
		Z1_XVLMERC AS VLRMERCADORIA,
		Z1_XDTFIM AS DATAFIM,
		Z1_XORIG AS ORIGEM,
		Z1_SDESORI AS DESCORIGEM,
		Z1_XDEST AS DESTINO,
		Z1_XDESDES AS DESCDESTINO,
		Z1_XCLIREM AS REMETENTE,
		Z1_XLJREM AS LJREMETENTE,
		Z1_XCLIDES AS DESTINATARIO,
		Z1_XLJDES AS LJDESTINATARIO,
		Z1_XCLIREC AS RECEBEDOR,
		Z1_XLJREC AS LJRECEBEDOR,
		Z1_XCLIEXP AS EXPEDIDOR,
		Z1_XLJEXP AS LJEXPEDIDOR,
		Z1_XCLITOM AS TOMADOR,
		Z1_XLJTOM AS LJTOMADOR	
	FROM %table:SF1% SF1 (NOLOCK)
	INNER JOIN %table:SZ1% SZ1 (NOLOCK) ON
		Z1_FILIAL = F1_FILIAL
		AND Z1_NOTNUM = F1_DOC
		AND Z1_NOTSER = F1_SERIE
		AND Z1_NOTFOR = F1_FORNECE
		AND Z1_NOTLOJ = F1_LOJA
		AND SZ1.D_E_L_E_T_ = ''
	INNER JOIN SD1990 SD1 (NOLOCK) ON
		D1_FILIAL = F1_FILIAL
		AND D1_DOC = F1_DOC
		AND D1_SERIE = F1_SERIE
		AND D1_FORNECE = F1_FORNECE
		AND D1_LOJA = F1_LOJA
		AND SD1.D_E_L_E_T_ = ''
	INNER JOIN %table:SA2% SA2 (NOLOCK) ON
		A2_FILIAL = %xFilial:SA2%
		AND A2_COD = F1_FORNECE
		AND A2_LOJA = F1_LOJA
		AND SA2.D_E_L_E_T_ = ''
	WHERE F1_FILIAL = %xFilial:SF1%
		AND F1_DOC BETWEEN %Exp:cNotaDe% AND %Exp:cNotaAte%
		AND F1_EMISSAO BETWEEN %Exp:dEmisDe% AND %Exp:dEmisAte%
		AND SF1.D_E_L_E_T_ = ''

EndSQL

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria arquivo                                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
msProcTxt("Gerando arquivo ...")

dbSelectArea((cAli))

//Caso o arquivo identificado no parametro ja exista eu excluo
If File(cArquivo)
	Ferase(cArquivo)
EndIf

//Chama a função para criar o excel
GeraExcel()

dbCloseArea((cAli))

Return()

Static Function GeraExcel()

Local oFwMsEx		:= NIL
Local cWorkSheet 	:= "Sheet1" //Nome da aba da planilha
Local cTable     	:= "REGISTROS" //Titulo na primeira linha da tabela

//Monta a classe do excel
oFwMsEx:= FWMsExcelEx():New()
oFwMsEx:AddWorkSheet(cWorkSheet)
oFwMsEx:AddTable(cWorkSheet,cTable)

//Define o nome das colunas
oFwMsEx:AddColumn(cWorkSheet,cTable,"EMISSAO",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"NOTA",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"SERIE",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"FORNECEDOR",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"LOJA",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"NOME",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"PESOFIM",1,2)
oFwMsEx:AddColumn(cWorkSheet,cTable,"VALORQUEBRA",1,3)
oFwMsEx:AddColumn(cWorkSheet,cTable,"ENTRADAORIGEM",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"SERIEORIGEM",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"FORORIGEM",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"LOJAFORORIGEM",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"SAIDAORIGEM",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"SERIEORIGEM",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"CLIORIGEM",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"LOJACLIORIGEM",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"VLRMERCADORIA",1,3)
oFwMsEx:AddColumn(cWorkSheet,cTable,"DATAFIM",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"ORIGEM",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"DESCORIGEM",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"DESTINO",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"DESCDESTINO",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"REMETENTE",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"LJREMETENTE",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"DESTINATARIO",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"LJDESTINATARI",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"RECEBEDOR",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"LJRECEBEDO",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"EXPEDIDOR",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"LJEXPEDIDOR",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"TOMADOR",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"LJTOMADOR",1,1)

dbSelectArea((cAli))
dbGotop()

While !EOF()                       

	oFwMsEx:AddRow( cWorkSheet,cTable,{	stod((cAli)->EMISSAO),;
										(cAli)->NOTA,;
										(cAli)->SERIE,;
										(cAli)->FORNECEDOR,;
										(cAli)->LOJA,;
										(cAli)->NOME,;
										(cAli)->PESOFIM,;
										(cAli)->VALORQUEBRA,;
										(cAli)->ENTRADAORIGEM,;
										(cAli)->SERIEORIGEM,;
										(cAli)->FORORIGEM,;
										(cAli)->LOJAFORORIGEM,;
										(cAli)->SAIDAORIGEM,;
										(cAli)->SERIEORIGEM,;
										(cAli)->CLIORIGEM,;
										(cAli)->LOJACLIORIGEM,;
										(cAli)->VLRMERCADORIA,;
										SubStr((cAli)->DATAFIM,7,2)+"/"+SubStr((cAli)->DATAFIM,5,2)+"/"+SubStr((cAli)->DATAFIM,1,4),;
										(cAli)->ORIGEM,;
										(cAli)->DESCORIGEM,;
										(cAli)->DESTINO,;
										(cAli)->DESCDESTINO,;
										(cAli)->REMETENTE,;
										(cAli)->LJREMETENTE,;
										(cAli)->DESTINATARIO,;
										(cAli)->LJDESTINATARI,;
										(cAli)->RECEBEDOR,;
										(cAli)->LJRECEBEDO,;
										(cAli)->EXPEDIDOR,;
										(cAli)->LJEXPEDIDOR,;
										(cAli)->TOMADOR,;
										(cAli)->LJTOMADOR})

	dbSkip()
EndDo								 				 
		
oFwMsEx:Activate()
oFwMsEx:GetXMLFile(cArquivo)

//ShellExecute('open',cArquivo,'','',3)

If ! ApOleClient( 'MsExcel' ) 
	MsgAlert('MsExcel nao instalado')
	Return()
EndIf

//Abre o excel gerado
oExcelApp := MsExcel():New()
oExcelApp :WorkBooks:Open( ALLTRIM(cArquivo) ) // Abre uma planilha
oExcelApp :SetVisible(.T.)

Return()
