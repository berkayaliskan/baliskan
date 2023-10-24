*&---------------------------------------------------------------------*
*& Report ZBA_001_P_SEARCH_HELP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zba_001_p_search_help.

TYPES: BEGIN OF ty_list,
         delivery TYPE zba_005_t_delvry-delivery,
         item     TYPE zba_005_t_delvry-item,
         material TYPE zba_005_t_delvry-material,
         quantity TYPE zba_005_t_delvry-quantity,
       END OF ty_list.

DATA: gt_list       TYPE TABLE OF ty_list,
      gt_return_tab TYPE TABLE OF ddshretval,
      gt_mapping    TYPE TABLE OF dselc,
      gs_mapping    TYPE dselc.

PARAMETERS: p_delvry TYPE zba_005_t_delvry-delivery,
            p_item   TYPE zba_005_t_delvry-item,
            p_materl TYPE zba_005_t_delvry-material,
            p_quanty TYPE zba_005_t_delvry-quantity.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_delvry.

  SELECT delivery,
         item,
         material,
         quantity
    FROM zba_005_t_delvry
    INTO CORRESPONDING FIELDS OF TABLE @gt_list.


    gs_mapping-fldname   = 'F0001'.
    gs_mapping-dyfldname = 'P_DELVRY'.
    APPEND gs_mapping TO gt_mapping.

    gs_mapping-fldname   = 'F0002'.
    gs_mapping-dyfldname = 'P_ITEM'.
    APPEND gs_mapping TO gt_mapping.

    gs_mapping-fldname   = 'F0003'.
    gs_mapping-dyfldname = 'P_MATERL'.
    APPEND gs_mapping TO gt_mapping.

    gs_mapping-fldname   = 'F0004'.
    gs_mapping-dyfldname = 'P_QUANTY'.
    APPEND gs_mapping TO gt_mapping.


  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
    EXPORTING
      retfield        = 'DELIVERY'
      dynpprog        = sy-repid
      dynpnr          = sy-dynnr
      dynprofield     = 'P_DELVRY'
      value_org       = 'S'   ""S or C (Structured or cell)
    TABLES
      value_tab       = gt_list    "Search Help Internal Table
      return_tab      = gt_return_tab
      dynpfld_mapping = gt_mapping
*   EXCEPTIONS
*     PARAMETER_ERROR = 1
*     NO_VALUES_FOUND = 2
*     OTHERS          = 3
    .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

START-OF-SELECTION.
