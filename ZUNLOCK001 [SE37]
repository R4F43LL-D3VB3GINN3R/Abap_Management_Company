DATA: LV_ATTEMPTS2 TYPE I. "VARIÁVEL GLOBAL DE CONTADOR."

FUNCTION ZUNLOCK001.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IN_LOGIN101) TYPE  ZLOGIN_100
*"     REFERENCE(IN_PASSWORD101) TYPE  ZPASSWORD_100
*"     REFERENCE(OKCODE101) TYPE  SY-UCOMM
*"  EXPORTING
*"     REFERENCE(LV_OK) TYPE  BOOL
*"----------------------------------------------------------------------

CASE OKCODE101.                                                                          "CASO A FUNÇÃO SEJA EXECUTADA...
    WHEN 'FCT_EXIT101'.                                                                  "QUANDO ESSA FUNÇÃO FOR FCT_EXIT100...
      LEAVE PROGRAM.                                                                     "ENCERRA O PROGRAMA."
    WHEN 'FCT_BACK101'.                                                                  "CASO A FUNÇÃO SEJA EXECUTADA...
      LEAVE TO SCREEN '0'.                                                               "fECHA A TELA ATUAL E VOLTA A ANTERIOR.   
    WHEN 'FCT_UNLOCK101'.                                                                "QUANDO ESSA FUNÇÃO FOR FCT_LOGIN100...

      CALL FUNCTION 'ZVERIFY_CREDENTIALS001'                                             "INVOCA A FUNÇÃO DE VERIFICAÇÃO DE CREDENCIAIS.
        EXPORTING
          IN_LOGIN100          = IN_LOGIN101
          IN_PASSWORD100       = IN_PASSWORD101
        IMPORTING
          OK                   = LV_OK.

      IF LV_OK = 'X'.                                                                    "SE A BOLEANA FOR TRUE.
        MESSAGE |'WELCOME | TYPE 'S' DISPLAY LIKE 'I'.                                   "EXIBE A MENSAGEM.
      ELSE.                                                                              "DO CONTRÁRIO.
        IF IN_LOGIN101 EQ 'ADMIN' AND IN_PASSWORD101 NE '123'.                           "OU SE O LOGIN ESTIVER CORRETO E O PASSWORD ESTIVER ERRADO...
          LV_ATTEMPTS2 = LV_ATTEMPTS2 + 1.                                               "INCREMENTA O CONTADOR.
          MESSAGE |'INVALID PASSWORD: { 0 + LV_ATTEMPTS2 }| TYPE 'S' DISPLAY LIKE 'I'.   "EXIBE MENSAGEM.
        ELSEIF IN_LOGIN101 NE 'ADMIN' AND IN_PASSWORD101 EQ '123'.                       "OU SE O LOGIN ESTIVER ERRADO E O PASSWORD ESTIVER CORRETO...
          LV_ATTEMPTS2 = LV_ATTEMPTS2 + 1.                                               "INCREMENTA O CONTADOR.
          MESSAGE |'INVALID LOGIN: { 0 + LV_ATTEMPTS2 }| TYPE 'S' DISPLAY LIKE 'I'.      "EXIBE MENSAGEM.
        ELSEIF IN_LOGIN101 IS INITIAL AND IN_PASSWORD101 IS INITIAL.                     "OU SE OS CAMPOS ESTIVEREM VAZIOS...
          LV_ATTEMPTS2 = LV_ATTEMPTS2 + 1.                                               "INCREMENTA O CONTADOR.
          MESSAGE |'FILL ENTRIES: { 0 + LV_ATTEMPTS2 }| TYPE 'S' DISPLAY LIKE 'I'.       "EXIBE MENSAGEM.
        ELSEIF IN_LOGIN101 IS INITIAL.                                                   "OU SE APENAS O LOGIN ESTIVER VAZIO...
          LV_ATTEMPTS2 = LV_ATTEMPTS2 + 1.                                               "INCREMENTA O CONTADOR.
          MESSAGE |'FILL LOGIN ENTRY: { 0 + LV_ATTEMPTS2 }| TYPE 'S' DISPLAY LIKE 'I'.   "EXIBE A MENSAGEM.
        ELSEIF IN_PASSWORD101 IS INITIAL.                                                "OU SE APENAS O PASSWORD ESTIVER VAZIO...
          LV_ATTEMPTS2 = LV_ATTEMPTS2 + 1.                                               "INCREMENTA O CONTADOR.
          MESSAGE |'FILL PASSWORD ENTRY: { 0 + LV_ATTEMPTS2 }| TYPE 'S' DISPLAY LIKE 'I'."EXIBE MENSAGEM.
        ELSE.                                                                            "DO CONTRÁRIO...
          LV_ATTEMPTS2 = LV_ATTEMPTS2 + 1.                                               "INCREMENTA O CONTADOR.
          MESSAGE |'INVALID DATA LOGIN: { 0 + LV_ATTEMPTS2 }| TYPE 'S' DISPLAY LIKE 'I'. "EXIBE MENSAGEM.
        ENDIF.                                                                           "ENCERRA CONDIÇÃO.

      IF LV_ATTEMPTS2 EQ 3.                                                              "SE O CONTADOR FOR IGUAL A 3...
        LEAVE PROGRAM.                                                                   "ENCERRA O PROGRAMA.
      ENDIF.                                                                             "ENCERRA A CONDIÇÃO.
       ENDIF.                                                                            "ENCERRA A CONDIÇÃO.
  ENDCASE.                                                                               "ENCERRA A CONDIÇÃO.

ENDFUNCTION.
