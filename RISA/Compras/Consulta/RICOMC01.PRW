#include "protheus.ch"
/*-----------------------------------------------------------------------------------------------------------------------------------
{Protheus.doc} RICOMC01
Exibe browse de notas de entrada para seleção. Usado no SXB XF1

@type    function
@author  TOTVS..
@since   Out/2020
@version P12

@project MAN0000001_EF_001
@obs     Projeto RISA
-----------------------------------------------------------------------------------------------------------------------------------*/
User Function RICOMC01()

Local   cCadastro  := "Documentos de Entrada"
Local   aRotOld    := Iif(Type('aRotina') == 'A',AClone(aRotina),{})
Local   aCampos    := {}
Local   aIndexSF1  := {}
Local   cFiltraSF1 := ''
Local   bFiltraBrw := {}
Local   cFilSF1    := ''
//Local   cCodFor    := ''
//Local   cLojFor    := ''
Private nOpcSel    := 0

//As variaveis publicas abaixo são para serem usadas na consulta padrao XF1
PUBLIC cXNumF1 := ""
PUBLIC cXSerF1 := ""
PUBLIC cXForF1 := ""
PUBLIC cXLojF1 := ""


aRotina := {}
AAdd( aRotina, { "&Confirmar" ,"U_ConfSel",0,2,,,.T.} )

cFilSF1 := xFilial('SF1')

//cCodFor := CA100FOR
//cLojFor := CLOJA

SF1->(DbSetOrder(1))
cFiltraSF1 := "F1_FILIAL == '"+cFilSF1+"'"

//cFilTraSF1 += ".And. F1_FORNECE == '"+cCodFor+"'"
//cFilTraSF1 += ".And. F1_LOJA == '"+cLojFor+"'"

bFiltraBrw := {|| FilBrowse("SF1",@aIndexSF1,@cFiltraSF1) }
Eval(bFiltraBrw)

MaWndBrowse(0,0,300,600,cCadastro,"SF1",aCampos,aRotina,,,,.T.)

nRecnoSF1 := SF1->(Recno())
aRotina   := AClone(aRotOld)

cXNumF1 := SF1->F1_DOC
cXSerF1 := SF1->F1_SERIE
cXForF1 := SF1->F1_FORNECE
cXLojF1 := SF1->F1_LOJA

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza o uso da funcao FilBrowse e retorna os indices padroes.       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
EndFilBrw("SF1",aIndexSF1)

SF1->(dbGoTo(nRecnoSF1))

Return( nOpcSel == 1 )
