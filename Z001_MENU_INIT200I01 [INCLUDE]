*----------------------------------------------------------------------*
***INCLUDE Z001_MENU_INIT200I01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  MENU_INIT200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE MENU_INIT200 INPUT.

  CASE OKCODE200.             "CASO A VARIÁVEL DE FUNÇÃO DE TELA SEJA..."
    WHEN 'FCT_INSERTMENU200'. "QUANDO O BOTÃO DE INSERIR FUNCIONÁRIO FOR APERTADO."
      CALL SCREEN '300'.      "CHAMA A TELA DE CADASTRO DE FUNCIONÁRIOS."
    WHEN 'FCT_PAYROLL200'.    "QUANDO O BOTÃO DE EMITIR PAGAMENTOS FOR APERTADO."
      CALL SCREEN '400'.      "CHAMA A TELA DE EMISSÃO DE PAGAMENTOS."
    WHEN 'FCT_EXIT200'.       "QUANDO O BOTÃO DE EXIT FOR APERTADO."
      LEAVE PROGRAM.          "ENCERRA O PROGRAMA."
  ENDCASE.

ENDMODULE.
