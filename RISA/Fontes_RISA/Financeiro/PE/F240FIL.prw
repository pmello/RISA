#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ F240FIL บAutor  ณ Flavio Dias         บ Data ณ  22/10/20   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Adiocnar Filtro adicinais para gera็ใo do                  บฑฑ
ฑฑบ          ณ border๔ no financeiro                                      บฑฑ
ฑฑบ          ณ Ponto de entrada                                           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ RISA S/A                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function F240FIL()
Local _cFiltro
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
Local nGBI :=Space(3)
Local nGBF :='ZZZ'
Local _cQuery := ''
Local _cQuery2 := ''
Local nGPI :=Space(6)
Local nGPF :='ZZZZZZ'
Local D1_SERIEI :=Space(2)
Local D1_DOCI := Space(9)
Local D1FORNECEI := Space(6)
Local D1_LOJAI := Space(2)
Local D1_SERIEF := 'ZZ'
Local D1_DOCF := 'ZZZZZZZZZ'
Local D1_FORNECEF := 'ZZZZZZ'
Local D1_LOJAF := 'ZZ'

/*ฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑ Declara็ใo de Variaveis Private dos Objetos                             ฑฑ
ูฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ*/
SetPrvt("oFont1","oDlg1","oSay1","oSay2","oSay3","oSay4","oSay5","oSay6","oSay7","oSay8","oSay9","oSay10")
SetPrvt("oSay12","oSay13","oSay14","oSay15","oSay16","oGet1","oGet2","oGet3","oGet4","oGet5","oGet6")
SetPrvt("oGet7","oGet8","oGet9","oGet10","oGet11","oGet12","oGet13","oGet14","oGet15","oGet16")

/*ฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑ Definicao do Dialog e todos os seus componentes.                        ฑฑ
ูฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ*/
oFont1     := TFont():New( "Arial",0,-15,,.F.,0,,400,.F.,.F.,,,,,, )
oDlg1      := MSDialog():New( 084,218,486,991,"Filtro Border๔ - Contas a Pagar",,,.F.,,,,,,.T.,,,.T. )
oSay1      := TSay():New( 004,004,{||"Fornecedor de?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
oSay2      := TSay():New( 002,218,{||"Fornecedor at้?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,057,008)
oSay3      := TSay():New( 023,004,{||"Contrato Venda de ?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,072,009)
oSay4      := TSay():New( 023,204,{||"Contrato Venda at้ ?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,072,009)
oSay5      := TSay():New( 101,004,{||"Valor de?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,048,010)
oSay6      := TSay():New( 102,239,{||"Valor at้?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,038,009)
oSay7      := TSay():New( 043,004,{||"Contrato Compra de ?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,076,011)
oSay8      := TSay():New( 042,198,{||"Contrato Compra at้ ?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,076,009)
oSay9      := TSay():New( 064,003,{||"Contrato Serv. de?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,076,009)
oSay10     := TSay():New( 063,209,{||"Contrato Serv. at้?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,068,009)
oSay11     := TSay():New( 081,003,{||"Contrato Troca de?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,076,009)
oSay12     := TSay():New( 081,210,{||"Contrato Troca at้?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,067,009)
oSay13     := TSay():New( 119,005,{||"Banco de?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,048,009)
oSay14     := TSay():New( 119,237,{||"Banco at้?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,048,009)
oSay15     := TSay():New( 138,003,{||"Pedido de?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,048,009)
oSay16     := TSay():New( 137,234,{||"Pedido at้?"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,048,009)
oGet1      := TGet():New( 003,097,{ |u| If( PCount() == 0,nGFI,nGFI := u ) },oDlg1,076,008,'!@',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA2","nGFI",,)
oGet2      := TGet():New( 002,279,{ |u| If( PCount() == 0,nGFF,nGFF := u ) },oDlg1,076,008,'!@',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA2","nGFF",,)
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
oGet13     := TGet():New( 120,096,{ |u| If( PCount() == 0,nGBI,nGBI := u ) },oDlg1,080,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nGBI",,)
oGet14     := TGet():New( 118,286,{ |u| If( PCount() == 0,nGBF,nGBF := u ) },oDlg1,078,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","nGBF",,)
oGet15     := TGet():New( 139,096,{ |u| If( PCount() == 0,nGPI,nGPI := u ) },oDlg1,080,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SC7","nGPI",,)
oGet16     := TGet():New( 138,287,{ |u| If( PCount() == 0,nGPF,nGPF := u ) },oDlg1,077,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SC7","nGPF",,)
//oGet1 := TGet():New( 028,076,{ |u| If( PCount() == 0,_cProd,_cProd := u ) },oDlg1,060,008,'@!',{|| U_XVERIF(_cProd,1)},CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SB1","_cProd",,)
oDlg1:Activate(,,,.T.)

// fazer consulta em rela็ใo so pedidos para listar os dados de vincula็ใo com a tabela SE2

if !EMPTY(nGPI)
_cQuery := "SELECT D1_SERIE, D1_DOC, D1_FORNECE, D1_LOJA FROM "+RetsqlName("SD1") +" where D_E_L_E_T_ <>'*' and D1_PEDIDO='"+nGPI+"'"

dbUseArea(.T.,"TOPCONN",TCGENQRY(,,_cQuery),"SD1_I",.F.,.T.)     

While (SD1_I->(!eof()))
    D1_SERIEI  := SD1_I->D1_SERIE
    D1_DOCI     := SD1_I->D1_DOC
    D1FORNECEI  := SD1_I->D1_FORNECE
    D1_LOJAI := SD1_I->D1_LOJA
   SD1_I->(dbSkip())
Enddo
SD1_I->(dbCloseArea())
 
 endif
 
 if (nGPF <> 'ZZZZZZ' .and. !EMPTY(nGPF))
_cQuery2 := "SELECT D1_SERIE, D1_DOC, D1_FORNECE, D1_LOJA FROM "+RetsqlName("SD1") +" where D_E_L_E_T_ <>'*' and D1_PEDIDO='"+nGPF+"'"

dbUseArea(.T.,"TOPCONN",TCGENQRY(,,_cQuery2),"SD1_F",.F.,.T.)     

While (SD1_F->(!eof()))
    D1_SERIEF  := SD1_F->D1_SERIE
    D1_DOCF     := SD1_F->D1_DOC
    D1_FORNECEF  := SD1_F->D1_FORNECE
    D1_LOJAF := SD1_F->D1_LOJA
   SD1_F->(dbSkip())
Enddo
SD1_F->(dbCloseArea())
endif


_cFiltro := " ((E2_FORNECE>='"+nGFI+"' .and. E2_FORNECE<='"+nGFF+"') .and. (E2_VALOR>="+nGVI+" .and. E2_VALOR<="+REPLACE(nGVF,".","")+") "
_cFiltro += " .and. (E2_GCCONTC>='"+nG1I+"' .AND. E2_GCCONTC<='"+nG1F+"')"
_cFiltro += " .and. (E2_GCCONTV>='"+nGCI+"' .AND. E2_GCCONTV<='"+nGCF+"')"
_cFiltro += " .and. (E2_GCCONTS>='"+nG2I+"' .AND. E2_GCCONTS<='"+nG2F+"')"
_cFiltro += " .and. (E2_FORBCO>='"+nGBI+"' .AND. E2_FORBCO<='"+nGBI+"')"
_cFiltro += " .and. (E2_PREFIXO>='"+D1_SERIEI+"' .AND. E2_PREFIXO<='"+D1_SERIEF+"')"
_cFiltro += " .and. (E2_NUM>='"+D1_DOCI+"' .AND. E2_NUM<='"+D1_DOCF+"')"
_cFiltro += " .and. (E2_FORNECE>='"+D1FORNECEI+"' .AND. E2_FORNECE<='"+D1_FORNECEF+"')"
_cFiltro += " .and. (E2_LOJA>='"+D1_LOJAI+"' .AND. E2_LOJA<='"+D1_LOJAF+"')"
_cFiltro += " .and. (E2_GCCONTT>='"+nG3I+"' .AND. E2_GCCONTT<='"+nG3F+"'))"

Return _cFiltro
