*&---------------------------------------------------------------------*
*& Include zot_05_i_report_sel
*&---------------------------------------------------------------------*

TABLES: eban, ekpo.

SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-003.
  PARAMETERS: p_sat  TYPE char1 RADIOBUTTON GROUP gr1,
              p_sas TYPE char1 RADIOBUTTON GROUP gr1.
SELECTION-SCREEN END OF BLOCK b3.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: s_banfn FOR eban-banfn,
                  s_bsart FOR eban-bsart.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
  SELECT-OPTIONS: s_ebeln FOR ekpo-ebeln,
                  s_matkl FOR ekpo-matkl.
SELECTION-SCREEN END OF BLOCK b2.
