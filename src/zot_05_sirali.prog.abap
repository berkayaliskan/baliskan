*&---------------------------------------------------------------------*
*& Report zot_05_sirali
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_05_sirali.


SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_num1 TYPE i OBLIGATORY,
              p_num2 TYPE i OBLIGATORY.
SELECTION-SCREEN END OF BLOCK b1.

DATA: lv_a TYPE i.

lv_a = 0.

IF 100 >= p_num1 AND 9 >= p_num2 .
  WHILE p_num1 >= lv_a.
    DO p_num2 TIMES.
      lv_a = lv_a + 1.
      IF p_num1 >= lv_a.
        WRITE lv_a.
      ENDIF.
    ENDDO.
    NEW-LINE.
  ENDWHILE.
ELSE.
  WRITE 'Maksimum sayı 1 ile 100000 arasında, kırılım sayısı 1 ile 9 arasında olmalıdır. Lütfen girdiğiniz değerleri kontrol ediniz.'.
ENDIF.
