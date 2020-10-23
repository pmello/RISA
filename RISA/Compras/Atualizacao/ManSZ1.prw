#include "Protheus.ch"
/*-----------------------------------------------------------------------------------------------------------------------------------
{Protheus.doc} ManSZ1()
Função para manutencao na tabela SZ1 de dados do CTe
Chamado pelo PE MA140BUT

@type    function
@author  TOTVS..
@since   Out/2020
@version P12

@project MAN0000001_EF_001
@obs     Projeto RISA
-----------------------------------------------------------------------------------------------------------------------------------*/
User Function ManSZ1()

Local aArea     := GetArea()
Local cAlias    := "SZ1"
Local nReg      := 0
Local nOpc      := 0
Local aCpos	    := {} //Array com os campos que poderão ser alterados

PRIVATE cCadastro := ""

If IsInCallStack("MATA140") //Pre-Nota de entrada

    aCpos := {"Z1_XNFEORI","Z1_XNFSORI"} //Campos que podem ser alterados

    If inclui //Inclusao
        cCadastro := "Manutenção CTe-Incluir"
        nOpc := 3
        AxInclui(cAlias,nReg,nOpc,,,aCpos) 
    else
        dbSelectArea("SZ1")
        dbSetOrder(1)
        If !dbSeek(xFilial("SZ1")+cNfiscal+cSerie+cA100For+cLoja)
            Aviso("Atencao","Não existe dados complementares para essa nota "+Alltrim(cNfiscal)+". Verifique!",{"Voltar"})
            RestArea(aArea)
            Return()
        EndIf
        
        If altera //Alteracao
            cCadastro   := "Manutenção CTe-Alterar"
            nOpc        := 4
            AxAltera(cAlias,RecNo(),nOpc,,aCpos,,,"U_VldAlt()")        
        Else //Visualizar
            cCadastro := "Manutenção CTe-Visualizar"
            nOpc := 2
            AxVisual(cAlias,nReg,nOpc)
        EndIf
    EndIf
ElseIf IsInCallStack("MATA103") //Documento de entrada

    dbSelectArea("SZ1")
    dbSetOrder(1)
    If !dbSeek(xFilial("SZ1")+cNfiscal+cSerie+cA100For+cLoja)
        Aviso("Atencao","Não existe dados complementares para essa nota "+Alltrim(cNfiscal)+". Verifique!",{"Voltar"})
        RestArea(aArea)
        Return()
    EndIf

    If l103Class //Alterar
        aCpos       := {"Z1_XPESFIM","Z1_XDTFIM","Z1_XORIG","Z1_XDEST","Z1_XCLIREM","Z1_XCLIDES","Z1_XCLIREC","Z1_XCLIEXP","Z1_XCLITOM"} //Campos que podem ser alterados
        cCadastro   := "Manutenção CTe-Alterar"
        nOpc        := 4
        AxAltera(cAlias,RecNo(),nOpc,,aCpos,,,"U_VldAlt()")        
    ElseIf l103Visual //Visualizar
        cCadastro := "Manutenção CTe-Visualizar"
        nOpc := 2
        AxVisual(cAlias,nReg,nOpc)
    Else
        Aviso("Atencao","Opção disponivel somente para classificação ou visualização. Verifique!",{"Voltar"})
    EndIf
EndIf

RestArea(aArea)

Return()

//Validacao da alteração
User Function VldAlt()

Local lRet := .F.

If  MsgYesNo("Confirma a alteração ?","Confirmação")
   lRet := .T.
EndIf

Return(lRet)
