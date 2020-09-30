#INCLUDE "TOTVS.CH"

/*/

{Protheus.doc} SF2460I.PRW
                 
Ponto de Entrada utilizado para criar a CD6, nos casos de Transferencia de COMBUSTIVEL

@author  Milton J.dos Santos	
@since   12/08/2020
@version 1.0

/*/

User Function SF2460I
Local aArea     := GetArea()


If ExistBlock("GRVCD6COMB")
    ExecBlock( "GRVCD6COMB", .F., .F.) //Grava dados ANP tabela CD6 conforme regra no parametro MV_COMBUS - chamado no fonte CFGXFAT
Endif

// Chamadas de outros modulos que nao utilizam as regras de precos e descontos
If U_USAREGRA()
    If ExistBlock("GRVMOTORIS")
        ExecBlock( "GRVMOTORIS", .F., .F.)//Grava dados do Motorista para impressão da Danfe
    Endif
EndIf

RestArea(aArea)
RETURN()
