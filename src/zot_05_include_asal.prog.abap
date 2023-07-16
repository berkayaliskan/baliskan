*&---------------------------------------------------------------------*
*& Include zot_05_include_asal
*&---------------------------------------------------------------------*


    WHILE ii < p_num2.
      sayac = 0.
      j = 2.
      WHILE j < ii.
        IF ii MOD j = 0.
          sayac = sayac + 1.
        ENDIF.
        j = j + 1.
      ENDWHILE.
      IF sayac = 0 and ii NE 1.
        WRITE: ii.
      ENDIF.
      ii = ii + 1.
    ENDWHILE.
