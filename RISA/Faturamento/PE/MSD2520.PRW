/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � MSD2520  �Autor  �Lincoln Rossetto    � Data �  03/06/09   ���
�������������������������������������������������������������������������͹��
���Desc.     �  Ponto de Entrada que trata procedimentos no exluir do item���
v���          � da nota fiscal.                                           ���
�������������������������������������������������������������������������͹��
���Uso       � Gestao de Cereais                                          ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function MSD2520()






//                                            ^
//                                            |
/*Implemente o ponto de entrada antes da chamada do Bloco de Fun��o do Gest�o de Cereais....*/
//*************************************************************************************************************************************
//�������������������������������������������������������������������������������������������������������������������������������������
//� Espec�fico para ser utilizado pelo Gest�o de Cereais 																			  �
//�������������������������������������������������������������������������������������������������������������������������������������
If ExistBlock("xMSD2520")
	ExecBlock("xMSD2520", .F., .F. )
EndIf

Return