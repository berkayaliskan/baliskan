*&---------------------------------------------------------------------*
*& Report zot_05_calculator
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_05_calculator.


SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_num1 TYPE p OBLIGATORY,
              p_num2 TYPE p OBLIGATORY.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
  PARAMETERS: p_topla  RADIOBUTTON GROUP g1,
              p_cikar  RADIOBUTTON GROUP g1,
              p_carpma RADIOBUTTON GROUP g1,
              p_bolme  RADIOBUTTON GROUP g1.
SELECTION-SCREEN END OF BLOCK b2.

START-OF-SELECTION.

  CASE 'X'.
    WHEN p_topla.
      cl_demo_output=>display( |Sonuç: { p_num1 + p_num2 }| ).
    WHEN p_cikar.
      cl_demo_output=>display( |Sonuç: { p_num1 - p_num2 }| ).
    WHEN p_carpma.
      cl_demo_output=>display( |Sonuç: { p_num1 * p_num2 }| ).
    WHEN p_bolme.
      TRY.
          cl_demo_output=>display( |Sonuç: { p_num1 / p_num2 }| ).
        CATCH cx_sy_zerodivide.
          cl_demo_output=>display( 'Sıfıra bölme işlemi yapılamaz.' ).
      ENDTRY.
  ENDCASE.
