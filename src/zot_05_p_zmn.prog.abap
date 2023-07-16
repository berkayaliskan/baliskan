*&---------------------------------------------------------------------*
*& Report zot_05_p_zmn
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_05_p_zmn.

DATA gs_zmn TYPE zot_05_t_zmn.
SELECT-OPTIONS : s_index FOR gs_zmn-id.

DATA: lv_datediff TYPE p,
      lv_time   TYPE uzeit.

START-OF-SELECTION.

  SELECT id,
         baslangic_tarihi,
         baslangic_saati,
         bitis_tarihi,
         bitis_saati
  FROM zot_05_t_zmn
  WHERE id IN @s_index
  INTO TABLE @DATA(lt_zmn).


SORT lt_zmn BY id ASCENDING.

  LOOP AT lt_zmn INTO DATA(ls_zmn).

    CALL FUNCTION 'SD_DATETIME_DIFFERENCE'
      EXPORTING
        date1    = ls_zmn-baslangic_tarihi
        time1    = ls_zmn-baslangic_saati
        date2    = ls_zmn-bitis_tarihi
        time2    = ls_zmn-bitis_saati
      IMPORTING
        datediff = lv_datediff.

    lv_time = ls_zmn-bitis_saati - ls_zmn-baslangic_saati.

    DATA(lv_gun_diff) = ls_zmn-bitis_tarihi - ls_zmn-baslangic_tarihi.

    DATA(lv_yıl) = lv_datediff DIV 365.
    lv_datediff = lv_datediff MOD 365.


    DATA(lv_ay) = lv_datediff DIV 30.
    DATA(lv_gun) = lv_datediff MOD 30.

    WRITE: |Index { ls_zmn-id } |.
    IF lv_yıl NE 0.
      WRITE: |{ lv_yıl  } YIL|.
    ENDIF.
    IF lv_ay NE 0.
      WRITE: |{ lv_ay } AY|.
    ENDIF.
    IF lv_gun NE 0.
      WRITE: |{ lv_gun } GÜN|.
    ENDIF.
    IF lv_time NE 0.
      WRITE: |{ lv_time+0(2) } SAAT|.
    ENDIF.
    IF lv_time NE 0.
      WRITE: |{ lv_time+2(2) } DAKİKA|.
    ENDIF.
    IF lv_time NE 0.
      WRITE: |{ lv_time+4(2) } SANİYE|.
    ENDIF.

    NEW-LINE.

  ENDLOOP.
