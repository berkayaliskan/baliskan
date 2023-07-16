*&---------------------------------------------------------------------*
*& Report zot_05_fibonachi
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_05_fibonachi.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_num1 TYPE int4 OBLIGATORY,
              p_num2 TYPE i OBLIGATORY.
SELECTION-SCREEN END OF BLOCK b1.

DATA: lv_c TYPE i,
      lv_a TYPE i,
      lv_b TYPE i.

lv_a = 0.
lv_b = 1.

IF 100000 >= p_num1 AND 9 >= p_num2 .
  WHILE p_num1 >= lv_c.
    DO p_num2 TIMES.
    lv_c = lv_a + lv_b.
      IF p_num1 >= lv_c.
        lv_a = lv_b.
        lv_b = lv_c.
        WRITE lv_c.
      ENDIF.
    ENDDO.
    NEW-LINE.
  ENDWHILE.
ELSE.
  WRITE 'Maksimum sayı 1 ile 100000 arasında, kırılım sayısı 1 ile 9 arasında olmalıdır. Lütfen girdiğiniz değerleri kontrol ediniz.'.
ENDIF.
