#include "rwmake.ch"                   
#include "protheus.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MAFISRUR  �Autor  �Marcelo Joner       � Data �  12/07/10   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada utilizado para alterar a aliquota de calculo��
���          �do FUNRURAL caso no cadastro do fornecedor esteja definido  ���
���          �que o mesmo possua liminar isentando do recolhimento.       ���
�������������������������������������������������������������������������͹��
���Uso       �Gest�o de Cereais                                           ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function MAFISRUR()

Local aParam			:= PARAMIXB
Local nAlqGilrat		:= aParam[8]
       




                                        








//                                            ^
//                                            |
/*Implemente o ponto de entrada antes da chamada do Bloco de Fun��o do Gest�o de Cereais....*/
//*************************************************************************************************************************************
//�������������������������������������������������������������������������������������������������������������������������������������
//�                                                                                                                                   �
//�������������������������������������������������������������������������������������������������������������������������������������
If ExistBlock("xMAFISRUR")
	nAlqGilrat := ExecBlock("xMAFISRUR", .F., .F., aParam)
EndIf

Return nAlqGilrat