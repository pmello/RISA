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

RestArea(aArea)
RETURN()
