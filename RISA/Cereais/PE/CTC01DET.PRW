#include 'totvs.ch
#include 'rwmake.ch'
#include 'protheus.ch'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
��������������������������������������������������������������������������ͱ�
���Programa  �CTC01DET   �Autor  � Marcelo Joner      � Data � 31/10/2020 ���
��������������������������������������������������������������������������ͱ�
���Desc.     �Ponto de entrada, executado antes da apresenta��o da interfa���
���          �ce das funcionalidades na rotina de Ct. Compra.             ���
��������������������������������������������������������������������������ͱ�
���Uso       � Gest�o de Cereais                                          ���
��������������������������������������������������������������������������ͱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function CTC01DET()

Local lRet  := .T.

//����������������������������������������������������
//�Verifica se existe Pesagem �nica para o Ct. Compra�
//����������������������������������������������������
If ISINCALLSTACK("U_CTC001EST") .AND. U_CXESP01(ZDA->ZDA_NUM)
    Help(NIL, NIL, "Aten��o", NIL, "Existem registros de Pesagem �nica para este Ct. Compra.", 1, 0, NIL, NIL, NIL, NIL, NIL, {"Para estornar o Ct. Compra, � necess�rio que n�o existam registros v�lidos de Pesagem �nica."})
    lRet := .F.
EndIf

Return lRet
