CLASS zcl_ph_drc_util DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: BEGIN OF ty_variables,"test
             name      TYPE string,
             address   TYPE string,
             returnper TYPE string,
             bpnumber  TYPE c LENGTH 10,
             acctgnum  TYPE c LENGTH 10,
           END OF ty_variables,

           BEGIN OF ty_result,
             num_records    TYPE c LENGTH 20,
             amount         TYPE dmbtr,
             cutt_off_dtime TYPE c LENGTH 100,
             extracted_by   TYPE c LENGTH 100,
           END OF ty_result,

           BEGIN OF ty_content,
             CompanyCode                  TYPE  bukrs,
             AccountingDocumentType       TYPE  blart,
             AccountingDocument           TYPE  belnr_d,
             FiscalYear                   TYPE  gjahr,
             StatryRptgEntity             TYPE  srf_reporting_entity,
             StatryRptCategory            TYPE  srf_rep_cat_id,
             StatryRptRunID               TYPE  srf_report_run_id,
             PostingDate                  TYPE  fis_budat,
             TaxBoxStrucValidityStartDate TYPE  datum,
             UnifiedTaxBoxStructureType   TYPE  c LENGTH 5,
             TaxBox                       TYPE  c LENGTH 15,
             TaxItemGroupingVersion       TYPE  c LENGTH 4,
             TaxBoxStructureType          TYPE  c LENGTH 5,
             ReportingDate                TYPE  datum,
             DocumentDate                 TYPE  bldat,
             TaxBoxStrucValidityEndDate   TYPE  datum,
             TaxReportingDate             TYPE  vatdate,
             TaxRateValidityStartDate     TYPE  datum,
             FiscalPeriod                 TYPE  fins_fiscalperiod,
             AccountingDocumentHeaderText TYPE  bktxt,
             DocumentReferenceID          TYPE  xblnr1,
             BusinessPartner              TYPE  c LENGTH 10,
             BusinessPartnerCountry       TYPE  c LENGTH 3,
             TaxNumber1                   TYPE  stcd1,
             TaxNumber2                   TYPE  stcd2,
             TaxNumber3                   TYPE  stcd3,
             BusinessPartnerName          TYPE  c LENGTH 80,
             CustomerSupplierAddress      TYPE  c LENGTH 120,
             Supplier                     TYPE  c LENGTH 10,
             SupplierTaxID1               TYPE  c LENGTH 16,
             SupplierTaxID2               TYPE  c LENGTH 11,
             SupplierTaxID3               TYPE  c LENGTH 18,
             SupplierAddress              TYPE  c LENGTH 255,
             SupplierName                 TYPE  c LENGTH 81,
             BusinessPlace                TYPE  bupla,
             TaxCode                      TYPE  mwskz,
             IPITaxRate                   TYPE  n LENGTH 12,
             TaxRate                      TYPE  p LENGTH 5 DECIMALS 2,
             ExchangeRate                 TYPE  ukurs_curr,
             TransactionTypeDetermination TYPE  ktosl,
             GLAccount                    TYPE  hkont,
             ReportingCountry             TYPE  c LENGTH 3,
             ReportingCurrency            TYPE  waers,
             TaxBaseAmountInRptgCrcy      TYPE  dmbtr,
             TaxAmountInRptgCrcy          TYPE  dmbtr,
             TaxBaseAmountInCoCodeCrcy    TYPE  dmbtr,
             TaxAmountInCoCodeCrcy        TYPE  dmbtr,
             DocumentCurrency             TYPE  waers,
             TaxBaseAmountInTransCrcy     TYPE  fwbas_bses,
             TaxAmount                    TYPE  dmbtr,
             GrossAmountInCoCodeCurrency  TYPE  dmbtr,
             DiscountAmtInCoCodeCrcy      TYPE  dmbtr,
             DiscountBaseAmtInCoCodeCrcy  TYPE  dmbtr,
             InvoiceAmtInCoCodeCrcy       TYPE  dmbtr,
             InvoiceBaseAmtInCoCodeCrcy   TYPE  dmbtr,
             TaxCodeName                  TYPE  c LENGTH 50,
             TaxTypeName                  TYPE  c LENGTH 60,
           END OF ty_content,

           tt_result  TYPE STANDARD TABLE OF ty_result WITH DEFAULT KEY,
           tt_content TYPE STANDARD TABLE OF ty_content WITH DEFAULT KEY.

    CLASS-METHODS get_new_header_fields
      IMPORTING
        !iv_rep_cat_id              TYPE srf_rep_cat_id
        !iv_reporting_entity        TYPE srf_reporting_entity
        !iv_report_run_id           TYPE srf_report_run_id
        !it_report_end_date         TYPE srft_long_selopt
        !iv_query_id                TYPE srf_query_id
        !it_record_group            TYPE srft_long_selopt OPTIONAL
        !it_postive_amount_columns  TYPE srft_long_selopt OPTIONAL
        !it_negative_amount_columns TYPE srft_long_selopt OPTIONAL
      EXPORTING
        !et_message                 TYPE srft_message
        !et_result                  TYPE tt_result .

    CLASS-METHODS:  filter_taxitems_1600vt
      IMPORTING i_repent   TYPE srf_reporting_entity
                i_repcat   TYPE srf_rep_cat_id
                i_reprun   TYPE srf_report_run_id
      EXPORTING et_result  TYPE tt_content
                et_message TYPE srft_message.

    CLASS-METHODS:  remove_comma
      IMPORTING iv_name    TYPE ty_variables-name OPTIONAL
                iv_addr    TYPE string OPTIONAL
      EXPORTING ev_name    TYPE ty_variables
                et_message TYPE srft_message,
      remove_comma_inline
        IMPORTING iv_name    TYPE ty_variables-name OPTIONAL
                  iv_addr    TYPE string OPTIONAL
        EXPORTING ev_name    TYPE ty_variables-name
                  et_message TYPE srft_message,
      remove_comma_addr
        IMPORTING
                  iv_addr    TYPE string OPTIONAL
        EXPORTING ev_addr    TYPE ty_variables
                  et_message TYPE srft_message,
      formatdate_1600VT
        IMPORTING
          iv_date    TYPE string OPTIONAL
        EXPORTING
          ev_date    TYPE ty_variables
          et_message TYPE srft_message,
      retrv_bpfullname
        IMPORTING
          iv_bpnum   TYPE ty_variables-bpnumber OPTIONAL
        EXPORTING
          ev_bpnum   TYPE ty_variables
          et_message TYPE srft_message,
      retrv_bpfulladdr
        IMPORTING
          iv_bpnum     TYPE ty_variables-bpnumber OPTIONAL
          iv_accntgdoc TYPE ty_variables-acctgnum OPTIONAL
        EXPORTING
          ev_fulladdr  TYPE ty_variables
          et_message   TYPE srft_message.
  PROTECTED SECTION.
  PRIVATE SECTION.

    CLASS-DATA: mo_dp TYPE REF TO zcl_ph_drc_util.


ENDCLASS.



CLASS ZCL_PH_DRC_UTIL IMPLEMENTATION.


  METHOD remove_comma.
    DATA(lv_name) = iv_name.
    IF lv_name IS NOT INITIAL.
      REPLACE ALL OCCURRENCES OF ',' IN lv_name WITH ''.
      REPLACE ALL OCCURRENCES OF '&' IN lv_name WITH 'and'.
      REPLACE ALL OCCURRENCES OF '-' IN lv_name WITH | |.

      ev_name-name = lv_name.
    ENDIF.

    DATA(lv_addr) = iv_addr.
    IF lv_addr IS NOT INITIAL.
      REPLACE ALL OCCURRENCES OF ',' IN lv_addr WITH ''.
      REPLACE ALL OCCURRENCES OF '&' IN lv_addr WITH 'and'.
      REPLACE ALL OCCURRENCES OF '-' IN lv_addr WITH | |.

      ev_name-address = lv_addr.
    ENDIF.

  ENDMETHOD.


  METHOD remove_comma_inline.
    DATA(lv_name) = iv_name.
    IF lv_name IS NOT INITIAL.
      REPLACE ALL OCCURRENCES OF ',' IN lv_name WITH ''.
      REPLACE ALL OCCURRENCES OF '&' IN lv_name WITH 'and'.
      REPLACE ALL OCCURRENCES OF '-' IN lv_name WITH | |.


      ev_name = lv_name.
    ENDIF.
*    DATA(lv_addr) = iv_addr.
*        IF lv_addr IS NOT INITIAL.
*          REPLACE ALL OCCURRENCES OF ',' IN lv_addr WITH ''.
*        REPLACE ALL OCCURRENCES OF '&' IN lv_addr WITH 'and'.
*        REPLACE ALL OCCURRENCES OF '-' IN lv_addr WITH | |.
*
*        ev_address = lv_addr.
*    ENDIF.

  ENDMETHOD.


  METHOD remove_comma_addr.
    DATA(lv_addr) = iv_addr.
    IF lv_addr IS NOT INITIAL.
      REPLACE ALL OCCURRENCES OF ',' IN lv_addr WITH ''.
      REPLACE ALL OCCURRENCES OF '&' IN lv_addr WITH 'and'.
      REPLACE ALL OCCURRENCES OF '-' IN lv_addr WITH | |.

      ev_addr-address = lv_addr.
    ENDIF.
  ENDMETHOD.


  METHOD formatdate_1600vt.
    DATA(lv_date) = iv_date.
    ev_date-returnper = |{ iv_date+4(2) }/{ iv_date+0(4) }|.
  ENDMETHOD.


  METHOD retrv_bpfullname.
    DATA: lv_bpfullname TYPE string.
    SELECT SINGLE BusinessPartnerFullName
    FROM I_BusinessPartner
    WHERE BusinessPartner = @iv_bpnum
    INTO @lv_bpfullname.
    IF sy-subrc = 0.
      remove_comma( EXPORTING iv_name = lv_bpfullname
                    IMPORTING ev_name = ev_bpnum ).
    ENDIF.
  ENDMETHOD.


  METHOD retrv_bpfulladdr.
    DATA: lv_bpfulladdr TYPE string.

    SELECT SINGLE addressid
   FROM I_BPCurrentDefaultAddress
   WHERE BusinessPartner = @iv_bpnum
   INTO @DATA(lv_bpaddressid).
    IF sy-subrc = 0.
      SELECT SINGLE
      CAST(

         concat_with_space( HouseNumber,
           concat_with_space(
             StreetName,
             concat_with_space(
               CityName,
               concat_with_space( Country, PostalCode, 1 ),
             1 ),
           1 ),
         1 ) AS SSTRING ) AS CustomerSupplierAddress
         FROM i_address_2 WITH PRIVILEGED ACCESS
         WHERE AddressID = @lv_bpaddressid
         INTO @lv_bpfulladdr.
    ENDIF.

    IF sy-subrc = 0.
      remove_comma( EXPORTING iv_addr = lv_bpfulladdr
                    IMPORTING ev_name = ev_fulladdr ).
    ENDIF.
  ENDMETHOD.


  METHOD get_new_header_fields.
    DATA: lo_records_proc TYPE REF TO data,
          ls_column       TYPE srfs_long_selopt.
    FIELD-SYMBOLS: <lt_records>      TYPE table,
                   <lt_records_proc> TYPE table.

    TRY .
        DATA(lo_acr) = cl_srf_facade=>get_report_run_by_id(
                         iv_rep_cat_id       = iv_rep_cat_id
                         iv_reporting_entity = iv_reporting_entity
                         iv_report_run_id    = iv_report_run_id
                       ).

        DATA(lo_handler) = cl_srf_facade=>get_message_handler( ).

*        IF it_record_group IS NOT INITIAL.
*
*          DATA(lt_cols) = VALUE if_srf_report_run=>gtt_column_name(
*            FOR _group IN it_record_group
*            ( CONV #(  _group-low ) )
*          ).
*
*          APPEND LINES OF it_postive_amount_columns TO lt_cols.
*          APPEND LINES OF it_negative_amount_columns TO lt_cols.
*          SORT lt_cols.
*          DELETE ADJACENT DUPLICATES FROM lt_cols.
*
*        ENDIF.

        DATA(lo_records) = lo_acr->execute_query(
                  EXPORTING
                    iv_query_id    = iv_query_id
*                    it_column_name = lt_cols
                    io_msg_handler = lo_handler
                ).

        IF lo_records IS NOT INITIAL.

          APPEND INITIAL LINE TO et_result ASSIGNING FIELD-SYMBOL(<ls_result>).

          SELECT SINGLE FROM I_BusinessUserBasic
          FIELDS PersonFullName
          WHERE UserID = @sy-uname
          INTO @DATA(lv_name).

          <ls_result>-extracted_by = lv_name.

          ASSIGN lo_records->* TO <lt_records>.
          IF <lt_records> IS ASSIGNED AND <lt_records> IS NOT INITIAL.

            IF it_record_group IS NOT INITIAL.

              DATA(lt_components) = CAST cl_abap_structdescr(
                  CAST cl_abap_tabledescr( cl_abap_tabledescr=>describe_by_data( p_data      = lo_records ) )->get_table_line_type( )
              )->get_components( ).

              LOOP AT lt_components INTO DATA(ls_components).
                DATA(lv_idx) = sy-tabix.
                READ TABLE it_record_group TRANSPORTING NO FIELDS WITH KEY low = ls_components-name.
                IF sy-subrc <> 0.
                  DELETE lt_components INDEX lv_idx.
                ENDIF.
              ENDLOOP.

              DATA(lo_strdesc) = cl_abap_structdescr=>create( p_components = lt_components ).
              DATA(lo_tabdesc) = cl_abap_tabledescr=>create( p_line_type  = lo_strdesc ).

              CREATE DATA lo_records_proc TYPE HANDLE lo_tabdesc.
              ASSIGN lo_records_proc->* TO <lt_records_proc>.
              <lt_records_proc> = CORRESPONDING #( <lt_records> ).
              SORT <lt_records_proc>.
              DELETE ADJACENT DUPLICATES FROM <lt_records_proc>.

              <ls_result>-num_records = lines( <lt_records_proc> ).

            ELSE.

              <ls_result>-num_records = lines( <lt_records> ).

            ENDIF.

            IF it_postive_amount_columns IS NOT INITIAL OR it_negative_amount_columns IS NOT INITIAL.

              LOOP AT <lt_records> ASSIGNING FIELD-SYMBOL(<ls_records>).

                LOOP AT it_postive_amount_columns INTO ls_column.
                  ASSIGN COMPONENT ls_column-low OF STRUCTURE <ls_records> TO FIELD-SYMBOL(<lv_field>).
                  IF sy-subrc = 0.
                    <ls_result>-amount += <lv_field>.
                  ENDIF.
                ENDLOOP.

                LOOP AT it_negative_amount_columns INTO ls_column.
                  ASSIGN COMPONENT ls_column-low OF STRUCTURE <ls_records> TO <lv_field>.
                  IF sy-subrc = 0.
                    <ls_result>-amount -= abs( <lv_field> ).
                  ENDIF.
                ENDLOOP.

              ENDLOOP.

            ENDIF.

          ENDIF.
        ENDIF.

      CATCH cx_srf_error INTO DATA(lx_srf_error).
        APPEND lx_srf_error->ms_msg TO et_message.
    ENDTRY.

  ENDMETHOD.


  METHOD filter_taxitems_1600vt.
    DATA: ls_record   TYPE ty_content,
          lt_taxitems TYPE tt_content.

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
            iv_query_id = 'TAX_ITEM'
            io_msg_handler = lo_handler
            it_column_name = VALUE #( ( CONV #( 'CompanyCode' ) )
                                      ( CONV #( 'AccountingDocumentType' ) )
                                      ( CONV #( 'AccountingDocument' ) )
                                      ( CONV #( 'FiscalYear' ) )
                                      ( CONV #( 'StatryRptgEntity' ) )
                                      ( CONV #( 'StatryRptCategory' ) )
                                      ( CONV #( 'StatryRptRunID' ) )
                                      ( CONV #( 'PostingDate' ) )
                                      ( CONV #( 'TaxBoxStrucValidityStartDate' ) )
                                      ( CONV #( 'UnifiedTaxBoxStructureType' ) )
                                      ( CONV #( 'TaxBox' ) )
                                      ( CONV #( 'TaxItemGroupingVersion' ) )
                                      ( CONV #( 'TaxBoxStructureType' ) )
                                      ( CONV #( 'ReportingDate' ) )
                                      ( CONV #( 'DocumentDate' ) )
                                      ( CONV #( 'TaxBoxStrucValidityEndDate' ) )
                                      ( CONV #( 'TaxReportingDate' ) )
                                      ( CONV #( 'TaxRateValidityStartDate' ) )
                                      ( CONV #( 'FiscalPeriod' ) )
                                      ( CONV #( 'AccountingDocumentHeaderText' ) )
                                      ( CONV #( 'DocumentReferenceID' ) )
                                      ( CONV #( 'BusinessPartner' ) )
                                      ( CONV #( 'BusinessPartnerCountry' ) )
                                      ( CONV #( 'TaxNumber1' ) )
                                      ( CONV #( 'TaxNumber2' ) )
                                      ( CONV #( 'TaxNumber3' ) )
                                      ( CONV #( 'BusinessPartnerName' ) )
                                      ( CONV #( 'CustomerSupplierAddress' ) )
                                      ( CONV #( 'Supplier' ) )
                                      ( CONV #( 'SupplierTaxID1' ) )
                                      ( CONV #( 'SupplierTaxID2' ) )
                                      ( CONV #( 'SupplierTaxID3' ) )
                                      ( CONV #( 'SupplierAddress' ) )
                                      ( CONV #( 'SupplierName' ) )
                                      ( CONV #( 'BusinessPlace' ) )
                                      ( CONV #( 'TaxCode' ) )
                                      ( CONV #( 'IPITaxRate' ) )
                                      ( CONV #( 'TaxRate' ) )
                                      ( CONV #( 'ExchangeRate' ) )
                                      ( CONV #( 'TransactionTypeDetermination' ) )
                                      ( CONV #( 'GLAccount' ) )
                                      ( CONV #( 'ReportingCountry' ) )
                                      ( CONV #( 'ReportingCurrency' ) )
                                      ( CONV #( 'TaxBaseAmountInRptgCrcy' ) )
                                      ( CONV #( 'TaxAmountInRptgCrcy' ) )
                                      ( CONV #( 'TaxBaseAmountInCoCodeCrcy' ) )
                                      ( CONV #( 'TaxAmountInCoCodeCrcy' ) )
                                      ( CONV #( 'DocumentCurrency' ) )
                                      ( CONV #( 'TaxBaseAmountInTransCrcy' ) )
                                      ( CONV #( 'TaxAmount' ) )
                                      ( CONV #( 'GrossAmountInCoCodeCurrency' ) )
                                      ( CONV #( 'DiscountAmtInCoCodeCrcy' ) )
                                      ( CONV #( 'DiscountBaseAmtInCoCodeCrcy' ) )
                                      ( CONV #( 'InvoiceAmtInCoCodeCrcy' ) )
                                      ( CONV #( 'InvoiceBaseAmtInCoCodeCrcy' ) )
                                      ( CONV #( 'TaxCodeName' ) )
                                      ( CONV #( 'TaxTypeName' ) )
                                       ) ).
      CATCH cx_srf_error INTO lx_srf_error.
        RETURN.
    ENDTRY.

    ASSIGN lo_records->* TO FIELD-SYMBOL(<lfs_records>).
    IF <lfs_records> IS ASSIGNED.

      LOOP AT <lfs_records> ASSIGNING FIELD-SYMBOL(<lfs_record>).
        ls_record = CORRESPONDING #( <lfs_record> ).
        APPEND ls_record TO lt_taxitems.
      ENDLOOP.
      UNASSIGN: <lfs_record>.

      IF lt_taxitems IS NOT INITIAL.
        SELECT  CompanyCode,
                FiscalYear,
                AccountingDocument
        FROM i_journalentry
        FOR ALL ENTRIES IN @lt_taxitems
        WHERE CompanyCode = @lt_taxitems-companycode
          AND FiscalYear  = @lt_taxitems-fiscalyear
          AND AccountingDocument = @lt_taxitems-accountingdocument
          AND IsReversal IS INITIAL
          AND IsReversed IS INITIAL
        INTO TABLE @DATA(lt_sourcedoc).

        IF lt_sourcedoc IS NOT INITIAL.
          LOOP AT lt_taxitems ASSIGNING FIELD-SYMBOL(<lfs_taxitems>).
            IF line_exists( lt_sourcedoc[ CompanyCode = <lfs_taxitems>-companycode
                                          FiscalYear = <lfs_taxitems>-fiscalyear
                                          AccountingDocument  = <lfs_taxitems>-accountingdocument
                                          ] ).
              APPEND <lfs_taxitems> TO et_result.
            ENDIF.
          ENDLOOP.
          UNASSIGN: <lfs_taxitems>.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
