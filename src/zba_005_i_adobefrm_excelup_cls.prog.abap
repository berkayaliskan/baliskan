*&---------------------------------------------------------------------*
*& Include          ZBA_005_I_ADOBEFRM_EXCELUPL_CLS
*&---------------------------------------------------------------------*

CLASS lcl_main DEFINITION.

  PUBLIC SECTION.
    TYPES: BEGIN OF gty_alv,
             kunnr     TYPE likp-kunnr,
             vbeln     TYPE lips-vbeln,
             posnr     TYPE lips-posnr,
             pstyv     TYPE lips-pstyv,
             ernam     TYPE lips-ernam,
             wadat_ist TYPE likp-wadat_ist,
             matnr     TYPE lips-matnr,
             ntgew     TYPE lips-ntgew,
             gewei     TYPE lips-gewei,
           END OF gty_alv.

    DATA: gt_alv TYPE STANDARD TABLE OF gty_alv.

    METHODS: get_data,
      build_fieldcatlog,
      display_alv,
      handle_toolbar_set FOR EVENT toolbar OF cl_gui_alv_grid
        IMPORTING
          e_object,
      handle_ucomm FOR EVENT user_command OF cl_gui_alv_grid
        IMPORTING
          e_ucomm.


    DATA: go_alv  TYPE REF TO cl_gui_alv_grid,
          go_cont TYPE REF TO cl_gui_custom_container.

    DATA: gt_fcat          TYPE lvc_t_fcat,
          go_container_100 TYPE REF TO cl_gui_custom_container,
          go_grid          TYPE REF TO cl_gui_alv_grid.

ENDCLASS.                    "lcl_report DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_report IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_main IMPLEMENTATION.

* Get REPORT data
  METHOD get_data.

    SELECT likp~kunnr,
           lips~vbeln,
           lips~posnr,
           lips~pstyv,
           lips~ernam,
           likp~wadat_ist,
           lips~matnr,
           lips~ntgew,
           lips~gewei
      FROM likp
      INNER JOIN lips
              ON likp~vbeln = lips~vbeln
      INTO TABLE @me->gt_alv
           WHERE lips~vbeln IN @s_vbeln
             AND lips~posnr IN @s_posnr
             AND lips~matnr IN @s_matnr
             AND likp~kunnr IN @s_kunnr.

  ENDMETHOD.                    "get_data

* Build FieldCatlog
  METHOD build_fieldcatlog.
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'ZBA_005_S_ALV_AFEU'
      CHANGING
        ct_fieldcat            = gt_fcat
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        OTHERS                 = 3.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDMETHOD.                    "build_fieldcatlog

* Display ALV
  METHOD display_alv.

    IF go_grid IS NOT BOUND.

* Get the REPORT table data
      go_class->get_data( ).

* 1. Create container instance
      CREATE OBJECT go_container_100
        EXPORTING
          container_name = 'CC_ALV'.

* 2. Create ALV grid instance by using the container instance
      CREATE OBJECT go_grid
        EXPORTING
          i_parent = go_container_100.

* 3. Build Field Catlog
      go_class->build_fieldcatlog( ).

* -handler for ToolBar
      SET HANDLER go_class->handle_toolbar_set FOR go_grid.

* 4. Call the ALV
      CALL METHOD go_grid->set_table_for_first_display
        EXPORTING
          is_layout                     = VALUE lvc_s_layo( zebra      = abap_true
                                                            cwidth_opt = abap_true
                                                            col_opt    = abap_true
                                                            sel_mode   = 'A' )
        CHANGING
          it_outtab                     = go_class->gt_alv
          it_fieldcatalog               = go_class->gt_fcat
        EXCEPTIONS
          invalid_parameter_combination = 1
          program_error                 = 2
          too_many_lines                = 3
          OTHERS                        = 4.
      IF sy-subrc <> 0.
* Implement suitable error handling here
      ENDIF.

* -handler user command for ToolBar
      SET HANDLER go_class->handle_ucomm FOR go_grid.

    ELSE.
      go_grid->refresh_table_display(
      EXPORTING
        is_stable      = VALUE lvc_s_stbl( row = 'X' col = 'X' )
        i_soft_refresh = 'X' ).
    ENDIF.
  ENDMETHOD.                    "display


  METHOD handle_toolbar_set.

    DATA ls_toolbar TYPE stb_button.

    CLEAR ls_toolbar.
    ls_toolbar-function  = '&PRT'.
    ls_toolbar-text      = 'PRINT'.
    ls_toolbar-icon      = '@0X@'.
    ls_toolbar-quickinfo = 'Print'.
    APPEND ls_toolbar TO e_object->mt_toolbar.

    CLEAR ls_toolbar.
    ls_toolbar-function  = '&LBL'.
    ls_toolbar-text      = 'LABEL'.
    ls_toolbar-icon      = '@SL@'.
    ls_toolbar-quickinfo = 'Label'.
    APPEND ls_toolbar TO e_object->mt_toolbar.

    IF p_excupl EQ abap_true.
    CLEAR ls_toolbar.
    ls_toolbar-function  = '&PRT'.
    ls_toolbar-text      = 'SAVE'.
    ls_toolbar-icon      = '@2L@'.
    ls_toolbar-quickinfo = 'Save'.
    APPEND ls_toolbar TO e_object->mt_toolbar.
    ENDIF.


  ENDMETHOD.

  METHOD handle_ucomm.

    CASE e_ucomm.
      WHEN '&PRT'.
      WHEN '&LBL'.
      WHEN '&PRT'.
    ENDCASE.

  ENDMETHOD.

ENDCLASS.                    "lcl_report IMPLEMENTATION
