*&---------------------------------------------------------------------*
*& Report zot_05_asal_sayi
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_05_asal_sayi.


SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_num1 TYPE i OBLIGATORY,
              p_num2 TYPE i OBLIGATORY.
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.
  DATA sayac TYPE i.
  DATA(j) = 2.
  DATA(ii) = p_num1.

  IF p_num1 < p_num2 AND p_num1 > 0.
        INCLUDE zot_05_include_asal.
  ELSE.
    WRITE 'Birinci sayı ikinci sayıdan küçük olmalıdır. Birinci değer 0 dan büyük olmalıdır. Lütfen kontrol ediniz.'.
  ENDIF.
