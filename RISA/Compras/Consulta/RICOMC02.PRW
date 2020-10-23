#include "protheus.ch"
/*-----------------------------------------------------------------------------------------------------------------------------------
{Protheus.doc} RICOMC02
Exibe browse de notas de saida para seleção. Usado no SXB XSF2

@type    function
@author  TOTVS..
@since   Out/2020
@version P12

@project MAN0000001_EF_001
@obs     Projeto RISA
-----------------------------------------------------------------------------------------------------------------------------------*/
User Function RICOMC02()

Local   cCadastro  := "Documentos de Saída"
Local   aRotOld    := Iif(Type('aRotina') == 'A',AClone(aRotina),{})
Local   aCampos    := {}
Local   aIndexSF2  := {}
Local   cFiltraSF2 := ''
Local   bFiltraBrw := {}
Local   nRecnoSF2  := 0
Local   cFilSF2    := ''
Private nOpcSel    := 0

//As variaveis publicas abaixo são para serem usadas na consulta padrao XF1
PUBLIC cXNumF2 := ""
PUBLIC cXSerF2 := ""
PUBLIC cXForF2 := ""
PUBLIC cXLojF2 := ""

aRotina := {}
AAdd( aRotina, { "&Confirmar" ,"U_ConfSel",0,2,,,.T.} )

cFilSF2 := xFilial('SF2')

SF2->(DbSetOrder(1))
cFiltraSF2 := "F2_FILIAL == '"+cFilSF2+"'"

bFiltraBrw := {|| FilBrowse("SF2",@aIndexSF2,@cFiltraSF2) }
Eval(bFiltraBrw)

MaWndBrowse(0,0,300,600,cCadastro,"SF2",aCampos,aRotina,,,,.T.)

nRecnoSF2 := SF2->(Recno())
aRotina   := AClone(aRotOld)

cXNumF2 := SF2->F2_DOC
cXSerF2 := SF2->F2_SERIE
cXForF2 := SF2->F2_CLIENTE
cXLojF2 := SF2->F2_LOJA

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza o uso da funcao FilBrowse e retorna os indices padroes.       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
EndFilBrw("SF2",aIndexSF2)

SF2->(dbGoTo(nRecnoSF2))

Return( nOpcSel == 1 )
