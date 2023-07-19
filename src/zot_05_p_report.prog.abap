*&---------------------------------------------------------------------*
*& Report zot_05_p_report
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_05_p_report.

INCLUDE zot_05_i_report_topp.

INCLUDE zot_05_i_report_selc.

INCLUDE zot_05_i_report_cls.

INCLUDE zot_05_i_report_mdl.

INITIALIZATION.
  go_main = lcl_main_controller=>get_instance( ).


AT SELECTION-SCREEN OUTPUT.
  go_main->selscr_output( ).

AT SELECTION-SCREEN.
  go_main->selscr_input( ).

START-OF-SELECTION.
  IF p_sat EQ abap_true.
    go_main->get_data_sat( ).
  ELSEIF p_sas EQ abap_true.
    go_main->get_data_sas( ).
  ENDIF.

END-OF-SELECTION.
    IF p_sat EQ abap_true.
    go_main->display_grid_sat( ).
  ELSEIF p_sas EQ abap_true.
    go_main->display_grid_sas( ).
  ENDIF.
