*&---------------------------------------------------------------------*
*& Report zot_05_p_sport
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_05_p_sport.


TYPES: BEGIN OF gty_a,
         team    TYPE numc2,
         country TYPE char2,
         pouch   TYPE numc1,
       END OF gty_a.

TYPES: BEGIN OF gty_b,
         team1 TYPE int2,
         team2 TYPE int2,
         team3 TYPE int2,
         team4 TYPE int2,
       END OF gty_b.

DATA: ls_data  TYPE gty_a,
      lt_data  TYPE TABLE OF gty_a,
      lt_pouch TYPE TABLE OF gty_a.

DATA: ls_team      TYPE gty_b,
      lt_team      TYPE TABLE OF gty_b,
      ls_display_v TYPE gty_b,
      lt_display_v TYPE TABLE OF gty_b,
      lv_i         TYPE i.

RANGES:lt_c FOR ls_data-country.

SELECT team,
       country,
       pouch
FROM zot_05_t_sport INTO TABLE @lt_data.


DATA(lv_mran) = 5.
DO 4 TIMES.

  CLEAR lt_c[].
  lt_c-option = 'EQ'.
  lt_c-sign   = 'I'.

  lv_mran = lv_mran - 1.


  lt_pouch[] = VALUE #( FOR ls_item_112 IN lt_data WHERE ( pouch = 1 ) ( CORRESPONDING #( ls_item_112 ) ) ).

  CALL FUNCTION 'QF05_RANDOM_INTEGER'
    EXPORTING
      ran_int_max = lv_mran
      ran_int_min = 1
    IMPORTING
      ran_int     = lv_i.


  READ TABLE lt_pouch INTO DATA(ls_pouch) INDEX lv_i.
  ls_team-team1 = ls_pouch-team.
  DELETE lt_data WHERE team = ls_pouch-team.

  lt_c-low = ls_pouch-country.
  APPEND lt_c TO lt_c[].


  lt_pouch[] = VALUE #( FOR ls_item_112 IN lt_data WHERE ( pouch = 2 AND country NOT IN lt_c ) ( CORRESPONDING #( ls_item_112 ) ) ).

  CALL FUNCTION 'QF05_RANDOM_INTEGER'
    EXPORTING
      ran_int_max = lv_mran
      ran_int_min = 1
    IMPORTING
      ran_int     = lv_i.


  READ TABLE lt_pouch INTO ls_pouch INDEX lv_i.
  ls_team-team2 = ls_pouch-team.
  DELETE lt_data WHERE team = ls_pouch-team.

  lt_c-low = ls_pouch-country.
  APPEND lt_c TO lt_c[].


  lt_pouch[] = VALUE #( FOR ls_item_112 IN lt_data WHERE ( pouch = 3 AND country NOT IN lt_c ) ( CORRESPONDING #( ls_item_112 ) ) ).

  CALL FUNCTION 'QF05_RANDOM_INTEGER'
    EXPORTING
      ran_int_max = lv_mran
      ran_int_min = 1
    IMPORTING
      ran_int     = lv_i.


  READ TABLE lt_pouch INTO ls_pouch INDEX lv_i.
  ls_team-team3 = ls_pouch-team.
  DELETE lt_data WHERE team = ls_pouch-team.

  lt_c-low = ls_pouch-country.
  APPEND lt_c TO lt_c[].


  lt_pouch[] = VALUE #( FOR ls_item_112 IN lt_data WHERE ( pouch = 4 AND country NOT IN lt_c ) ( CORRESPONDING #( ls_item_112 ) ) ).

  CALL FUNCTION 'QF05_RANDOM_INTEGER'
    EXPORTING
      ran_int_max = lv_mran
      ran_int_min = 1
    IMPORTING
      ran_int     = lv_i.


  READ TABLE lt_pouch INTO ls_pouch INDEX lv_i.
  ls_team-team4 = ls_pouch-team.
  DELETE lt_data WHERE team = ls_pouch-team.

  APPEND ls_team TO lt_team.

ENDDO .

DATA lv_r TYPE char2.

DO 4 TIMES .

  lv_i = 1.
  lv_r = sy-index.
  CONCATENATE 'team' lv_r INTO DATA(ls_com).

  ASSIGN COMPONENT ls_com OF STRUCTURE ls_team TO FIELD-SYMBOL(<fs_v>).

  READ TABLE lt_team INTO ls_team INDEX lv_i.
  ls_display_v-team1 = <fs_v>.

  lv_i = lv_i + 1.
  READ TABLE lt_team INTO ls_team INDEX lv_i.
  ls_display_v-team2 = <fs_v>.

  lv_i = lv_i + 1.
  READ TABLE lt_team INTO ls_team INDEX lv_i.
  ls_display_v-team3 = <fs_v>.

  lv_i = lv_i + 1.
  READ TABLE lt_team INTO ls_team INDEX lv_i.
  ls_display_v-team4 = <fs_v>.

  APPEND ls_display_v TO lt_display_v.

ENDDO.

cl_demo_output=>display( lt_display_v ).
