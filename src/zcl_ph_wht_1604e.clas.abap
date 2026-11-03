CLASS zcl_ph_wht_1604e DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES:
      BEGIN OF ty_content,
        CompanyCode                 TYPE  c LENGTH 4,
        AccountingDocument          TYPE  c LENGTH 10,
        FiscalYear                  TYPE  n LENGTH 4,
        AccountingDocumentItem      TYPE  n LENGTH 3,
        WithholdingTaxType          TYPE  c LENGTH 2,
        StatryRptgEntity            TYPE  c LENGTH 10,
        StatryRptCategory           TYPE  c LENGTH 30,
        StatryRptRunID              TYPE  n LENGTH 8,
        PostingDate                 TYPE  datum,
        DocumentDate                TYPE  datum,
        ClearingDate                TYPE  datum,
        ReportingDate               TYPE  datum,
        FiscalPeriod                TYPE  n LENGTH 3,
        WithholdingTaxCode          TYPE  c LENGTH 2,
        BusinessPartner             TYPE  c LENGTH 10,
        BusinessPartnerCountry      TYPE  c LENGTH 3,
        BusinessPartnerNumber       TYPE  c LENGTH 10,
        ReportingCurrency           TYPE  waers,
        WhldgTaxBaseAmtInCoCodeCrcy TYPE  I_Withholdingtaxitem-WhldgTaxBaseAmtInCoCodeCrcy,
        WhldgTaxAmtInCoCodeCrcy     TYPE  I_Withholdingtaxitem-WhldgTaxAmtInCoCodeCrcy,
        Quarter                     TYPE  c LENGTH 2,
        CalendarQuarterPeriod       TYPE  n LENGTH 3,
        WithholdingTaxPercent       TYPE  p LENGTH 7 DECIMALS 4,
        IsReversed                  TYPE  c LENGTH 1,
        IsReversal                  TYPE  c LENGTH 1,
        BPTaxNumber                 TYPE  c LENGTH 18,
        Name                        TYPE  c LENGTH 80,
        CustomerSupplierHouseNumber TYPE  c LENGTH 10,
        CustomerSupplierCityName    TYPE  c LENGTH 40,
        CustomerSupplierStreetName  TYPE  c LENGTH 60,
        StreetPrefixName1           TYPE  c LENGTH 40,
        AdditionalStreetPrefixName  TYPE  c LENGTH 40,
        StreetSuffixName            TYPE  c LENGTH 40,
        AdditionalStreetSuffixName  TYPE  c LENGTH 40,
        CustomerSupplierPostalCode  TYPE  c LENGTH 10,
        SupplierAddress             TYPE  c LENGTH 255,
        VATRegistration             TYPE  c LENGTH 20,
        Company                     TYPE  c LENGTH 6,
        CompanyCodeName             TYPE  c LENGTH 25,
        HouseNumber                 TYPE  c LENGTH 10,
        StreetName                  TYPE  c LENGTH 60,
        StreetPrefixName            TYPE  c LENGTH 40,
        CityName                    TYPE  c LENGTH 40,
        POBox                       TYPE  c LENGTH 10,
        PostalCode                  TYPE  c LENGTH 10,
        IsNaturalPerson             TYPE  c LENGTH 1,
        OfficialWhldgTaxCode        TYPE  c LENGTH 4,
        Language                    TYPE  spras,
        OfficialWhldgTaxCodeDesc    TYPE  c LENGTH 40,
        ItemIsReportingRelevant     TYPE  c LENGTH 1,
        BusinessPartnerCategory     TYPE  c LENGTH 1,
        LastName                    TYPE  c LENGTH 40,
        FirstName                   TYPE  c LENGTH 40,
        MiddleName                  TYPE  c LENGTH 40,
        OrganizationBPName1         TYPE  c LENGTH 40,
        OrganizationBPName2         TYPE  c LENGTH 40,
        OrganizationBPName3         TYPE  c LENGTH 163,
        WhldgTaxDocumentType        TYPE  c LENGTH 3,
      END OF ty_content,

      BEGIN OF ty_taxcode,
        sign   TYPE c LENGTH 1,
        option TYPE c LENGTH 2,
        low    TYPE c LENGTH 2,
        high   TYPE c LENGTH 2,
      END OF ty_taxcode,

      BEGIN OF ty_summary,
        ReportingCurrency           TYPE  waers,
        WhldgTaxBaseAmtInCoCodeCrcy TYPE  I_Withholdingtaxitem-WhldgTaxBaseAmtInCoCodeCrcy,
        WhldgTaxAmtInCoCodeCrcy     TYPE  I_Withholdingtaxitem-WhldgTaxAmtInCoCodeCrcy,
      END OF ty_summary,

      tt_content TYPE STANDARD TABLE OF ty_content WITH DEFAULT KEY,
      tt_taxcode TYPE STANDARD TABLE OF ty_taxcode.

    CLASS-METHODS:  filter_tax_items  IMPORTING i_repent   TYPE srf_reporting_entity
                                                i_repcat   TYPE srf_rep_cat_id
                                                i_reprun   TYPE srf_report_run_id
                                      EXPORTING et_result  TYPE tt_content
                                                et_message TYPE srft_message,
      get_vendor_sum    IMPORTING i_repent   TYPE srf_reporting_entity
                                  i_repcat   TYPE srf_rep_cat_id
                                  i_reprun   TYPE srf_report_run_id
                        EXPORTING es_result  TYPE ty_summary
                                  et_message TYPE srft_message.

  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA: mo_app         TYPE REF TO zcl_ph_wht_1604e.
    CLASS-METHODS create
      RETURNING
        VALUE(r_result) TYPE REF TO zcl_ph_wht_1604e.
    DATA: mt_result TYPE tt_content.
    METHODS:  get_filtered_data IMPORTING i_repent         TYPE srf_reporting_entity
                                          i_repcat         TYPE srf_rep_cat_id
                                          i_reprun         TYPE srf_report_run_id
                                RETURNING VALUE(rt_result) TYPE tt_content.
ENDCLASS.



CLASS ZCL_PH_WHT_1604E IMPLEMENTATION.


  METHOD create.

    IF mo_app IS INITIAL.
      mo_app = NEW zcl_ph_wht_1604e( ).
    ENDIF.

    RETURN mo_app.

  ENDMETHOD.


  METHOD filter_tax_items.
    DATA(lo_app) = create( ).

    et_result = lo_app->get_filtered_data(
      i_repent = i_repent
      i_repcat = i_repcat
      i_reprun = i_reprun
     ).
  ENDMETHOD.


  METHOD get_filtered_data.
    DATA: lr_tax_ci TYPE tt_taxcode,
          lr_tax_cp TYPE tt_taxcode,
          lr_tax_ey TYPE tt_taxcode,
          lr_tax_ez TYPE tt_taxcode,
          lr_tax_gi TYPE tt_taxcode,
          lr_tax_gp TYPE tt_taxcode,
          ls_record TYPE ty_content.

    IF mt_result[] IS NOT INITIAL.
      RETURN mt_result.
    ENDIF.

    TRY .
        DATA(lo_acr) = cl_srf_facade=>get_report_run_by_id(
                         iv_rep_cat_id       = i_repcat
                         iv_reporting_entity = i_repent
                         iv_report_run_id    = i_reprun
                       ).
      CATCH cx_srf_error INTO DATA(lx_srf_error).
        RETURN.
    ENDTRY.

    DATA(lo_handler) = cl_srf_facade=>get_message_handler( ).

    TRY.
        DATA(lo_records) = lo_acr->execute_query(
          EXPORTING
            iv_query_id = 'TAX_ITEM_DETAILS'
            io_msg_handler = lo_handler
            it_column_name = VALUE #( ( CONV #( 'CompanyCode' ) )
                                      ( CONV #( 'AccountingDocument' ) )
                                      ( CONV #( 'FiscalYear' ) )
                                      ( CONV #( 'AccountingDocumentItem' ) )
                                      ( CONV #( 'WithholdingTaxType' ) )
                                      ( CONV #( 'StatryRptgEntity' ) )
                                      ( CONV #( 'StatryRptCategory' ) )
                                      ( CONV #( 'StatryRptRunID' ) )
                                      ( CONV #( 'PostingDate' ) )
                                      ( CONV #( 'DocumentDate' ) )
                                      ( CONV #( 'ClearingDate' ) )
                                      ( CONV #( 'ReportingDate' ) )
                                      ( CONV #( 'FiscalPeriod' ) )
                                      ( CONV #( 'WithholdingTaxCode' ) )
                                      ( CONV #( 'BusinessPartner' ) )
                                      ( CONV #( 'BusinessPartnerCountry' ) )
                                      ( CONV #( 'BusinessPartnerNumber' ) )
                                      ( CONV #( 'ReportingCurrency' ) )
                                      ( CONV #( 'WhldgTaxBaseAmtInCoCodeCrcy' ) )
                                      ( CONV #( 'WhldgTaxAmtInCoCodeCrcy' ) )
                                      ( CONV #( 'Quarter' ) )
                                      ( CONV #( 'CalendarQuarterPeriod' ) )
                                      ( CONV #( 'WithholdingTaxPercent' ) )
                                      ( CONV #( 'IsReversed' ) )
                                      ( CONV #( 'IsReversal' ) )
                                      ( CONV #( 'BPTaxNumber' ) )
                                      ( CONV #( 'Name' ) )
                                      ( CONV #( 'CustomerSupplierHouseNumber' ) )
                                      ( CONV #( 'CustomerSupplierCityName' ) )
                                      ( CONV #( 'CustomerSupplierStreetName' ) )
                                      ( CONV #( 'StreetPrefixName1' ) )
                                      ( CONV #( 'AdditionalStreetPrefixName' ) )
                                      ( CONV #( 'StreetSuffixName' ) )
                                      ( CONV #( 'AdditionalStreetSuffixName' ) )
                                      ( CONV #( 'CustomerSupplierPostalCode' ) )
                                      ( CONV #( 'SupplierAddress' ) )
                                      ( CONV #( 'VATRegistration' ) )
                                      ( CONV #( 'Company' ) )
                                      ( CONV #( 'CompanyCodeName' ) )
                                      ( CONV #( 'HouseNumber' ) )
                                      ( CONV #( 'StreetName' ) )
                                      ( CONV #( 'StreetPrefixName' ) )
                                      ( CONV #( 'CityName' ) )
                                      ( CONV #( 'POBox' ) )
                                      ( CONV #( 'PostalCode' ) )
                                      ( CONV #( 'IsNaturalPerson' ) )
                                      ( CONV #( 'OfficialWhldgTaxCode' ) )
                                      ( CONV #( 'Language' ) )
                                      ( CONV #( 'OfficialWhldgTaxCodeDesc' ) )
                                      ( CONV #( 'ItemIsReportingRelevant' ) )
                                      ( CONV #( 'BusinessPartnerCategory' ) )
                                      ( CONV #( 'LastName' ) )
                                      ( CONV #( 'FirstName' ) )
                                      ( CONV #( 'MiddleName' ) )
                                      ( CONV #( 'OrganizationBPName1' ) )
                                      ( CONV #( 'OrganizationBPName2' ) )
                                      ( CONV #( 'OrganizationBPName3' ) )
                                      ( CONV #( 'WhldgTaxDocumentType' ) )
                                       )
        ).
      CATCH cx_srf_error INTO lx_srf_error.
        RETURN.
    ENDTRY.

    ASSIGN lo_records->* TO FIELD-SYMBOL(<lfs_records>).
    IF <lfs_records> IS ASSIGNED.
      "Populate range tables for CI codes
      lr_tax_ci = VALUE #(
                    sign    = 'I'
                    option  = 'EQ'
                    ( low   = '14'  )
                    ( low   = '15'  )
                    ( low   = '16'  )
                    ( low   = '21'  )
                    ( low   = '23'  )
                    ( low   = '24'  )
                    ( low   = '30'  )
                    ( low   = '31'  )
                    ).

      "Populate range tables for CP codes
      lr_tax_cp = VALUE #(
                    sign    = 'I'
                    option  = 'EQ'
                    ( low   = '14'  )
                    ( low   = '16'  )
                    ( low   = '17'  )
                    ( low   = '21'  )
                    ( low   = '24'  )
                    ( low   = '30'  )
                    ( low   = '31'  )
                    ( low   = '33'  )
                    ).
      "Populate range tables for EY codes
      lr_tax_ey = VALUE #(
                    sign    = 'I'
                    option  = 'EQ'
                    ( low   = '01'  )
                    ( low   = '02'  )
                    ( low   = '03'  )
                    ( low   = '04'  )
                    ( low   = '05'  )
                    ( low   = '06'  )
                    ( low   = '07'  )
                    ( low   = '08'  )
                    ( low   = '09'  )
                    ( low   = '10'  )
                    ( low   = '11'  )
                    ( low   = '12'  )
                    ( low   = '13'  )
                    ).
      "Populate range tables for EZ codes
      lr_tax_ez = VALUE #(
                    sign    = 'I'
                    option  = 'EQ'
                    ( low   = '01'  )
                    ( low   = '02'  )
                    ( low   = '03'  )
                    ( low   = '04'  )
                    ( low   = '05'  )
                    ( low   = '06'  )
                    ( low   = '07'  )
                    ( low   = '08'  )
                    ( low   = '09'  )
                    ( low   = '10'  )
                    ( low   = '11'  )
                    ( low   = '12'  )
                    ( low   = '13'  )
                    ).
      "Populate range tables for GI codes
      lr_tax_gi = VALUE #(
                    sign    = 'I'
                    option  = 'EQ'
                    ( low   = '01'  )
                    ( low   = '02'  )
                    ( low   = '03'  )
                    ( low   = '04'  )
                    ).
      "Populate range tables for GP codes
      lr_tax_gp = VALUE #(
                    sign    = 'I'
                    option  = 'EQ'
                    ( low   = '01'  )
                    ( low   = '02'  )
                    ( low   = '03'  )
                    ( low   = '04'  )
                    ).

      LOOP AT <lfs_records> ASSIGNING FIELD-SYMBOL(<lfs_record>).
        ls_record = CORRESPONDING #( <lfs_record> ).
        CASE ls_record-withholdingtaxtype.
          WHEN 'CI'.
            IF ls_record-withholdingtaxcode IN lr_tax_ci[].
              CONTINUE.
            ENDIF.

          WHEN 'CP'.
            IF ls_record-withholdingtaxcode IN lr_tax_cp[].
              CONTINUE.
            ENDIF.

          WHEN 'EY'.
            IF ls_record-withholdingtaxcode IN lr_tax_ey[].
              CONTINUE.
            ENDIF.

          WHEN 'EZ'.
            IF ls_record-withholdingtaxcode IN lr_tax_ez[].
              CONTINUE.
            ENDIF.

          WHEN 'GI'.
            IF ls_record-withholdingtaxcode IN lr_tax_gi[].
              CONTINUE.
            ENDIF.

          WHEN 'GP'.
            IF ls_record-withholdingtaxcode IN lr_tax_gp[].
              CONTINUE.
            ENDIF.

          WHEN OTHERS.
            "Do nothing
        ENDCASE.

        APPEND ls_record TO mt_result.
      ENDLOOP.
      UNASSIGN: <lfs_record>.
    ENDIF.

    RETURN mt_result.

  ENDMETHOD.


  METHOD get_vendor_sum.
    DATA(lo_app) = create( ).

    DATA(lt_result) = lo_app->get_filtered_data(
      i_repent = i_repent
      i_repcat = i_repcat
      i_reprun = i_reprun
     ).

    IF lt_result IS NOT INITIAL.
      es_result = REDUCE #( INIT ls_totals TYPE ty_summary
        FOR ls_result IN lt_result
        NEXT  ls_totals-reportingcurrency = ls_result-reportingcurrency
              ls_totals-whldgtaxamtincocodecrcy += ls_result-whldgtaxamtincocodecrcy
              ls_totals-whldgtaxbaseamtincocodecrcy += ls_result-whldgtaxbaseamtincocodecrcy
        ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
