#include "protheus.ch"                      
#include "rwmake.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MTASF2    �Autor  �Marcelo Joner       � Data �  15/01/2010 ���
�������������������������������������������������������������������������͹��
���Desc.     � Ponto de entrada utilizado ap�s o faturamento de documento ���
���          � de sa�da para gravar campos adicionais na tabela SF2.      ���
�������������������������������������������������������������������������͹��
���Uso       � Gest�o de Cereais                                          ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function MTASF2()
  

//                                            ^
//                                            |
/*Implemente o ponto de entrada antes da chamada do Bloco de Fun��o do Gest�o de Cereais....*/
//*************************************************************************************************************************************
//�������������������������������������������������������������������������������������������������������������������������������������
//� Espec�fico para ser utilizado pelo Gest�o de Cereais 																			  �
//�������������������������������������������������������������������������������������������������������������������������������������
If ExistBlock("xMTASF2")
	ExecBlock( "xMTASF2", .F., .F.)
EndIf


// Chamadas de outros modulos que nao utilizam as regras de precos e descontos
If U_USAREGRA() //Caso perten�a h� algum modulo vertical o retorno � .F. e n�o executa os dados da Transportadora
    If ExistBlock("GRVMOTORIS")
        ExecBlock( "GRVMOTORIS", .F., .F.)//Grava dados do Motorista para impress�o da Danfe
    Endif
EndIf
Return .T.
