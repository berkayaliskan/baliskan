CLASS zcl_ot_06_math_opera DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS: calculate_result
      IMPORTING  iv_number1   TYPE i
                 iv_number2   TYPE i
                 iv_operation TYPE c
      EXPORTING  ev_rslt    TYPE i.



  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ot_06_math_opera IMPLEMENTATION.
  METHOD calculate_result.

    CASE iv_operation.
      WHEN '+'.
        ev_rslt = iv_number1 + iv_number2.
      WHEN '-'.
        ev_rslt = iv_number1 - iv_number2.
      WHEN '*'.
        ev_rslt = iv_number1 * iv_number2.
      WHEN '/'.
        ev_rslt = iv_number1 / iv_number2.
    ENDCASE.
  ENDMETHOD.

ENDCLASS.
