#include "rwmake.ch"        

User Function SISPAGCC()  

// SISPAG - Posicaoes( 024 - 043 )
If !EMPTY(SA2->A2_BANCO)
    If SA2->A2_BANCO =="341"
        _Conta :="0"+STRZERO(VAL(SA2->A2_AGENCIA),4)+" "+"0000000"+STRZERO(VAL(SA2->A2_NUMCON),5)+" "+STRZERO(VAL(SA2->A2_DVCTA),1)
    else  
        If SA2->A2_BANCO !="341"
            _Conta := STRZERO(VAL(SA2->A2_AGENCIA),5)+" "+STRZERO(VAL(SA2->A2_NUMCON),12)+" "+SA2->A2_DVCTA
        Endif
    Endif
ELSE
    MSGALERT( "Aten��o", "Banco N�O informado no cadastro do Fornecedor: "+SA2->A2_COD+"-"+SA2->A2_LOJA+": "+SA2->A2_NOME )
    _Conta := "0ERRO"
    
ENDIF
Return(_Conta)
/*
Quando o banco favorecido for 341 (Banco Ita�) ou 409 (Unibanco) este campo dever� ser preenchido da seguinte forma:
   Nome do Campo
ZEROS BRANCOS CONTA
DAC
Significado
COMPLEMENTO DE REGISTRO COMPLEMENTO DE REGISTRO N�MERO DE C/C CREDITADA
DAC DA AG�NCIA/CONTA CREDITADA
Posi��o
024 024
029 029
036 041
043 043
Picture Conte�do
9(01) x(01) 9(06) 9(01)
     
AG�NCIA
N�MERO AG�NCIA CREDITADA
025 028 9(04)
ZEROS
COMPLEMENTO DE REGISTRO
030 035 9(06)
BRANCOS
COMPLEMENTO DE REGISTRO
042 042 X(01)
 Os campos Conta e DAC devem ser preenchidos com zeros quando a forma de pagamento for 02 ou 10 (cheque ou Ordem de Pagamento), porque neste caso a OP ou o cheque ficar�o � disposi��o do favorecido na ag�ncia indicada.
b) Quando o banco favorecido n�o for 341 ou 409 (portanto as formas de pagamento s�o 03-DOC C, 07- DOC D, 41-TED/outro titular e 43-TED/mesmo titular) os campos dever�o ser preenchidos da seguinte forma:
     Nome do Campo
Ag�ncia
Significado
N�mero ag�ncia CREDITADA
Posi��o
024 028
Picture
9(05)
Conte�do
     
brancos
Complemento de registro 029 029 X(01)
Novembro 2018
SISPAG Febraban 240
44
Conta N�mero de C/C CREDITADA 030 041 9(12) 042 X(01) DAC DAC DA AG�NCIA/Conta CREDITADA 043 043 X(01)
*/