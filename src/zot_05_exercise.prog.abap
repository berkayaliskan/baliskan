*&---------------------------------------------------------------------*
*& Report zot_05_exercise
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_05_exercise.

*cl_demo_output=>write( 'Hello World' ).
*
*cl_demo_output=>display( ).

*SELECT *
*       FROM scarr
*       INTO TABLE @DATA(itab).
*
*DATA(html) = cl_demo_output=>get( itab ).
*
*cl_demo_output=>display( html ).

*DATA: lv_number1   TYPE i VALUE 60,
*      lv_number2   TYPE i VALUE 3,
*      lv_operation TYPE c VALUE '*'.

*DATA(lv_carpma) = lv_number1 * lv_number2.
*
* cl_demo_output=>write( lv_carpma ).
*
* cl_demo_output=>write( |Clear işleminden önce lv_carpma'nin değeri: { lv_carpma }| ).
*
*  CLEAR lv_carpma.
*
* cl_demo_output=>write( |Clear işleminden sonra lv_carpma'nin değeri: { lv_carpma }| ).

* lv_number2 = 0.


*try.
*   DATA(lv_bolme) = lv_number1 / lv_number2.
*  catch CX_SY_ZERODIVIDE.
*   cl_demo_output=>write( |Sıfıra bölme işlemi yapılamaz!| ).
*endtry.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

*DATA: lv_number1 TYPE i VALUE 10,
*      lv_number2 TYPE i VALUE 0,
*      lv_op      TYPE c VALUE '/',
*      lv_result TYPE i.
*
*
*CALL FUNCTION 'ZOT_05_DO_MATH_OPERA'
*  EXPORTING
*    iv_number1   = lv_number1
*    iv_number2   = lv_number2
*    iv_operation = lv_op
*  IMPORTING
*    ev_result    = lv_result.
**CATCH cx_sy_zerodivide.
**CATCH cx_sy_assign_cast_error.
*
* cl_demo_output=>write( | { lv_number1 } { lv_op } { lv_number2 } = { lv_result } | ).

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

*DATA(lo_math_op) = NEW zcl_ot_06_math_opera( ).
*
*lo_math_op->calculate_result(
*  EXPORTING
*    iv_number1   = lv_number1
*    iv_number2   = lv_number2
*    iv_operation = lv_operation
*  IMPORTING
*    ev_rslt      = DATA(lv_result)
*).
*
* cl_demo_output=>write( | { lv_number1 } { lv_operation } { lv_number2 } = { lv_result } | ).

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

*TYPES: gty_tip TYPE c LENGTH 12.
*
*TYPES: BEGIN OF gty_komplex,
*         alan1 TYPE c LENGTH 12,
*         alan2 TYPE c LENGTH 12,
*         alan3 TYPE i,
*       END OF gty_komplex.
*
*DATA: gv_alan1   TYPE gty_tip,
*      gs_komplex TYPE gty_komplex,
*      gt_komplex TYPE TABLE OF gty_komplex,
*      gv_alan2   TYPE gty_komplex-alan1.
*
*    gv_alan1 = 'Hello World'.
*    gs_komplex-alan1 = 'One'.
*    gs_komplex-alan2 = 'Talent'.
*    gs_komplex-alan3 = '23'.
*
*
*gs_komplex = VALUE #( alan1 = 'Fikri'
*                      alan2 = 'Alışkan'
*                      alan3 = 06  ).
*
*gt_komplex = VALUE #( ( alan1 = 'Berkay'
*                        alan2 = 'Alışkan'
*                        alan3 = 05 )
*                       ( alan1 = 'Anıl'
*                         alan2 = 'Ağcalar'
*                         alan3 = 28 )  ).
*
*APPEND VALUE #( alan1 = 'Necati'
*                alan2 = 'Çalışkan'
*                alan3 = 30 ) TO gt_komplex.
*
*APPEND gs_komplex TO gt_komplex.
*
*
* cl_demo_output=>write( gt_komplex ).

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

*SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
*PARAMETERS: p_ad TYPE c LENGTH 20,
*            p_soyad TYPE char20,
*            p_tc TYPE i.
*SELECTION-SCREEN END OF BLOCK b1.
*
*SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
*PARAMETERS: p_dahil RADIOBUTTON GROUP g1,
*            p_deri RADIOBUTTON GROUP g1,
*            p_cocuk RADIOBUTTON GROUP g1,
*            p_ortap RADIOBUTTON GROUP g1,
*            p_saat TYPE t.
*SELECTION-SCREEN END OF BLOCK b2.
*
*START-OF-SELECTION.
*
* cl_demo_output=>write( |{ p_ad } { p_soyad } { p_tc } { p_saat }| ).



*DATA(lt_personel) = VALUE zot_00_tt_personel( ( id        = 1
*                                                ad        = 'Sena Süyün'
*                                                yas       = 18
*                                                departman = 'ABAP'
*                                                unvan     = 'Stajyer'
*                                                ekip      =  VALUE #(
*                                                             ( id = 2
*                                                               ad = 'Yusuf Yüksel' )
*                                                             ( id = 3
*                                                               ad = 'Mustafa Özkaya') )
*                     ) ).
*


*cl_demo_output=>display( lt_personel ).
