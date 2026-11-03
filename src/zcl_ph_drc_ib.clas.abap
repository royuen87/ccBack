CLASS zcl_ph_drc_ib DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: BEGIN OF ty_inventorybook,
             fiscalenddatetext     TYPE c LENGTH 10,
             plant                 TYPE bwkey,
             ValuationType         TYPE bwtar_d,
             CompanyCode           TYPE bukrs,
             IscurrentFiscalPeriod TYPE n LENGTH 2,
             material              TYPE matnr,
             materialname          TYPE c LENGTH 82,
             materialbaseunit      TYPE meins,
             totalvalstockquantity TYPE lbkum,
             currency              TYPE waers,
             itemprice             TYPE stprs,
             totalvalstockvalue    TYPE salk3,
           END OF ty_inventorybook,

           BEGIN OF ty_ib_dateint,
             fiscalenddatetext     TYPE c LENGTH 10,
             plant                 TYPE bwkey,
             ValuationType         TYPE bwtar_d,
             CompanyCode           TYPE bukrs,
             IscurrentFiscalPeriod TYPE n LENGTH 2,
             material              TYPE matnr,
             materialname          TYPE c LENGTH 82,
             materialbaseunit      TYPE meins,
             totalvalstockquantity TYPE lbkum,
             currency              TYPE waers,
             itemprice             TYPE stprs,
             totalvalstockvalue    TYPE salk3,
             date_internal         TYPE datum,
           END OF ty_ib_dateint,

           tt_result TYPE STANDARD TABLE OF ty_inventorybook WITH DEFAULT KEY,
           tt_ib_int TYPE STANDARD TABLE OF ty_ib_dateint WITH DEFAULT KEY.

    CLASS-METHODS get_new_detail_fields
      IMPORTING
        !iv_rep_cat_id       TYPE srf_rep_cat_id
        !iv_reporting_entity TYPE srf_reporting_entity
        !iv_report_run_id    TYPE srf_report_run_id
        !it_report_end_date  TYPE srft_long_selopt
      EXPORTING
        !et_message          TYPE srft_message
        !et_result           TYPE tt_result .

  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA: mo_dp TYPE REF TO zcl_ph_drc_ib.
    CLASS-METHODS create
      RETURNING
        VALUE(r_result) TYPE REF TO zcl_ph_drc_ib.
    METHODS:
      _get_rn_am_ib  IMPORTING io_msg_handler     TYPE REF TO if_srf_msg_handler
                               io_acr             TYPE REF TO if_srf_report_run
                               it_report_end_date TYPE srft_long_selopt
                     RETURNING VALUE(r_result)    TYPE tt_result
                     RAISING   cx_srf_error.
ENDCLASS.



CLASS ZCL_PH_DRC_IB IMPLEMENTATION.


  METHOD create.
    IF mo_dp IS INITIAL.
      mo_dp = NEW zcl_ph_drc_ib( ).
    ENDIF.
    RETURN mo_dp.
  ENDMETHOD.


  METHOD get_new_detail_fields.
    TRY .
        DATA(lo_acr) = cl_srf_facade=>get_report_run_by_id(
                         iv_rep_cat_id       = iv_rep_cat_id
                         iv_reporting_entity = iv_reporting_entity
                         iv_report_run_id    = iv_report_run_id
                       ).
      CATCH cx_srf_error INTO DATA(lx_srf_error).
        RETURN.
    ENDTRY.

    DATA(lo_handler) = cl_srf_facade=>get_message_handler( ).

    CLEAR: lx_srf_error.
    DATA(lo_dp) = create( ).

    TRY.
        et_result = lo_dp->_get_rn_am_ib(
                        io_msg_handler      = lo_handler
                        io_acr              = lo_acr
                        it_report_end_date  = it_report_end_date
                        ).
      CATCH cx_srf_error INTO lx_srf_error.
        RETURN.
    ENDTRY.

  ENDMETHOD.


  METHOD _get_rn_am_ib.
    DATA: ls_result       TYPE ty_inventorybook,
          lt_ib_int       TYPE tt_ib_int.
    TRY .
        DATA(lo_records) = io_acr->execute_query(
          iv_query_id = 'INVENTORY_DETAILS'
          it_column_name = VALUE #(
                                      ( CONV #( 'FISCALENDDATETEXT' ) )
                                      ( CONV #( 'PLANT' ) )
                                      ( CONV #( 'VALUATIONTYPE' ) )
                                      ( CONV #( 'COMPANYCODE' ) )
                                      ( CONV #( 'ISCURRENTFISCALPERIOD' ) )
                                      ( CONV #( 'MATERIAL' ) )
                                      ( CONV #( 'MATERIALNAME' ) )
                                      ( CONV #( 'MATERIALBASEUNIT' ) )
                                      ( CONV #( 'TOTALVALSTOCKQUANTITY' ) )
                                      ( CONV #( 'CURRENCY' ) )
                                      ( CONV #( 'ITEMPRICE' ) )
                                      ( CONV #( 'TOTALVALSTOCKVALUE' ) )
                                  )
            io_msg_handler    = io_msg_handler
          ).
      CATCH cx_srf_error INTO DATA(lx_srf_error).
        RETURN.
    ENDTRY.

    IF lo_records IS NOT INITIAL.
      ASSIGN lo_records->* TO FIELD-SYMBOL(<lt_ib_items>).

      IF <lt_ib_items> IS NOT INITIAL.
        r_result = <lt_ib_items>.

        LOOP AT r_result INTO ls_result.
          APPEND INITIAL LINE TO lt_ib_int ASSIGNING FIELD-SYMBOL(<lfs_ib_int>).
          IF <lfs_ib_int> IS ASSIGNED.
            MOVE-CORRESPONDING ls_result TO <lfs_ib_int>.
            <lfs_ib_int>-date_internal = |{ <lfs_ib_int>-fiscalenddatetext+6(4) }{ <lfs_ib_int>-fiscalenddatetext(2) }{ <lfs_ib_int>-fiscalenddatetext+3(2) }|.
          ENDIF.
          CLEAR:  ls_result.
        ENDLOOP.

        "Delete and get only unique and latest combination for Material - Plant - Date
        SORT lt_ib_int BY material ASCENDING
                          plant ASCENDING
                          date_internal DESCENDING.
        DELETE ADJACENT DUPLICATES FROM lt_ib_int
            COMPARING material
                      plant.
        IF lt_ib_int IS NOT INITIAL.
          CLEAR:  r_result.
          r_result = lt_ib_int.
        ENDIF.
        " Delete duplicate from r_result
        SORT r_result BY plant
                         valuationtype
                         companycode
                         iscurrentfiscalperiod
                         material
                         currency
                         fiscalenddatetext
                         DESCENDING.
        DELETE ADJACENT DUPLICATES FROM r_result COMPARING  plant
                         valuationtype
                         companycode
                         iscurrentfiscalperiod
                         material
                         currency
                         fiscalenddatetext.
      ENDIF.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
