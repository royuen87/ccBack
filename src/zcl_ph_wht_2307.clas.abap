CLASS zcl_ph_wht_2307 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: BEGIN OF ty_doc_sel,
             CompanyCode           TYPE c LENGTH 4,
             AccountingDocument    TYPE c LENGTH 10,
             FiscalYear            TYPE n LENGTH 4,
             WithholdingTaxType    TYPE c LENGTH 2,
             StatryRptgEntity      TYPE c LENGTH 10,
             StatryRptCategory     TYPE c LENGTH 30,
             StatryRptRunID        TYPE n LENGTH 8,
             PostingDate           TYPE datum,
             DocumentDate          TYPE datum,
             ClearingDate          TYPE datum,
             ReportingDate         TYPE datum,
             FiscalPeriod          TYPE n LENGTH 3,
             Quarter               TYPE c LENGTH 2,
             CalendarQuarterPeriod TYPE n LENGTH 3,
             BusinessPartner       TYPE c LENGTH 10,
             BPTaxNumber           TYPE c LENGTH 18,
             VATRegistration       TYPE c LENGTH 20,
             OfficialWhldgTaxCode  TYPE c LENGTH 4,
           END OF ty_doc_sel,

           BEGIN OF ty_bupla_addr,
             AddressID                 TYPE c LENGTH 10,
             AddressPersonID           TYPE c LENGTH 10,
             AddressRepresentationCode TYPE c LENGTH 1,
             completeaddress           TYPE c LENGTH 157,
             AddressSearchTerm1        TYPE c LENGTH 20,
             PostalCode                TYPE c LENGTH 10,
           END OF ty_bupla_addr,

           BEGIN OF ty_businessplace,
             CompanyCode                    TYPE c LENGTH 4,
             BusinessPlace                  TYPE c LENGTH 4,
             AddressID                      TYPE c LENGTH 10,
             BusinessPlaceStartDate         TYPE datum,
             BusinessPlaceEndDate           TYPE datum,
             TaxNumber1                     TYPE c LENGTH 16,
             TaxNumber2                     TYPE c LENGTH 11,
             TaxNumber5                     TYPE c LENGTH 60,
             BusinessPlaceDescription       TYPE c LENGTH 30,
             TaxInvoiceRepresentativeName   TYPE c LENGTH 10,
             IndustryType                   TYPE c LENGTH 30,
             BusinessType                   TYPE c LENGTH 30,
             DistrictTaxOffice              TYPE c LENGTH 3,
             ResponsibleDepartmentName      TYPE c LENGTH 100,
             ResponsiblePersonName          TYPE c LENGTH 100,
             ResponsiblePersonEmailAddress1 TYPE c LENGTH 100,
             TaxInvoiceRepresentativeName1  TYPE c LENGTH 100,
             IndustryTypeList               TYPE c LENGTH 100,
             BusinessTypeList               TYPE c LENGTH 100,
             NatlTaxServiceRegnNumber       TYPE n LENGTH 8,
             KR_TaxBusinessCode             TYPE c LENGTH 30,
           END OF ty_businessplace,

           BEGIN OF ty_taxitems,
             CompanyCode                 TYPE c LENGTH 4,
             AccountingDocument          TYPE c LENGTH 10,
             FiscalYear                  TYPE n LENGTH 4,
             AccountingDocumentItem      TYPE n LENGTH 3,
             WithholdingTaxType          TYPE c LENGTH 2,
             StatryRptgEntity            TYPE c LENGTH 10,
             StatryRptCategory           TYPE c LENGTH 30,
             StatryRptRunID              TYPE n LENGTH 8,
             Quarter                     TYPE c LENGTH 2,
             WithholdingTaxCode          TYPE c LENGTH 2,
             OfficialWhldgTaxCode        TYPE c LENGTH 4,
             OfficialWhldgTaxCodeDesc    TYPE c LENGTH 40,
             Country                     TYPE c LENGTH 3,
             BusinessPlace               TYPE c LENGTH 4,
             BusinessArea                TYPE c LENGTH 4,
             BusinessPartner             TYPE c LENGTH 10,
             FiscalPeriod                TYPE n LENGTH 3,
             PostingDate                 TYPE datum,
             DocumentDate                TYPE datum,
             ClearingAccountingDocument  TYPE c LENGTH 10,
             IsReversed                  TYPE c LENGTH 1,
             IsReversal                  TYPE c LENGTH 1,
             ReverseDocument             TYPE c LENGTH 10,
             AccountingDocumentType      TYPE c LENGTH 2,
             WhldgTaxBaseAmtInCoCodeCrcy TYPE dmbtr,
             WhldgTaxAmtInCoCodeCrcy     TYPE dmbtr,
             WhldgTaxAmtInTransacCrcy    TYPE dmbtr,
             Name                        TYPE c LENGTH 163,
             BusinessPartnerName         TYPE c LENGTH 163,
             TaxNumber1                  TYPE c LENGTH 16,
             TaxNumber3                  TYPE c LENGTH 16,
             VATRegistration             TYPE c LENGTH 20,
             PostalCode                  TYPE c LENGTH 10,
             CityName                    TYPE c LENGTH 40,
             Supplier                    TYPE c LENGTH 10,
             StreetName                  TYPE c LENGTH 60,
             POBoxPostalCode             TYPE c LENGTH 10,
             POBox                       TYPE c LENGTH 10,
           END OF ty_taxitems,

           BEGIN OF ty_taxcd_desc,
             CompanyCode              TYPE c LENGTH 4,
             AccountingDocument       TYPE c LENGTH 10,
             FiscalYear               TYPE n LENGTH 4,
             Quarter                  TYPE c LENGTH 2,
             AccountingDocumentItem   TYPE n LENGTH 3,
             WithholdingTaxType       TYPE c LENGTH 2,
             StatryRptgEntity         TYPE c LENGTH 10,
             StatryRptCategory        TYPE c LENGTH 30,
             StatryRptRunID           TYPE n LENGTH 8,
             WithholdingTaxCode       TYPE c LENGTH 2,
             OfficialWhldgTaxCode     TYPE c LENGTH 4,
             Language                 TYPE c LENGTH 1,
             OfficialWhldgTaxCodeDesc TYPE c LENGTH 40,
           END OF ty_taxcd_desc,

           BEGIN OF ty_phwhtitemtodetail,
             companycode                   TYPE c LENGTH 4,
             vendornumber                  TYPE c LENGTH 10,
             whldgtaxbaseamtincocodecrcy   TYPE dmbtr,
             whldgtaxamtincocodecrcy       TYPE dmbtr,
             officialwhldgtaxcode          TYPE c LENGTH 5,
             officialwhldgtaxcodedesc      TYPE c LENGTH 255,
             firstmnthwhldgtaxamtincccrcy  TYPE dmbtr,
             secondmnthwhldgtaxamtincccrcy TYPE dmbtr,
             thirdmnthwhldgtaxamtincccrcy  TYPE dmbtr,
           END OF ty_phwhtitemtodetail,

           BEGIN OF ty_phwhtitemtodetailgovt,
             companycode                   TYPE c LENGTH 4,
             vendornumber                  TYPE c LENGTH 10,
             whldgtaxbaseamtincocodecrcy   TYPE dmbtr,
             whldgtaxamtincocodecrcy       TYPE dmbtr,
             officialwhldgtaxcode          TYPE c LENGTH 5,
             officialwhldgtaxcodedesc      TYPE c LENGTH 255,
             firstmnthwhldgtaxamtincccrcy  TYPE dmbtr,
             secondmnthwhldgtaxamtincccrcy TYPE dmbtr,
             thirdmnthwhldgtaxamtincccrcy  TYPE dmbtr,
           END OF ty_phwhtitemtodetailgovt,

           BEGIN OF ty_pdf_content,
             companycode                TYPE c LENGTH 4,
             businessplace              TYPE c LENGTH 4,
             vendornumber               TYPE c LENGTH 10,
             quarter                    TYPE c LENGTH 2,
             fiscalyear                 TYPE c LENGTH 4,
             calendarquarterperiod      TYPE n LENGTH 3,
             fiscalperiodenddate        TYPE c LENGTH 20,
             fiscalperiodstartdate      TYPE c LENGTH 20,
             fiscalperiod               TYPE c LENGTH 3,
             bptaxnumber                TYPE c LENGTH 18,
             name                       TYPE c LENGTH 80,
             customersupplierpostalcode TYPE c LENGTH 10,
             postalcode                 TYPE c LENGTH 10,
             vatregistration            TYPE c LENGTH 20,
             streetname                 TYPE c LENGTH 60,
             cityname                   TYPE c LENGTH 40,
             pobox                      TYPE c LENGTH 10,
             companycodename            TYPE c LENGTH 120,
             customersupplieraddress    TYPE c LENGTH 120,
             taxpayeridbyagency         TYPE c LENGTH 100,
             companycodeaddress         TYPE c LENGTH 140,
             personname                 TYPE string,
             personjob                  TYPE string,
             persontin                  TYPE string,
             signature                  TYPE string,
             watermark                  TYPE string,
             businessplaceaddress       TYPE c LENGTH 140,
             companytin                 TYPE c LENGTH 20,
             country                    TYPE c LENGTH 3,
           END OF ty_pdf_content,

           BEGIN OF ty_split_forms,
             companycode       TYPE c LENGTH 4,
             Vendor            TYPE c LENGTH 10,
             StatryRptgEntity  TYPE c LENGTH 10,
             StatryRptCategory TYPE c LENGTH 30,
             StatryRptRunID    TYPE n LENGTH 8,
           END OF ty_split_forms,

           BEGIN OF ty_payments,
             sign   TYPE c LENGTH 1,
             option TYPE c LENGTH 2,
             low    TYPE c LENGTH 2,
             high   TYPE c LENGTH 2,
           END OF ty_payments,

           BEGIN OF ty_range_c4,
             sign   TYPE c LENGTH 1,
             option TYPE c LENGTH 2,
             low    TYPE c LENGTH 4,
             high   TYPE c LENGTH 4,
           END OF ty_range_c4,

           tt_doc_sel               TYPE STANDARD TABLE OF ty_doc_sel WITH DEFAULT KEY,
           tt_bupla_addr            TYPE STANDARD TABLE OF ty_bupla_addr WITH DEFAULT KEY,
           tt_businessplace         TYPE STANDARD TABLE OF ty_businessplace WITH DEFAULT KEY,
           tt_taxitems              TYPE STANDARD TABLE OF ty_taxitems  WITH DEFAULT KEY,
           tt_taxcd_desc            TYPE STANDARD TABLE OF ty_taxcd_desc  WITH DEFAULT KEY,
           tt_pdf_content           TYPE STANDARD TABLE OF ty_pdf_content WITH DEFAULT KEY,
           tt_phwhtitemtodetail     TYPE STANDARD TABLE OF ty_phwhtitemtodetail WITH DEFAULT KEY,
           tt_phwhtitemtodetailgovt TYPE STANDARD TABLE OF ty_phwhtitemtodetailgovt WITH DEFAULT KEY,
           tt_split_forms           TYPE STANDARD TABLE OF ty_split_forms WITH DEFAULT KEY,
           tt_payments              TYPE STANDARD TABLE OF ty_payments,
           tt_taxcode               TYPE STANDARD TABLE OF ty_payments,
           tt_range_c4              TYPE STANDARD TABLE OF ty_range_c4.

    CLASS-DATA: gt_master_table TYPE ztt_2307_aggr_items,
                gt_pdf_header   TYPE tt_pdf_content,
                gt_taxitems_fnl TYPE ztt_2307_taxitems.

    CLASS-METHODS:  get_data  IMPORTING i_repent         TYPE srf_reporting_entity
                                        i_repcat         TYPE srf_rep_cat_id
                                        i_reprun         TYPE srf_report_run_id
                              RETURNING VALUE(rt_result) TYPE tt_pdf_content,

      get_vendor_whtht IMPORTING i_repent      TYPE srf_reporting_entity
                                 i_repcat      TYPE srf_rep_cat_id
                                 i_reprun      TYPE srf_report_run_id
                                 i_companycode TYPE ty_phwhtitemtodetail-companycode
                                 i_vendor      TYPE ty_phwhtitemtodetail-vendornumber
                       EXPORTING et_result     TYPE tt_pdf_content
                                 et_message    TYPE srft_message,

      get_item_inc_pay  IMPORTING i_repent       TYPE srf_reporting_entity
                                  i_repcat       TYPE srf_rep_cat_id
                                  i_reprun       TYPE srf_report_run_id
                                  i_companycode  TYPE ty_phwhtitemtodetail-companycode
                                  i_vendornumber TYPE ty_phwhtitemtodetail-vendornumber
                        EXPORTING et_result      TYPE tt_phwhtitemtodetail
                                  et_message     TYPE srft_message,

      get_item_gov_pay  IMPORTING i_repent       TYPE srf_reporting_entity
                                  i_repcat       TYPE srf_rep_cat_id
                                  i_reprun       TYPE srf_report_run_id
                                  i_companycode  TYPE ty_phwhtitemtodetail-companycode
                                  i_vendornumber TYPE ty_phwhtitemtodetail-vendornumber
                        EXPORTING et_result      TYPE tt_phwhtitemtodetail
                                  et_message     TYPE srft_message,

      get_doc_sel_items  IMPORTING io_msg_handler  TYPE REF TO if_srf_msg_handler
                                   io_acr          TYPE REF TO if_srf_report_run
                         RETURNING VALUE(r_result) TYPE tt_doc_sel
                         RAISING   cx_srf_error,

      get_bupla_addr    IMPORTING io_msg_handler  TYPE REF TO if_srf_msg_handler
                                  io_acr          TYPE REF TO if_srf_report_run
                        RETURNING VALUE(r_result) TYPE tt_bupla_addr
                        RAISING   cx_srf_error,

      get_businessplace  IMPORTING io_msg_handler  TYPE REF TO if_srf_msg_handler
                                   io_acr          TYPE REF TO if_srf_report_run
                         RETURNING VALUE(r_result) TYPE tt_businessplace
                         RAISING   cx_srf_error,

      get_taxitems       IMPORTING io_msg_handler  TYPE REF TO if_srf_msg_handler
                                   io_acr          TYPE REF TO if_srf_report_run
                         RETURNING VALUE(r_result) TYPE tt_taxitems
                         RAISING   cx_srf_error,

      get_taxcd_desc    IMPORTING io_msg_handler  TYPE REF TO if_srf_msg_handler
                                  io_acr          TYPE REF TO if_srf_report_run
                        RETURNING VALUE(r_result) TYPE tt_taxcd_desc
                        RAISING   cx_srf_error,

      split_forms       IMPORTING i_repent TYPE srf_reporting_entity
                                  i_repcat TYPE srf_rep_cat_id
                                  i_reprun TYPE srf_report_run_id
                        EXPORTING et_split TYPE tt_split_forms
                                  et_msg   TYPE srft_message,

      fetch_taxitems    IMPORTING i_repent    TYPE srf_reporting_entity
                                  i_repcat    TYPE srf_rep_cat_id
                                  i_reprun    TYPE srf_report_run_id
                        EXPORTING et_taxitems TYPE ztt_2307_taxitems
                                  et_msg      TYPE srft_message,

      fetch_header_dtls IMPORTING i_repent    TYPE srf_reporting_entity
                                  i_repcat    TYPE srf_rep_cat_id
                                  i_reprun    TYPE srf_report_run_id
                        EXPORTING es_head_dtl TYPE zst_2307_dtl_hdr
                                  et_msg      TYPE srft_message.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_PH_WHT_2307 IMPLEMENTATION.


  METHOD get_item_gov_pay.
    IF gt_master_table IS INITIAL.
      get_data( i_repcat = i_repcat
                i_repent = i_repent
                i_reprun = i_reprun
              ).
    ENDIF.


    LOOP AT gt_master_table ASSIGNING FIELD-SYMBOL(<lfs_vendor_whtht>)
      WHERE companycode   = i_companycode
        AND vendornumber  = i_vendornumber.

      LOOP AT <lfs_vendor_whtht>-phwhtitemtodetailgovt ASSIGNING FIELD-SYMBOL(<lfs_gov_pay>).
        et_result = VALUE #( BASE et_result
                    ( companycode                   = <lfs_vendor_whtht>-companycode
                      vendornumber                  = <lfs_vendor_whtht>-vendornumber
                      whldgtaxbaseamtincocodecrcy   = <lfs_gov_pay>-whldgtaxbaseamtincocodecrcy
                      whldgtaxamtincocodecrcy       = <lfs_gov_pay>-whldgtaxamtincocodecrcy
                      officialwhldgtaxcode          = <lfs_gov_pay>-officialwhldgtaxcode
                      officialwhldgtaxcodedesc      = <lfs_gov_pay>-officialwhldgtaxcodedesc
                      firstmnthwhldgtaxamtincccrcy  = <lfs_gov_pay>-firstmnthwhldgtaxamtincccrcy
                      secondmnthwhldgtaxamtincccrcy = <lfs_gov_pay>-secondmnthwhldgtaxamtincccrcy
                      thirdmnthwhldgtaxamtincccrcy  = <lfs_gov_pay>-thirdmnthwhldgtaxamtincccrcy
                      ) ).
      ENDLOOP.
      UNASSIGN: <lfs_gov_pay>.

    ENDLOOP.
    UNASSIGN: <lfs_vendor_whtht>.

  ENDMETHOD.


  METHOD split_forms.
    IF gt_master_table IS INITIAL.
      get_data( i_repent = i_repent
                i_repcat = i_repcat
                i_reprun = i_reprun
              ).
    ENDIF.

    et_split = VALUE #( FOR ls_master IN gt_master_table (
                  companycode       = ls_master-companycode
                  Vendor            = ls_master-vendornumber
                  StatryRptgEntity  = i_repent
                  StatryRptCategory = i_repcat
                  StatryRptRunID    = i_reprun
                  ) ).
  ENDMETHOD.


  METHOD fetch_taxitems.
    IF gt_taxitems_fnl IS INITIAL.
      get_data( i_repent = i_repent
                i_repcat = i_repcat
                i_reprun = i_reprun
              ).
    ENDIF.

    et_taxitems = gt_taxitems_fnl.

  ENDMETHOD.


  METHOD fetch_header_dtls.

    IF gt_pdf_header IS INITIAL.
      get_data( i_repent = i_repent
                i_repcat = i_repcat
                i_reprun = i_reprun
              ).
    ENDIF.

    DATA(ls_header) = VALUE #( gt_pdf_header[ 1 ] OPTIONAL ).
    es_head_dtl = VALUE #(
                    companycodename = ls_header-companycodename
                    fiscalyear      = ls_header-fiscalyear
                    quarter         = ls_header-quarter
                     ).
  ENDMETHOD.


  METHOD get_vendor_whtht.
    IF gt_master_table IS INITIAL.
      DATA(lt_result) = get_data( i_repcat = i_repcat
                                  i_repent = i_repent
                                  i_reprun = i_reprun
                          ).
      DELETE lt_result WHERE vendornumber <> i_vendor.
    ELSE.
      lt_result = gt_pdf_header.
      DELETE lt_result WHERE vendornumber <> i_vendor.
    ENDIF.

    IF lt_result IS NOT INITIAL.
      et_result = lt_result.
    ENDIF.
  ENDMETHOD.


  METHOD get_data.
    "Data getter method. Collect all data into master internal table
    DATA: ls_pdf_header   TYPE ty_pdf_content,
          ls_master_table TYPE zst_2307_schema,
          lt_itemtodetail TYPE ztt_2307_item_dtl_node,
          lt_itemtogovt   TYPE ztt_2307_item_govt_node,
          lv_prd_start    TYPE c LENGTH 20,
          lv_prd_end      TYPE c LENGTH 20,
          lv_startdatum   TYPE datum,
          lv_enddatum     TYPE datum,
          lv_cntryname    TYPE c LENGTH 50,
          lr_payments     TYPE tt_payments,
          lr_govpayts     TYPE tt_payments,
          lr_offtaxcd     TYPE tt_range_c4.

    FIELD-SYMBOLS: <lt_bupla_item> TYPE table.
    TRY .
        DATA(lo_acr) = cl_srf_facade=>get_report_run_by_id(
                         iv_rep_cat_id       = i_repcat
                         iv_reporting_entity = i_repent
                         iv_report_run_id    = i_reprun
                       ).
      CATCH cx_srf_error INTO DATA(lx_srf_error).
        RETURN.
    ENDTRY.

    DATA(lt_params) = lo_acr->get_rep_run_parameters( ).
    DATA(lo_handler) = cl_srf_facade=>get_message_handler( ).

    TRY .
        DATA(lt_doc_sel_items) = get_doc_sel_items(
                                  io_msg_handler  = lo_handler
                                  io_acr          = lo_acr
                                  ).
      CATCH cx_srf_error INTO lx_srf_error.
        RETURN.
    ENDTRY.

    TRY.
        DATA(lt_bupla_addr) = get_bupla_addr(
                                  io_msg_handler  = lo_handler
                                  io_acr          = lo_acr
                                  ).
      CATCH cx_srf_error INTO lx_srf_error.
        RETURN.
    ENDTRY.

    TRY.
        DATA(lt_businessplace) = get_businessplace(
                                  io_msg_handler  = lo_handler
                                  io_acr          = lo_acr
                                  ).
      CATCH cx_srf_error INTO lx_srf_error.
        RETURN.
    ENDTRY.

    TRY.
        DATA(lt_taxitems) = get_taxitems(
                                  io_msg_handler  = lo_handler
                                  io_acr          = lo_acr
                                  ).
      CATCH cx_srf_error INTO lx_srf_error.
        RETURN.
    ENDTRY.

    TRY.
        DATA(lt_taxcodedesc) = get_taxcd_desc(
                                  io_msg_handler  = lo_handler
                                  io_acr          = lo_acr
                                  ).
      CATCH cx_srf_error INTO lx_srf_error.
        RETURN.
    ENDTRY.

    "also populate payments wht tax types
    lr_govpayts = VALUE #(
                    sign    = 'I'
                    option  = 'EQ'
                    ( low   = 'VI'  )
                    ( low   = 'VP'  )
                    ).
    lr_payments = VALUE #(
                    sign    = 'I'
                    option  = 'EQ'
                    ( low   = 'CP'  )
                    ( low   = 'EP'  )
                    ( low   = 'EV'  )
                    ( low   = 'EX'  )
                    ( low   = 'EZ'  )
                    ( low   = 'FB'  )
                    ( low   = 'FP'  )
                    ( low   = 'GP'  )
                    ( low   = 'VP'  )
                    ( low   = 'EI'  )
                    ).

    "remove Tax Items with payments made outside the target period for reporting
    DATA(lt_taxitems_tmp) = lt_taxitems.
    CLEAR: lt_taxitems_tmp.

    LOOP AT lt_taxitems ASSIGNING FIELD-SYMBOL(<lfs_item>).
      IF <lfs_item>-withholdingtaxtype IN lr_payments.
        ASSIGN lt_doc_sel_items[  companycode         = <lfs_item>-companycode
                                  accountingdocument  = <lfs_item>-accountingdocument
                                  fiscalyear          = <lfs_item>-fiscalyear
                                  fiscalperiod        = <lfs_item>-fiscalperiod
                                  ] TO FIELD-SYMBOL(<lfs_doc_sel>).
        IF <lfs_doc_sel> IS ASSIGNED.

          "Specific for tax type EI, regardless of cleared doc, directly check for reversal status
          IF <lfs_item>-isreversal IS INITIAL
            AND <lfs_item>-isreversed IS INITIAL
            AND <lfs_item>-withholdingtaxtype = 'EI'.
            APPEND <lfs_item> TO lt_taxitems_tmp.
            "Skip further checking and proceed with next item.
            CONTINUE.
          ENDIF.

          IF <lfs_doc_sel>-clearingdate IS NOT INITIAL.
            CLEAR:  lv_startdatum,
                    lv_enddatum.
            "For the period based the vendor posting quarter
            lv_startdatum = SWITCH #( <lfs_item>-quarter
                              WHEN 'Q1' THEN |{ <lfs_item>-fiscalyear }0101|
                              WHEN 'Q2' THEN |{ <lfs_item>-fiscalyear }0401|
                              WHEN 'Q3' THEN |{ <lfs_item>-fiscalyear }0701|
                              WHEN 'Q4' THEN |{ <lfs_item>-fiscalyear }1001|
                              ).
            lv_enddatum   = SWITCH #( <lfs_item>-quarter
                              WHEN 'Q1' THEN |{ <lfs_item>-fiscalyear }0331|
                              WHEN 'Q2' THEN |{ <lfs_item>-fiscalyear }0630|
                              WHEN 'Q3' THEN |{ <lfs_item>-fiscalyear }0930|
                              WHEN 'Q4' THEN |{ <lfs_item>-fiscalyear }1231|
                              ).

            "Do not include items with clearing date outside of target posting period for the quarter
            IF lv_startdatum <= <lfs_doc_sel>-clearingdate
              AND lv_enddatum >= <lfs_doc_sel>-clearingdate
              AND <lfs_item>-isreversal IS INITIAL " kulikov 290426 add this condition
              AND <lfs_item>-isreversed IS INITIAL. "kulikov 290426 add this condition
              "remove documents already paid, retain payment document
              IF <lfs_item>-clearingaccountingdocument IS NOT INITIAL.
                IF <lfs_item>-accountingdocument = <lfs_item>-clearingaccountingdocument.
                  "Do not include reversal documents
                  IF <lfs_item>-isreversal <> abap_true.
                    APPEND <lfs_item> TO lt_taxitems_tmp.
                  ENDIF.
                ENDIF.
              ELSE.
                APPEND <lfs_item> TO lt_taxitems_tmp.
              ENDIF.

            ELSEIF <lfs_item>-isreversed = abap_true  " add if reversed
               OR <lfs_item>-isreversal = abap_true.
              APPEND <lfs_item> TO lt_taxitems_tmp.
            ENDIF.
          ELSE.
            APPEND <lfs_item> TO lt_taxitems_tmp.
          ENDIF.
        ENDIF.

      ELSE.
        APPEND <lfs_item> TO lt_taxitems_tmp.
      ENDIF.
    ENDLOOP.
    UNASSIGN: <lfs_item>.

    DELETE lt_taxitems_tmp WHERE whldgtaxamtincocodecrcy = 0.

    CLEAR: lt_taxitems.
    lt_taxitems = lt_taxitems_tmp.

    IF lt_taxitems[] IS NOT INITIAL.
      SELECT Country, CountryName
        FROM I_CountryText
        FOR ALL ENTRIES IN @lt_taxitems
        WHERE language = 'E'
        AND Country = @lt_taxitems-country
        INTO TABLE @DATA(lt_cntryname).
    ENDIF.

    "Build table for official wht tax code descriptions
    SORT lt_taxcodedesc BY officialwhldgtaxcode.
    DELETE ADJACENT DUPLICATES FROM lt_taxcodedesc
      COMPARING officialwhldgtaxcode.

    "Sort header and items table
    SORT  lt_doc_sel_items BY companycode
                              businesspartner.
    DELETE ADJACENT DUPLICATES FROM lt_doc_sel_items
      COMPARING companycode
                businesspartner.
    SORT  lt_taxitems BY  companycode
                          supplier
                          OfficialWhldgTaxCode
                          fiscalperiod.

    "Save filtered tax item details to master table
    gt_taxitems_fnl = lt_taxitems.

    "Collate all entries from tables and pass to internal table
    LOOP AT lt_doc_sel_items ASSIGNING FIELD-SYMBOL(<lfs_docsel>).
      CLEAR:  ls_pdf_header,
              ls_master_table.

      ls_pdf_header = VALUE #(
                        quarter               = <lfs_docsel>-quarter
                        calendarquarterperiod = <lfs_docsel>-calendarquarterperiod
                        ).

      "Read withholding tax items data from LT_TAXITEMS
      ASSIGN lt_taxitems[ companycode   = <lfs_docsel>-companycode
                          supplier      = <lfs_docsel>-businesspartner  "Vendor
                          ] TO FIELD-SYMBOL(<lfs_taxitems>).
      IF <lfs_taxitems> IS ASSIGNED.
        CLEAR:  lv_startdatum,
                lv_enddatum,
                lv_cntryname.
        "For the period based the vendor posting quarter
        lv_startdatum = SWITCH #( <lfs_docsel>-quarter
                          WHEN 'Q1' THEN |{ <lfs_docsel>-fiscalyear }0101|
                          WHEN 'Q2' THEN |{ <lfs_docsel>-fiscalyear }0401|
                          WHEN 'Q3' THEN |{ <lfs_docsel>-fiscalyear }0701|
                          WHEN 'Q4' THEN |{ <lfs_docsel>-fiscalyear }1001|
                          ).
        lv_enddatum   = SWITCH #( <lfs_docsel>-quarter
                          WHEN 'Q1' THEN |{ <lfs_docsel>-fiscalyear }0331|
                          WHEN 'Q2' THEN |{ <lfs_docsel>-fiscalyear }0630|
                          WHEN 'Q3' THEN |{ <lfs_docsel>-fiscalyear }0930|
                          WHEN 'Q4' THEN |{ <lfs_docsel>-fiscalyear }1231|
                          ).
        lv_prd_start  = |00000000{ lv_startdatum(2) }0{ lv_startdatum+2(2) }0{ lv_startdatum+4(2) }0{ lv_startdatum+6(2) }|.
        lv_prd_end    = |00000000{ lv_enddatum(2) }0{ lv_enddatum+2(2) }0{ lv_enddatum+4(2) }0{ lv_enddatum+6(2) }|.

        "get country name from country key
        lv_cntryname  = VALUE #( lt_cntryname[ country = <lfs_taxitems>-Country ]-countryname OPTIONAL ).

        ls_pdf_header = VALUE #( BASE ls_pdf_header
                          companycode                 = <lfs_taxitems>-companycode
                          businessplace               = <lfs_taxitems>-businessplace
                          vendornumber                = <lfs_taxitems>-Supplier
                          quarter                     = <lfs_taxitems>-quarter
                          fiscalyear                  = <lfs_taxitems>-fiscalyear
                          fiscalperiod                = <lfs_taxitems>-fiscalperiod
                          fiscalperiodenddate         = lv_prd_start
                          fiscalperiodstartdate       = lv_prd_end
                          bptaxnumber                 = COND #( WHEN <lfs_taxitems>-taxnumber1 IS NOT INITIAL
                                                            THEN <lfs_taxitems>-taxnumber1
                                                            ELSE <lfs_taxitems>-taxnumber3 )
                          name                        = <lfs_taxitems>-name
                          customersupplierpostalcode  = <lfs_taxitems>-postalcode
                          customersupplieraddress     = |{ <lfs_taxitems>-streetname } { <lfs_taxitems>-postalcode } { <lfs_taxitems>-cityname } { lv_cntryname }|
                          streetname                  = <lfs_taxitems>-streetname
                          cityname                    = <lfs_taxitems>-cityname
                          pobox                       = <lfs_taxitems>-pobox
                          companycodename             = SWITCH #( <lfs_taxitems>-companycode
                                                          WHEN 'CLCT'
                                                          THEN 'CENTRAL LUZON CABLE TELEVISION NETWORK INC.'
                                                          WHEN 'CNTC'
                                                          THEN 'COMCLARK NETWORK & TECHNOLOGY CORPORATION'
                                                           )
                          taxpayeridbyagency          = <lfs_taxitems>-vatregistration
                          companytin                  = <lfs_taxitems>-vatregistration
                          ).
        CONDENSE: ls_pdf_header-customersupplieraddress.

        "Read business place data from LT_BUSINESSPLACE
        ASSIGN lt_businessplace[  CompanyCode   = <lfs_docsel>-companycode
                                  businessplace = <lfs_taxitems>-businessplace
                                  ] TO FIELD-SYMBOL(<lfs_businessplace>).
        IF <lfs_businessplace> IS ASSIGNED.
          ls_pdf_header = VALUE #( BASE ls_pdf_header
                            businessplace   = <lfs_businessplace>-businessplace
                            vatregistration = <lfs_businessplace>-taxnumber1
                            ).

          "Read business place address from LT_BUPLA_ITEMS
          ASSIGN lt_bupla_addr[ addressid = <lfs_businessplace>-addressid ]
            TO FIELD-SYMBOL(<lfs_bupla_addr>).
          IF <lfs_bupla_addr> IS ASSIGNED.
            ls_pdf_header = VALUE #( BASE ls_pdf_header
                          companycodeaddress      = <lfs_bupla_addr>-completeaddress
                          businessplaceaddress    = <lfs_bupla_addr>-completeaddress
                          postalcode              = <lfs_bupla_addr>-postalcode
                          ).
            UNASSIGN: <lfs_bupla_addr>.
          ENDIF.

          UNASSIGN: <lfs_businessplace>.
        ENDIF.

        UNASSIGN: <lfs_taxitems>.

        "Populate incoming payments and government payments per vendor
        CLEAR:  lt_itemtodetail,
                lt_itemtogovt.

        "Aggregate incoming payments
        lt_itemtodetail = VALUE #( FOR GROUPS ls_group OF ls_data IN lt_taxitems
                            WHERE ( CompanyCode = <lfs_docsel>-CompanyCode
                              AND   supplier    = <lfs_docsel>-businesspartner
                              AND   withholdingtaxtype NOT IN lr_govpayts[]
                              )
                            GROUP BY (  CompanyCode           = ls_data-CompanyCode
                                        supplier              = ls_data-supplier
                                        officialwhldgtaxcode  = ls_data-officialwhldgtaxcode
                                        )

                            LET ls_totals = REDUCE #( INIT ls_sumitems = VALUE zst_2307_item_dtl_node( )
                              FOR ls_row IN GROUP ls_group
                                NEXT
                                  ls_sumitems-whldgtaxbaseamtincocodecrcy = ls_sumitems-whldgtaxbaseamtincocodecrcy +
                                    ls_row-whldgtaxbaseamtincocodecrcy

                                  ls_sumitems-whldgtaxamtincocodecrcy = ls_sumitems-whldgtaxamtincocodecrcy +
                                    ls_row-whldgtaxamtincocodecrcy

                                  ls_sumitems-firstmnthwhldgtaxamtincccrcy = ls_sumitems-firstmnthwhldgtaxamtincccrcy +
                                  COND #( WHEN ls_row-fiscalperiod MOD 3 = 1
                                    THEN ls_row-whldgtaxbaseamtincocodecrcy
                                    ELSE 0 )

                                  ls_sumitems-secondmnthwhldgtaxamtincccrcy = ls_sumitems-secondmnthwhldgtaxamtincccrcy +
                                  COND #( WHEN ls_row-fiscalperiod MOD 3 = 2
                                    THEN ls_row-whldgtaxbaseamtincocodecrcy
                                    ELSE 0 )

                                  ls_sumitems-thirdmnthwhldgtaxamtincccrcy = ls_sumitems-thirdmnthwhldgtaxamtincccrcy +
                                  COND #( WHEN ls_row-fiscalperiod MOD 3 = 0
                                    THEN ls_row-whldgtaxbaseamtincocodecrcy
                                    ELSE 0 ) )

                            IN ( VALUE #(
                              whldgtaxbaseamtincocodecrcy   = ls_totals-whldgtaxbaseamtincocodecrcy
                              whldgtaxamtincocodecrcy       = ls_totals-whldgtaxamtincocodecrcy
                              officialwhldgtaxcode          = |W{ ls_group-officialwhldgtaxcode }|
                              officialwhldgtaxcodedesc      = VALUE #( lt_taxcodedesc[ officialwhldgtaxcode = ls_group-officialwhldgtaxcode ]-officialwhldgtaxcodedesc OPTIONAL )
                              firstmnthwhldgtaxamtincccrcy  = ls_totals-firstmnthwhldgtaxamtincccrcy
                              secondmnthwhldgtaxamtincccrcy = ls_totals-secondmnthwhldgtaxamtincccrcy
                              thirdmnthwhldgtaxamtincccrcy  = ls_totals-thirdmnthwhldgtaxamtincccrcy
                             ) ) ).

        "Aggregate govt payments
        lt_itemtogovt = VALUE #( FOR GROUPS ls_group OF ls_data IN lt_taxitems
                            WHERE ( CompanyCode = <lfs_docsel>-CompanyCode
                              AND   supplier    = <lfs_docsel>-businesspartner
                              AND   withholdingtaxtype IN lr_govpayts
                              )
                            GROUP BY (  CompanyCode           = ls_data-CompanyCode
                                        supplier              = ls_data-supplier
                                        officialwhldgtaxcode  = ls_data-officialwhldgtaxcode
                                      )

                            LET ls_totals = REDUCE #( INIT ls_sumitems = VALUE zst_2307_item_dtl_node( )
                              FOR ls_row IN GROUP ls_group
                                NEXT
                                  ls_sumitems-whldgtaxbaseamtincocodecrcy = ls_sumitems-whldgtaxbaseamtincocodecrcy +
                                    ls_row-whldgtaxbaseamtincocodecrcy

                                  ls_sumitems-whldgtaxamtincocodecrcy = ls_sumitems-whldgtaxamtincocodecrcy +
                                    ls_row-whldgtaxamtincocodecrcy

                                  ls_sumitems-firstmnthwhldgtaxamtincccrcy = ls_sumitems-firstmnthwhldgtaxamtincccrcy +
                                  COND #( WHEN ls_row-fiscalperiod MOD 3 = 1
                                    THEN ls_row-whldgtaxbaseamtincocodecrcy
                                    ELSE 0 )

                                  ls_sumitems-secondmnthwhldgtaxamtincccrcy = ls_sumitems-secondmnthwhldgtaxamtincccrcy +
                                  COND #( WHEN ls_row-fiscalperiod MOD 3 = 2
                                    THEN ls_row-whldgtaxbaseamtincocodecrcy
                                    ELSE 0 )

                                  ls_sumitems-thirdmnthwhldgtaxamtincccrcy = ls_sumitems-thirdmnthwhldgtaxamtincccrcy +
                                  COND #( WHEN ls_row-fiscalperiod MOD 3 = 0
                                    THEN ls_row-whldgtaxbaseamtincocodecrcy
                                    ELSE 0 ) )

                            IN ( VALUE #(
                              whldgtaxbaseamtincocodecrcy   = ls_totals-whldgtaxbaseamtincocodecrcy
                              whldgtaxamtincocodecrcy       = ls_totals-whldgtaxamtincocodecrcy
                              officialwhldgtaxcode          = |W{ ls_group-officialwhldgtaxcode }|
                              officialwhldgtaxcodedesc      = VALUE #( lt_taxcodedesc[ officialwhldgtaxcode = ls_group-officialwhldgtaxcode ]-officialwhldgtaxcodedesc OPTIONAL )
                              firstmnthwhldgtaxamtincccrcy  = ls_totals-firstmnthwhldgtaxamtincccrcy
                              secondmnthwhldgtaxamtincccrcy = ls_totals-secondmnthwhldgtaxamtincccrcy
                              thirdmnthwhldgtaxamtincccrcy  = ls_totals-thirdmnthwhldgtaxamtincccrcy
                             ) ) ).

        DELETE lt_itemtodetail WHERE whldgtaxamtincocodecrcy = 0.
        DELETE lt_itemtogovt WHERE whldgtaxamtincocodecrcy = 0.

        IF lt_itemtodetail IS NOT INITIAL OR lt_itemtogovt IS NOT INITIAL.
          ls_master_table = CORRESPONDING #( ls_pdf_header ).
          ls_master_table = VALUE #( BASE ls_master_table
                            phwhtitemtodetail     = lt_itemtodetail[]
                            phwhtitemtodetailgovt = lt_itemtogovt[]
                            ).
          APPEND ls_pdf_header TO gt_pdf_header.
          APPEND ls_master_table TO gt_master_table.
        ENDIF.
      ENDIF.

    ENDLOOP.

    DELETE gt_master_table  WHERE vendornumber IS INITIAL.
    DELETE gt_pdf_header    WHERE vendornumber IS INITIAL.

    IF gt_pdf_header IS NOT INITIAL.  "Save final internal table to global internal table for splitting
      rt_result = CORRESPONDING #( gt_pdf_header ).
    ENDIF.
  ENDMETHOD.


  METHOD get_bupla_addr.
    DATA: lt_bupla_addr TYPE tt_bupla_addr.

    DATA(lo_records) = io_acr->execute_query(
      EXPORTING
        iv_query_id = 'YY1_BUPLA_ADDRS'
        io_msg_handler = io_msg_handler
        it_column_name = VALUE #( ( CONV #( 'AddressID' ) )
                                  ( CONV #( 'AddressPersonID' ) )
                                  ( CONV #( 'AddressRepresentationCode' ) )
                                  ( CONV #( 'completeaddress' ) )
                                  ( CONV #( 'AddressSearchTerm1' ) )
                                  ( CONV #( 'PostalCode' ) )
                                   )
    ).

    ASSIGN lo_records->* TO FIELD-SYMBOL(<lfs_records>).
    IF <lfs_records> IS ASSIGNED.
      LOOP AT <lfs_records> ASSIGNING FIELD-SYMBOL(<ls_record>).
        APPEND CORRESPONDING #( <ls_record> ) TO lt_bupla_addr.
      ENDLOOP.
    ENDIF.

    IF lt_bupla_addr IS NOT INITIAL.
      r_result = lt_bupla_addr.
    ENDIF.
  ENDMETHOD.


  METHOD get_businessplace.
    DATA: lt_businessplace TYPE tt_businessplace.

    DATA(lo_records) = io_acr->execute_query(
      EXPORTING
        iv_query_id = 'YY1_BUSINESSPLACE'
        io_msg_handler = io_msg_handler
        it_column_name = VALUE #( ( CONV #( 'CompanyCode' ) )
                                  ( CONV #( 'BusinessPlace' ) )
                                  ( CONV #( 'AddressID' ) )
                                  ( CONV #( 'BusinessPlaceStartDate' ) )
                                  ( CONV #( 'BusinessPlaceEndDate' ) )
                                  ( CONV #( 'TaxNumber1' ) )
                                  ( CONV #( 'TaxNumber2' ) )
                                  ( CONV #( 'TaxNumber5' ) )
                                  ( CONV #( 'BusinessPlaceDescription' ) )
                                  ( CONV #( 'TaxInvoiceRepresentativeName' ) )
                                  ( CONV #( 'IndustryType' ) )
                                  ( CONV #( 'BusinessType' ) )
                                  ( CONV #( 'DistrictTaxOffice' ) )
                                  ( CONV #( 'ResponsibleDepartmentName' ) )
                                  ( CONV #( 'ResponsiblePersonName' ) )
                                  ( CONV #( 'ResponsiblePersonEmailAddress1' ) )
                                  ( CONV #( 'TaxInvoiceRepresentativeName1' ) )
                                  ( CONV #( 'IndustryTypeList' ) )
                                  ( CONV #( 'BusinessTypeList' ) )
                                  ( CONV #( 'NatlTaxServiceRegnNumber' ) )
                                  ( CONV #( 'KR_TaxBusinessCode' ) )
                                   )
    ).

    ASSIGN lo_records->* TO FIELD-SYMBOL(<lfs_records>).
    IF <lfs_records> IS ASSIGNED.
      LOOP AT <lfs_records> ASSIGNING FIELD-SYMBOL(<ls_record>).
        APPEND CORRESPONDING #( <ls_record> ) TO lt_businessplace.
      ENDLOOP.
    ENDIF.

    IF lt_businessplace IS NOT INITIAL.
      r_result = lt_businessplace.
    ENDIF.

  ENDMETHOD.


  METHOD get_doc_sel_items.
    DATA: lt_doc_sel TYPE tt_doc_sel,
          ls_doc_sel TYPE ty_doc_sel.

    DATA(lo_records) = io_acr->execute_query(
      EXPORTING
        iv_query_id = 'DOC_SEL'
        io_msg_handler = io_msg_handler
        it_column_name = VALUE #( ( CONV #( 'CompanyCode' ) )
                                  ( CONV #( 'AccountingDocument' ) )
                                  ( CONV #( 'FiscalYear' ) )
                                  ( CONV #( 'WithholdingTaxType' ) )
                                  ( CONV #( 'StatryRptgEntity' ) )
                                  ( CONV #( 'StatryRptCategory' ) )
                                  ( CONV #( 'StatryRptRunID' ) )
                                  ( CONV #( 'PostingDate' ) )
                                  ( CONV #( 'DocumentDate' ) )
                                  ( CONV #( 'ClearingDate' ) )
                                  ( CONV #( 'ReportingDate' ) )
                                  ( CONV #( 'FiscalPeriod' ) )
                                  ( CONV #( 'Quarter' ) )
                                  ( CONV #( 'CalendarQuarterPeriod' ) )
                                  ( CONV #( 'BusinessPartner' ) )
                                  ( CONV #( 'BPTaxNumber' ) )
                                  ( CONV #( 'VATRegistration' ) )
                                  ( CONV #( 'OfficialWhldgTaxCode' ) )
                                   )
    ).

    ASSIGN lo_records->* TO FIELD-SYMBOL(<lfs_records>).
    IF <lfs_records> IS ASSIGNED.
      LOOP AT <lfs_records> ASSIGNING FIELD-SYMBOL(<ls_record>).
        CLEAR:  ls_doc_sel.
        ls_doc_sel = CORRESPONDING #( <ls_record> ).
        IF ls_doc_sel-quarter IS INITIAL.
          ls_doc_sel-quarter = SWITCH #( ls_doc_sel-postingdate+4(2)
                                WHEN '01' OR '02' OR '03' THEN 'Q1'
                                WHEN '04' OR '05' OR '06' THEN 'Q2'
                                WHEN '07' OR '08' OR '09' THEN 'Q3'
                                WHEN '10' OR '11' OR '12' THEN 'Q4'
                                 ).
        ENDIF.

        APPEND ls_doc_sel TO lt_doc_sel.
      ENDLOOP.
    ENDIF.

    IF lt_doc_sel IS NOT INITIAL.
      r_result = lt_doc_sel.
    ENDIF.
  ENDMETHOD.


  METHOD get_item_inc_pay.
    IF gt_master_table IS INITIAL.
      get_data( i_repcat = i_repcat
                i_repent = i_repent
                i_reprun = i_reprun
              ).
    ENDIF.

    LOOP AT gt_master_table ASSIGNING FIELD-SYMBOL(<lfs_vendor_whtht>)
      WHERE companycode   = i_companycode
        AND vendornumber  = i_vendornumber.

      LOOP AT <lfs_vendor_whtht>-phwhtitemtodetail ASSIGNING FIELD-SYMBOL(<lfs_inc_pay>).
        et_result = VALUE #( BASE et_result
                    ( companycode                   = <lfs_vendor_whtht>-companycode
                      vendornumber                  = <lfs_vendor_whtht>-vendornumber
                      whldgtaxbaseamtincocodecrcy   = <lfs_inc_pay>-whldgtaxbaseamtincocodecrcy
                      whldgtaxamtincocodecrcy       = <lfs_inc_pay>-whldgtaxamtincocodecrcy
                      officialwhldgtaxcode          = <lfs_inc_pay>-officialwhldgtaxcode
                      officialwhldgtaxcodedesc      = <lfs_inc_pay>-officialwhldgtaxcodedesc
                      firstmnthwhldgtaxamtincccrcy  = <lfs_inc_pay>-firstmnthwhldgtaxamtincccrcy
                      secondmnthwhldgtaxamtincccrcy = <lfs_inc_pay>-secondmnthwhldgtaxamtincccrcy
                      thirdmnthwhldgtaxamtincccrcy  = <lfs_inc_pay>-thirdmnthwhldgtaxamtincccrcy
                      ) ).
      ENDLOOP.
      UNASSIGN: <lfs_inc_pay>.

    ENDLOOP.
    UNASSIGN: <lfs_vendor_whtht>.

  ENDMETHOD.


  METHOD get_taxcd_desc.
    DATA: lt_taxcd_desc TYPE tt_taxcd_desc.

    DATA(lo_records) = io_acr->execute_query(
      EXPORTING
        iv_query_id = 'YY1_GET_TAXCODE_DESC'
        io_msg_handler = io_msg_handler
        it_column_name = VALUE #( ( CONV #( 'CompanyCode' ) )
                                  ( CONV #( 'AccountingDocument' ) )
                                  ( CONV #( 'FiscalYear' ) )
                                  ( CONV #( 'Quarter' ) )
                                  ( CONV #( 'AccountingDocumentItem' ) )
                                  ( CONV #( 'WithholdingTaxType' ) )
                                  ( CONV #( 'StatryRptgEntity' ) )
                                  ( CONV #( 'StatryRptCategory' ) )
                                  ( CONV #( 'StatryRptRunID' ) )
                                  ( CONV #( 'WithholdingTaxCode' ) )
                                  ( CONV #( 'OfficialWhldgTaxCode' ) )
                                  ( CONV #( 'Language' ) )
                                  ( CONV #( 'OfficialWhldgTaxCodeDesc' ) )
                                  )
    ).

    ASSIGN lo_records->* TO FIELD-SYMBOL(<lfs_records>).
    IF <lfs_records> IS ASSIGNED.
      LOOP AT <lfs_records> ASSIGNING FIELD-SYMBOL(<ls_record>).
        APPEND CORRESPONDING #( <ls_record> ) TO lt_taxcd_desc.
      ENDLOOP.
    ENDIF.

    IF lt_taxcd_desc IS NOT INITIAL.
      r_result = lt_taxcd_desc.
    ENDIF.
  ENDMETHOD.


  METHOD get_taxitems.
    DATA: lt_taxitems TYPE tt_taxitems,
          ls_taxitems TYPE ty_taxitems,
          lr_tax_ci   TYPE tt_payments,
          lr_tax_cp   TYPE tt_payments,
          lr_tax_ey   TYPE tt_payments,
          lr_tax_ez   TYPE tt_payments,
          lr_tax_gi   TYPE tt_payments,
          lr_tax_gp   TYPE tt_payments,
          lv_quarter  TYPE i.

    DATA(lo_records) = io_acr->execute_query(
      EXPORTING
        iv_query_id = 'YY1_TAXITEM_BUPLA'
        io_msg_handler = io_msg_handler
        it_column_name = VALUE #( ( CONV #( 'CompanyCode' ) )
                                  ( CONV #( 'AccountingDocument' ) )
                                  ( CONV #( 'FiscalYear' ) )
                                  ( CONV #( 'AccountingDocumentItem' ) )
                                  ( CONV #( 'WithholdingTaxType' ) )
                                  ( CONV #( 'StatryRptgEntity' ) )
                                  ( CONV #( 'StatryRptCategory' ) )
                                  ( CONV #( 'StatryRptRunID' ) )
                                  ( CONV #( 'WithholdingTaxCode' ) )
                                  ( CONV #( 'OfficialWhldgTaxCode' ) )
                                  ( CONV #( 'Country' ) )
                                  ( CONV #( 'BusinessPlace' ) )
                                  ( CONV #( 'BusinessArea' ) )
                                  ( CONV #( 'BusinessPartner' ) )
                                  ( CONV #( 'FiscalPeriod' ) )
                                  ( CONV #( 'PostingDate' ) )
                                  ( CONV #( 'DocumentDate' ) )
                                  ( CONV #( 'ClearingAccountingDocument' ) )
                                  ( CONV #( 'IsReversed' ) )
                                  ( CONV #( 'IsReversal' ) )
                                  ( CONV #( 'ReverseDocument' ) )
                                  ( CONV #( 'AccountingDocumentType' ) )
                                  ( CONV #( 'WhldgTaxBaseAmtInCoCodeCrcy' ) )
                                  ( CONV #( 'WhldgTaxAmtInCoCodeCrcy' ) )
                                  ( CONV #( 'WhldgTaxAmtInTransacCrcy' ) )
                                  ( CONV #( 'Name' ) )
                                  ( CONV #( 'BusinessPartnerName' ) )
                                  ( CONV #( 'TaxNumber1' ) )
                                  ( CONV #( 'TaxNumber3' ) )
                                  ( CONV #( 'VATRegistration' ) )
                                  ( CONV #( 'PostalCode' ) )
                                  ( CONV #( 'CityName' ) )
                                  ( CONV #( 'Supplier' ) )
                                  ( CONV #( 'StreetName' ) )
                                  ( CONV #( 'POBoxPostalCode' ) )
                                  ( CONV #( 'POBox' ) )
                                   )
    ).

    ASSIGN lo_records->* TO FIELD-SYMBOL(<lfs_records>).
    IF <lfs_records> IS ASSIGNED.
      LOOP AT <lfs_records> ASSIGNING FIELD-SYMBOL(<ls_record>).
        CLEAR:  ls_taxitems,
                lv_quarter.
        ls_taxitems = CORRESPONDING #( <ls_record> ).
        lv_quarter = trunc( ( ls_taxitems-fiscalperiod - 1 ) / 3 ) + 1.
        ls_taxitems-quarter = |Q{ lv_quarter }|.
        APPEND ls_taxitems TO lt_taxitems.
      ENDLOOP.
    ENDIF.

*    "delete reversed items
*    DELETE lt_taxitems WHERE IsReversed = abap_true.
*    DELETE lt_taxitems WHERE ReverseDocument IS NOT INITIAL.
*
    IF lt_taxitems IS NOT INITIAL.
      SELECT  a~CompanyCode,
              a~FiscalYear,
              a~AccountingDocument,
              b~ReversalReferenceDocument,
              b~postingdate
        FROM i_journalentry AS a
        LEFT OUTER JOIN i_journalentry AS b
            ON a~CompanyCode               = b~CompanyCode
             AND b~ReversalReferenceDocument = a~AccountingDocument
        FOR ALL ENTRIES IN @lt_taxitems
        WHERE a~CompanyCode = @lt_taxitems-companycode
          AND a~FiscalYear  = @lt_taxitems-fiscalyear
          AND a~AccountingDocument = @lt_taxitems-accountingdocument
**          AND ReversalReferenceDocument IS INITIAL
        INTO TABLE @DATA(lt_reversed).
      IF sy-subrc EQ 0.


        DATA(lt_taxitems_tmp) = lt_taxitems.
        CLEAR:  lt_taxitems_tmp.

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

        LOOP AT lt_taxitems ASSIGNING FIELD-SYMBOL(<lfs_taxitems>).
          CASE <lfs_taxitems>-withholdingtaxtype.
            WHEN 'CI'.
              IF <lfs_taxitems>-withholdingtaxcode IN lr_tax_ci[].
                CONTINUE.
              ENDIF.

            WHEN 'CP'.
              IF <lfs_taxitems>-withholdingtaxcode IN lr_tax_cp[].
                CONTINUE.
              ENDIF.

            WHEN 'EY'.
              IF <lfs_taxitems>-withholdingtaxcode IN lr_tax_ey[].
                CONTINUE.
              ENDIF.

            WHEN 'EZ'.
              IF <lfs_taxitems>-withholdingtaxcode IN lr_tax_ez[].
                CONTINUE.
              ENDIF.

            WHEN 'GI'.
              IF <lfs_taxitems>-withholdingtaxcode IN lr_tax_gi[].
                CONTINUE.
              ENDIF.

            WHEN 'GP'.
              IF <lfs_taxitems>-withholdingtaxcode IN lr_tax_gp[].
                CONTINUE.
              ENDIF.

            WHEN OTHERS.
              "Do nothing
          ENDCASE.
*
*            IF line_exists( lt_reversed[  CompanyCode = <lfs_taxitems>-companycode
*                                          FiscalYear  = <lfs_taxitems>-fiscalyear
*                                          AccountingDocument = <lfs_taxitems>-accountingdocument ] ).
*              APPEND <lfs_taxitems> TO lt_taxitems_tmp.
*            ENDIF.

          READ TABLE lt_reversed INTO DATA(ls_reversed)
             WITH KEY companycode        = <lfs_taxitems>-companycode
                      fiscalyear         = <lfs_taxitems>-fiscalyear
                      accountingdocument = <lfs_taxitems>-accountingdocument.

          IF sy-subrc = 0.
            "If a reversal document exists, check if its quarter falls within the same quarter as the tax item
            IF ls_reversed-reversalreferencedocument IS NOT INITIAL.
              DATA(lv_rev_quarter) = COND #(
                WHEN ls_reversed-postingdate+4(2) BETWEEN '01' AND '03' THEN 'Q1'
                WHEN ls_reversed-postingdate+4(2) BETWEEN '04' AND '06' THEN 'Q2'
                WHEN ls_reversed-postingdate+4(2) BETWEEN '07' AND '09' THEN 'Q3'
                WHEN ls_reversed-postingdate+4(2) BETWEEN '10' AND '12' THEN 'Q4'
              ).
              "Skip item — reversed within the same quarter, nets to zero
              IF lv_rev_quarter = <lfs_taxitems>-quarter.
                CONTINUE.
              ENDIF.
            ENDIF.
            APPEND <lfs_taxitems> TO lt_taxitems_tmp.
          ENDIF.
        ENDLOOP.

        IF lt_taxitems_tmp IS NOT INITIAL.
          r_result = lt_taxitems_tmp.
        ENDIF.

      ENDIF.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
