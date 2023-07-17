*&---------------------------------------------------------------------*
*& Report zot_05_p_internal_tables
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_05_p_internal_tables.

TYPES: BEGIN OF lty_collect,
         matkl TYPE zot_00_t_materia-matkl,
         menge TYPE zot_00_t_materia-menge,
       END OF lty_collect.

DATA: gt_materia2        TYPE TABLE OF zot_00_t_materia,
      gt_materia_combine TYPE TABLE OF zot_00_t_materia,
      gt_materia_total   TYPE TABLE OF lty_collect,
      ls_materia_total   TYPE lty_collect.


SELECT matnr,
       maktx,
       matkl,
       menge,
       meins
   FROM zot_00_t_materia
   INTO TABLE @DATA(gt_materia).

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

gt_materia2 = VALUE #( ( matnr = '000000000000000011'
                         maktx = 'Tabak'
                         matkl = 'C'
                         menge = 5
                         meins = 'ST' )
                       ( matnr = '000000000000000012'
                         maktx = 'Tencere'
                         matkl = 'C'
                         menge = 5
                         meins = 'ST' )
                       ( matnr = '000000000000000013'
                         maktx = 'Çatal'
                         matkl = 'C'
                         menge = 6
                         meins = 'ST' )
                       ( matnr = '000000000000000014'
                         maktx = 'Bıçak'
                         matkl = 'C'
                         menge = 5
                         meins = 'ST' )
                       ( matnr = '000000000000000015'
                         maktx = 'Tava'
                         matkl = 'C'
                         menge = 5
                         meins = 'ST' ) ).

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

LOOP AT gt_materia INTO DATA(ls_materia).
  READ TABLE gt_materia2 INTO DATA(ls_materia_read) WITH KEY meins = ls_materia-meins.
  IF sy-subrc = 0.
    ls_materia-menge += 10.
    MODIFY gt_materia FROM ls_materia.
  ENDIF.
ENDLOOP.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

APPEND LINES OF gt_materia TO gt_materia_combine.
APPEND LINES OF gt_materia2 TO gt_materia_combine.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

LOOP AT gt_materia_combine INTO DATA(ls_materia_combine).
  CLEAR: ls_materia_total.
  MOVE-CORRESPONDING ls_materia_combine TO ls_materia_total.
  COLLECT ls_materia_total INTO gt_materia_total.
ENDLOOP.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

DELETE gt_materia_combine WHERE menge < 10.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

SORT gt_materia_combine BY menge ASCENDING.
SORT gt_materia_total BY menge DESCENDING.

cl_demo_output=>display( gt_materia_combine ).
cl_demo_output=>display( gt_materia_total ).

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""" FINISH
