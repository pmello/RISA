// função para retornar modelo de pagamento ao sispag - Andrea Martins em 01/08/2019
User Function XModelo()
Local cRet := ""

If SEA->EA_MODELO == "13" .And. SEA->EA_TIPOPAG == "20"
	cRet := "13"
ElseIf SEA->EA_MODELO == "13" .And. SEA->EA_TIPOPAG == "22"
	cRet := "91"
Else
	cRet := SEA->EA_MODELO
EndIf

Return cRet