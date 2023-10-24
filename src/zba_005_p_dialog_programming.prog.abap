*&---------------------------------------------------------------------*
*& Report ZBA_005_P_DIALOG_PROGRAMMING
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zba_005_p_dialog_programming.

INCLUDE zba_005_i_dialog_prog_tcw.

TYPES: BEGIN OF gty_delvry,
         delivery TYPE vbeln_vl,
         item     TYPE posnr_vl,
         material TYPE matnr,
         quantity TYPE lfimg,
         meins    TYPE meins,
         wavwr    TYPE wavwr,
         currency TYPE waerk,
       END OF gty_delvry.

DATA: gt_delvry TYPE TABLE OF gty_delvry.

DATA: gs_delivery TYPE zba_005_t_delvry.

DATA: gv_quantity TYPE lfimg.

DATA: gt_return_tab TYPE TABLE OF ddshretval,
      gt_mapping    TYPE TABLE OF dselc,
      gs_mapping    TYPE dselc.

CONTROLS tab TYPE TABSTRIP.


START-OF-SELECTION.

  CALL SCREEN 0100.

MODULE status_0100 OUTPUT.
  SET PF-STATUS '0100'.
* SET TITLEBAR 'xxx'.

 PERFORM get_data.

ENDMODULE.


MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN '&BACK'.
      LEAVE TO SCREEN 0.
    WHEN '&EXIT'.
      LEAVE PROGRAM.
    WHEN '&TAB1'.
      CLEAR gs_delivery.
      tab-activetab = '&TAB1'.
    WHEN '&TAB2'.
      CLEAR gs_delivery.
      tab-activetab = '&TAB2'.
    WHEN '&TAB3'.
      tab-activetab = '&TAB3'.
      SELECT * FROM zba_005_t_delvry
        ORDER BY delivery, item
        INTO CORRESPONDING FIELDS OF TABLE @it_delvry.
    WHEN '&SAVE'.
      PERFORM save_data.
    WHEN '&DISPLAY'.
      PERFORM get_field.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Form save_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM save_data .

  SELECT SINGLE * FROM zba_005_t_stock
  INTO @DATA(ls_stock)
  WHERE material EQ @gs_delivery-material.

  IF ls_stock-quantity GE gs_delivery-quantity.
    SELECT SINGLE * FROM zba_005_t_delvry
        INTO @DATA(ls_delvry)
        WHERE delivery EQ @gs_delivery-delivery AND
              item     EQ @gs_delivery-item.
    IF sy-subrc IS INITIAL.
      MESSAGE 'There is item for this delivery number!' TYPE 'I' DISPLAY LIKE 'W'.
    ELSE.
      INSERT zba_005_t_delvry FROM gs_delivery.
      COMMIT WORK AND WAIT.
      gv_quantity = ls_stock-quantity - gs_delivery-quantity.
      ls_stock-quantity = gv_quantity.
      MODIFY zba_005_t_stock FROM ls_stock.
      COMMIT WORK AND WAIT.
      MESSAGE 'Has been added successfully!' TYPE 'I'.
      CLEAR gs_delivery.
    ENDIF.
  ELSE.
    MESSAGE 'Insufficient stock!' TYPE 'I' DISPLAY LIKE 'E'.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Module  F4_HELP  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE f4_help INPUT.

  gs_mapping-fldname   = 'F0001'.
  gs_mapping-dyfldname = 'GS_DELIVERY-DELIVERY'.
  APPEND gs_mapping TO gt_mapping.

  gs_mapping-fldname   = 'F0002'.
  gs_mapping-dyfldname = 'GS_DELIVERY-ITEM'.
  APPEND gs_mapping TO gt_mapping.

  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
    EXPORTING
      retfield        = 'DELIVERY'
      dynpprog        = sy-repid
      dynpnr          = '0102'
      dynprofield     = 'GS_DELIVERY-DELIVERY'
      value_org       = 'S'
    TABLES
      value_tab       = gt_delvry
      return_tab      = gt_return_tab
      dynpfld_mapping = gt_mapping
    EXCEPTIONS
      parameter_error = 1
      no_values_found = 2
      OTHERS          = 3.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Form get_field
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_field .
  READ TABLE gt_delvry INTO DATA(ls_delvry) WITH KEY delivery = gs_delivery-delivery
                                                     item     = gs_delivery-item.
  gs_delivery-material = ls_delvry-material.
  gs_delivery-quantity = ls_delvry-quantity.
  gs_delivery-meins    = ls_delvry-meins.
  gs_delivery-wavwr    = ls_delvry-wavwr.
  gs_delivery-currency = ls_delvry-currency.
ENDFORM.


FORM get_data .

  SELECT delivery,
         item,
         material,
         quantity,
         meins,
         wavwr,
         currency
    FROM zba_005_t_delvry
    INTO CORRESPONDING FIELDS OF TABLE @gt_delvry.

ENDFORM.
