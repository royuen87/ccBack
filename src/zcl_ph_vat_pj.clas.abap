CLASS zcl_ph_vat_pj DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  CLASS-METHODS: get_net_amt  IMPORTING iv_vatamount  TYPE dmbtr
                                        iv_netamount  TYPE dmbtr
                              EXPORTING ev_totvatamt  TYPE dmbtr
                                        et_message    TYPE srft_message.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_PH_VAT_PJ IMPLEMENTATION.


  METHOD get_net_amt.
    ev_totvatamt = iv_vatamount + iv_netamount.
  ENDMETHOD.
ENDCLASS.
