FUNCTION ZOT_05_DO_MATH_OPERA.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_NUMBER1) TYPE  I
*"     VALUE(IV_NUMBER2) TYPE  I
*"     VALUE(IV_OPERATION) TYPE  C
*"  EXPORTING
*"     REFERENCE(EV_RESULT) TYPE  I
*"  RAISING
*"      CX_SY_ZERODIVIDE
*"     RESUMABLE(CX_SY_ASSIGN_CAST_ERROR)
*"----------------------------------------------------------------------
CASE iv_operation.
    WHEN '+'.
        ev_result = iv_number1 + iv_number2.
    WHEN '-'.
        ev_result = iv_number1 - iv_number2.
    WHEN '*'.
        ev_result = iv_number1 * iv_number2.
    WHEN '/'.
        ev_result = iv_number1 / iv_number2.
ENDCASE.


ENDFUNCTION.
