*&---------------------------------------------------------------------*
*& Include zot_05_i_report_cls
*&---------------------------------------------------------------------*
CLASS lcl_main_controller DEFINITION CREATE PRIVATE FINAL.
  PUBLIC SECTION.

    CLASS-METHODS:
      "! Main controller get singleton object
      get_instance
        RETURNING
          VALUE(ro_instance) TYPE REF TO lcl_main_controller.

    METHODS:
      "! Selection screen output event
      selscr_output,
      "! Selection screen input event
      selscr_input,
      "! Get report data
      get_data_sat,
      get_data_sas,
      "! Display report
      display_grid_sat,
      display_grid_sas,
      select_file,
      init_0100,
      free.

  PRIVATE SECTION.
    CLASS-DATA:
      "! Singleton object
      mo_instance              TYPE REF TO lcl_main_controller,
      "! ALV List
      mt_alv_list              TYPE TABLE OF zot_05_s_sat,
      mt_alv_list_sas          TYPE TABLE OF zot_05_s_sas,
      "! Main custom container
      mo_main_custom_container TYPE REF TO cl_gui_custom_container,
      "! Main ALV grid
      mo_main_grid             TYPE REF TO cl_gui_alv_grid.

    METHODS:
      fill_main_fieldcat
        RETURNING
          VALUE(rt_fcat) TYPE lvc_t_fcat,
      fill_main_fieldcat_sas
        RETURNING
          VALUE(rt_fcat) TYPE lvc_t_fcat,
      fill_main_layout
        RETURNING
          VALUE(rs_layo) TYPE lvc_s_layo.

ENDCLASS.

CLASS lcl_main_controller IMPLEMENTATION.
  METHOD get_instance.
    IF mo_instance IS INITIAL.
      mo_instance = NEW #( ).
    ENDIF.
    ro_instance = mo_instance.
  ENDMETHOD.

  METHOD selscr_output.
*    CONCATENATE '@J2@' TEXT-003 INTO down_exc SEPARATED BY space.
*    CONCATENATE '@DI@' TEXT-004 INTO maint  SEPARATED BY space.
*    CONCATENATE '@QH@' TEXT-005 INTO report  SEPARATED BY space.

  LOOP AT SCREEN.

      screen-active = COND #( WHEN p_sat EQ abap_true THEN SWITCH #( screen-group1 WHEN 'M2' THEN 0 )
                              WHEN p_sas EQ abap_true THEN SWITCH #( screen-group1 WHEN 'M1' THEN 0 ) ).
      MODIFY SCREEN.
    ENDLOOP.

*LOOP AT SCREEN .
**    CASE 'X'.
**      WHEN p_sat.
**        IF screen-group1 = 'M1'.
**          screen-input     =  1.
**          screen-invisible =  0.
**        ELSEIF screen-group1 = 'M2'.
**          screen-input     =  0.
**          screen-invisible =  1.
**        ENDIF..
**      WHEN p_sas.
**        IF screen-group1 = 'M2'.
**          screen-input     =  1.
**          screen-invisible =  0.
**        ELSEIF screen-group1 = 'M1'.
**          screen-input     =  0.
**          screen-invisible =  1.
**        ENDIF.
**    ENDCASE.
**    MODIFY SCREEN.
*  ENDLOOP.
  ENDMETHOD.

  METHOD selscr_input.
*    IF sy-ucomm = 'MAINT'.
**      go_main->mainttenance_tables( ).
*    ELSEIF sy-ucomm = 'DOWN_EXC'.
**      go_main->crt_excl_template( ).
*    ELSEIF sy-ucomm = 'REPORT'.
**      go_main->call_log_report( ).
*    ENDIF.

*    IF s_matnr-low IS NOT INITIAL.
*      APPEND VALUE #( SIGN = 'I' OPTION = 'EQ' LOW = 'B001' ) TO s_matkl.
*    ENDIF.

  ENDMETHOD.

  METHOD get_data_sat.

    SELECT eb~banfn,
           eb~bnfpo,
           eb~bsart,
           eb~matnr,
           eb~menge,
           eb~meins
    FROM eban AS eb
    INNER JOIN ekpo AS ek ON eb~banfn EQ ek~banfn
                                          AND eb~bnfpo EQ ek~bnfpo
    INTO CORRESPONDING FIELDS OF TABLE @me->mt_alv_list
    WHERE eb~banfn IN @s_banfn AND eb~bsart IN @s_bsart.


    LOOP AT me->mt_alv_list ASSIGNING FIELD-SYMBOL(<Ls_list>).
      IF <Ls_list>-menge > 10 .
        <Ls_list>-color = 'C510'.
      ELSE.
      ENDIF..
    ENDLOOP.

  ENDMETHOD.

  METHOD get_data_sas.

    SELECT ek~ebeln,
           ek~ebelp,
           ek~matnr,
           ek~menge,
           ek~meins
    FROM ekpo AS ek
    INNER JOIN eban AS eb ON eb~banfn EQ ek~banfn
                                          AND eb~bnfpo EQ ek~bnfpo
    INTO CORRESPONDING FIELDS OF TABLE @me->mt_alv_list_sas
    WHERE ek~ebeln IN @s_ebeln AND ek~matkl IN @s_matkl.


    LOOP AT me->mt_alv_list_sas ASSIGNING FIELD-SYMBOL(<Ls_list>).
      IF <Ls_list>-menge > 10 .
        <Ls_list>-color = 'C510'.
      ELSE.
      ENDIF..
    ENDLOOP.

  ENDMETHOD.


  METHOD display_grid_sat.

    DATA: lv_title TYPE lvc_title,
          lv_lines TYPE num10.

    FIELD-SYMBOLS: <lt_data> TYPE STANDARD TABLE,
                   <ls_data> TYPE any.

    ASSIGN me->mt_alv_list TO <lt_data>.
    CHECK sy-subrc IS INITIAL.
*
    DATA(ls_layo) = VALUE lvc_s_layo( zebra      = abap_true
                                      cwidth_opt = abap_true
*                                      sel_mode   = 'A'
*                                      excp_fname = 'COLOR'
                                      info_fname = 'COLOR'
                                      excp_led   = abap_true ).
    DATA(ls_vari) = VALUE disvariant( report = sy-repid
                                      username = sy-uname ).

    DATA(lt_fcat_main) = me->fill_main_fieldcat( ).

    DESCRIBE TABLE <lt_data> LINES lv_lines.
    SHIFT lv_lines LEFT DELETING LEADING '0'.

    CONCATENATE 'Rapor-SAT' sy-uname sy-datum sy-uzeit INTO lv_title SEPARATED BY space.

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
      EXPORTING
        i_callback_program = sy-repid
        i_grid_title       = lv_title
        is_layout_lvc      = ls_layo
        it_fieldcat_lvc    = lt_fcat_main
        i_save             = 'A'
        is_variant         = ls_vari
      TABLES
        t_outtab           = <lt_data>
      EXCEPTIONS
        program_error      = 1
        OTHERS             = 2.
    IF sy-subrc IS NOT INITIAL.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.


  ENDMETHOD.

  METHOD display_grid_sas.

    DATA: lv_title TYPE lvc_title,
          lv_lines TYPE num10.

    FIELD-SYMBOLS: <lt_data> TYPE STANDARD TABLE,
                   <ls_data> TYPE any.

    ASSIGN me->mt_alv_list_sas TO <lt_data>.
    CHECK sy-subrc IS INITIAL.
*
    DATA(ls_layo) = VALUE lvc_s_layo( zebra      = abap_true
                                      cwidth_opt = abap_true
*                                      sel_mode   = 'A'
*                                      excp_fname = 'COLOR'
                                      info_fname = 'COLOR'
                                      excp_led   = abap_true ).
    DATA(ls_vari) = VALUE disvariant( report = sy-repid
                                      username = sy-uname ).

    DATA(lt_fcat_main) = me->fill_main_fieldcat_sas( ).

    DESCRIBE TABLE <lt_data> LINES lv_lines.
    SHIFT lv_lines LEFT DELETING LEADING '0'.

    CONCATENATE 'Rapor-SAS' sy-uname sy-datum sy-uzeit INTO lv_title SEPARATED BY space.

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
      EXPORTING
        i_callback_program = sy-repid
        i_grid_title       = lv_title
        is_layout_lvc      = ls_layo
        it_fieldcat_lvc    = lt_fcat_main
        i_save             = 'A'
        is_variant         = ls_vari
      TABLES
        t_outtab           = <lt_data>
      EXCEPTIONS
        program_error      = 1
        OTHERS             = 2.
    IF sy-subrc IS NOT INITIAL.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.


  ENDMETHOD.

  METHOD init_0100.
    IF me->mo_main_custom_container IS INITIAL.
      me->mo_main_custom_container = NEW cl_gui_custom_container( container_name = 'CC_MAIN' ).
      me->mo_main_grid = NEW cl_gui_alv_grid( i_parent = me->mo_main_custom_container i_appl_events = abap_true ).

      FIELD-SYMBOLS <lt_data> TYPE STANDARD TABLE.
      ASSIGN me->mt_alv_list TO <lt_data>.

      DATA(ls_vari) = VALUE disvariant( report = sy-repid
                                        username = sy-uname ).

*      me->set_handler_for_main( ).

      DATA(lt_fcat_main) = me->fill_main_fieldcat( ).

      me->mo_main_grid->set_table_for_first_display(
        EXPORTING
          i_bypassing_buffer            = abap_true
          is_variant                    = ls_vari
          i_save                        = 'A'
          is_layout                     = me->fill_main_layout( )
        CHANGING
          it_outtab                     = <lt_data>
          it_fieldcatalog               = lt_fcat_main
        EXCEPTIONS
          invalid_parameter_combination = 1
          program_error                 = 2
          too_many_lines                = 3
          OTHERS                        = 4
      ).
      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                   WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.
    ELSE.
      me->mo_main_grid->refresh_table_display( is_stable = VALUE #( col = abap_true row = abap_true ) ).
    ENDIF.
  ENDMETHOD.

  METHOD fill_main_fieldcat.
    DATA: lv_fname  TYPE lvc_fname,
          lv_offset TYPE i.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'ZOT_05_S_SAT'
        i_bypassing_buffer     = abap_true
      CHANGING
        ct_fieldcat            = rt_fcat
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        OTHERS                 = 3.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    LOOP AT rt_fcat ASSIGNING FIELD-SYMBOL(<ls_fcat>).
      CASE <ls_fcat>-fieldname.
        WHEN 'COLOR'.
          <ls_fcat>-no_out = abap_true.
*          <ls_fcat>-hotspot = abap_true.
*        WHEN 'MATKL'.
*          <ls_fcat>-edit = abap_true.
*        WHEN 'MATNR'.
*          <ls_fcat>-scrtext_l =
*          <ls_fcat>-scrtext_M =
*          <ls_fcat>-scrtext_S =
*          <ls_fcat>-reptext = 'DENEMEEE'.
*
*          <ls_fcat>-hotspot = abap_true.
      ENDCASE.
    ENDLOOP.

  ENDMETHOD.

  METHOD fill_main_fieldcat_sas.
    DATA: lv_fname  TYPE lvc_fname,
          lv_offset TYPE i.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'ZOT_05_S_SAS'
        i_bypassing_buffer     = abap_true
      CHANGING
        ct_fieldcat            = rt_fcat
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        OTHERS                 = 3.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

  ENDMETHOD.

  METHOD fill_main_layout.
    rs_layo = VALUE lvc_s_layo( zebra = abap_true cwidth_opt = abap_true sel_mode = 'A' ).
  ENDMETHOD.


  METHOD free.
    IF me->mo_main_custom_container IS NOT INITIAL.
      me->mo_main_grid->free( ).
      me->mo_main_custom_container->free( ).
      CLEAR: me->mo_main_grid,
             me->mo_main_custom_container.
    ENDIF.
    FREE mo_instance.
    CLEAR mo_instance.
  ENDMETHOD.

  METHOD select_file.
*    DATA: lt_file  TYPE filetable,
*          lv_rc    TYPE i,
*          lv_title TYPE string.
*
*    lv_title = TEXT-006.
*
*    CALL METHOD cl_gui_frontend_services=>file_open_dialog
*      EXPORTING
*        window_title            = lv_title
*      CHANGING
*        file_table              = lt_file
*        rc                      = lv_rc
*      EXCEPTIONS
*        file_open_dialog_failed = 1
*        cntl_error              = 2
*        error_no_gui            = 3
*        not_supported_by_gui    = 4
*        OTHERS                  = 5.
*    IF sy-subrc = 0.
*      p_file = VALUE #( lt_file[ 1 ]-filename OPTIONAL ).
*    ELSE.
*      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
*    ENDIF.
  ENDMETHOD.
ENDCLASS.


DATA:
  "! Main controller global object
  go_main TYPE REF TO lcl_main_controller.
