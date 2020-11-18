#include "protheus.ch"
/*-----------------------------------------------------------------------------------------------------------------------------------
{Protheus.doc} ConfSel
Confirma selecao em browse especifico.

@type    function
@author  TOTVS..
@since   Out/2020
@version P12

@project MAN0000001_EF_001
@obs     Projeto RISA
-----------------------------------------------------------------------------------------------------------------------------------*/
User Function ConfSel()

nOpcSel := 1

If Type("oWind") == "O"
	oWind:End()
Else
	oWnd:End()
EndIf

Return( Nil )


/*-----------------------------------------------------------------------------------------------------------------------------------
{Protheus.doc} EnvMail
Funcao para envio de e-mail

Exemplo de como chamar a função:

	cAssunto 	 := "Teste" //Assunto do e-mail
	cTexto 	 	 := "Teste de envio de e-mail." //Texto que vai no corpo do e-mail
	cAnexos	 	 := cGetFile( '*.*' , 'Arquivos', 1, 'C:\', .F.,,.T., .T. )//Arquivo a ser enviado como anexo
	cMailDestino := "fulano@gmail.com.br" //E-mail para quem será enviado o e-mail

	U_EnvMail(Alltrim(cMailDestino),cAssunto,cTexto,cAnexos)

@type    function
@author  TOTVS..
@since   Nov/2020
@version P12

@project MAN0000001_EF_001
@obs     Projeto RISA
-----------------------------------------------------------------------------------------------------------------------------------*/

User Function EnvMail(cMailDestino,cAssunto,cTexto,cAnexos)

Local cAccount	:= GetMV("MV_RELACNT")//Conta de e-mail para enviar a msg
Local cPassword	:= GetMV("MV_RELPSW") //senha da conta definida acima
Local cServer	:= Substr(GetMV("MV_RELSERV"),1,AT(":",GetMV("MV_RELSERV"))-1)//GetMV("MV_RELSERV")//IP do servidor de e-mail //No caso da risa, esse parametro está com a porta informada, por isso eu tiro ela daqui
Local cEmailde  := GetMV("MV_RELFROM")//Endereco de e_mail que vai enviar a msg o mesmo da conta

Local lMensagem	:= .T.

TkSendMail(	cAccount,cPassword,cServer,cEmailde,cMailDestino,cAssunto,cTexto,cAnexos)

Return()
