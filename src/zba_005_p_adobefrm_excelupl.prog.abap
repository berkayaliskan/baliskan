*&---------------------------------------------------------------------*
*& Report ZBA_005_ADOBEFRM_EXCELUPL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zba_005_p_adobefrm_excelupl.

INCLUDE : zba_005_i_adobefrm_excelup_top,
          zba_005_i_adobefrm_excelup_ss,
          zba_005_i_adobefrm_excelup_cls,
          zba_005_i_adobefrm_excelup_pbo,
          zba_005_i_adobefrm_excelup_pai.

INITIALIZATION.
* Create instance for the local class
  CREATE OBJECT go_class.


START-OF-SELECTION.
  CALL SCREEN 100.
