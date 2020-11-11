#include 'totvs.ch
#include 'rwmake.ch'
#include 'protheus.ch'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออฑฑ
ฑฑบPrograma  ณREL044CPO  บAutor  ณ Marcelo Joner      บ Data ณ 18/08/2020 บฑฑ
ฑฑอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออฑฑ
ฑฑบDesc.     ณPonto de entrada executado na impressใo de Ct. Troca atrav้sบฑฑ
ฑฑบ          ณde integra็ใo com o Microsoft Word.                         บฑฑ
ฑฑอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออฑฑ
ฑฑบUso       ณ Especifico RISA SA                                         บฑฑ
ฑฑอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
*/
User Function REL044CPO()

Local lRet      := .T.
Local aArea     := GetArea()
Local cCodFil   := ""
Local cNomFil   := ""
Local cDetPrd   := ""
Local cDetQtd   := ""
Local cDetUm    := ""
Local cDetAco   := ""
Local cDetVUn   := ""
Local cDetVFr   := ""
Local cDetMoe   := ""
Local cDetVDs   := ""
Local cDetVTo   := ""
Local nChrFil   := 13
Local nChrPro   := 32

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
//ณIdentifica็ใo do simbolo da moedaณ
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
dbSelectArea("ZEN")
cDetSmb := IIF(ZEN->ZEN_MOEDA <= 1, "R$", "US$")

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
//ณPosiciona no registro referente aos insumos vinculados ao contrato de trocaณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
dbSelectArea("ZEO")
ZEO->(dbSetOrder(1))
ZEO->(dbGoTop())
If ZEO->(dbSeek(xFilial("ZEO") + ZEN->ZEN_NUM))
    While ZEO->(!EOF()) .AND. ZEO->ZEO_FILIAL == xFilial("ZEO") .AND. ZEO->ZEO_NUM == ZEN->ZEN_NUM
        
        //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
        //ณPosiciona no cadastro do produto vinculado ao item do contrato de trocaณ
        //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
        dbSelectArea("SB1")
        SB1->(dbSetOrder(1))
        SB1->(dbGoTop())
        SB1->(dbSeek(xFilial("SB1") + ZEO->ZEO_PRODUT))

        //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
        //ณObt้m descri็ใo da filialณ
        //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
        cDesFil := ALLTRIM(POSICIONE("SM0", 1, cEmpAnt + ZEO->ZEO_FILFAT, "M0_FILIAL"))
        
        //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
        //ณObt้m descri็ใo do produtoณ
        //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
        cDesPro := ALLTRIM(ZEO->ZEO_PRODUT) + " - " + ALLTRIM(ZEO->ZEO_DESPRO)

        //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
        //ณVerifica quantidade de linhas para apresenta็ใo da descri็ใo da filial e do produtoณ
        //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
        nQtdFil := NUMLIN(cDesFil, nChrFil)
        nQtdPro := NUMLIN(cDesPro, nChrPro)

        //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
        //ณObt้m o maior n๚mero de linhas necessแrioณ
        //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
        nQtdLin := MAX(nQtdFil, nQtdPro)

        //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
        //ณComp๕e as quebras de linha conforme o tamanho de cada colunaณ
        //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
        cDetQbr := STRQBR(1, nQtdLin) 
        cQbrFil := STRQBR(nQtdFil, nQtdLin) + CRLF
        cQbrPro := STRQBR(nQtdPro, nQtdLin) + CRLF

        //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
        //ณRealiza composi็ใo das variaveis com informa็๕es dos insumosณ
        //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
        cCodFil += IIF(!EMPTY(cCodFil), cDetQbr, "") + ZEO->ZEO_FILFAT
        cNomFil += IIF(!EMPTY(cNomFil), cQbrFil, "") + cDesFil
        cDetPrd += IIF(!EMPTY(cDetPrd), cQbrPro, "") + cDesPro
        cDetQtd += IIF(!EMPTY(cDetQtd), cDetQbr, "") + ALLTRIM(TRANSFORM(ZEO->ZEO_QUANT, PESQPICT("ZEO", "ZEO_QUANT")))
        cDetUm  += IIF(!EMPTY(cDetUm) , cDetQbr, "") + ALLTRIM(ZEO->ZEO_UM)
        cDetAco += IIF(!EMPTY(cDetAco), cDetQbr, "") + ""
        cDetVUn += IIF(!EMPTY(cDetVUn), cDetQbr, "") + ALLTRIM(TRANSFORM(ZEO->ZEO_PRCVEN, PESQPICT("ZEO", "ZEO_PRCVEN")))
        cDetVDs += IIF(!EMPTY(cDetVDs), cDetQbr, "") + ALLTRIM(TRANSFORM(ZEO->ZEO_VALDES, PESQPICT("ZEO", "ZEO_VALDES")))
        cDetVFr += IIF(!EMPTY(cDetVFr), cDetQbr, "") + ALLTRIM(TRANSFORM(0, PESQPICT("ZEO", "ZEO_VALDES")))
        cDetMoe += IIF(!EMPTY(cDetMoe), cDetQbr, "") + cDetSmb
        cDetVTo += IIF(!EMPTY(cDetVTo), cDetQbr, "") + ALLTRIM(TRANSFORM(ZEO->ZEO_TOTAL, PESQPICT("ZEO", "ZEO_TOTAL")))

        //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
        //ณAvan็a para o pr๓ximo registroณ
        //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
        ZEO->(dbSkip())
    End

    //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
    //ณCria variaveis em mem๓riaณ
    //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
    OLE_SetDocumentVat(oWord,"%cCodFil", cCodFil)
    OLE_SetDocumentVat(oWord,"%cNomFil", cNomFil)
    OLE_SetDocumentVat(oWord,"%cDetPrd", cDetPrd)
    OLE_SetDocumentVat(oWord,"%cDetQtd", cDetQtd)
    OLE_SetDocumentVat(oWord,"%cDetUm" , cDetUm)
    OLE_SetDocumentVat(oWord,"%cDetAco", cDetAco)
    OLE_SetDocumentVat(oWord,"%cDetVUn", cDetVUn)
    OLE_SetDocumentVat(oWord,"%cDetVDs", cDetVDs)
    OLE_SetDocumentVat(oWord,"%cDetMoe", cDetMoe)
    OLE_SetDocumentVat(oWord,"%cDetVTo", cDetVTo)
    OLE_SetDocumentVat(oWord,"%cDetVFr", cDetVFr)
    OLE_SetDocumentVat(oWord,"%cDetSmb", cDetSmb)
EndIf

RestArea(aArea)

Return lRet





/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออฑฑ
ฑฑบPrograma  ณNUMLIN    บAutor  ณ Marcelo Joner      บ Data ณ  27/10/2020 บฑฑ
ฑฑอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออฑฑ
ฑฑบDesc.     ณFun็ใo responsแvel por analisar os caracteres de uma string บฑฑ
ฑฑบ          ณe retornar o n๚mero de linhas necessแrias para impressใo    บฑฑ
ฑฑบ          ณconsiderando que เ quebra serแ entres os espa็os em branco. บฑฑ
ฑฑอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออฑฑ
ฑฑบUso       ณ Gestใo de Cereais                                          บฑฑ
ฑฑอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
*/
Static Function NUMLIN(cTexto, nTamLin)

Local nI        := 0
Local nPosSpc   := 0
Local nLinhas   := 1
Local cPosAtu   := ""
Local cFracao   := ""

Default cTexto  := ""
Default nTamLin := 0

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
//ณExecuta regras, caso tenha sido informado textoณ
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
If !EMPTY(cTexto) .AND. nTamLin > 0

    //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
    //ณAnalisa todos os caracteres da string repassadaณ
    //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
    For nI := 1 To Len(cTexto)
        cPosAtu := SUBSTR(cTexto, nI, 1)
        
        cFracao += cPosAtu
        nPosSpc := IIF(cPosAtu == " ", nI, nPosSpc)
        
        //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
        //ณCaso เ string acumulada ultrapasse o tamanho da linha, considera quebra de linhaณ
        //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
        If Len(cFracao) > nTamLin
            nLinhas++
            nI := nPosSpc
            cFracao := ""
        EndIf
    Next nI

    nLinhas++
EndIf

Return nLinhas





/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออฑฑ
ฑฑบPrograma  ณSTRQBR      บAutor  ณ Marcelo Joner     บ Data ณ 27/10/2020 บฑฑ
ฑฑอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออฑฑ
ฑฑบDesc.     ณFun็ใo responsแvel pela composi็ใo de caracteres de quebra  บฑฑ
ฑฑบ          ณde linha, conforme os parโmetros repassados.                บฑฑ
ฑฑอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออฑฑ
ฑฑบUso       ณ Gestใo de Cereais                                          บฑฑ
ฑฑอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
*/
Static Function STRQBR(nTamLin, nQtdLin)

Local cStrQbr   := CRLF

Default nTamLin := 0
Default nQtdLin := 0

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
//ณExecuta regras, caso os parโmetros tenham sido informadosณ
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
If nTamLin > 0 .AND. nQtdLin > 0
    
    //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
    //ณExecuta regras, caso o tamanho de linhas atual, seja inferior เ quantidade de linhas necessแriasณ
    //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
    If nTamLin < nQtdLin
        cStrQbr += REPLICATE(CRLF, (nQtdLin - nTamLin))
    EndIf
EndIf

Return cStrQbr
