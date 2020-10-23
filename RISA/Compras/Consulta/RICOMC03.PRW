#include "protheus.ch"
/*-----------------------------------------------------------------------------------------------------------------------------------
{Protheus.doc} RICOMC03
Função utilizada no gatilho do campo especifico D1_XPESFIM para D1_XVLQUEB para calcular o valor de quebra da carga e 
preencher os campos D1_VALDESC e D1_XVLQUEB

@type    function
@author  TOTVS..
@since   Out/2020
@version P12

@project MAN0000001_EF_001
@obs     Projeto RISA
-----------------------------------------------------------------------------------------------------------------------------------*/
User Function RICOMC03()

Local aArea     := GetArea()
Local nRet 	    := 0
Local nPesOri   := 0 //Peso de Origem em quilos (quantidade informada pelo usuário no campo D1_QUANT)
Local nTol      := 0 //Percentual de Tolerancia a ser dencontado o peso original.
Local nPesLiq   := 0 //Peso Liquido, peso original descontado da tolerancia
Local nPesFim   := 0 //Peso na chegada, Peso Final informado pelo cliente.
Local nPesPerda := 0 //Perda de mercadoria a ser considerar Peso original descontado da tolerancia menos o peso final
Local nValMerc  := 0 //Valor total da mercadoria da nota fiscal original de entrada ou saida.
Local nVlrPerda := 0 //Valor do Produto perdido este valor é considerado valor de quebra. Valor por quilo
Local nPosQtd	:= aScan(aHeadER,{|x| AllTrim(x[2])=="D1_QUANT"}) 

nPesOri     := aCols[1][nPosQtd]//Considero somente o primeiro item M->D1_QUANT, nota de conhecimento só tem 1 item //Peso original
nTol        := GetNewPar("MV_XTOLER",0.25) //Tolerancia 
nPesLiq     := nPesOri-(nPesOri*(nTol/100)) //Peso Liquido
nPesFim     := M->D1_XPESFIM //Peso final ou de chegada
nPesPerda   := nPesLiq-nPesFim //Peso perdido que sera descontado da transportadora.
nValMerc    := GetAdvFVal("SZ1","Z1_XVLMERC",xFilial("SZ1")+cNfiscal+cSerie+cA100For+cLoja,1,0) 
nVlrPerda   := nValMerc/nPesOri //Valor do quilo por produto vencido, baseado no valor da mercadoria da NF original dividido pelo peso transportado no CTe
nRet        := nPesPerda*nVlrPerda //Desconto financeiro

M->D1_VALDESC := nRet
MaFisRef("IT_DESCONTO","MT100",M->D1_VALDESC) //função que preenche o valor do desconto no rodape da nota

RestArea(aArea)

Return(nRet)
