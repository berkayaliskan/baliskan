*&---------------------------------------------------------------------*
*& Report ZBA_001_P_SCREEN_MDL_DIALOG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBA_001_P_SCREEN_MDL_DIALOG.

CALL SCREEN 0100 STARTING AT 10 10
                   ENDING AT 40 15.

MODULE status_0100 OUTPUT.
 SET PF-STATUS '0100'.
* SET TITLEBAR 'xxx'.
ENDMODULE.

MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN '&CANCEL'.
      LEAVE TO SCREEN 0.
  ENDCASE.

ENDMODULE.
