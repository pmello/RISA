#include 'totvs.ch
#include 'rwmake.ch'
#include 'protheus.ch'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
��������������������������������������������������������������������������ͱ�
���Programa  �REL044CPO  �Autor  � Marcelo Joner      � Data � 18/08/2020 ���
��������������������������������������������������������������������������ͱ�
���Desc.     �Ponto de entrada executado na impress�o de Ct. Troca atrav�s���
���          �de integra��o com o Microsoft Word.                         ���
��������������������������������������������������������������������������ͱ�
���Uso       � Especifico RISA SA                                         ���
��������������������������������������������������������������������������ͱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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

//�����������������������������������
//�Identifica��o do simbolo da moeda�
//�����������������������������������
dbSelectArea("ZEN")
cDetSmb := IIF(ZEN->ZEN_MOEDA <= 1, "R$", "US$")

//�����������������������������������������������������������������������������
//�Posiciona no registro referente aos insumos vinculados ao contrato de troca�
//�����������������������������������������������������������������������������
dbSelectArea("ZEO")
ZEO->(dbSetOrder(1))
ZEO->(dbGoTop())
If ZEO->(dbSeek(xFilial("ZEO") + ZEN->ZEN_NUM))
    While ZEO->(!EOF()) .AND. ZEO->ZEO_FILIAL == xFilial("ZEO") .AND. ZEO->ZEO_NUM == ZEN->ZEN_NUM
        
        //�������������������������������������������������������������������������
        //�Posiciona no cadastro do produto vinculado ao item do contrato de troca�
        //�������������������������������������������������������������������������
        dbSelectArea("SB1")
        SB1->(dbSetOrder(1))
        SB1->(dbGoTop())
        SB1->(dbSeek(xFilial("SB1") + ZEO->ZEO_PRODUT))

        //���������������������������
        //�Obt�m descri��o da filial�
        //���������������������������
        cDesFil := ALLTRIM(POSICIONE("SM0", 1, cEmpAnt + ZEO->ZEO_FILFAT, "M0_FILIAL"))
        
        //����������������������������
        //�Obt�m descri��o do produto�
        //����������������������������
        cDesPro := ALLTRIM(ZEO->ZEO_PRODUT) + " - " + ALLTRIM(ZEO->ZEO_DESPRO)

        //�������������������������������������������������������������������������������������
        //�Verifica quantidade de linhas para apresenta��o da descri��o da filial e do produto�
        //�������������������������������������������������������������������������������������
        nQtdFil := NUMLIN(cDesFil, nChrFil)
        nQtdPro := NUMLIN(cDesPro, nChrPro)

        //�������������������������������������������
        //�Obt�m o maior n�mero de linhas necess�rio�
        //�������������������������������������������
        nQtdLin := MAX(nQtdFil, nQtdPro)

        //��������������������������������������������������������������
        //�Comp�e as quebras de linha conforme o tamanho de cada coluna�
        //��������������������������������������������������������������
        cDetQbr := STRQBR(1, nQtdLin) 
        cQbrFil := STRQBR(nQtdFil, nQtdLin) + CRLF
        cQbrPro := STRQBR(nQtdPro, nQtdLin) + CRLF

        //��������������������������������������������������������������
        //�Realiza composi��o das variaveis com informa��es dos insumos�
        //��������������������������������������������������������������
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

        //��������������������������������
        //�Avan�a para o pr�ximo registro�
        //��������������������������������
        ZEO->(dbSkip())
    End

    //���������������������������
    //�Cria variaveis em mem�ria�
    //���������������������������
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
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
��������������������������������������������������������������������������ͱ�
���Programa  �NUMLIN    �Autor  � Marcelo Joner      � Data �  27/10/2020 ���
��������������������������������������������������������������������������ͱ�
���Desc.     �Fun��o respons�vel por analisar os caracteres de uma string ���
���          �e retornar o n�mero de linhas necess�rias para impress�o    ���
���          �considerando que � quebra ser� entres os espa�os em branco. ���
��������������������������������������������������������������������������ͱ�
���Uso       � Gest�o de Cereais                                          ���
��������������������������������������������������������������������������ͱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function NUMLIN(cTexto, nTamLin)

Local nI        := 0
Local nPosSpc   := 0
Local nLinhas   := 1
Local cPosAtu   := ""
Local cFracao   := ""

Default cTexto  := ""
Default nTamLin := 0

//�������������������������������������������������
//�Executa regras, caso tenha sido informado texto�
//�������������������������������������������������
If !EMPTY(cTexto) .AND. nTamLin > 0

    //�������������������������������������������������
    //�Analisa todos os caracteres da string repassada�
    //�������������������������������������������������
    For nI := 1 To Len(cTexto)
        cPosAtu := SUBSTR(cTexto, nI, 1)
        
        cFracao += cPosAtu
        nPosSpc := IIF(cPosAtu == " ", nI, nPosSpc)
        
        //����������������������������������������������������������������������������������
        //�Caso � string acumulada ultrapasse o tamanho da linha, considera quebra de linha�
        //����������������������������������������������������������������������������������
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
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
��������������������������������������������������������������������������ͱ�
���Programa  �STRQBR      �Autor  � Marcelo Joner     � Data � 27/10/2020 ���
��������������������������������������������������������������������������ͱ�
���Desc.     �Fun��o respons�vel pela composi��o de caracteres de quebra  ���
���          �de linha, conforme os par�metros repassados.                ���
��������������������������������������������������������������������������ͱ�
���Uso       � Gest�o de Cereais                                          ���
��������������������������������������������������������������������������ͱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function STRQBR(nTamLin, nQtdLin)

Local cStrQbr   := CRLF

Default nTamLin := 0
Default nQtdLin := 0

//�����������������������������������������������������������
//�Executa regras, caso os par�metros tenham sido informados�
//�����������������������������������������������������������
If nTamLin > 0 .AND. nQtdLin > 0
    
    //��������������������������������������������������������������������������������������������������
    //�Executa regras, caso o tamanho de linhas atual, seja inferior � quantidade de linhas necess�rias�
    //��������������������������������������������������������������������������������������������������
    If nTamLin < nQtdLin
        cStrQbr += REPLICATE(CRLF, (nQtdLin - nTamLin))
    EndIf
EndIf

Return cStrQbr
