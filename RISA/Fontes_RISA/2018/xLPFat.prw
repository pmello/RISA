#include "rwmake.ch"
#include "protheus.ch"
#include "topconn.ch"       

/*                                                                                      
#####################################################################################################################################
#####################################################################################################################################
# Programador   : Valdiney Silva em 29/11/2017																						#	
# Finalidade    : Verifica o cfop da nota buscando a conta contabil no grupo de produdos											#
# Utilizacao    : LP 610-001							                                                                            #
# Sintaxe       : u_xLPFat(cChave)                     		                                                                        #
# Retorno       : Conta contabil																									# 
# cChave 	    : u_xLPFat(xFilial("SD2")+SD2->D2_GRUPO+SD2->D2_CF)           	                                                    #
#####################################################################################################################################
*/
User Function xLPFat(cChave)
Local cRetorno	:= ''
Local cEmpresa	:= SubStr(cChave,1,6)
Local cGrupo	:= SubStr(cChave,7,4)
Local cCFOP 	:= SubStr(cChave,11,4)
	
If(Alltrim(cCFOP) $ "5102/6102/5405/6404")
	cRetorno := Posicione("SBM",1,cEmpresa+cGRUPO,"BM_XCTA01") 
ElseIf(Alltrim(cCFOP) $ "7501")
	cRetorno := Posicione("SBM",1,cEmpresa+cGrupo,"BM_XCTA02")  
ElseIf(Alltrim(cCFOP) $ "5922/6922")
	cRetorno := Posicione("SBM",1,cEmpresa+cGrupo,"BM_XCTA03")
ElseIf(Alltrim(cCFOP) $ "5117/6117")
	cRetorno := Posicione("SBM",1,cEmpresa+cGrupo,"BM_XCTA04") 
ElseIf(Alltrim(cCFOP) $ "5101/6101")
	cRetorno := Posicione("SBM",1,cEmpresa+cGrupo,"BM_XCTA05") 
ElseIf(Alltrim(cCFOP) $ "7101")
	cRetorno := Posicione("SBM",1,cEmpresa+cGrupo,"BM_XCTA06") 
ElseIf(Alltrim(cCFOP) $ "5501/6501")
	cRetorno := Posicione("SBM",1,cEmpresa+cGrupo,"BM_XCTA07")  
ElseIf(Alltrim(cCFOP) $ "5116/6117")
	cRetorno := Posicione("SBM",1,cEmpresa+cGrupo,"BM_XCTA08")  
EndIF	

Return AllTrim(cRetorno)