*&---------------------------------------------------------------------*
*& Report ZBA_002_P_SCREEN_EXERCISE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBA_002_P_SCREEN_EXERCISE.

CONTROLS tb_strp TYPE TABSTRIP.

DATA gs_sflight TYPE sflight.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS:p_CARRID TYPE s_carr_id,
             p_CONNID TYPE s_conn_id,
             p_FLDATE TYPE s_date.
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.

  SELECT SINGLE * FROM sflight
      INTO gs_sflight
      WHERE carrid EQ p_CARRID
        AND connid EQ p_CONNID
        AND fldate EQ p_FLDATE.

    CALL SCREEN 0100.

MODULE status_0100 OUTPUT.
 SET PF-STATUS '0100'.
* SET TITLEBAR 'xxx'.
ENDMODULE.

MODULE user_command_0100 INPUT.

  CASE sy-ucomm.
    WHEN '&BACK'.
      SET SCREEN 0.   "or LEAVE TO SCREEN 0.
    WHEN '&OK'.
      LEAVE PROGRAM .
    WHEN '&TAB1'.
      tb_strp-activetab = '&TAB1'.
    WHEN '&TAB2'.
      tb_strp-activetab = '&TAB2'.

  ENDCASE.
ENDMODULE.
