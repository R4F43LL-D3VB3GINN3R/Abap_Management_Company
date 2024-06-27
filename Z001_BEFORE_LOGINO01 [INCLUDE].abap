*----------------------------------------------------------------------*
***INCLUDE Z001_BEFORE_LOGINO01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module BEFORE_LOGIN OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE BEFORE_LOGIN OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.

"ENTRIES DE VALIDAÇÃO PARA A TELA PRINCIPAL DE LOGIN."
  DATA: IN_LOGIN100     TYPE C LENGTH 20, "ENTRY DE LOGIN."
        IN_PASSWORD100  TYPE C LENGTH 20. "ENTRY DE PASSWORD."

ENDMODULE.
