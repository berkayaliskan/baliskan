*&---------------------------------------------------------------------*
*& Include          ZBA_005_I_ADOBEFRM_EXCELUPL_SS
*&---------------------------------------------------------------------*



SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_alv    RADIOBUTTON GROUP rgr1 DEFAULT 'X' USER-COMMAND a1,
              p_excupl RADIOBUTTON GROUP rgr1.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
  SELECT-OPTIONS: s_vbeln FOR lips-vbeln MODIF ID gr1,
                  s_posnr FOR lips-posnr MODIF ID gr1,
                  s_matnr FOR lips-matnr MODIF ID gr1,
                  s_kunnr FOR likp-kunnr MODIF ID gr1.
SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-003.
  PARAMETERS: p_file type localfile MODIF ID gr2.
SELECTION-SCREEN END OF BLOCK b3.

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.
    IF p_alv EQ abap_true.
      IF screen-group1 EQ 'GR1'.
        screen-active = 1.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 EQ 'GR2'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.
    IF p_excupl EQ abap_true.
      IF screen-group1 EQ 'GR1'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 EQ 'GR2'.
        screen-active = 1.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.
  ENDLOOP.
