#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ FA460FIL ºAutor  ³ Flavio Dias         º Data ³  28/10/20  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Adiocnar Filtro adicinais para geração da                  º±±
±±º          ³ Liquidação do Contas a receber                             º±±
±±º          ³ Ponto de entrada                                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ RISA S/A                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function FA460FIL()
Local _cFiltro := ""
Local nGFI :=Space(6)
Local nGFF :='ZZZZZZZZ'
Local nGCI :=Space(16)
Local nGCF :='ZZZZZZZZZZZZZZZZ'
Local nG1I :=Space(16)
Local nG1F :='ZZZZZZZZZZZZZZZZ'
Local nGVI :=Transform(0, "@E 99,999.99")
Local nGVF :=Transform(999999999.99, "@E 9,999,999,999,999.99")
Local nG2I :=Space(16)
Local nG2F :='ZZZZZZZZZZZZZZZZ'
Local nG3I :=Space(16)
Local nG3F :='ZZZZZZZZZZZZZZZZ'
Local nGPI :=Space(6)
Local nGPF :='ZZZZZZ'


/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
SetPrvt("oFont1","oDlg1","oSay1","oSay2","oSay3","oSay4","oSay5","oSay6","oSay7","oSay8","oSay9","oSay10")
SetPrvt("oSay12","oSay13","oSay14","oSay15","oSay16","oGet1","oGet2","oGet3","oGet4","oGet5","oGet6")
SetPrvt("oGet7","oGet8","oGet9","oGet10","oGet11","oGet12","oGet13","oGet14","oGet15","oGet16")

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
oFont1     := TFont():New( "Arial",0,-15,,.F.,0,,400,.F.,.F.,,,,,, )
oDlg1      := MSDialog():New( 084,218,486,991,"Filtro Contas a Receber - Liquidação",,,.F.,,,,,,.T.,,,.T. )
//oSay1      := TSay():New( 004,004,{||"Cliente de?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
//oSay2      := TSay():New( 002,218,{||"Cliente até?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,057,008)
oSay3      := TSay():New( 023,004,{||"Contrato Venda de ?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,072,009)
oSay4      := TSay():New( 023,204,{||"Contrato Venda até ?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,072,009)
oSay5      := TSay():New( 101,004,{||"Valor de?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,048,010)
oSay6      := TSay():New( 102,239,{||"Valor até?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,038,009)
oSay7      := TSay():New( 043,004,{||"Contrato Compra de ?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,076,011)
oSay8      := TSay():New( 042,198,{||"Contrato Compra até ?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,076,009)
oSay9      := TSay():New( 064,003,{||"Contrato Serv. de?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,076,009)
oSay10     := TSay():New( 063,209,{||"Contrato Serv. até?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,068,009)
oSay11     := TSay():New( 081,003,{||"Contrato Troca de?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,076,009)
oSay12     := TSay():New( 081,210,{||"Contrato Troca até?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,067,009)
//oSay13     := TSay():New( 119,005,{||"Banco de?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,048,009)
//oSay14     := TSay():New( 119,237,{||"Banco até?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,048,009)
oSay15     := TSay():New( 119,005,{||"Pedido de?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,048,009)
oSay16     := TSay():New( 119,237,{||"Pedido até?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,048,009)
//oGet1      := TGet():New( 003,097,{ |u| If( PCount() == 0,nGFI,nGFI := u ) },oDlg1,076,008,'!@',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA2","nGFI",,)
//oGet2      := TGet():New( 002,279,{ |u| If( PCount() == 0,nGFF,nGFF := u ) },oDlg1,076,008,'!@',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA2","nGFF",,)
oGet3      := TGet():New( 022,097,{ |u| If( PCount() == 0,nGCI,nGCI := u ) },oDlg1,076,008,'!@',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"ZDP","nGCI",,)
oGet4      := TGet():New( 022,280,{ |u| If( PCount() == 0,nGCF,nGCF := u ) },oDlg1,076,008,'!@',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"ZDP","nGCF",,)
oGet5      := TGet():New( 100,097,{ |u| If( PCount() == 0,nGVI,nGVI := u ) },oDlg1,076,008,'@E',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nGVI",,)
oGet6      := TGet():New( 100,285,{ |u| If( PCount() == 0,nGVF,nGVF := u ) },oDlg1,076,008,'@E',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nGVF",,)
oBtn1      := TButton():New( 173,304,"Filtar",oDlg1,{ || oDlg1:End()},060,016,,oFont1,,.T.,,"",,,,.F. )
oGet7      := TGet():New( 041,097,{ |u| If( PCount() == 0,nG1I,nG1I := u ) },oDlg1,076,010,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"ZDA","nG1I",,)
oGet8      := TGet():New( 041,281,{ |u| If( PCount() == 0,nG1F,nG1F := u ) },oDlg1,076,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"ZDA","nG1F",,)
oGet9      := TGet():New( 063,096,{ |u| If( PCount() == 0,nG2I,nG2I := u ) },oDlg1,076,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"ZEG","nG2I",,)
oGet10     := TGet():New( 063,281,{ |u| If( PCount() == 0,nG2F,nG2F := u ) },oDlg1,076,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"ZEG","nG2F",,)
oGet11     := TGet():New( 081,096,{ |u| If( PCount() == 0,nG3I,nG3I := u ) },oDlg1,076,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"ZEN","nG3I",,)
oGet12     := TGet():New( 081,283,{ |u| If( PCount() == 0,nG3F,nG3F := u ) },oDlg1,077,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"ZEN","nG3F",,)
//oGet13     := TGet():New( 120,096,{ |u| If( PCount() == 0,nGBI,nGBI := u ) },oDlg1,080,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nGBI",,)
//oGet14     := TGet():New( 118,286,{ |u| If( PCount() == 0,nGBF,nGBF := u ) },oDlg1,078,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nGBF",,)
oGet15     := TGet():New( 120,096,{ |u| If( PCount() == 0,nGPI,nGPI := u ) },oDlg1,080,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SC5","nGPI",,)
oGet16     := TGet():New( 118,286,{ |u| If( PCount() == 0,nGPF,nGPF := u ) },oDlg1,077,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SC5","nGPF",,)
//oGet1 := TGet():New( 028,076,{ |u| If( PCount() == 0,_cProd,_cProd := u ) },oDlg1,060,008,'@!',{|| U_XVERIF(_cProd,1)},CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SB1","_cProd",,)
oDlg1:Activate(,,,.T.)



//_cFiltro := " ((E1_CLIENTE>='"+nGFI+"' .and. E1_CLIENTE<='"+nGFF+"') .and. (E1_VALOR>="+nGVI+" .and. E1_VALOR<="+REPLACE(nGVF,".","")+") "
_cFiltro := " and ((E1_GCCONTC>='"+nG1I+"' AND E1_GCCONTC<='"+nG1F+"')"
_cFiltro += " and (E1_GCCONTV>='"+nGCI+"' AND E1_GCCONTV<='"+nGCF+"')"
_cFiltro += " and (E1_GCCONTS>='"+nG2I+"' AND E1_GCCONTS<='"+nG2F+"')"
_cFiltro += " and (E1_PEDIDO>='"+nGPI+"' AND E1_PEDIDO<='"+nGPF+"')"
//_cFiltro += " .and. (E1_PREFIXO>='"+D1_SERIEI+"' .AND. E1_PREFIXO<='"+D1_SERIEF+"')"
//_cFiltro += " .and. (E2_NUM>='"+D1_DOCI+"' .AND. E2_NUM<='"+D1_DOCF+"')"
//_cFiltro += " .and. (E2_FORNECE>='"+D1FORNECEI+"' .AND. E2_FORNECE<='"+D1_FORNECEF+"')"
//_cFiltro += " .and. (E2_LOJA>='"+D1_LOJAI+"' .AND. E2_LOJA<='"+D1_LOJAF+"')"
_cFiltro += " and (E1_GCCONTT>='"+nG3I+"' AND E1_GCCONTT<='"+nG3F+"'))"

return _cFiltro
