CLASS zcl_2307_query DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES: if_oo_adt_classrun.

    CLASS-METHODS: get_tax_items IMPORTING i_repent        TYPE srf_reporting_entity
                                           i_repcat        TYPE srf_rep_cat_id
                                           i_reprun        TYPE srf_report_run_id
                                 RETURNING VALUE(r_result) TYPE REF TO data
                                 RAISING
                                           cx_srf_error.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_2307_QUERY IMPLEMENTATION.


  METHOD get_tax_items.



    FIELD-SYMBOLS: <lt_bupla_item> TYPE table.

    DATA(lo_acr) = cl_srf_facade=>get_report_run_by_id(
                     iv_rep_cat_id       = i_repcat
                     iv_reporting_entity = i_repent
                     iv_report_run_id    = i_reprun
                   ).
    DATA(lt_params) = lo_acr->get_rep_run_parameters( ).

    DATA(lo_handler) = cl_srf_facade=>get_message_handler( ).

    DATA(lo_bupla_item) = lo_acr->execute_query(
      EXPORTING
*        iv_query_id    = 'YY1_TAXITEM_BUPLA'
        iv_query_id = 'DOC_SEL'
        io_msg_handler = lo_handler
    ).

*        ASSIGN lo_bupla_item->* TO <lt_bupla_item>.
    r_result = lo_bupla_item.



  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.
    TRY.
        DATA(lo_bupla) = get_tax_items(
          i_repent = 'PH_CC_CLCT'
          i_repcat = 'YY1_TESTJM2'
          i_reprun = 4
        ).
*        out->write(
*      EXPORTING
*        data   = lo_bupla
**        name   =
**      RECEIVING
**        output =
*    ).
      CATCH cx_srf_error INTO DATA(lx_a).
        "handle exception
        out->write(
          EXPORTING
            data   = lx_a->gv_mtext
*            name   =
*          RECEIVING
*            output =
        ).
    ENDTRY.



  ENDMETHOD.
ENDCLASS.
