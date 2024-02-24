*----------------------------------------------------------------------*
***INCLUDE Z001_AFTER_PAYROLLI01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  AFTER_PAYROLL  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE AFTER_PAYROLL INPUT.

  CASE OKCODE400.                                                                    "CASO VARIÁVEL DE FUNÇÃO DE SISTEMA SEJA...
    WHEN 'FCT_FIND400'.                                                              "QUANDO FOR ENCONTRAR...
      SELECT SINGLE SALARY FROM ZEMPLOYEES001 INTO IN_SALARY400 WHERE ID = IN_ID400. "SELECIONA APENAS A COLUNA SALÁRIO DA TABELA TRANSPARENTE E INSIRA NA ENTRY ONDE O ID DA TABELA FOR IGUAL AO ID DA ENTRY.
    WHEN 'FCT_REFRESH400'.                                                           "QUANDO FOR REFRESH...
      CREATE OBJECT LO_CL_EMPLOYEES.                                                 "CRIA UM OBJETO DE CLASSE...

      LO_CL_EMPLOYEES->WORK_SHIFT(                        "INVOCA O MÉTODO PARA CALCULAR O BONUS NOTURNO."
                        EXPORTING
                          LV_SAL    = IN_SALARY400
                          WORKSHIFT = IN_WORKSHIFT400
                        IMPORTING
                          BONUS     = IN_BONUS400 ).

      LO_CL_EMPLOYEES->EXTRAHOURS(                        "INVOCA O MÉTODO PARA CÁLCULO DE HORAS EXTRAS."
                        EXPORTING
                          LV_SAL    = IN_SALARY400
                          EXTRAHOUR = IN_EXTRAHOUR400
                          WORKSHIFT = IN_WORKSHIFT400
                        IMPORTING
                          BRUTESAL  = IN_BRUTESAL400 ).

      LO_CL_EMPLOYEES->HOLYDAYS_SUB(                      "INVOCA O MÉTODO PARA CALCULAR SUBSÍDIO DÉCIMO E FÉRIAS."
                        EXPORTING
                          BRUTESAL    = IN_BRUTESAL400
                          LV_SAL      = IN_SALARY400
                          SUBHOLYDAYS = CB_SUBHOLYDAYS400
                        IMPORTING
                          LIQSAL      = IN_LIQSAL400 ).

      LO_CL_EMPLOYEES->SERVICES(                           "INVOCA O MÉTODO PARA CALCULAR OS SERVIÇOS ESCOLHIDOS PELO FUNCIONÁRIO."
                        EXPORTING
                          HEALTHPLAN = CB_HEALTHPLAN400
                          SINDICAL   = CB_SINDICAL400
                          TRANSPORT  = CB_TRANSPORT400
                          LV_SAL     = IN_SALARY400
                        IMPORTING
                          DEDUCTIONS = IN_DEDUCTIONS400
                          BONUS      = IN_BONUS400 ).

      LO_CL_EMPLOYEES->GOVERNAMENTAL_CONTRIBUTIONS(         "INVOCA O MÉTODO PARA CALCULAR OS IMPOSTOS TRIBUTÁRIOS."
                        EXPORTING
                          LV_SAL     = IN_SALARY400
                        IMPORTING
                          DEDUCTIONS = IN_DEDUCTIONS400
                          SECSOCIAL  = IN_SECSOCIAL400
                          IRS        = IN_IRS400 ).

      LO_CL_EMPLOYEES->EMPLOYEE_OUT(                        "INVOCA O MÉTODO PARA CALCULAR AS HORAS PENDENTES."
                        EXPORTING
                          NOPAYLEAVE = IN_NOPAYLEAVE400
                          LV_SAL     = IN_SALARY400
                        IMPORTING
                          DEDUCTIONS = IN_DEDUCTIONS400 ).

      LO_CL_EMPLOYEES->CALCULATE_SAL(                       "INVOCA O MÉTODO PARA CALCULAR O SALÁRIO LÍQUIDO."
                        EXPORTING
                          BRUTESAL   = IN_BRUTESAL400
                          DEDUCTIONS = IN_DEDUCTIONS400
                          BONUS      = IN_BONUS400
                        IMPORTING
                          LIQSAL     = IN_LIQSAL400 ).

      IF SY-SUBRC = 0 AND IN_LIQSAL400 >= 700. "SE A INSTRUÇÃO FOI EXECUTADA COM SUCESSO E O SALÁRIO LÍQUIDO FOR MAIOR OU IGUAL A 700...
        LV_REFRESH_DONE = 'X'.                 "A FLAG RECEBE TRUE."
      ELSE.                                    "DO CONTRÁRIO..."
        LV_REFRESH_DONE = ''.                  "A FLAG CONTINUA RECEBENDO FALSE."
      ENDIF.                                   "ENCERRA A CONDIÇÃO."

    WHEN 'FCT_GENERATE400'.                                        "QUANDO FOR GERAR O PAGAMENTO."

      IF LV_REFRESH_DONE EQ 'X'.                                   "SE A MINHA FLAG ESTIVER RECEBENDO TRUE...

        DATA: LS_EMP400   TYPE ZPAYROLL,                           "ESTRUTURA LOCAL DA TABELA TRANSPARENTE."
              LS_EMP400_2 TYPE ZEMPLOYEES001,                      "ESTRUTURA LOCAL DA TABELA TRANSPARENTE."
              LT_EMP400_2 TYPE TABLE OF ZEMPLOYEES001,             "TABELA INTERNA DA TABELA TRANSPARENTE."
              LT_EMP400   TYPE TABLE OF ZPAYROLL,                  "TABELA INTERNA DA TABELA TRANSPARENTE."
              LV_PAYMENT  TYPE ZPAYMENT.                           "VARIÁVEL LOCAL."

        LV_PAYMENT = 'OK'.                                         "STATUS DE PAGAMENTO RECEBE OK."

        SELECT * FROM ZPAYROLL INTO TABLE LT_EMP400.               "INSIRA TODOS OS DADOS DA TABELA TRANSPARENTE NA TABELA INTERNA."
        SELECT * FROM ZEMPLOYEES001 INTO TABLE LT_EMP400_2.        "INSIRA TODOS OS DADOS DA TABELA TRANSPARENTE NA TABELA INTERNA."

        LS_EMP400-ID          = IN_ID400.                          "ESTRUTURA LOCAL PREENCHIDA COM O VALOR RECEBIDOS DAS ENTRIES."
        LS_EMP400-BRUTESAL    = IN_BRUTESAL400.
        LS_EMP400-LIQSAL      = IN_LIQSAL400.
        LS_EMP400-HEALTHPLAN  = CB_HEALTHPLAN400.
        LS_EMP400-SINDICAL    = CB_SINDICAL400.
        LS_EMP400-TRANSPORT   = CB_TRANSPORT400.
        LS_EMP400-EXTRAHOUR   = IN_EXTRAHOUR400.
        LS_EMP400-DEDUCTIONS  = IN_DEDUCTIONS400.
        LS_EMP400-SECSOCIAL   = IN_SECSOCIAL400.
        LS_EMP400-IRS         = IN_IRS400.
        LS_EMP400-BONUS       = IN_BONUS400.
        LS_EMP400-SUBHOLYDAYS = CB_SUBHOLYDAYS400.
        LS_EMP400-NOPAYLEAVE  = IN_NOPAYLEAVE400.
        LS_EMP400-WORKSHIFT   = IN_WORKSHIFT400.

        APPEND LS_EMP400 TO LT_EMP400.                                      "INSERE A ESTRUTURA NUMA TABELA INTERNA."
        MODIFY ZPAYROLL FROM TABLE LT_EMP400.                               "MODIFICA A TABELA TRANSPARENTE A PARTIR DA TABELA INTERNA ATUALIZADA."
        UPDATE ZEMPLOYEES001 SET PAYMENT = LV_PAYMENT WHERE ID = IN_ID400.  "ATUALIZA O STATUS DE PAGAMENTO NA OUTRA TABELA TRANSPARENTE."
        UPDATE ZEMPLOYEES001 SET ID_PAYROLL = IN_ID400 WHERE ID = IN_ID400. "VINCULA A CHAVE ESTRANGEIRA À CHAVE DA TABELA DE PAGAMENTO."

        MESSAGE |'PAYMENT GENERATED | TYPE 'S' DISPLAY LIKE 'I'.

      ELSE.                                                                 "DO CONTRÁRIO...
        MESSAGE |'NO DATA TO GENERATE PAYMENT | TYPE 'S' DISPLAY LIKE 'I'.  "EXIBE MENSAGEM."
      ENDIF.                                                                "ENCERRA A CONDIÇÃO."

    WHEN 'FCT_CLEAR400'. "QUANDO APERTAR O BOTÃO CLEAR...

      CLEAR: IN_ID400,        "LIMPA TODAS AS ENTRIES."
             IN_BRUTESAL400,
             IN_LIQSAL400,
             CB_HEALTHPLAN400,
             CB_SINDICAL400,
             CB_TRANSPORT400,
             IN_EXTRAHOUR400,
             IN_DEDUCTIONS400,
             IN_SECSOCIAL400,
             IN_IRS400,
             IN_BONUS400,
             CB_SUBHOLYDAYS400,
             IN_NOPAYLEAVE400,
             IN_WORKSHIFT400.

      LV_REFRESH_DONE = ''.    "REDEFINE A FLAG COMO FALSE."

      WHEN 'FCT_DISPLAY400'. "QUANDO APERTAR O BOTÃO DE EXIBIR RELATÓRIO."

        DATA: LT_DISPLAY TYPE TABLE OF ZPAYROLL. "DEFINE TABELA INTERNA."

        SELECT * FROM ZPAYROLL INTO TABLE LT_DISPLAY. "TABELA INTERNA É PREENCHIDA."

        DATA: REPORTALV2 TYPE REF TO CL_SALV_TABLE,     "VARIÁVEL QUE FAZ REFERÊNCIA AO OBJETO DA CLASSE CL_SALV_TABLE."
              FUNCTIONS2 TYPE REF TO CL_SALV_FUNCTIONS. "VARIÁVEL QUE VAI ARMAZENAR A REFERÊNCIA AO OBJETO DA CLASSE CL_SALV_FUNCTIONS."

         TRY.                                                               "TENTE
          CALL METHOD CL_SALV_TABLE=>FACTORY                                "CHAMADA DO MÉTODO DA CLASSE DE MANIPULAÇÃOO ALV PARA EXIBIR O RELATÓRIO."
            IMPORTING
              R_SALV_TABLE = REPORTALV                                      "A VARIÁVEL DE REFERÊNCIA À CLASSE CL_SALV_TABLE É IMPORTADA."
            CHANGING
              T_TABLE      = LT_DISPLAY.                                    "MINHA TABELA INTERNA É ALTERADA COM A CLÁUSULA CHANGING DO MÉTODO."

          FUNCTIONS = REPORTALV->GET_FUNCTIONS( ).                          "OBTER AS FUNÇÕES DISPONÍVEIS PARA O RELATÓRIO ALV."
          FUNCTIONS->SET_ALL( ABAP_TRUE ).                                  "QUE TODAS AS FUNÇÕES ESTEJAM DISPONÍVEIS."

          CALL METHOD REPORTALV->DISPLAY( ).                                "CHAMADA DO MÉTODO PARA EXIBIR O RELATÓRIO ALV."
        CATCH CX_SALV_MSG.                                                  "CASO HAJA ALGUM PROBLEMA, SUBSTITUA O TRECHO ANTERIOR DO CÓDIGO POR...
          MESSAGE 'ERROR TO DISPLAY ALV REPORT!' TYPE 'S' DISPLAY LIKE 'I'. "...UMA MENSAGEM DE ERRO"
      ENDTRY.

    WHEN 'FCT_BACK400'.  "QUANDO APERTAR O BOTÃO DE VOLTAR...
      CALL SCREEN '200'. "VAI PARA A TELA 200."
    WHEN 'FCT_EXIT400'.  "QUANDO APERTAR O BOTÃO DE SAIR...
      LEAVE PROGRAM.     "ENCERRA O PROGRAMA."
   ENDCASE.              "ENCERRA A CONDIÇÃO."

ENDMODULE.
