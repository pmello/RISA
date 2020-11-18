#Include 'Protheus.ch'

//Este Ponto de Entrada, localizado no TMSA200(Cálculo de Frete), é executado após a gravação do Documento de Transporte (DT6)
//Está sendo utilizado para ajustar informações no Lote quando este for gerado de maneira incorreta pela rotina automática do painel de Agendamento

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ TMSAF76  ³ Autor ³ Marcelo Abreu      ³ Data ³ 13/11/2020  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Calculo de CTe no Painel de Agendamento                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGATMS                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function TM200DT6()

Local cFilDoc  := PARAMIXB[1]
Local cDocto   := PARAMIXB[2]
Local cSerie   := PARAMIXB[3]
Local cLote

If IsInCallStack('TMSAF76')

    DbSelectArea("DT6")
    DT6->(dbSetOrder(1))
    If DT6->(MsSeek(xFilial("DT6")+cFilDoc+cDocto+cSerie))
        cLote := DT6->DT6_LOTNFC

        DbSelectArea("DTP")
        DbSetOrder(2)
        If MsSeek(xFilial("DTP")+cFilDoc+cLote)

            If DTP->DTP_TIPLOT == '3'          // Altera o tipo do lote para Normal quando for gerado como Eletrônico "A Risa não utilizará Documentos eletrônicos no TMS"
                Reclock("DTP",.F.)
                DTP->DTP_TIPLOT  := '1'
                MsUnlock()
            Endif

                DbSelectArea("DTC")
                DbSetOrder(1)
                If MsSeek(xFilial("DTC")+cFilDoc+cLote)

                    If EMPTY(DTP->DTP_VIAGEM) .AND. !EMPTY(DTC->DTC_NUMSOL) // Grava o número da viagem no Lote para permitir o Carregamento do CTe
                        DbSelectArea("DUD")
                        DbSetOrder(1)
                        If MsSeek(xFilial("DUD")+cFilDoc+DTC->DTC_NUMSOL+"COL") .AND. !EMPTY(DUD->DUD_VIAGEM) .AND.  DUD->DUD_STATUS ='2'
                            DbSelectArea("DTQ")
                            DbSetOrder(2)
                            If MsSeek(xFilial("DTQ")+DUD->DUD_FILORI+DUD->DUD_VIAGEM) .AND. DTQ->DTQ_SERTMS == '3' .AND. DTQ->DTQ_STATUS $ '52'

                                Reclock("DTP",.F.)
                                DTP->DTP_VIAGEM  := DUD->DUD_VIAGEM
                                MsUnlock()

                            Endif

                        Endif
                    Endif
                Endif

         Endif
    Endif
Endif

Return Nil
