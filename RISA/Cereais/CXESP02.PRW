#include "rwmake.ch"
#include "topconn.ch"
#include "protheus.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
���������������������������������������������`���������������������������ͻ��
���Programa  �CXESP02   �Autor  �Marcelo Joner        � Data � 12/03/2018 ���
�������������������������������������������������������������������������͹��
���Desc.     �Fun��o respons�vel pela carga da tabela de classifica��o na ���
���          �pesagem conforme defini��es do contrato selecionado.        ���
�������������������������������������������������������������������������͹��
���Uso       � Especifico Risa S/A                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function CXESP02()

Local lRet			:= .T.
Local lUpdCla		:= .T.
Local lUpdSub		:= .F.
Local nI			:= 0
Local aArea			:= GetArea()
Local cCliFor		:= cCodCliFor
Local cCodLoj		:= cLojCliFor
Local cCodOpe		:= ""
Local cCodPrd		:= ""
Local cCodTab		:= ""
Local cTpCt			:= SUBSTR(cDocumento, 1, 2)
Local cTpRoma		:= IIF(ALLTRIM(UPPER(aOperacoes[oCbOperacao:nAt])) == "ENTRADA", "1", "2")
Local cTpOper		:= IIF(cTpCt == "CC", "G3", IIF(cTpCt == "CV", "G8", "G7"))
Local cCodFil		:= SUBSTR(cDocumento, 3, TAMSX3("ZDA_FILIAL")[1])
Local nQtdDesCla	:= aScan(aHeaderClas,{|x| ALLTRIM(x[2]) == 'ZCC_QUANT'})

//������������������������������������������������������������
//�Executa regras caso seja Abertura\Inclus�o de nova pesagem�
//������������������������������������������������������������
If nOpc == 3
	Do Case
		
		//����������������������������������������������
		//�Executa regras quando trata-se de Ct. Compra�
		//����������������������������������������������
		Case cTpCt == "CC"
			dbSelectArea("ZDA")
			ZDA->(dbSetOrder(1))
			ZDA->(dbGoTop())
			If ZDA->(dbSeek(xFilial("ZDA", cCodFil) + PADR(cDocumento, TAMSX3("ZDA_NUM")[1])))
				cCodOpe := "G3"
				cCodTab := ZDA->ZDA_TBCLAS
				cCodPrd := ZDA->ZDA_PRODUT
			Else
				lRet := .F.
				ShowHelpDlg("Aten��o", {"O Ct. Compra " + ALLTRIM(TRANSFORM(cDocumento, PESQPICT("ZDA", "ZDA_NUM"))) + " n�o foi localizado."}, 5, {"Favor verificar se o contrato informado � v�lido."}, 5)
			EndIf
		
		//���������������������������������������������
		//�Executa regras quando trata-se de Ct. Venda�
		//���������������������������������������������
		Case cTpCt == "CV"
			dbSelectArea("ZDP")
			ZDP->(dbSetOrder(1))
			ZDP->(dbGoTop())
			If ZDP->(dbSeek(xFilial("ZDP", cCodFil) + PADR(cDocumento, TAMSX3("ZDP_NUM")[1])))
				cCodOpe := "G8"
				cCodTab := ZDP->ZDP_TBCLAS
				cCodPrd := ZDP->ZDP_PROD
			Else
				lRet := .F.
				ShowHelpDlg("Aten��o", {"O Ct. Venda " + ALLTRIM(TRANSFORM(cDocumento, PESQPICT("ZDP", "ZDP_NUM"))) + " n�o foi localizado."}, 5, {"Favor verificar se o contrato informado � v�lido."}, 5)
			EndIf
			
		//�����������������������������������������������
		//�Executa regras quando trata-se de Ct. Servi�o�
		//�����������������������������������������������
		Case cTpCt == "CS"
			dbSelectArea("ZEG")
			ZEG->(dbSetOrder(1))
			ZEG->(dbGoTop())
			If ZEG->(dbSeek(xFilial("ZEG", cCodFil) + PADR(cDocumento, TAMSX3("ZEG_NUM")[1])))
				cCodOpe := "G7"
				cCodPrd := ZEG->ZEG_PROD1
				If cTpRoma == "1"
					cCodTab := ZEG->ZEG_CLAENT
				Else
					cCodTab := ZEG->ZEG_CLASAI
				EndIf
			Else
				lRet := .F.
				ShowHelpDlg("Aten��o", {"O Ct. Servi�o " + ALLTRIM(TRANSFORM(cDocumento, PESQPICT("ZEG", "ZEG_NUM"))) + " n�o foi localizado."}, 5, {"Favor verificar se o contrato informado � v�lido."}, 5)
			EndIf
			
	EndCase
	
	//��������������������������������������������������������
	//�Valida Produto X Tab. Classifica��o obtida no contrato�
	//��������������������������������������������������������
	dbSelectArea("SB1")
	SB1->(dbSetOrder(1))
	SB1->(dbGoTop())
	SB1->(dbSeek(xFilial("SB1") + cCodPrd))
	If SB1->B1_GCCLASS == "1" .AND. EMPTY(cCodTab)
		lRet := .F.
		ShowHelpDlg("Aten��o", {"N�o foi definida � tabela de classifica��o no contrato  " + ALLTRIM(TRANSFORM(cDocumento, PESQPICT("ZEG", "ZEG_NUM"))) + "."}, 5, {"Favor verificar se o contrato informado � v�lido."}, 5)
	EndIf
	
	//��������������������������������������������������������������������
	//�Executa demais regras, caso tenha validado o contrato corretamente�
	//��������������������������������������������������������������������
	If lRet
	
		//���������������������������������������������������������������������������������������������
		//�Executa fun��o do Addon Gest�o de Cereais para carga das regras de classifica��o da pesagem�
		//���������������������������������������������������������������������������������������������
		lRet := U_MOV01ZCJ(cCodFil, cTpRoma, cCliFor, cCodLoj, cCodOpe, cCodPrd, cCodTab, .F.,, .T.)
	EndIf

//�������������������������������������������������
//�Executa regras de calculo dos totais da pesagem�
//�������������������������������������������������
ElseIf nOpc == 4

	//���������������������������������������������������������
	//�Atualiza os totais da pesagem com base na classifica��o�
	//���������������������������������������������������������
	nPesoDesconto := 0
	For nI := 1 To Len(aColsClas)
		dbSelectArea("ZCH")
		ZCH->(dbSetOrder(1))
		ZCH->(dbGoTop())
		ZCH->(dbSeek(xFilial("ZCH") + aColsClas2[nI][1])) 
		
		//������������������������������������������������������������������������
		//�Desconto do item de classifica��o comp�e o total de descontos da carga�
		//������������������������������������������������������������������������
		If ZCH->ZCH_CARGA != "2"
			nPesoDesconto += ROUND(aColsClas[nI][nQtdDesCla], 0) 
		EndIf
	Next nI
	
	//�����������������������������
	//�Recalcula totais da pesagem�
	//�����������������������������	
	nPesoBalanca := nPesoBruto - nPesoTara
	nPesoLiquido := nPesoBalanca - nPesoDesconto
EndIf

RestArea(aArea)

Return lRet
