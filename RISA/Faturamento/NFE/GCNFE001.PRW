#include "rwmake.ch"
#include "topconn.ch"
#include "protheus.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
���������������������������������������������`���������������������������ͻ��
���Programa  �GCNFE001     �Autor �Marcelo Joner      � Data � 27/08/2015 ���
�������������������������������������������������������������������������͹��
���Desc.     �Fun��o vinculada ao ponto de entrada PE01NFESEFA utilizado  ���
���          �para tratamento de dados adicionais na transmiss�o das notas���
���          �fiscais eletr�nicas referente � informa��es do Template de  ���
���          �Gest�o de Cereais.                                          ���
�������������������������������������������������������������������������͹��
���Uso       �Gest�o de Cereais                                           ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function GCNFE001() 

Local aArea			:= GetArea()

Local aRetorno		:= {}
Local aInfNFe		:= PARAMIXB[1]
Local aProd			:= aInfNFe[1]
Local aDest			:= aInfNFe[4] 
Local aNota   		:= aInfNFe[5]
Local aInfItem		:= aInfNFe[6]
Local aDup			:= aInfNFe[7]
Local aTransp		:= aInfNFe[8]
Local aEntrega		:= aInfNFe[9]
Local aRetirada		:= aInfNFe[10]
Local aVeiculo		:= aInfNFe[11] 
Local aReboque		:= aInfNFe[12] 
Local aNfpVinc		:= aInfNFe[13]
Local aEspVol		:= aInfNFe[14]
Local aNfVinc		:= aInfNFe[15]
Local aDetPag		:= aInfNFe[16]
Local aObsCont		:= aInfNFe[17]
Local aProcRef		:= aInfNFe[18]

Local cCliFor		:= ""
Local cLoja			:= ""
Local cInfProd		:= ""
Local hQuebraCpl	:= PARAMIXB[2]
Local nI			:= 0

Private cMensCli	:= aInfNFe[2]
Private cMensFis	:= aInfNFe[3]

//��������������������������������������������������������
//�Executa regras quando se trata de nota fiscal de sa�da�
//��������������������������������������������������������
If aNota[4] == "1"

	//��������������������������������������������������������
	//�Obt�m c�digo do fornecedor\cliente do documento fiscal�
	//��������������������������������������������������������
	If aNota[5] $ "B\D"
		dbSelectArea("SA2")
		SA2->(dbSetOrder(1))
		SA2->(dbGoTop())
		If SA2->(dbSeek(xFilial("SA2") + SF2->F2_CLIENTE + SF2->F2_LOJA))
			cCliFor	:= SA2->A2_COD
			cLoja	:= SA2->A2_LOJA  
		EndIf                      
	Else                           
		dbSelectArea("SA1")
		SA1->(dbSetOrder(1))
		SA1->(dbGoTop())
		If SA1->(dbSeek(xFilial("SA1") + SF2->F2_CLIENTE + SF2->F2_LOJA))
			cCliFor	:= SA1->A1_COD
			cLoja	:= SA1->A1_LOJA   
		EndIf
	EndIf
	
	//����������������������������������������������
	//�Garante posicionamento do documento de sa�da�
	//����������������������������������������������
	dbSelectArea("SF2")
	SF2->(dbSetOrder(1))
	SF2->(dbGoTop())
	If SF2->(dbSeek(xFilial("SF2") + aNota[2] + aNota[1] + cCliFor + cLoja))
		
		//���������������������������������������������������������������������
		//�Executa la�o de processamento de todos os itens do documento fiscal�
		//���������������������������������������������������������������������
		For nI := 1 To Len(aInfItem)
			
			//������������������������������������������������������
			//�Posiciona no item do documento fiscal conforme array�
			//������������������������������������������������������
			dbSelectArea("SD2")
			SD2->(dbSetOrder(3))
			SD2->(dbGoTop())
			If SD2->(dbSeek(xFilial("SD2") + SF2->F2_DOC + SF2->F2_SERIE + SF2->F2_CLIENTE + SF2->F2_LOJA + aProd[nI][2] + aInfItem[nI][4]))
				cInfProd := hQuebraCpl
				
				//�������������������������������������������
				//�Posiciona no cabe�alho do pedido de venda�
				//�������������������������������������������
				dbSelectArea("SC5")
				SC5->(dbSetOrder(1))
				SC5->(dbGoTop())
				SC5->(dbSeek(xFilial("SC5") + SD2->D2_PEDIDO))
				
				//��������������������������������������
				//�Posiciona no item do pedido de venda�
				//��������������������������������������
				dbSelectArea("SC6")
				SC6->(dbSetOrder(1))
				SC6->(dbGoTop())
				SC6->(dbSeek(xFilial("SC6") + SD2->D2_PEDIDO + SD2->D2_ITEMPV))
				
				//����������������������������������������������
				//�Posiciona no TES do item do documento fiscal�
				//����������������������������������������������
				dbSelectArea("SF4")
				SF4->(dbSetOrder(1))
				SF4->(dbGoTop())
				SF4->(dbSeek(xFilial("SF4") + SD2->D2_TES))
				
				
				//�������������������������������������������������������
				//�Carrega informa��es vinculadas ao cadastro do produto�
				//�������������������������������������������������������
				dbSelectArea("SB1")
				SB1->(dbSetOrder(1))
				SB1->(dbGoTop())
				SB1->(dbSeek(xFilial("SB1") + SD2->D2_COD))
				
				
				//�����������������������������������������������������������
				//�Posiciona no grupo de produto do item do documento fiscal�
				//�����������������������������������������������������������
				dbSelectArea("SBM")
				SBM->(dbSetOrder(1))
				SBM->(dbGoTop())
				SBM->(dbSeek(xFilial("SBM") + SB1->B1_GRUPO))
				

				//���������������������������������������������������������������������������������
				//�Carrega informa��es vinculadas � campos especificos do item do documento fiscal�
				//���������������������������������������������������������������������������������
				If SD2->(FieldPos("D2_GCPH")) > 0 .AND. SD2->D2_GCPH > 0 
					cInfProd += "Ph: " + ALLTRIM(TRANSFORM(SD2->D2_GCPH, "999")) + hQuebraCpl
				EndIf
				
				If SD2->(FieldPos("D2_GCRENDA")) > 0 .AND. !EMPTY(SD2->D2_GCRENDA)
					cInfProd += "Renda: " + ALLTRIM(TRANSFORM(SD2->D2_GCRENDA, "99/99")) + hQuebraCpl
				EndIf

				If SB1->(FieldPos("B1_GCKGSAC")) > 0 .AND. SB1->B1_GCKGSAC > 0
					cInfProd += "Valor Saca R$ " + ALLTRIM(TRANSFORM(ROUND((SD2->D2_PRCVEN * SB1->B1_GCKGSAC), TAMSX3("D2_TOTAL")[2]), PESQPICT("SD2", "D2_TOTAL"))) + hQuebraCpl
				EndIf
				
				If SD2->(FieldPos("D2_GCNFPRO")) > 0 .AND. !EMPTY(SD2->D2_GCNFPRO)
					cInfProd += "NF Produtor: " + ALLTRIM(SD2->D2_GCNFPRO) + "\" + ALLTRIM(SD2->D2_GCSRPRO) + hQuebraCpl
				EndIf
				
				If SD2->(FieldPos("D2_GCROMAN")) > 0 .AND. !EMPTY(SD2->D2_GCROMAN)
					dbSelectArea("ZCB")
					ZCB->(dbSetOrder(1))
					ZCB->(dbGoTop())
					If ZCB->(dbSeek(xFilial("ZCB") + SD2->D2_GCROMAN))
						If ZCB->(FieldPos("ZCB_X_NPES")) > 0 .AND. !EMPTY(ZCB->ZCB_X_NPES)
							cInfProd += "Pesagem: " + ALLTRIM(ZCB->ZCB_X_NPES) + hQuebraCpl
						EndIf
					EndIf
				EndIf

				If SD2->(FieldPos("D2_GCROMAN")) > 0 .AND. !EMPTY(SD2->D2_GCROMAN)
					cInfProd += "Romaneio: " + ALLTRIM(SD2->D2_GCROMAN) + "\" + ALLTRIM(SD2->D2_GCITROM) + hQuebraCpl
				EndIf
				
				If SD2->(FieldPos("D2_GCCONTV")) > 0 .AND. !EMPTY(SD2->D2_GCCONTV)
					cInfProd += "Ct. Venda: " + ALLTRIM(TRANSFORM(SD2->D2_GCCONTV, PESQPICT("ZDP", "ZDP_NUM"))) + hQuebraCpl
				EndIf
				
				If SD2->(FieldPos("D2_GCCONTC")) > 0 .AND. !EMPTY(SD2->D2_GCCONTC)
					cInfProd += "Ct. Compra: " + ALLTRIM(TRANSFORM(SD2->D2_GCCONTC, PESQPICT("ZDA", "ZDA_NUM"))) + hQuebraCpl
				EndIf
				
				If SD2->(FieldPos("D2_GCCONTS")) > 0 .AND. !EMPTY(SD2->D2_GCCONTS)
					cInfProd += "Ct. Servi�o: " + ALLTRIM(TRANSFORM(SD2->D2_GCCONTS, PESQPICT("ZDP", "ZDP_NUM"))) + hQuebraCpl
				EndIf

				If SD2->(FieldPos("D2_LOTECTL")) > 0 .AND. !EMPTY(SD2->D2_LOTECTL)
					cInfProd += "Lote: " + ALLTRIM(SD2->D2_LOTECTL) + " Dt. Validade: " + DTOC(SD2->D2_DTVALID) + hQuebraCpl
				EndIf

				If SD2->(FieldPos("D2_NFORI")) > 0 .AND. !EMPTY(SD2->D2_NFORI)
					cInfProd += "NF Ref.: " + ALLTRIM(SD2->D2_NFORI) + "\" + ALLTRIM(SD2->D2_SERIORI) + "-" + ALLTRIM(SD2->D2_ITEMORI) + hQuebraCpl
				EndIf
				
				//��������������������������������������������������
				//�Complementa as informa��es adicionais do produto�
				//��������������������������������������������������
				aProd[nI][25] += cInfProd
				

				//���������������������������������������������
				//�Mensagem nos dados adicionais do Ped. Venda�
				//���������������������������������������������
				If SD2->(FieldPos("D2_PEDIDO")) > 0 .AND. !EMPTY(SD2->D2_PEDIDO) .AND. !(hQuebraCpl + "Ped. Venda: " + ALLTRIM(SD2->D2_PEDIDO)) $ cMensCli
					cMensCli += hQuebraCpl + "Ped. Venda: " + ALLTRIM(SD2->D2_PEDIDO)
				EndIf

				//��������������������������������������������������������������
				//�Carrega informa��es\menagens do contrato de compra vinculado�
				//��������������������������������������������������������������
				If SD2->(FieldPos("D2_GCCONTV")) > 0 .AND. !EMPTY(SD2->D2_GCCONTV)
					dbSelectArea("ZDP")
					ZDP->(dbSetOrder(1))
					ZDP->(dbGoTop())
					ZDP->(dbSeek(SUBSTR(SD2->D2_GCCONTV, 3, TAMSX3("ZDP_FILIAL")[1]) + SD2->D2_GCCONTV))
					
					If !EMPTY(ZDP->ZDP_MENPAD) .AND. !(hQuebraCpl + ALLTRIM(FORMULA(ZDP->ZDP_MENPAD))) $ cMensCli
						cMensCli += hQuebraCpl + ALLTRIM(FORMULA(ZDP->ZDP_MENPAD))
					EndIf
						
					If !EMPTY(ZDP->ZDP_INFOPE) .AND. !(hQuebraCpl + ALLTRIM(ZDP->ZDP_INFOPE)) $ cMensCli
						cMensCli += hQuebraCpl + ALLTRIM(ZDP->ZDP_INFOPE)
					EndIf
					
					If !EMPTY(ZDP->ZDP_INFCOR) .AND. !(hQuebraCpl + ALLTRIM(ZDP->ZDP_INFCOR)) $ cMensCli
						cMensCli += hQuebraCpl + ALLTRIM(ZDP->ZDP_INFCOR)
					EndIf
					
					If !EMPTY(ZDP->ZDP_INFFIS) .AND. !(hQuebraCpl + ALLTRIM(ZDP->ZDP_INFFIS)) $ cMensFis
						cMensFis += hQuebraCpl + ALLTRIM(ZDP->ZDP_INFFIS)
					EndIf
				EndIf
				
				
				//����������������������������������������������������������������
				//�Carrega informa��es\menagens do contrato de servi�os vinculado�
				//����������������������������������������������������������������
				If SD2->(FieldPos("D2_GCCONTS")) > 0 .AND. !EMPTY(SD2->D2_GCCONTS)
					dbSelectArea("ZEG")
					ZEG->(dbSetOrder(1))
					ZEG->(dbGoTop())
					ZEG->(dbSeek(SUBSTR(SD2->D2_GCCONTS, 3, TAMSX3("ZEG_FILIAL")[1]) + SD2->D2_GCCONTS))
					
					If !EMPTY(ZEG->ZEG_MSGF01) .AND. !(hQuebraCpl + ALLTRIM(FORMULA(ZEG->ZEG_MSGF01))) $ cMensCli
						cMensFis += hQuebraCpl + ALLTRIM(FORMULA(ZEG->ZEG_MSGF01))
					EndIf
					
					If !EMPTY(ZEG->ZEG_MSGD01) .AND. !(hQuebraCpl + ALLTRIM(ZEG->ZEG_MSGD01)) $ cMensCli
						cMensCli += hQuebraCpl + ALLTRIM(ZEG->ZEG_MSGD01)
					EndIf
					
					If !EMPTY(ZEG->ZEG_MSGD02) .AND. !(hQuebraCpl + ALLTRIM(ZEG->ZEG_MSGD02)) $ cMensFis
						cMensCli += hQuebraCpl + ALLTRIM(ZEG->ZEG_MSGD02)
					EndIf
				EndIf
				
				
				//�������������������������������������������������������������������������������������������
				//�Adiciona mensagem de placas e motorista aos dados adicionais do Danfe - Conforme romaneio�
				//�������������������������������������������������������������������������������������������
				If !EMPTY(SD2->D2_GCROMAN)
					dbSelectArea("ZCB")
					ZCB->(dbSetOrder(1))
					ZCB->(dbGoTop())
					If ZCB->(dbSeek(xFilial("ZCB") + SD2->D2_GCROMAN))
						
						//������������������������������������������������������������������
						//�Adiciona as PLACAS do romaneio caso ainda n�o estejam vinculadas�
						//������������������������������������������������������������������
						cPlacas := "Placas: " + ALLTRIM(ZCB->ZCB_PLACA) + IIF(!EMPTY(ALLTRIM(ZCB->ZCB_REBOQ1)), " \ " + ALLTRIM(ZCB->ZCB_REBOQ1), "") + IIF(!EMPTY(ALLTRIM(ZCB->ZCB_REBOQ2)), " \ " + ALLTRIM(ZCB->ZCB_REBOQ2),  "") + IIF(!EMPTY(ALLTRIM(ZCB->ZCB_REBOQ3)), " \ " + ALLTRIM(ZCB->ZCB_REBOQ3),  "")
						If !((cPlacas + hQuebraCpl) $ cMensCli)
							cMensCli += cPlacas + hQuebraCpl
						EndIf
						
						//���������������������������������������������������������������������������������
						//�Adiciona o NOME\CNH do motorista caso esteja cadastrado e vinculado ao romaneio�
						//���������������������������������������������������������������������������������
						If !EMPTY(ZCB->ZCB_CODMOT)
							dbSelectArea("DA4")
							DA4->(dbSetOrder(1))
							DA4->(dbGoTop())
							If DA4->(dbSeek(xFilial("DA4") + ZCB->ZCB_CODMOT))
								cMotorista := "Motorista: " + ALLTRIM(DA4->DA4_NOME) + IIF(!EMPTY(ALLTRIM(DA4->DA4_NUMCNH)), "          CNH: " + ALLTRIM(DA4->DA4_NUMCNH), "")
								If !((cMotorista + hQuebraCpl) $ cMensCli)
									cMensCli += cMotorista + hQuebraCpl
								EndIf
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf
		Next nI

		//������������������������������������������
		//�Comp�e mensagem do FECHAMENTO FORNECEDOR�
		//������������������������������������������
		If SF2->(FieldPos("F2_GCFECH")) > 0 .AND. !EMPTY(SF2->F2_GCFECH) .AND. !("#Fechamento Fornecedor: " + ALLTRIM(SF2->F2_GCFECH) + "#") $ cMensCli
			cMensCli += "#Fechamento Fornecedor: " + ALLTRIM(SF2->F2_GCFECH) + "#"
		EndIf

		//�������������������������������������������������������
		//�Comp�e mensagem da TRANSFER�NCIA DE SALDOS FORNECEDOR�
		//������������������������������������������������������
		If SF2->(FieldPos("F2_GCTRFOR")) > 0 .AND. !EMPTY(SF2->F2_GCTRFOR) .AND. !("#Transf. Saldos Fornecedor: " + ALLTRIM(SF2->F2_GCTRFOR) + "#") $ cMensCli
			cMensCli += "#Transf. Saldos Fornecedor: " + ALLTRIM(SF2->F2_GCTRFOR) + "#"
		EndIf
		
		//�����������������������������������������������������������������������������������������������������������������������������������
		//�Tratamento para compor TAGs de NFP vinculadas as notas fiscais de entrada\compra, referenciadas ao documento fiscal de exporta��o�
		//�����������������������������������������������������������������������������������������������������������������������������������
		If !EMPTY(SF2->F2_GCCTEXP) .AND. !EMPTY(SF2->F2_GCEXPCT)
			dbSelectArea("ZEM")
			ZEM->(dbSetOrder(1))
			ZEM->(dbGoTop())
			If ZEM->(dbSeek(xFilial("ZEM") + SF2->F2_GCCTEXP + SF2->F2_GCEXPCT))
				
				//�������������������������������������������������������������������������������������������������������������
				//�Executa demais regras caso seja EXPORTA��O DIRETA\TRANSFER�NCIA\DEST EXP. de volume para fins de exporta��o�
				//�������������������������������������������������������������������������������������������������������������
				If ALLTRIM(ZEM->ZEM_TIPO) $ "2\4\5"
					dbSelectArea("ZDL")
					ZDL->(dbSetOrder(2))
					ZDL->(dbGoTop())
					If ZDL->(dbSeek(xFilial("ZDL") + ZEM->ZEM_NUM + ZEM->ZEM_ITEM))
						
						//���������������������������������������������������������������������������������������������������������������������������������������������������������������������
						//�Para cada NFe referenciada h� NFe exporta��o, verifica se trata-se de compra de produtor rural e atualiza array para posterior gera��o das tags de NFP Referenciada�
						//���������������������������������������������������������������������������������������������������������������������������������������������������������������������
						While ZDL->(!EOF()) .AND. ZDL->ZDL_FILIAL == xFilial("ZDL") .AND. ZDL->ZDL_NUM == ZEM->ZEM_NUM .AND. ZDL->ZDL_NUMEXP == ZEM->ZEM_ITEM
							If ZDL->ZDL_TPMOV == "E"
								dbSelectArea("SD1")
								SD1->(dbSetOrder(1))
								SD1->(dbGoTop())
								If SD1->(dbSeek(xFilial("SD1", ZDL->ZDL_FILDOC) + ZDL->ZDL_DOC + ZDL->ZDL_SERIE + ZDL->ZDL_CLIFOR + ZDL->ZDL_LOJA + ZDL->ZDL_COD + ZDL->ZDL_ITEM))
									dbSelectArea("SA2")
									SA2->(dbSetOrder(1))
									SA2->(dbGoTop())
									If SA2->(dbSeek(xFilial("SA2") + SD1->D1_FORNECE + SD1->D1_LOJA))
										
										//�������������������������������������������������������������������
										//�Considera informa��es da NFP apenas se � fornecedor pessoa fisica�
										//�������������������������������������������������������������������
										If SA2->A2_TIPO == "F"
											AADD(aNfpVinc, {SD1->D1_EMISSAO, SD1->D1_GCSRPRO, SD1->D1_GCNFPRO, "NFP", SA2->A2_CGC, SA2->A2_EST, SA2->A2_INSCR})
										EndIf
									EndIf
								EndIf
							EndIf
							ZDL->(dbSkip())
						End
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf



Else



	//����������������������������������������������������������
	//�Executa regras quando se trata de nota fiscal de entrada�
	//����������������������������������������������������������

	//��������������������������������������������������������
	//�Obt�m c�digo do fornecedor\cliente do documento fiscal�
	//��������������������������������������������������������
	If !aNota[5] $ "B\D"
		dbSelectArea("SA2")
		SA2->(dbSetOrder(1))
		SA2->(dbGoTop())
		If SA2->(dbSeek(xFilial("SA2") + SF1->F1_FORNECE + SF1->F1_LOJA))
			cCliFor	:= SA2->A2_COD
			cLoja	:= SA2->A2_LOJA  
		EndIf                      
	Else                           
		dbSelectArea("SA1")
		SA1->(dbSetOrder(1))
		SA1->(dbGoTop())
		If SA1->(dbSeek(xFilial("SA1") + SF1->F1_FORNECE + SF1->F1_LOJA))
			cCliFor	:= SA1->A1_COD
			cLoja	:= SA1->A1_LOJA   
		EndIf
	EndIf
	
	//������������������������������������������������
	//�Garante posicionamento do documento de entrada�
	//������������������������������������������������
	dbSelectArea("SF1")
	SF1->(dbSetOrder(1))
	SF1->(dbGoTop())
	If SF1->(dbSeek(xFilial("SF2") + aNota[2] + aNota[1] + cCliFor + cLoja))
		
		//���������������������������������������������������������������������
		//�Executa la�o de processamento de todos os itens do documento fiscal�
		//���������������������������������������������������������������������
		For nI := 1 To Len(aInfItem)
			
			//������������������������������������������������������
			//�Posiciona no item do documento fiscal conforme array�
			//������������������������������������������������������
			dbSelectArea("SD1")
			SD1->(dbSetOrder(1))
			SD1->(dbGoTop())
			If SD1->(dbSeek(xFilial("SD1") + SF1->F1_DOC + SF1->F1_SERIE + SF1->F1_FORNECE + SF1->F1_LOJA + aProd[nI][2] + aInfItem[nI][4]))
				cInfProd := hQuebraCpl
				
				//��������������������������������������������
				//�Posiciona no no pedido de compra vinculado�
				//��������������������������������������������
				dbSelectArea("SC7")
				SC7->(dbSetOrder(1))
				SC7->(dbGoTop())
				SC7->(dbSeek(xFilial("SC7") + SD1->D1_PEDIDO + SD1->D1_ITEMPC))
				
				//����������������������������������������������
				//�Posiciona no TES do item do documento fiscal�
				//����������������������������������������������
				dbSelectArea("SF4")
				SF4->(dbSetOrder(1))
				SF4->(dbGoTop())
				SF4->(dbSeek(xFilial("SF4") + SD1->D1_TES))
				
				
				//�������������������������������������������������������
				//�Carrega informa��es vinculadas ao cadastro do produto�
				//�������������������������������������������������������
				dbSelectArea("SB1")
				SB1->(dbSetOrder(1))
				SB1->(dbGoTop())
				SB1->(dbSeek(xFilial("SB1") + SD1->D1_COD))
				
				
				//�����������������������������������������������������������
				//�Posiciona no grupo de produto do item do documento fiscal�
				//�����������������������������������������������������������
				dbSelectArea("SBM")
				SBM->(dbSetOrder(1))
				SBM->(dbGoTop())
				SBM->(dbSeek(xFilial("SBM") + SB1->B1_GRUPO))
				
				
				//���������������������������������������������������������������������������������
				//�Carrega informa��es vinculadas � campos especificos do item do documento fiscal�
				//���������������������������������������������������������������������������������
				If SD1->(FieldPos("D1_GCPH")) > 0 .AND. SD1->D1_GCPH > 0 
					cInfProd += "Ph: " + ALLTRIM(TRANSFORM(SD1->D1_GCPH, "999")) + hQuebraCpl
				EndIf
				
				If SD1->(FieldPos("D1_GCRENDA")) > 0 .AND. !EMPTY(SD1->D1_GCRENDA)
					cInfProd += "Renda: " + ALLTRIM(TRANSFORM(SD1->D1_GCRENDA, "99/99")) + hQuebraCpl
				EndIf
				
				If SB1->B1_GCKGSAC > 0
					If !EMPTY(SF1->F1_GCFECH) .AND. SD1->D1_QUANT == 0
						nQtdMov := 0
						nVlSaca := 0
						dbSelectArea("ZE3")
						ZE3->(dbSetOrder(1))
						ZE3->(dbGoTop())
						If ZE3->(dbSeek(xFilial("ZE3") + SF1->F1_GCFECH))
							While ZE3->(!EOF()) .AND. ZE3->ZE3_FILIAL == xFilial("ZE3") .AND. ZE3->ZE3_COD == SF1->F1_GCFECH
								If ALLTRIM(ZE3->ZE3_PROD) == ALLTRIM(SD1->D1_COD)
									nQtdMov += ZE3->ZE3_QUANT
									nVlSaca := ZE3->ZE3_VLSACA
								EndIf
								ZE3->(dbSkip())
							End
							
							cInfProd += "Valor Saca R$ " + ALLTRIM(TRANSFORM(nVlSaca, PESQPICT("SD1", "D1_TOTAL"))) + hQuebraCpl
						EndIf
					Else
						cInfProd += "Valor Saca R$ " + ALLTRIM(TRANSFORM(ROUND((SD1->D1_VUNIT * SB1->B1_GCKGSAC), TAMSX3("D1_TOTAL")[2]), PESQPICT("SD1", "D1_TOTAL"))) + hQuebraCpl
					EndIf
				EndIf

				If SB1->(FieldPos("B1_GCALDPI")) > 0 .AND. SB1->B1_GCALDPI > 0 .AND. SD1->D1_VALIMP3 > 0
					cInfProd += "DPI Monsanto: R$ " + ALLTRIM(TRANSFORM(SD1->D1_VALIMP3, PESQPICT("SD1", "D1_VALIMP3"))) + hQuebraCpl
				EndIf

				If SB1->(FieldPos("B1_GCALDPI")) > 0 .AND. SB1->B1_GCALDPI > 0 .AND. SD1->(FieldPos("D1_GCBAIXA")) .AND. !EMPTY(SD1->D1_GCBAIXA)
					cInfProd += "Cr�dito DPI: " + ALLTRIM(SD1->D1_GCBAIXA) + " - " + ALLTRIM(TRANSFORM(SD1->D1_GCCREDI, PESQPICT("SD1", "D1_GCCREDI"))) + " Kg" + hQuebraCpl
				EndIf

				If SD1->(FieldPos("D1_GCNFPRO")) > 0 .AND. !EMPTY(SD1->D1_GCNFPRO)
					cInfProd += "NF Produtor: " + ALLTRIM(SD1->D1_GCNFPRO) + "\" + ALLTRIM(SD1->D1_GCSRPRO) + hQuebraCpl
				EndIf

				If SD1->(FieldPos("D1_GCROMAN")) > 0 .AND. !EMPTY(SD1->D1_GCROMAN)
					dbSelectArea("ZCB")
					ZCB->(dbSetOrder(1))
					ZCB->(dbGoTop())
					If ZCB->(dbSeek(xFilial("ZCB") + SD1->D1_GCROMAN))
						If ZCB->(FieldPos("ZCB_X_NPES")) > 0 .AND. !EMPTY(ZCB->ZCB_X_NPES)
							cInfProd += "Pesagem: " + ALLTRIM(ZCB->ZCB_X_NPES) + hQuebraCpl
						EndIf
					EndIf
				EndIf

				If SD1->(FieldPos("D1_GCROMAN")) > 0 .AND. !EMPTY(SD1->D1_GCROMAN)
					cInfProd += "Romaneio: " + ALLTRIM(SD1->D1_GCROMAN) + "\" + ALLTRIM(SD1->D1_GCITROM) + hQuebraCpl
				EndIf
				
				If SD1->(FieldPos("D1_GCCONTV")) > 0 .AND. !EMPTY(SD1->D1_GCCONTV)
					cInfProd += "Ct. Venda: " + ALLTRIM(TRANSFORM(SD1->D1_GCCONTV, PESQPICT("ZDP", "ZDP_NUM"))) + hQuebraCpl
				EndIf
				
				If SD1->(FieldPos("D1_GCCONTC")) > 0 .AND. !EMPTY(SD1->D1_GCCONTC)
					cInfProd += "Ct. Compra: " + ALLTRIM(TRANSFORM(SD1->D1_GCCONTC, PESQPICT("ZDA", "ZDA_NUM"))) + hQuebraCpl
				EndIf
				
				If SD1->(FieldPos("D1_GCCONTS")) > 0 .AND. !EMPTY(SD1->D1_GCCONTS)
					cInfProd += "Ct. Servi�o: " + ALLTRIM(TRANSFORM(SD1->D1_GCCONTS, PESQPICT("ZDP", "ZDP_NUM"))) + hQuebraCpl
				EndIf

				If SD1->(FieldPos("D1_LOTECTL")) > 0 .AND. !EMPTY(SD1->D1_LOTECTL)
					cInfProd += "Lote: " + ALLTRIM(SD1->D1_LOTECTL) + " Dt. Validade: " + DTOC(SD1->D1_DTVALID) + hQuebraCpl
				EndIf

				If SD1->(FieldPos("D1_NFORI")) > 0 .AND. !EMPTY(SD1->D1_NFORI)
					cInfProd += "NF Ref.: " + ALLTRIM(SD1->D1_NFORI) + "\" + ALLTRIM(SD1->D1_SERIORI) + "-" + ALLTRIM(SD1->D1_ITEMORI) + hQuebraCpl
				EndIf
				
				//��������������������������������������������������
				//�Complementa as informa��es adicionais do produto�
				//��������������������������������������������������
				aProd[nI][25] += cInfProd
				
				
				//��������������������������������������������������������������
				//�Carrega informa��es\menagens do contrato de compra vinculado�
				//��������������������������������������������������������������
				If SD1->(FieldPos("D1_GCCONTC")) > 0 .AND. !EMPTY(SD1->D1_GCCONTC)
					dbSelectArea("ZDA")
					ZDA->(dbSetOrder(1))
					ZDA->(dbGoTop())
					ZDA->(dbSeek(SUBSTR(SD1->D1_GCCONTC, 3, TAMSX3("ZDA_FILIAL")[1]) + SD1->D1_GCCONTC))
					
					If !EMPTY(ZDA->ZDA_MENPAD) .AND. !(hQuebraCpl + ALLTRIM(FORMULA(ZDA->ZDA_MENPAD))) $ cMensCli
						cMensCli += hQuebraCpl + ALLTRIM(FORMULA(ZDA->ZDA_MENPAD))
					EndIf
					
					If !EMPTY(ZDA->ZDA_INFOPE) .AND. !(hQuebraCpl + ALLTRIM(ZDA->ZDA_INFOPE)) $ cMensCli
						cMensCli += hQuebraCpl + ALLTRIM(ZDA->ZDA_INFOPE)
					EndIf
					
					If !EMPTY(ZDA->ZDA_INFCOR) .AND. !(hQuebraCpl + ALLTRIM(ZDA->ZDA_INFCOR)) $ cMensCli
						cMensCli += hQuebraCpl + ALLTRIM(ZDA->ZDA_INFCOR)
					EndIf
					
					If !EMPTY(ZDA->ZDA_INFFIS) .AND. !(hQuebraCpl + ALLTRIM(ZDA->ZDA_INFFIS)) $ cMensFis
						cMensFis += hQuebraCpl + ALLTRIM(ZDA->ZDA_INFFIS)
					EndIf
				EndIf
				
				
				//����������������������������������������������������������������
				//�Carrega informa��es\menagens do contrato de servi�os vinculado�
				//����������������������������������������������������������������
				If SD1->(FieldPos("D1_GCCONTS")) > 0 .AND. !EMPTY(SD1->D1_GCCONTS)
					dbSelectArea("ZEG")
					ZEG->(dbSetOrder(1))
					ZEG->(dbGoTop())
					ZEG->(dbSeek(SUBSTR(SD1->D1_GCCONTS, 3, TAMSX3("ZEG_FILIAL")[1]) + SD1->D1_GCCONTS))
					
					If !EMPTY(ZEG->ZEG_MSGF01) .AND. !(hQuebraCpl + ALLTRIM(FORMULA(ZEG->ZEG_MSGF01))) $ cMensCli
						cMensFis += hQuebraCpl + ALLTRIM(FORMULA(ZEG->ZEG_MSGF01))
					EndIf
					
					If !EMPTY(ZEG->ZEG_MSGD01) .AND. !(hQuebraCpl + ALLTRIM(ZEG->ZEG_MSGD01)) $ cMensCli
						cMensCli += hQuebraCpl + ALLTRIM(ZEG->ZEG_MSGD01)
					EndIf
					
					If !EMPTY(ZEG->ZEG_MSGD02) .AND. !(hQuebraCpl + ALLTRIM(ZEG->ZEG_MSGD02)) $ cMensFis
						cMensCli += hQuebraCpl + ALLTRIM(ZEG->ZEG_MSGD02)
					EndIf
				EndIf
				
				//��������������������������������������������
				//�Comp�e mensagem do INSS vinculado � compra�
				//��������������������������������������������
				If SF1->F1_INSS > 0 .AND. !("#Valor INSS: R$ " + ALLTRIM(TRANSFORM(SF1->F1_INSS, "@E 999,999.99")) + "#") $ cMensCli
					cMensCli += "#Valor INSS: R$ " + ALLTRIM(TRANSFORM(SF1->F1_INSS, "@E 999,999.99")) + "#"
				EndIf

				//���������������������������������������������
				//�Comp�e mensagem do SENAR vinculado � compra�
				//���������������������������������������������
				dbSelectArea("SF1")
				If SF1->F1_VLSENAR > 0 .AND. !("#Valor SENAR: R$ " + ALLTRIM(TRANSFORM(SF1->F1_VLSENAR, "@E 999,999.99"))) $ cMensCli
					cMensCli += "#Valor SENAR: R$ " + ALLTRIM(TRANSFORM(SF1->F1_VLSENAR, "@E 999,999.99"))
				EndIf
				
				//����������������������������������������������
				//�Comp�e mensagem do GILRAT vinculado � compra�
				//����������������������������������������������
				If SF1->F1_CONTSOC > 0 .AND. !("#Valor GILRAT: R$ " + ALLTRIM(TRANSFORM(SF1->F1_CONTSOC, "@E 999,999.99")) + "#") $ cMensCli
					cMensCli += "#Valor GILRAT: R$ " + ALLTRIM(TRANSFORM(SF1->F1_CONTSOC, "@E 999,999.99")) + "#"
				EndIf

				//����������������������������������������������������
				//�Comp�e mensagem do DPI MONSANTO vinculado � compra�
				//����������������������������������������������������
				If SF1->F1_VALIMP3 > 0 .AND. !("#DPI Monsanto: R$ " + ALLTRIM(TRANSFORM(SF1->F1_VALIMP3, "@E 999,999.99")) + "#") $ cMensCli
					cMensCli += "#DPI Monsanto: R$ " + ALLTRIM(TRANSFORM(SF1->F1_VALIMP3, "@E 999,999.99")) + "#"
				EndIf

				//������������������������������������������
				//�Comp�e mensagem do FECHAMENTO FORNECEDOR�
				//������������������������������������������
				If SF1->(FieldPos("F1_GCFECH")) > 0 .AND. !EMPTY(SF1->F1_GCFECH) .AND. !("#Fechamento Fornecedor: " + ALLTRIM(SF1->F1_GCFECH) + "#") $ cMensCli
					cMensCli += "#Fechamento Fornecedor: " + ALLTRIM(SF1->F1_GCFECH) + "#"
				EndIf

				//�������������������������������������������������������
				//�Comp�e mensagem da TRANSFER�NCIA DE SALDOS FORNECEDOR�
				//������������������������������������������������������
				If SF1->(FieldPos("F1_GCTRFOR")) > 0 .AND. !EMPTY(SF1->F1_GCTRFOR) .AND. !("#Transf. Saldos Fornecedor: " + ALLTRIM(SF1->F1_GCTRFOR) + "#") $ cMensCli
					cMensCli += "#Transf. Saldos Fornecedor: " + ALLTRIM(SF1->F1_GCTRFOR) + "#"
				EndIf
				
				//�������������������������������������������������������������������������������������������
				//�Adiciona mensagem de placas e motorista aos dados adicionais do Danfe - Conforme romaneio�
				//�������������������������������������������������������������������������������������������
				If !EMPTY(SD1->D1_GCROMAN)
					dbSelectArea("ZCB")
					ZCB->(dbSetOrder(1))
					ZCB->(dbGoTop())
					If ZCB->(dbSeek(xFilial("ZCB") + SD1->D1_GCROMAN))
						
						//������������������������������������������������������������������
						//�Adiciona as PLACAS do romaneio caso ainda n�o estejam vinculadas�
						//������������������������������������������������������������������
						cPlacas := "Placas: " + ALLTRIM(ZCB->ZCB_PLACA) + IIF(!EMPTY(ALLTRIM(ZCB->ZCB_REBOQ1)), " \ " + ALLTRIM(ZCB->ZCB_REBOQ1), "") + IIF(!EMPTY(ALLTRIM(ZCB->ZCB_REBOQ2)), " \ " + ALLTRIM(ZCB->ZCB_REBOQ2),  "") + IIF(!EMPTY(ALLTRIM(ZCB->ZCB_REBOQ3)), " \ " + ALLTRIM(ZCB->ZCB_REBOQ3),  "")
						If !((cPlacas + hQuebraCpl) $ cMensCli)
							cMensCli += cPlacas + hQuebraCpl
						EndIf
						
						//���������������������������������������������������������������������������������
						//�Adiciona o NOME\CNH do motorista caso esteja cadastrado e vinculado ao romaneio�
						//���������������������������������������������������������������������������������
						If !EMPTY(ZCB->ZCB_CODMOT)
							dbSelectArea("DA4")
							DA4->(dbSetOrder(1))
							DA4->(dbGoTop())
							If DA4->(dbSeek(xFilial("DA4") + ZCB->ZCB_CODMOT))
								cMotorista := "Motorista: " + ALLTRIM(DA4->DA4_NOME) + IIF(!EMPTY(ALLTRIM(DA4->DA4_NUMCNH)), "          CNH: " + ALLTRIM(DA4->DA4_NUMCNH), "")
								If !((cMotorista + hQuebraCpl) $ cMensCli)
									cMensCli += cMotorista + hQuebraCpl
								EndIf
							EndIf
						EndIf
					EndIf
				EndIf
				
			EndIf
		Next nI
	EndIf
EndIf

//��������������������������������������������������
//�Compoe array de retorno com os dados manipulados�
//��������������������������������������������������
AADD(aRetorno, aProd)
AADD(aRetorno, cMensCli)
AADD(aRetorno, cMensFis)
AADD(aRetorno, aDest)
AADD(aRetorno, aNota)  
AADD(aRetorno, aInfItem)
AADD(aRetorno, aDup)
AADD(aRetorno, aTransp)
AADD(aRetorno, aEntrega)
AADD(aRetorno, aRetirada)
AADD(aRetorno, aVeiculo)
AADD(aRetorno, aReboque)
AADD(aRetorno, aNfpVinc)
AADD(aRetorno, aEspVol)
AADD(aRetorno, aNfVinc)
AADD(aRetorno, aDetPag)
AADD(aRetorno, aObsCont)
AADD(aRetorno, aProcRef)

RestArea(aArea)

Return aRetorno





/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
���������������������������������������������`���������������������������ͻ��
���Programa  �GCNFEEXP     �Autor �Marcelo Joner      � Data � 12/08/2019 ���
�������������������������������������������������������������������������͹��
���Desc.     �Fun��o utilizada na transmiss�o da NFe para identificar se  ���
���          �trata-se de documento fiscal de exporta��o direta\indireta. ���
�������������������������������������������������������������������������͹��
���Uso       �Especifico Grupo Cavalca                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function GCNFEEXP()

Local lExp	:= .T.

//�����������������������������������������������������������������������������������������������������
//�Executa demais regras caso seja embarque de Ct. Venda (Exporta��o\Remessa\Transfer�ncia\Dest. Exp.)�
//�����������������������������������������������������������������������������������������������������
dbSelectArea("SF2")
If !EMPTY(SF2->F2_GCCTEXP) .AND. !EMPTY(SF2->F2_GCEXPCT)
	dbSelectArea("ZEM")
	ZEM->(dbSetOrder(1))
	ZEM->(dbGoTop())
	If ZEM->(dbSeek(xFilial("ZEM") + SF2->F2_GCCTEXP + SF2->F2_GCEXPCT))
		lExp := IIF(ZEM->ZEM_TIPO $ "3\4\5", .F., .T.)
	EndIf
EndIf

Return lExp
