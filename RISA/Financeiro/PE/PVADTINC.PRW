#include "rwmake.ch"
/*
O ponto de entrada PVADTINC é utilizado para bloquear a opção de inclusão de adiantamento por 
meio da rotina do pedido de venda e pedido de compras.
*/
User Function PVADTINC()

Local lRet := .T. //Bloqueia a inclusão de PA ou RA

Return lRet
