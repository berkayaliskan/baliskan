*&---------------------------------------------------------------------*
*& Report ZBA_001_P_SCREEN_TABSTRIP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zba_001_p_screen_tabstrip.

CONTROLS tb_id TYPE TABSTRIP.

START-OF-SELECTION.

  CALL SCREEN 0100.

MODULE status_0100 OUTPUT.
  SET PF-STATUS '0100'.
* SET TITLEBAR 'xxx'.
ENDMODULE.

MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN '&EXIT'.
      LEAVE PROGRAM.
    WHEN '&BACK'.
      SET SCREEN 0.   "or LEAVE TO SCREEN 0.
    WHEN '&TAB1'.
      tb_id-activetab = '&TAB1'.
    WHEN '&TAB2'.
      tb_id-activetab = '&TAB2'.
  ENDCASE.
ENDMODULE.
