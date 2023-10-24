*&---------------------------------------------------------------------*
*& Report ZBA_001_P_SCREEN_SLCT_SCRN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zba_001_p_screen_slct_scrn.

*PARAMETERS: p_num1 TYPE int4 MODIF ID gr1,
*            p_num2 TYPE int4 MODIF ID gr1,
*            p_num3 TYPE int4 MODIF ID gr2,
*            p_num4 TYPE int4 MODIF ID gr2.
*
*INITIALIZATION.
*  LOOP AT SCREEN.
*    IF screen-group1 EQ 'GR1'.
*      screen-display_3d = 1.
*      MODIFY SCREEN.
*    ENDIF.
*    IF screen-group1 EQ 'GR2'.
*      screen-input = 0.
*      MODIFY SCREEN.
*    ENDIF.
*  ENDLOOP.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_rad1 RADIOBUTTON GROUP rgr1 DEFAULT 'X' USER-COMMAND a1,
              p_rad2 RADIOBUTTON GROUP rgr1.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
  PARAMETERS: p_LIFNR  TYPE lifnr    MODIF ID gr1 DEFAULT 'GS',
              p_LIFNRN TYPE name1_gp MODIF ID gr1,
              p_KUNNR  TYPE kunnr    MODIF ID gr2 DEFAULT 'GC',
              p_KUNNRN TYPE name1_gp MODIF ID gr2.
SELECTION-SCREEN END OF BLOCK b2.

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.
    IF p_rad1 EQ abap_true.
      IF screen-group1 EQ 'GR1'.
        screen-active = 1.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 EQ 'GR2'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.
    IF p_rad2 EQ abap_true.
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
