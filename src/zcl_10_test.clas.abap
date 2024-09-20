CLASS zcl_10_test DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_10_test IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*    TYPES ty_result type i.
*    CONSTANTS pi TYPE p DECIMALS 14 VALUE '3.14159265358979'.
*    DATA result type ty_result.
*    DATA output type string.
*
*    result = sin( '0.5' * pi ).
*
*    DO 100 TIMES.
**     out->write( sy-index ).
*
*      DO sin( sy-index * '0.1' ) * 50 TIMES.
*        output = |{ output }-|.
*      ENDDO.
*      out->write( output ).
*      CLEAR output.
*    ENDDO.


    DATA tester TYPE REF TO LCL_TESTER.
    tester = NEW LCL_TESTER(  ).

    out->write( tester->sinus_ausgabe( 500 ) ).

  ENDMETHOD.
ENDCLASS.
