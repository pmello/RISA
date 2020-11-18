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
{Protheus.doc} RFINR01
Rotina para gerar excel do SE5 referente a Variação Cambial

@type    function
@author  TOTVS..
@since   Nov/2020
@version P12

@project MAN0000001_EF_001
@obs     Projeto
-----------------------------------------------------------------------------------------------------------------------------------*/

User Function RFINR01()

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

#IFDEF TOP
        TCInternal(5,"*OFF")   // Desliga Refresh no Lock do Top
#ENDIF

aAdd(aParamBox,{1,"Diretorio\Arquivo" ,Space(120),"","","","",80,.T.})
aAdd(aParamBox,{1,"Emissao de"	,CriaVar("E1_EMISSAO"),"","","","",50,.T.}) 
aAdd(aParamBox,{1,"Emissao ate"	,CriaVar("E1_EMISSAO"),"","","","",50,.T.}) 

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
aadd(aSays,OemToAnsi("formato excel, contendo as informacoes da Variação Cambial."))

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
		E5_FILIAL AS FILIAL,
		E5_FILORIG AS FILORIG,
		E5_RECPAG AS RECPAG,
		E5_MOTBX AS MOTIVOBAIXA,
		ISNULL(CASE WHEN E5_RECPAG = 'R' THEN  E1_EMISSAO ELSE E2_EMISSAO END,'') AS EMISSAO, 
		ISNULL(CASE WHEN E5_RECPAG = 'R' THEN  E1_VENCTO ELSE E2_VENCTO END,'') AS VENCIMENTO, 
		E5_DATA AS BAIXA, 
		E5_PREFIXO AS PREFIXO, 
		E5_NUMERO AS NUMERO, 
		E5_PARCELA AS PARCELA, 
		E5_CLIFOR AS CLIFOR, 
		E5_LOJA AS LOJA, 
		ISNULL(CASE WHEN E5_RECPAG = 'R' THEN  A1_NREDUZ ELSE A2_NREDUZ END,'') AS RAZAOSOCIAL, 
		E5_NATUREZ AS NATUREZA, 
		ISNULL(ED_DESCRIC,'') AS DESCNAT, 
		E5_BANCO AS BANCO, 
		E5_AGENCIA AS AGENCIA, 
		E5_CONTA AS CONTA, 
		ISNULL(A6_NOME,'') AS DESCBCO, 
		
		CASE WHEN  (E5_RECPAG = 'R' 
					AND E5_VALOR > 0
				   	AND E5_TIPODOC = 'CM' 
				   	AND (E5_BANCO <> '' OR E5_MOTBX IN ('CMP','CEC') ) )
				   OR
				   (E5_RECPAG = 'P' 
					AND E5_VALOR < 0
				   	AND E5_TIPODOC = 'CM' 
				   	AND (E5_BANCO <> '' OR E5_MOTBX IN ('CMP','CEC') ) )
			 THEN (CASE WHEN E5_VALOR > 0 THEN E5_VALOR ELSE (E5_VALOR*-1) END) ELSE 0 END AS VcAtivaRealizada,
		
		CASE WHEN  (E5_RECPAG = 'R' 
				   	AND E5_VALOR > 0
				   	AND E5_TIPODOC = 'VM' 
				   	AND (E5_BANCO = '' OR E5_MOTBX NOT IN ('CMP','CEC') ) )
				   OR
				   (E5_RECPAG = 'P' 
				   	AND E5_VALOR < 0
				   	AND E5_TIPODOC = 'VM' 
				   	AND (E5_BANCO = '' OR E5_MOTBX NOT IN ('CMP','CEC') ) )
			 THEN (CASE WHEN E5_VALOR > 0 THEN E5_VALOR ELSE (E5_VALOR*-1) END) ELSE 0 END AS VcAtivaNRealizada,
			 
		CASE WHEN  (E5_RECPAG = 'R' 
					AND E5_VALOR < 0
				   	AND E5_TIPODOC = 'CM' 
				   	AND (E5_BANCO <> '' OR E5_MOTBX IN ('CMP','CEC') ) )
				   OR
				   (E5_RECPAG = 'P' 
					AND E5_VALOR > 0
				   	AND E5_TIPODOC = 'CM' 
				   	AND (E5_BANCO <> '' OR E5_MOTBX IN ('CMP','CEC') ) )
			 THEN (CASE WHEN E5_VALOR > 0 THEN E5_VALOR ELSE (E5_VALOR*-1) END) ELSE 0 END AS VcPassivaRealizada,
		
		CASE WHEN  (E5_RECPAG = 'R' 
					AND E5_VALOR < 0
				   	AND E5_TIPODOC = 'VM' 
				   	AND (E5_BANCO = '' OR E5_MOTBX NOT IN ('CMP','CEC') ) )
				   OR
				   (E5_RECPAG = 'P' 
					AND E5_VALOR > 0
				   	AND E5_TIPODOC = 'VM' 
				   	AND (E5_BANCO = '' OR E5_MOTBX NOT IN ('CMP','CEC') ) )
			 THEN (CASE WHEN E5_VALOR > 0 THEN E5_VALOR ELSE (E5_VALOR*-1) END) ELSE 0 END AS VcPassivaNRealizada	
		
	FROM %table:SE5% SE5 (NOLOCK)
	
	LEFT OUTER JOIN %table:SE1% SE1 (NOLOCK) ON
		SE1.E1_FILIAL = SE5.E5_FILORIG
		AND SE1.E1_PREFIXO = SE5.E5_PREFIXO
		AND SE1.E1_NUM = SE5.E5_NUMERO
		AND SE1.E1_PARCELA = SE5.E5_PARCELA
		AND SE1.E1_TIPO = SE5.E5_TIPO
		AND SE1.E1_CLIENTE = SE5.E5_CLIENTE
		AND SE1.E1_LOJA = SE5.E5_LOJA
		AND SE1.D_E_L_E_T_ = ''
	
	LEFT OUTER JOIN %table:SA1% SA1 (NOLOCK) ON
		SA1.A1_FILIAL = %xFilial:SA1%
		AND SA1.A1_COD = SE1.E1_CLIENTE
		AND SA1.A1_LOJA = SE1.E1_LOJA
		AND SA1.D_E_L_E_T_ = '' 
	
	LEFT OUTER JOIN %table:SE2% SE2 (NOLOCK) ON
		SE2.E2_FILIAL = SE5.E5_FILORIG
		AND SE2.E2_PREFIXO = SE5.E5_PREFIXO
		AND SE2.E2_NUM = SE5.E5_NUMERO
		AND SE2.E2_PARCELA = SE5.E5_PARCELA
		AND SE2.E2_TIPO = SE5.E5_TIPO
		AND SE2.E2_FORNECE = SE5.E5_FORNECE
		AND SE2.E2_LOJA = SE5.E5_LOJA
		AND SE2.D_E_L_E_T_ = ''	
	
	LEFT OUTER JOIN %table:SA2% SA2 (NOLOCK) ON
		SA2.A2_FILIAL = %xFilial:SA2%
		AND SA2.A2_COD = SE2.E2_FORNECE
		AND SA2.A2_LOJA = SE2.E2_LOJA
		AND SA2.D_E_L_E_T_ = '' 
		
	LEFT OUTER JOIN %table:SED% SED (NOLOCK) ON
		SED.ED_FILIAL = %xFilial:SED%
		AND SED.ED_CODIGO = SE5.E5_NATUREZ
		AND SED.D_E_L_E_T_ = ''
	
	LEFT OUTER JOIN %table:SA6% SA6 (NOLOCK) ON
		SA6.A6_FILIAL = %xFilial:SA6%
		AND SA6.A6_COD = SE5.E5_BANCO
		AND SA6.A6_AGENCIA = SE5.E5_AGENCIA
		AND SA6.A6_NUMCON = SE5.E5_CONTA
		AND SA6.D_E_L_E_T_ = ''
			
	WHERE SE5.D_E_L_E_T_ = '' 
		AND E5_TIPODOC IN ('VM','CM')
		AND E5_SITUACA <> 'C'
		AND E5_DATA BETWEEN %Exp:dEmisDe% AND %Exp:dEmisAte%
	ORDER BY E5_NATUREZ, E5_PREFIXO, E5_NUMERO, E5_PARCELA, E5_CLIFOR

EndSQL

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria arquivo                                                              ³
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
oFwMsEx:AddColumn(cWorkSheet,cTable,"FILIAL",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"FILORIG",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"RECPAG",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"MOTIVOBAIXA",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"EMISSAO",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"VENCIMENTO",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"BAIXA",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"PREFIXO",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"NUMERO",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"PARCELA",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"CLIFOR",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"LOJA",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"RAZAOSOCIAL",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"NATUREZA",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"DESCNAT",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"BANCO",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"AGENCIA",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"CONTA",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"DESCBCO",1,1)
oFwMsEx:AddColumn(cWorkSheet,cTable,"VcAtivaRealizada",1,3)
oFwMsEx:AddColumn(cWorkSheet,cTable,"VcAtivaNRealizada",1,3)
oFwMsEx:AddColumn(cWorkSheet,cTable,"VcPassivaRealizada",1,3)
oFwMsEx:AddColumn(cWorkSheet,cTable,"VcPassivaNRealizada",1,3)	

dbSelectArea((cAli))
dbGotop()

While !EOF()                       

	oFwMsEx:AddRow( cWorkSheet,cTable,{	(cAli)->FILIAL,;
										(cAli)->FILORIG,;
										(cAli)->RECPAG,;
										(cAli)->MOTIVOBAIXA,;
										stod((cAli)->EMISSAO),;
										stod((cAli)->VENCIMENTO),;
										stod((cAli)->BAIXA),;
										(cAli)->PREFIXO,;
										(cAli)->NUMERO,;
										(cAli)->PARCELA,;
										(cAli)->CLIFOR,;
										(cAli)->LOJA,;
										(cAli)->RAZAOSOCIAL,;
										(cAli)->NATUREZA,;
										(cAli)->DESCNAT,;
										(cAli)->BANCO,;
										(cAli)->AGENCIA,;
										(cAli)->CONTA,;
										(cAli)->DESCBCO,;
										(cAli)->VcAtivaRealizada,;
										(cAli)->VcAtivaNRealizada,;
										(cAli)->VcPassivaRealizada,;
										(cAli)->VcPassivaNRealizada})

//SubStr((cAli)->DATAFIM,7,2)+"/"+SubStr((cAli)->DATAFIM,5,2)+"/"+SubStr((cAli)->DATAFIM,1,4),;
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
