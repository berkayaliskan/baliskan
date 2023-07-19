*&---------------------------------------------------------------------*
*& Include zot_05_i_report_selc
*&---------------------------------------------------------------------*

TABLES: eban, ekpo.

SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-003.
  PARAMETERS: p_sat TYPE char1 RADIOBUTTON GROUP gr1 USER-COMMAND RADIO,
              p_sas TYPE char1 RADIOBUTTON GROUP gr1.
SELECTION-SCREEN END OF BLOCK b3.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: s_banfn FOR eban-banfn MODIF ID M1,
                  s_bsart FOR eban-bsart MODIF ID M1.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
  SELECT-OPTIONS: s_ebeln FOR ekpo-ebeln MODIF ID M2,
                  s_matkl FOR ekpo-matkl MODIF ID M2.
SELECTION-SCREEN END OF BLOCK b2.
