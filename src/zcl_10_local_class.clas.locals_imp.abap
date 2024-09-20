*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_connection DEFINITION.
  PUBLIC SECTION.
    DATA airport_from_id TYPE /DMO/AIRPORT_FROM_ID.
    DATA airport_to_id TYPE /DMO/AIRPORT_TO_ID.
  CLASS-DATA connection_counter TYPE i READ-ONLY.
  METHODS get_output
    RETURNING
      "type table of string doesn't work
      VALUE(r_output) TYPE STRING_TABLE.
*  METHODS set_attributes
*    IMPORTING
*      i_carrier_id TYPE /DMO/CARRIER_ID
*      i_connection_id TYPE /DMO/CONNECTION_ID
*    RAISING
*      CX_ABAP_INVALID_VALUE.
    METHODS constructor
      IMPORTING
        i_carrier_id TYPE /DMO/CARRIER_ID
        i_connection_id TYPE /DMO/CONNECTION_ID
      RAISING
        cx_abap_invalid_value.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA carrier_id TYPE /DMO/CARRIER_ID.
    DATA connection_id TYPE /DMO/CONNECTION_ID.
    DATA carrier_name TYPE /DMO/CARRIER_NAME.

ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.
  METHOD get_output.
    "r_output wird automatisch zurückgegeben
    append | carrier_id: { carrier_id } | to r_output.
    append | connection_id: { connection_id } | to r_output.
    append | airport_from_id: { airport_from_id }| to r_output.
    append | airport_to_id: { airport_to_id }| to r_output.
    append | carrier_name: { carrier_name }| to r_output.
  ENDMETHOD.

*  METHOD set_attributes.
*    IF i_carrier_id IS INITIAL.
*      RAISE EXCEPTION TYPE cx_abap_invalid_value exporting value = 'carrier_id'.
*    ENDIF.
*    IF i_connection_id IS INITIAL.
*      RAISE EXCEPTION TYPE cx_abap_invalid_value.
*    ENDIF.
*
**    me-> = this.
*    me->carrier_id = i_carrier_id.
*    me->connection_id = i_connection_id.
*
*  ENDMETHOD.

  METHOD constructor.
    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.
    me->carrier_id = i_carrier_id.
    me->connection_id = i_connection_id.
    connection_counter += 1.

*    SELECT SINGLE FROM /DMO/CONNECTION
*    FIELDS airport_from_id, airport_to_id
*    WHERE carrier_id = @i_carrier_id AND connection_id = @i_connection_id
*    INTO ( @airport_from_id, @airport_to_id ).
*
*    IF sy-subrc <> 0.
*      RAISE EXCEPTION TYPE cx_abap_invalid_value.
*    ENDIF.

* Zugriff auf CDS view
* Zugriff auf Assoziation

    SELECT SINGLE FROM /DMO/I_Connection as Connection
      FIELDS DepartureAirport, DestinationAirport, \_Airline-Name
      WHERE AirlineId = @i_carrier_id AND connectionId = @i_connection_id
      INTO ( @airport_from_id, @airport_to_id, @carrier_name ).
  ENDMETHOD.

ENDCLASS.
