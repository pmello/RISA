#include "rwmake.ch"
/*
O ponto de entrada PVADTINC � utilizado para bloquear a op��o de inclus�o de adiantamento por 
meio da rotina do pedido de venda e pedido de compras.
*/
User Function PVADTINC()

Local lRet := .F. //Bloqueia a inclus�o de PA ou RA

Return lRet
