CLASS zcl_nr_getter DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.

    TYPES: ty_soanr    TYPE c LENGTH 8,
           ty_nrreturn TYPE c LENGTH 1.

    CLASS-METHODS: get_soa_number
      IMPORTING i_companycode TYPE bukrs DEFAULT 'CNCT'
      EXPORTING e_soanumber   TYPE ty_soanr
                e_rc          TYPE ty_nrreturn.
    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_NR_GETTER IMPLEMENTATION.


  METHOD get_soa_number.

    e_rc = 4.

    TRY.

        DATA(lv_interval) = COND cl_numberrange_runtime=>nr_interval(
            WHEN i_companycode = 'CNTC' THEN '02'
            WHEN i_companycode = 'CLCT' THEN '03'
        ).

        cl_numberrange_runtime=>number_get(
          EXPORTING
                nr_range_nr       = lv_interval
                object            = 'ZNO_SOA'
                quantity          = 1
              IMPORTING
                number            = DATA(lv_number)
                returncode        = DATA(lv_rc)
        ).

        e_soanumber = |{ lv_number ALPHA = OUT }|.
        e_soanumber = |{ lv_number ALPHA = IN }|.
        e_rc = lv_rc.

        ##NO_HANDLER
      CATCH cx_nr_object_not_found.
        ##NO_HANDLER
      CATCH cx_number_ranges.

    ENDTRY.
  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.

    get_soa_number(
      EXPORTING i_companycode = 'CLCT'
      IMPORTING
        e_soanumber = DATA(lv_soa)
        e_rc        = DATA(lv_rc)
    ).

    out->write(
      EXPORTING
        data   =  lv_soa
        name   = 'Soa number'
    ).

    out->write(
      EXPORTING
        data   =  lv_rc
        name   = 'Return code'
    ).

  ENDMETHOD.
ENDCLASS.
