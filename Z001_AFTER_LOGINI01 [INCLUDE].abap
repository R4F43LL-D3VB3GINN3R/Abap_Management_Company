*----------------------------------------------------------------------*
***INCLUDE Z001_AFTER_LOGINI01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  AFTER_LOGIN  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE AFTER_LOGIN INPUT.

   DATA: LV_OK2 TYPE BOOL. "VARIÁVEL DE VERIFICAÇÃO"
   LV_OK2 = 'FALSE'.       "A VARIÁVEL É INICIADA COMO FALSE."

  CALL FUNCTION 'ZLOGIN001'                   "INVOCA A FUNÇÃO DE VALIDAÇÃO DE CAMPOS E CREDENCIAIS."
    EXPORTING
      IN_LOGIN100          = IN_LOGIN100
      IN_PASSWORD100       = IN_PASSWORD100
      OKCODE100            = OKCODE100
    IMPORTING
      LV_OK                = LV_OK2
            .

    IF LV_OK2 EQ 'X'.    "SE A VARIÁVEL DE VERIFICAÇÃO FOR VERDADEIRA."
      CALL SCREEN '200'. "CHAMA A TELA DE MENU."
    ENDIF.

ENDMODULE.
