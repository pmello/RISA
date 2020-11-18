#include "rwmake.ch"
#include "Protheus.ch"
/*-----------------------------------------------------------------------------------------------------------------------------------
{Protheus.doc} ROFIA01
Rotina para atualizar o preco das pecas em garantia.

@type    function
@author  TOTVS..
@since   Out/2020
@version P12.1.25

@project MAN0000001_EF_001
@obs     Para o campo VO3_VALPEC houve a seguinte alteração no SX3.
		 1- O campo foi alterado de visualizar para alterar, assim posso fazer o ajuste por essa rotina
		 2- No X3_WHEN foi colocado alltrim(FunName()) == "ROFIA01", assim só podem ser alterados por essa rotina.
-----------------------------------------------------------------------------------------------------------------------------------*/

User Function ROFIA01()

Private CCADASTRO,AROTINA
Private aCores 		   := {}
Private lCopia  := .F.

cCadastro := "Garantia"
aRotina := {{ "Pesquisar" ,"AxPesqui" ,	 0 , 1},;
			{ "Visualizar","U_ROFIA01A", 0 , 2},;
			{ "Incluir"   ,"U_ROFIA01A", 0 , 3},;
			{ "Alterar"   ,"U_ROFIA01A", 0 , 4},;
			{ "Legenda"   ,'BrwLegenda(cCadastro,"Legenda",{{"BR_VERDE","Aberto"},{"BR_VERMELHO","Encerrado"}})',0,8} }
			
Aadd(aCores,{ "VO1_STATUS =='A'","BR_VERDE"	} )		//Aberto
Aadd(aCores,{ "VO1_STATUS <>'A'","BR_VERMELHO"	} )	//Encerrado

Mbrowse(6,1,22,75,"VO1",,,,,,aCores)

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ºDesc.     ³Manutencao nas tabelas VO1 e VO3.                           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ROFIA01A(X,Y,PARAMIXB,xParam,lCopia)

Local NOPCE,NOPCG,ACPOS
Local CCAMPO,CTITULO,CALIASE,CALIASG,CLINOK,CTUDOK
Local CFIELOK,ACPOE,AALTE,LOK

Local lContinua := .T.
Local i:= 0

Local nPosTip  	:= 0
Local nPosProd 	:= 0
Local nPosVlPec	:= 0
Local nPosDoc	:= 0

Local cTip  := ""
Local cProd := ""
Local nVlPec:= 0
Local cDoc  := ""

Local aAreaAtu := ""

Private AHEADER,ACOLS
Private aRodape := {}
Private lCancel	       := .T.
Private nUItem := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Opcoes de acesso para a Modelo 3                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Do Case
	Case ParamIxb == 2 ; nOpcE:=2 ; nOpcG:=2	//Visualizar
	Case ParamIxb == 3 ; nOpcE:=3 ; nOpcG:=3	//Incluir
	Case ParamIxb == 4 ; nOpcE:=3 ; nOpcG:=3	//Alterar
	Case ParamIxb == 5 ; nOpcE:=2 ; nOpcG:=2    //Excluir
EndCase

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta array para impressao do rodape da modelo3. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//AADD(aRodape,{"Total de Itens"	,0})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria variaveis M->????? da Enchoice                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//RegToMemory("PA3",(ParamIxb==3))

INCLUI := ( ParamIxb == 3 .And. !lCopia ) 
ALTERA := ( ParamIxb == 4 )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicializa as variaveis da Enchoice                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If INCLUI
	//RegToMemory( "PA3", .T., .F. )
	Aviso("Atencao","Opção de inclusão não disponivel nessa rotina, somente alteração. Verifique!",{"Voltar"})
	Return()
EndIf

If ALTERA
	//Verifico somente OS que estiverem com status de aberto
	If VO1->VO1_STATUS <> 'A'
		Aviso("Atencao","Somente itens com status em aberto podem ser alterados. Verifique!",{"Voltar"})
		Return()
	EndIf

	//Verifico se a OS tem peça requisitada
	aAreaAtu := GetArea()

	dbSelectArea("VO3")
	dbSetOrder(8)
	If !dbSeek(xFilial("VO3")+VO1->VO1_NUMOSV,.T.)
		Aviso("Atencao","Não foram localizadas peças para a OS selecionada. Verifique!",{"Voltar"})
		Return()
	EndIf
	
	RestArea(aAreaAtu)

EndIf

If !INCLUI
	If SoftLock("VO1")
		RegToMemory( "VO1", .F., .F. )
	Else
		lContinua := .F.
	EndIf
EndIf

If lContinua
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria aHeader e aCols da GetDados                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aHeader:= {}
	aCols  := {}
	aCpos  := {"VO3_TIPTEM","VO3_CODITE",;
				"VO3_VALPEC","VO3_NUMDOC";
				} //Campos que serão tratados nos itens
	
	dbSelectArea("SX3")
	dbSetOrder(1)
	dbSeek("VO3")
	
	While !Eof() .And. X3_ARQUIVO == "VO3"
		If x3uso(x3_usado) .And. cNivel >= X3_NIVEL .And. ;
			Ascan( aCpos, {|x| x == AllTrim(X3_CAMPO) } ) > 0
			AADD(aHeader,{ TRIM(X3_TITULO), X3_CAMPO, X3_PICTURE,;
			X3_TAMANHO, X3_DECIMAL, X3_VALID,;
			X3_USADO, X3_TIPO, X3_ARQUIVO } )
		EndIf

		//Esse campo no configurador não está marcado para todos os modulos, por isso forço ele aqui. Uso para fazer o update
		If AllTrim(X3_CAMPO) == "VO3_NUMDOC"
			AADD(aHeader,{ TRIM(X3_TITULO), X3_CAMPO, X3_PICTURE,;
			X3_TAMANHO, X3_DECIMAL, X3_VALID,;
			X3_USADO, X3_TIPO, X3_ARQUIVO } )
		EndIf

		dbSkip()
	EndDo
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Preenche o aCols                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ParamIxb <> 3 //Nao fazer se for Inclusao
		dbSelectArea("VO3")
		dbSetOrder(8)
		dbSeek(xFilial()+VO1->VO1_NUMOSV,.T.)
		
		While !Eof() .And. VO1->VO1_NUMOSV == VO3->VO3_NUMOSV
			
			If GetAdvFVal("VO2","VO2_DEVOLU",xFilial("VO2")+VO3->VO3_NOSNUM,2,0) == "1" //So considero os registros igual a 1=Requisição se for igual a 0=Devolução não entra nos itens
			
				AADD(aCols,Array(Len(aHeader)+1))
				For i:= 1 to Len(aHeader)
					cCampo:= Alltrim(aHeader[i,2])
					aCols[Len(aCols)][i]:= FieldGet(FieldPos(cCampo))
				Next i
				aCols[Len(aCols)][Len(aHeader)+1]:= .F.
			
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Soma para rodape. ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//aRodape[1,2] += 1
			//nUItem +=1
			
			dbSkip()
			
		EndDo
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicializa variaveis                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cTitulo:= cCadastro
	cAliasE:= "VO1"
	cAliasG:= "VO3"
	cLinOk := 'U_VALVO3' //Validação da linha
	cTudOk := "AllwaysTrue()"
	cFielOk:= 'U_VALCPO'//Validação de campo
	aCpoE  := {"VO1_NUMOSV","VO1_DATABE","VO1_HORABE","VO1_CHASSI"}//Campos do cabecalho
	aAltE  := {"VO1_CHASSI"}//AClone(aCpoE)//Campos que podem ser alterados do cabeçalho
	aAltG  := {"VO3_VALPEC"}//Campos que podem ser alterados nos itens

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Chamada da Modelo 3                                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	lOk:= U_Mod3Buzz(cTitulo,cAliasE,cAliasG,aCpoE,cLinOk,cTudOk,nOpcE,nOpcG,cFielOk,.T.,999,aAltE,,aRodape,,,{61,50,12},aAltG)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Tratar Includao ou Alteracao (Exclusao dos Itens GetDados)   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lOk .And. ParamIxb <> 2 .And. ParamIxb <> 5

		//dbSelectArea("VO3")
		//dbSetOrder(8)
		
		If ParamIxb == 4	//Altera
	    
			nPosTip	 	:= AScan(aHeader,{|x| Trim(x[2]) == "VO3_TIPTEM"})
			nPosProd 	:= AScan(aHeader,{|x| Trim(x[2]) == "VO3_CODITE"})
			nPosVlPec	:= AScan(aHeader,{|x| Trim(x[2]) == "VO3_VALPEC"})
			nPosDoc		:= AScan(aHeader,{|x| Trim(x[2]) == "VO3_NUMDOC"})

			For i:= 1 To Len(aCols)
				
				//dbSeek(xFilial("VO3")+VO1->VO1_NUMOSV,.T.)
				
				If !(aCols[i][Len(aHeader)+1]) //Verifica se o item esta deletado ou nao.
					
					cTip   := aCols[i,nPosTip]
					cProd  := aCols[i,nPosProd]
					nVlPec := aCols[i,nPosVlPec]
					cDoc   := aCols[i,nPosDoc]
					
					//Funcao que ira atualizar os registros na VO3
					AtuVO3(VO1->VO1_FILIAL,VO1->VO1_NUMOSV,cTip,cProd,cDoc,nVlPec)
					
				EndIf
			
			Next i

		EndIf
		
	EndIf
	
EndIf

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Validacao da linha para a funcao modelo 3.                  º±±
±±º          ³                                                            º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VALVO3()

Local LRET,NPOSPROD,NPOS
Local i:= 0
//Local nItemAtu := Val(GDFieldGet("PA4_ITEM",N))

lRet:= .T.
/*
If !aCols[n,Len(aHeader)+1]
	
	nPosProd:= AScan(aHeader,{|x| Trim(x[2]) == "VO3_CODITE"})
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Validacao do Grupo                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For i:= 1 To Len(aCols)
		If !aCols[i,Len(aHeader)+1]
			nPos:= AScan(aCols, {|x| x[nPosProd] == aCols[i,nPosProd]} )
			
			If nPos <> 0 .And. i == nPos .And. !aCols[nPos,Len(aHeader)+1]
				nPos:= AScan(aCols, {|x| x[nPosProd] == aCols[i,nPosProd]}, i+1 )
				If nPos <> 0 .And. !aCols[nPos,Len(aHeader)+1]
					Help(" ",1,"JAGRAVADO")
					lRet:= .F.
				EndIf
			Else
				If nPos <> 0 .And. !aCols[nPos,Len(aHeader)+1]
					Help(" ",1,"JAGRAVADO")
					lRet:= .F.
				EndIf
			EndIf
		EndIf
	Next i

EndIf               
*/
/*
nVerbas := 	GDFieldGet ("PA4_PERVE1", N)+;
			GDFieldGet ("PA4_PERVE2", N)+;
			GDFieldGet ("PA4_PERVE3", N)+;
			GDFieldGet ("PA4_PERVE4", N)+;
			GDFieldGet ("PA4_PERVE5", N)+;
			GDFieldGet ("PA4_PERVE6", N)+;
			GDFieldGet ("PA4_PERVE7", N)+;
			GDFieldGet ("PA4_PERVE8", N)+;
			GDFieldGet ("PA4_PERVE9", N)+;
			GDFieldGet ("PA4_PERV10", N)

nTotVerba := GDFieldGet ("PA4_TOTVER", N)

If nVerbas <> nTotVerba       
	Aviso("Divergencia","Valor total da verba nao confere com a somatoria das verbas.",{"Ok"},1,"Verifique")
	lRet:= .F.
EndIf

If nItemAtu > nUItem
	nUItem := nItemAtu

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Soma para rodape. ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
  	aRodape[1,2] += 1

	oRod1:refresh()	

EndIf
*/
Return(lRet)

//////////////////////////////////////////////////////////////////////////
// Função que permite alterar os valores somente se for item de garantia//
//////////////////////////////////////////////////////////////////////////
User Function VALCPO()
Local lRet		:= .T.
Local nPosTP	:= AScan(aHeader,{|x| Trim(x[2]) == "VO3_TIPTEM"})
Local nTP		:= Alltrim(aCols[n,nPosTP])
Local cSitTpo	:= Alltrim(Posicione("VOI",1,xFilial("VOI")+nTP,"VOI_SITTPO"))

If cSitTpo <> "2" //Tipo de tempo não é garantia
	Aviso("Atencao","Esse item não está com tipo de garantia. Verifique!",{"Voltar"})
	lRet := .F.
EndIf

Return(lRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³Mod3Buzz	  ³ Autor ³ Silvio Cazela       ³ Data ³ 15/10/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Enchoice e GetDados                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³01-cTitulo------Titulo da Janela                            ³±±
±±³          ³02-cAlias1------Alias da enchoice                           ³±±
±±³          ³03-cAlias2------Alias da getDados                           ³±±
±±³          ³04-aMyEncho-----Array com campos da enchoice                ³±±
±±³          ³05-cLinOk-------Funcao de validacao da linha                ³±±
±±³          ³06-cTudoOk------Funcao de validacao na confirmacao          ³±±
±±³          ³07-nOpcE--------nOpc da enchoice                            ³±±
±±³          ³08-nOpcG--------nOpc da getdados                            ³±±
±±³          ³09-cFieldOk-----Funcao de validaca dos campos da getdados   ³±±
±±³          ³10-lVirtual-----Permite visualizar campos virtuais da enchoi³±±
±±³          ³11-nLinhas------Numero maximo de linhas da getdados         ³±±
±±³          ³12-aAltEnchoice-Array com campos alteraveis da enchoice     ³±±
±±³          ³13-nFreeze------Congelamento das colunas                    ³±±
±±³          ³14-aRodape------Array com texto e conteudo do rodape (Max.3)³±±
±±³          ³       Ex.AADD(aRodape,{"Total de Itens",0})                ³±±
±±³          ³15-aButtons-----Array com botoes a serem incluidos na bar   ³±±
±±³          ³       Ex.AADD(aButtons, {"EDIT",{||Valid()},"Descricao"})  ³±±
±±³          ³16-cCpoItem-----Campo para Controle de Numeracao de Itens   ³±±
±±³          ³       Ex.'+PAF_ITEM'                                       ³±±
±±³          ³17-aObj    -----Dimensao dos Objetos                        ³±±
±±³          ³       Ex.{40,40,10}                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Mudancas  ³a)Rotina de AutoDimensiona Conforme Resolucao de Video Usada³±±
±±³          ³b)Inclusao de Rodape (Maximo de 3 Elementos)                ³±±
±±³          ³c)Inclusao de Botoes na EnchoiceBar                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Dicas     ³1)Na utilizacao de rodapes, sera preciso atualizar (refresh)³±±
±±³          ³  nos valores, ou seja, na rotina de validacao de linha por ³±±
±±³          ³  exemplo, devera ser incluido o seguinte.                  ³±±
±±³          ³  oRod1:refresh(),oRod2:refresh(),oRod3:refresh()->depende  ³±±
±±³          ³  do numero de elementos passado como rodape.               ³±±
±±³          ³2)Variavel lcancel - devera ser informado como private no   ³±±
±±³          ³  inicio da rotina e controlado se e possivel efetuar o     ³±±
±±³          ³  cancelamento da tela.                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³.t. se confirmado ou .f. se cancelado                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Mod3Buzz(cTitulo,cAlias1,cAlias2,aMyEncho,cLinOk,cTudoOk,nOpcE,nOpcG,cFieldOk,lVirtual,nLinhas,aAltEnchoice,nFreeze,aRodape,aButtons,cCpoItem,aObj,aAltG)

Local lRet, nOpca	:= 0,cSaveMenuh,nReg:=(cAlias1)->(Recno()),oDlg
Local aSizeAut    	:= MsAdvSize(,.f.,400)
Local aInfo       	:= { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], 3, 3 }
Local aObjects 		:= {}

Private cSavScrVT,cSavScrVP,cSavScrHT,cSavScrHP,CurLen,nPosAtu:=0

lCancel := If(valtype(lCancel)=="U".or.lCancel==NIL,.t.,lCancel)

aObj := If(aObj==NIL,{50,50,0},aObj)

Aadd( aObjects, {000,aObj[1], .T., .F. } )
Aadd( aObjects, {000,aObj[2], .T., .T. } )
/*
If aRodape<>NIL
	Aadd( aObjects, {000,aObj[3], .T., .F. } )
Endif
*/
aPosObj	:= MsObjSize( aInfo, aObjects )
Altera	:=.t.
Inclui	:=.t.
lRefresh:=.t.
aTELA	:=Array(0,0)
aGets	:=Array(0)
bCampo	:={|nCPO|Field(nCPO)}
nPosAnt	:=9999
nColAnt	:=9999

nOpcE 	 	:= Iif(nOpcE==Nil		,3	,nOpcE)
nOpcG 	 	:= Iif(nOpcG==Nil		,3	,nOpcG)
lVirtual 	:= Iif(lVirtual==Nil	,.F.,lVirtual)
nLinhas	 	:= Iif(nLinhas==Nil		,99	,nLinhas)

DEFINE MSDIALOG oDlg TITLE cTitulo From aSizeAut[7],0 to aSizeAut[6],aSizeAut[5]	of oMainWnd PIXEL
EnChoice(cAlias1,nReg,nOpcE,,,,aMyEncho,{aPosObj[1,1],aPosObj[1,2],aPosObj[1,3],aPosObj[1,4]},aAltEnchoice,3,,,,,,lVirtual)
oGetDados := MsGetDados():New(aPosObj[2,1],aPosObj[2,2],aPosObj[2,3],aPosObj[2,4],nOpcG,cLinOk,cTudoOk,cCpoItem,.T.,aAltG,nFreeze,,nLinhas,cFieldOk)
/*
If aRodape<>NIL
	If len(aRodape)>0
		@ aPosObj[3,1],010 Say aRodape[1,1] Pixel
		@ aPosObj[3,1],050 MsGet oRod1 Var aRodape[1,2] Picture "@E 9999,999.99" When .f. Pixel
	Endif
	If len(aRodape)>1
		@ aPosObj[3,1],130 Say aRodape[2,1] Pixel
		@ aPosObj[3,1],170 MsGet oRod2 Var aRodape[2,2] Picture "@E 9999,999.99" When .f. Pixel
	Endif
	If len(aRodape)>2
		@ aPosObj[3,1],240 Say aRodape[3,1] Pixel
		@ aPosObj[3,1],280 MsGet oRod3 Var aRodape[3,2] Picture "@E 9999,999.99" When .f. Pixel
	Endif
Endif
*/
ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{||nOpca:=1,If(oGetDados:TudoOk(),If(!obrigatorio(aGets,aTela),nOpca := 0,oDlg:End()),nOpca := 0)},{||iif(lCancel,oDlg:End(),Aviso("Atencao","Nao e possivel cancelamento.",{"OK"}))},,aButtons)

lRet:=(nOpca==1)

Return lRet

////////////////////////////////////////////////
//Funcao que ira atualizar os registros na VO3//
////////////////////////////////////////////////
Static Function AtuVO3(xVO1_FILIAL,xVO1_NUMOSV,cTip,cProd,cDoc,nVlPec)
Local cUpd := ""

//Gravo o valor da peça no valor liquido tambem e zero o valor de desconto
cUpd := " UPDATE "+RetSqlName("VO3")
cUpd += " SET VO3_VALPEC = "+Alltrim(Str(nVlPec))+" , VO3_VALLIQ = "+Alltrim(Str(nVlPec))+", VO3_VALDES = 0"
cUpd += " WHERE D_E_L_E_T_ = '' "
cUpd += " AND VO3_FILIAL = '"+xVO1_FILIAL+"' "
cUpd += " AND VO3_NUMOSV = '"+xVO1_NUMOSV+"' "
cUpd += " AND VO3_TIPTEM = '"+Alltrim(cTip)+"' "
cUpd += " AND VO3_CODITE = '"+Alltrim(cProd)+"' "
cUpd += " AND VO3_NUMDOC = '"+cDoc+"' "

TCSQLExec(cUpd) 	//executo o update na string cUpdate 

Return()
