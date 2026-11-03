CLASS zcl_ph_drc_cdj_util DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: BEGIN OF ty_result,
             num_records    TYPE c LENGTH 20,
             amount         TYPE dmbtr,
             cutt_off_dtime TYPE c LENGTH 100,
             extracted_by   TYPE c LENGTH 100,
           END OF ty_result,

           tt_result TYPE STANDARD TABLE OF ty_result WITH DEFAULT KEY,

           BEGIN OF ty_glacctincocode,
             GLAccount                      TYPE c LENGTH 10,
             CompanyCode                    TYPE c LENGTH 4,
             AuthorizationGroup             TYPE c LENGTH 4,
             AccountingClerk                TYPE c LENGTH 2,
             LastInterestCalcRunDate        TYPE datum,
             CreationDate                   TYPE datum,
             CreatedByUser                  TYPE c LENGTH 12,
             LastChangeDateTime             TYPE c LENGTH 15,
             PlanningLevel                  TYPE c LENGTH 2,
             HouseBank                      TYPE c LENGTH 5,
             HouseBankAccount               TYPE c LENGTH 5,
             ExchRateDifferencesAccountDetn TYPE c LENGTH 4,
             ReconciliationAccountType      TYPE c LENGTH 1,
             TaxCategory                    TYPE c LENGTH 2,
             InterestCalculationCode        TYPE c LENGTH 2,
             GLAccountCurrency              TYPE c LENGTH 5,
             ReconciliationAcctIsChangeable TYPE c LENGTH 1,
             IsManagedExternally            TYPE c LENGTH 1,
             IsAutomaticallyPosted          TYPE c LENGTH 1,
             LineItemDisplayIsEnabled       TYPE c LENGTH 1,
             SupplementIsAllowed            TYPE c LENGTH 1,
             IsOpenItemManaged              TYPE c LENGTH 1,
             InterestCalculationDate        TYPE datum,
             IntrstCalcFrequencyInMonths    TYPE n LENGTH 2,
             AcctgDocItmDisplaySequenceRule TYPE c LENGTH 3,
             AlternativeGLAccount           TYPE c LENGTH 10,
             JointVentureRecoveryCode       TYPE c LENGTH 2,
             CommitmentItem                 TYPE c LENGTH 14,
             TaxCodeIsRequired              TYPE c LENGTH 1,
             BalanceHasLocalCurrency        TYPE c LENGTH 1,
             ValuationGroup                 TYPE c LENGTH 10,
             APARToleranceGroup             TYPE c LENGTH 4,
             AccountIsBlockedForPosting     TYPE c LENGTH 1,
             AccountIsMarkedForDeletion     TYPE c LENGTH 1,
             ClearingIsLedgerGroupSpecific  TYPE c LENGTH 1,
             IsCashFlowAccount              TYPE c LENGTH 1,
             GLAcctInflationKey             TYPE c LENGTH 8,
             FieldStatusGroup               TYPE c LENGTH 4,
             MultiCurrencyAccountingCode    TYPE c LENGTH 5,
             IsExtendedOpenItemManaged      TYPE c LENGTH 1,
             Country                        TYPE c LENGTH 3,
             ChartOfAccounts                TYPE c LENGTH 4,
             ControllingArea                TYPE c LENGTH 4,
             FieldStatusVariant             TYPE c LENGTH 4,
             CountryChartOfAccounts         TYPE c LENGTH 4,
           END OF ty_glacctincocode,

           tt_glacctincocode TYPE STANDARD TABLE OF ty_glacctincocode WITH DEFAULT KEY,

           "! Name of month
           BEGIN OF scals_month_name,
             "! Language
             spras TYPE spras,
             "! Number of month
             mnr   TYPE n LENGTH 2,
             "! Short text of month
             ktx   TYPE c LENGTH 3,
             "! Long text of month
             ltx   TYPE c LENGTH 10,
           END OF scals_month_name ,

           scalt_month_name TYPE STANDARD TABLE OF scals_month_name WITH DEFAULT KEY.
    TYPES:
  "! List of names of months
      scalt_month_names TYPE TABLE OF scals_month_name .

    CLASS-METHODS get_new_header_fields
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
    CLASS-DATA: mo_dp TYPE REF TO zcl_ph_drc_cdj_util.
    CLASS-METHODS create
      RETURNING
        VALUE(r_result) TYPE REF TO zcl_ph_drc_cdj_util.
    METHODS:  _get_rn_am_cdj IMPORTING io_msg_handler     TYPE REF TO if_srf_msg_handler
                                       io_acr             TYPE REF TO if_srf_report_run
                                       it_report_end_date TYPE srft_long_selopt
                             RETURNING VALUE(r_result)    TYPE tt_result
                             RAISING   cx_srf_error,
      _get_rn_am_crj IMPORTING io_msg_handler     TYPE REF TO if_srf_msg_handler
                               io_acr             TYPE REF TO if_srf_report_run
                               it_report_end_date TYPE srft_long_selopt
                     RETURNING VALUE(r_result)    TYPE tt_result
                     RAISING   cx_srf_error,
      _get_rn_am_pj  IMPORTING io_msg_handler     TYPE REF TO if_srf_msg_handler
                               io_acr             TYPE REF TO if_srf_report_run
                               it_report_end_date TYPE srft_long_selopt
                     RETURNING VALUE(r_result)    TYPE tt_result
                     RAISING   cx_srf_error,
      _get_rn_am_sj  IMPORTING io_msg_handler     TYPE REF TO if_srf_msg_handler
                               io_acr             TYPE REF TO if_srf_report_run
                               it_report_end_date TYPE srft_long_selopt
                     RETURNING VALUE(r_result)    TYPE tt_result
                     RAISING   cx_srf_error,
      _get_rn_am_gl  IMPORTING io_msg_handler     TYPE REF TO if_srf_msg_handler
                               io_acr             TYPE REF TO if_srf_report_run
                               it_report_end_date TYPE srft_long_selopt
                     RETURNING VALUE(r_result)    TYPE tt_result
                     RAISING   cx_srf_error,
      _get_rn_am_gj  IMPORTING io_msg_handler     TYPE REF TO if_srf_msg_handler
                               io_acr             TYPE REF TO if_srf_report_run
                               it_report_end_date TYPE srft_long_selopt
                     RETURNING VALUE(r_result)    TYPE tt_result
                     RAISING   cx_srf_error,
      _get_rn_am_ib  IMPORTING io_msg_handler     TYPE REF TO if_srf_msg_handler
                               io_acr             TYPE REF TO if_srf_report_run
                               it_report_end_date TYPE srft_long_selopt
                     RETURNING VALUE(r_result)    TYPE tt_result
                     RAISING   cx_srf_error,
      _get_cutoff_date  IMPORTING it_report_end_date    TYPE srft_long_selopt
                        RETURNING VALUE(rv_cutoff_date) TYPE string.
ENDCLASS.



CLASS ZCL_PH_DRC_CDJ_UTIL IMPLEMENTATION.


  METHOD get_new_header_fields.
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

    CASE iv_rep_cat_id.
      WHEN 'YY1_PH_CAS_CDJ_BP1000'
        OR 'YY1_PH_CAS_CDJ_BP1005'
        OR 'YY1_PH_CAS_CDJ_BP1006'
        OR 'YY1_PH_CAS_CDJ_BP2000'
        OR 'YY1_PH_CAS_CDJ_BP2036'.
        TRY.
            et_result = lo_dp->_get_rn_am_cdj(
                            io_msg_handler      = lo_handler
                            io_acr              = lo_acr
                            it_report_end_date  = it_report_end_date
                            ).
          CATCH cx_srf_error INTO lx_srf_error.
            RETURN.
        ENDTRY.

      WHEN 'YY1_PH_CAS_CRJ_BP1000'
        OR 'YY1_PH_CAS_CRJ_BP1005'
        OR 'YY1_PH_CAS_CRJ_BP1006'
        OR 'YY1_PH_CAS_CRJ_BP2000'
        OR 'YY1_PH_CAS_CRJ_BP2036'.
        TRY.
            et_result = lo_dp->_get_rn_am_crj(
                            io_msg_handler      = lo_handler
                            io_acr              = lo_acr
                            it_report_end_date  = it_report_end_date
                            ).
          CATCH cx_srf_error INTO lx_srf_error.
            RETURN.
        ENDTRY.

      WHEN 'YY1_PH_CAS_PJ_CLCT' OR 'YY1_PH_CAS_PJ_CNTC'.
        TRY.
            et_result = lo_dp->_get_rn_am_pj(
                            io_msg_handler      = lo_handler
                            io_acr              = lo_acr
                            it_report_end_date  = it_report_end_date
                            ).
          CATCH cx_srf_error INTO lx_srf_error.
            RETURN.
        ENDTRY.

      WHEN 'YY1_PH_CAS_BP1000_SJ'
        OR 'YY1_PH_CAS_BP1005_SJ'
        OR 'YY1_PH_CAS_BP1006_SJ'
        OR 'YY1_PH_CAS_BP2000_SJ'
        OR 'YY1_PH_CAS_BP2036_SJ'.
        TRY.
            et_result = lo_dp->_get_rn_am_sj(
                            io_msg_handler      = lo_handler
                            io_acr              = lo_acr
                            it_report_end_date  = it_report_end_date
                            ).
          CATCH cx_srf_error INTO lx_srf_error.
            RETURN.
        ENDTRY.

      WHEN 'YY1_PH_CAS_GL'.
        TRY.
            et_result = lo_dp->_get_rn_am_gl(
                            io_msg_handler      = lo_handler
                            io_acr              = lo_acr
                            it_report_end_date  = it_report_end_date
                            ).
          CATCH cx_srf_error INTO lx_srf_error.
            RETURN.
        ENDTRY.

      WHEN 'YY1_PH_CAS_GJ'.
        TRY.
            et_result = lo_dp->_get_rn_am_gj(
                            io_msg_handler      = lo_handler
                            io_acr              = lo_acr
                            it_report_end_date  = it_report_end_date
                            ).
          CATCH cx_srf_error INTO lx_srf_error.
            RETURN.
        ENDTRY.

      WHEN 'YY1_PH_CAS_IB'.
        TRY.
            et_result = lo_dp->_get_rn_am_ib(
                            io_msg_handler      = lo_handler
                            io_acr              = lo_acr
                            it_report_end_date  = it_report_end_date
                            ).
          CATCH cx_srf_error INTO lx_srf_error.
            RETURN.
        ENDTRY.
    ENDCASE.

  ENDMETHOD.


  METHOD _get_rn_am_cdj.
    DATA: ls_result                 TYPE ty_result,
          lv_debit_amount           TYPE dmbtr,
          lv_credit_amount          TYPE dmbtr,
          lt_glaccountincompanycode TYPE tt_glacctincocode,
          ls_glaccountincompanycode TYPE ty_glacctincocode.
    FIELD-SYMBOLS:  <lv_amount>     TYPE any.

    "get entries to derive total amount from
    TRY .
        DATA(lo_records) = io_acr->execute_query(
          iv_query_id = 'YY1_GLACCTINCOCODE'
          it_column_name = VALUE #(
                                      ( CONV #( 'GLAccount' ) )
                                      ( CONV #( 'CompanyCode' ) )
                                      ( CONV #( 'AuthorizationGroup' ) )
                                      ( CONV #( 'AccountingClerk' ) )
                                      ( CONV #( 'LastInterestCalcRunDate' ) )
                                      ( CONV #( 'CreationDate' ) )
                                      ( CONV #( 'CreatedByUser' ) )
                                      ( CONV #( 'LastChangeDateTime' ) )
                                      ( CONV #( 'PlanningLevel' ) )
                                      ( CONV #( 'HouseBank' ) )
                                      ( CONV #( 'HouseBankAccount' ) )
                                      ( CONV #( 'ExchRateDifferencesAccountDetn' ) )
                                      ( CONV #( 'ReconciliationAccountType' ) )
                                      ( CONV #( 'TaxCategory' ) )
                                      ( CONV #( 'InterestCalculationCode' ) )
                                      ( CONV #( 'GLAccountCurrency' ) )
                                      ( CONV #( 'ReconciliationAcctIsChangeable' ) )
                                      ( CONV #( 'IsManagedExternally' ) )
                                      ( CONV #( 'IsAutomaticallyPosted' ) )
                                      ( CONV #( 'LineItemDisplayIsEnabled' ) )
                                      ( CONV #( 'SupplementIsAllowed' ) )
                                      ( CONV #( 'IsOpenItemManaged' ) )
                                      ( CONV #( 'InterestCalculationDate' ) )
                                      ( CONV #( 'IntrstCalcFrequencyInMonths' ) )
                                      ( CONV #( 'AcctgDocItmDisplaySequenceRule' ) )
                                      ( CONV #( 'AlternativeGLAccount' ) )
                                      ( CONV #( 'JointVentureRecoveryCode' ) )
                                      ( CONV #( 'CommitmentItem' ) )
                                      ( CONV #( 'TaxCodeIsRequired' ) )
                                      ( CONV #( 'BalanceHasLocalCurrency' ) )
                                      ( CONV #( 'ValuationGroup' ) )
                                      ( CONV #( 'APARToleranceGroup' ) )
                                      ( CONV #( 'AccountIsBlockedForPosting' ) )
                                      ( CONV #( 'AccountIsMarkedForDeletion' ) )
                                      ( CONV #( 'ClearingIsLedgerGroupSpecific' ) )
                                      ( CONV #( 'IsCashFlowAccount' ) )
                                      ( CONV #( 'GLAcctInflationKey' ) )
                                      ( CONV #( 'FieldStatusGroup' ) )
                                      ( CONV #( 'MultiCurrencyAccountingCode' ) )
                                      ( CONV #( 'IsExtendedOpenItemManaged' ) )
                                      ( CONV #( 'Country' ) )
                                      ( CONV #( 'ChartOfAccounts' ) )
                                      ( CONV #( 'ControllingArea' ) )
                                      ( CONV #( 'FieldStatusVariant' ) )
                                      ( CONV #( 'CountryChartOfAccounts' ) )
                                  )
            io_msg_handler    = io_msg_handler
          ).
      CATCH cx_srf_error INTO DATA(lx_srf_error).
        RETURN.
    ENDTRY.

    IF lo_records IS NOT INITIAL.
      ASSIGN lo_records->* TO FIELD-SYMBOL(<lt_glacctincocode>).
      IF <lt_glacctincocode> IS ASSIGNED.
        LOOP AT <lt_glacctincocode> ASSIGNING FIELD-SYMBOL(<lfs_glacctincocode>).
          APPEND INITIAL LINE TO lt_glaccountincompanycode ASSIGNING FIELD-SYMBOL(<lfs_glaccountincompanycode>).
          IF <lfs_glaccountincompanycode> IS ASSIGNED.
            MOVE-CORRESPONDING <lfs_glacctincocode> TO <lfs_glaccountincompanycode>.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.

    "Get number of records
    CLEAR:  lx_srf_error,
            lo_records.
    TRY .
        lo_records = io_acr->execute_query(
          iv_query_id = 'CDJ_ITM'
          it_column_name = VALUE #(
                                      ( CONV #( 'POSTINGDATE' ) )
                                      ( CONV #( 'ACCOUNTINGDOCUMENT' ) )
                                      ( CONV #( 'ACCOUNTINGDOCUMENTITEM' ) )
                                      ( CONV #( 'ACCOUNTINGDOCUMENTTYPE' ) )
                                      ( CONV #( 'CUSTOMERSUPPLIERVATREGN' ) )
                                      ( CONV #( 'CUSTOMERSUPPLIERACCOUNT' ) )
                                      ( CONV #( 'CUSTOMERSUPPLIERNAME' ) )
                                      ( CONV #( 'CUSTOMERSUPPLIERADDRESS' ) )
                                      ( CONV #( 'ORIGINALREFERENCEDOCUMENT' ) )
                                      ( CONV #( 'EXTERNALDOCUMENTID' ) )
                                      ( CONV #( 'OFFICIALRECEIPTNUMBER' ) )
                                      ( CONV #( 'GLACCOUNT' ) )
                                      ( CONV #( 'GLACCOUNTNAME' ) )
                                      ( CONV #( 'DEBITCREDITCODENAME' ) )
                                      ( CONV #( 'DEBITAMOUNTINCOCODECRCY' ) )
                                      ( CONV #( 'CREDITAMOUNTINCOCODECRCY' ) )
                                      ( CONV #( 'COMPANYCODECURRENCY' ) )
                                      ( CONV #( 'DOCUMENTITEMTEXT' ) )
                                  )
            io_msg_handler    = io_msg_handler
          ).
      CATCH cx_srf_error INTO lx_srf_error.
        RETURN.
    ENDTRY.

    ls_result-num_records = 0.
    ls_result-amount = 0.

    IF lo_records IS NOT INITIAL.
      ASSIGN lo_records->* TO FIELD-SYMBOL(<lt_cdj_items>).
      IF <lt_cdj_items> IS NOT INITIAL.
        ls_result-num_records = lines( <lt_cdj_items> ).

        LOOP AT <lt_cdj_items> ASSIGNING FIELD-SYMBOL(<lr_record>).
*          ASSIGN COMPONENT 'GLACCOUNT' OF STRUCTURE <lr_record> TO FIELD-SYMBOL(<lv_glaccount>).
*          IF sy-subrc = 0.
*            READ TABLE lt_glaccountincompanycode INTO ls_glaccountincompanycode WITH KEY glaccount = <lv_glaccount> iscashflowaccount = 'X'.
*            IF sy-subrc = 0.
          ASSIGN COMPONENT 'DEBITAMOUNTINCOCODECRCY' OF STRUCTURE <lr_record> TO <lv_amount>.
          IF sy-subrc = 0.
            lv_debit_amount +=  <lv_amount>.
          ENDIF.

          ASSIGN COMPONENT 'CREDITAMOUNTINCOCODECRCY' OF STRUCTURE <lr_record> TO <lv_amount>.
          IF sy-subrc = 0.
            lv_credit_amount +=  <lv_amount>.
          ENDIF.
*            ENDIF.
*          ENDIF.
        ENDLOOP.

        ls_result-amount = lv_debit_amount - lv_credit_amount.
        IF ls_result-amount = 0.
          ls_result-amount = lv_debit_amount.
        ENDIF.

        ls_result-cutt_off_dtime = _get_cutoff_date( it_report_end_date ).
      ENDIF.
    ENDIF.

    IF ls_result IS NOT INITIAL.
      CONDENSE: ls_result-num_records.
      APPEND ls_result TO r_result.
    ENDIF.
  ENDMETHOD.


  METHOD _get_rn_am_crj.
    DATA: ls_result                 TYPE ty_result,
          lv_debit_amount           TYPE dmbtr,
          lv_credit_amount          TYPE dmbtr,
          lt_glaccountincompanycode TYPE tt_glacctincocode,
          ls_glaccountincompanycode TYPE ty_glacctincocode.
    FIELD-SYMBOLS:  <lv_amount>     TYPE any.

    "get entries to derive total amount from
    TRY .
        DATA(lo_records) = io_acr->execute_query(
          iv_query_id = 'YY1_GLACCTINCOCODE'
          it_column_name = VALUE #(
                                      ( CONV #( 'GLAccount' ) )
                                      ( CONV #( 'CompanyCode' ) )
                                      ( CONV #( 'AuthorizationGroup' ) )
                                      ( CONV #( 'AccountingClerk' ) )
                                      ( CONV #( 'LastInterestCalcRunDate' ) )
                                      ( CONV #( 'CreationDate' ) )
                                      ( CONV #( 'CreatedByUser' ) )
                                      ( CONV #( 'LastChangeDateTime' ) )
                                      ( CONV #( 'PlanningLevel' ) )
                                      ( CONV #( 'HouseBank' ) )
                                      ( CONV #( 'HouseBankAccount' ) )
                                      ( CONV #( 'ExchRateDifferencesAccountDetn' ) )
                                      ( CONV #( 'ReconciliationAccountType' ) )
                                      ( CONV #( 'TaxCategory' ) )
                                      ( CONV #( 'InterestCalculationCode' ) )
                                      ( CONV #( 'GLAccountCurrency' ) )
                                      ( CONV #( 'ReconciliationAcctIsChangeable' ) )
                                      ( CONV #( 'IsManagedExternally' ) )
                                      ( CONV #( 'IsAutomaticallyPosted' ) )
                                      ( CONV #( 'LineItemDisplayIsEnabled' ) )
                                      ( CONV #( 'SupplementIsAllowed' ) )
                                      ( CONV #( 'IsOpenItemManaged' ) )
                                      ( CONV #( 'InterestCalculationDate' ) )
                                      ( CONV #( 'IntrstCalcFrequencyInMonths' ) )
                                      ( CONV #( 'AcctgDocItmDisplaySequenceRule' ) )
                                      ( CONV #( 'AlternativeGLAccount' ) )
                                      ( CONV #( 'JointVentureRecoveryCode' ) )
                                      ( CONV #( 'CommitmentItem' ) )
                                      ( CONV #( 'TaxCodeIsRequired' ) )
                                      ( CONV #( 'BalanceHasLocalCurrency' ) )
                                      ( CONV #( 'ValuationGroup' ) )
                                      ( CONV #( 'APARToleranceGroup' ) )
                                      ( CONV #( 'AccountIsBlockedForPosting' ) )
                                      ( CONV #( 'AccountIsMarkedForDeletion' ) )
                                      ( CONV #( 'ClearingIsLedgerGroupSpecific' ) )
                                      ( CONV #( 'IsCashFlowAccount' ) )
                                      ( CONV #( 'GLAcctInflationKey' ) )
                                      ( CONV #( 'FieldStatusGroup' ) )
                                      ( CONV #( 'MultiCurrencyAccountingCode' ) )
                                      ( CONV #( 'IsExtendedOpenItemManaged' ) )
                                      ( CONV #( 'Country' ) )
                                      ( CONV #( 'ChartOfAccounts' ) )
                                      ( CONV #( 'ControllingArea' ) )
                                      ( CONV #( 'FieldStatusVariant' ) )
                                      ( CONV #( 'CountryChartOfAccounts' ) )
                                  )
            io_msg_handler    = io_msg_handler
          ).
      CATCH cx_srf_error INTO DATA(lx_srf_error).
        RETURN.
    ENDTRY.

    IF lo_records IS NOT INITIAL.
      ASSIGN lo_records->* TO FIELD-SYMBOL(<lt_glacctincocode>).
      IF <lt_glacctincocode> IS ASSIGNED.
        LOOP AT <lt_glacctincocode> ASSIGNING FIELD-SYMBOL(<lfs_glacctincocode>).
          APPEND INITIAL LINE TO lt_glaccountincompanycode ASSIGNING FIELD-SYMBOL(<lfs_glaccountincompanycode>).
          IF <lfs_glaccountincompanycode> IS ASSIGNED.
            MOVE-CORRESPONDING <lfs_glacctincocode> TO <lfs_glaccountincompanycode>.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.

    "Get number of records
    CLEAR:  lx_srf_error,
            lo_records.
    TRY .
        lo_records = io_acr->execute_query(
          iv_query_id = 'CRJ_ITEM_BRF'
          it_column_name = VALUE #(
                                      ( CONV #( 'POSTINGDATE' ) )
                                      ( CONV #( 'DOCUMENTNUMBER' ) )
                                      ( CONV #( 'POSTINGVIEWITEM' ) )
                                      ( CONV #( 'DOCUMENTTYPE' ) )
                                      ( CONV #( 'TAXIDENTIFICATIONID' ) )
                                      ( CONV #( 'CUSTOMERID' ) )
                                      ( CONV #( 'CUSTOMERNAME' ) )
                                      ( CONV #( 'CUSTOMERADDRESS' ) )
                                      ( CONV #( 'ORIGINALREFERENCEDOCUMENT' ) )
                                      ( CONV #( 'EXTERNALDOCUMENTID' ) )
                                      ( CONV #( 'OFFICIALRECEIPTNUMBER' ) )
                                      ( CONV #( 'GLACCOUNT' ) )
                                      ( CONV #( 'GLACCOUNTTEXT' ) )
                                      ( CONV #( 'DEBITCREDITCODE' ) )
                                      ( CONV #( 'DEBITAMOUNT' ) )
                                      ( CONV #( 'CREDITAMOUNT' ) )
                                      ( CONV #( 'CURRENCY' ) )
                                      ( CONV #( 'LINEITEMTEXT' ) )
                                  )
            io_msg_handler    = io_msg_handler
          ).
      CATCH cx_srf_error INTO lx_srf_error.
        RETURN.
    ENDTRY.

    ls_result-num_records = 0.
    ls_result-amount = 0.

    IF lo_records IS NOT INITIAL.
      ASSIGN lo_records->* TO FIELD-SYMBOL(<lt_crj_items>).
      IF <lt_crj_items> IS NOT INITIAL.
        ls_result-num_records = lines( <lt_crj_items> ).

        LOOP AT <lt_crj_items> ASSIGNING FIELD-SYMBOL(<lr_record>).
*          ASSIGN COMPONENT 'GLACCOUNT' OF STRUCTURE <lr_record> TO FIELD-SYMBOL(<lv_glaccount>).
*          IF sy-subrc = 0.
*            READ TABLE lt_glaccountincompanycode INTO ls_glaccountincompanycode WITH KEY glaccount = <lv_glaccount> iscashflowaccount = 'X'.
*            IF sy-subrc = 0.
          ASSIGN COMPONENT 'DEBITAMOUNT' OF STRUCTURE <lr_record> TO <lv_amount>.
          IF sy-subrc = 0.
            lv_debit_amount +=  <lv_amount>.
          ENDIF.

          ASSIGN COMPONENT 'CREDITAMOUNT' OF STRUCTURE <lr_record> TO <lv_amount>.
          IF sy-subrc = 0.
            lv_credit_amount +=  <lv_amount>.
          ENDIF.
*            ENDIF.
*          ENDIF.
        ENDLOOP.

        ls_result-amount = lv_debit_amount - lv_credit_amount.
        IF ls_result-amount = 0.
          ls_result-amount = lv_debit_amount.
        ENDIF.
        ls_result-cutt_off_dtime = _get_cutoff_date( it_report_end_date ).
      ENDIF.
    ENDIF.

    IF ls_result IS NOT INITIAL.
      CONDENSE: ls_result-num_records.
      APPEND ls_result TO r_result.
    ENDIF.
  ENDMETHOD.


  METHOD _get_rn_am_pj.
    DATA: ls_result       TYPE ty_result,
          lv_debit_amount TYPE dmbtr.
    TRY .
        DATA(lo_records) = io_acr->execute_query(
          iv_query_id = 'PURCHASEJOURNAL'
          it_column_name = VALUE #(
                                      ( CONV #( 'VATREGISTRATION' ) )
                                      ( CONV #( 'SUPPLIER' ) )
                                      ( CONV #( 'BUSINESSPARTNERNAME' ) )
                                      ( CONV #( 'ADDRESSID' ) )
                                      ( CONV #( 'ACCOUNTINGDOCUMENT' ) )
                                      ( CONV #( 'ACCOUNTINGDOCUMENTTYPE' ) )
                                      ( CONV #( 'POSTINGDATE' ) )
                                      ( CONV #( 'AMOUNTINCOMPANYCODECURRENCY' ) )
                                      ( CONV #( 'CASHDISCOUNTAMTINCOCODECRCY' ) )
                                      ( CONV #( 'COMPANYCODECURRENCY' ) )
                                      ( CONV #( 'TAXAMOUNTINCOUNTRYCRCY' ) )
                                      ( CONV #( 'TAXBASEAMOUNTINCOUNTRYCRCY' ) )
                                      ( CONV #( 'COUNTRYCURRENCY' ) )
                                      ( CONV #( 'ORIGINALREFERENCEDOCUMENT' ) )
                                      ( CONV #( 'DOCUMENTREFERENCEID' ) )
                                      ( CONV #( 'TAXCODE' ) )
                                      ( CONV #( 'ACCOUNTINGDOCUMENTHEADERTEXT' ) )
                                  )
            io_msg_handler    = io_msg_handler
          ).
      CATCH cx_srf_error INTO DATA(lx_srf_error).
        RETURN.
    ENDTRY.

    ls_result-num_records = 0.
    ls_result-amount = 0.

    IF lo_records IS NOT INITIAL.
      ASSIGN lo_records->* TO FIELD-SYMBOL(<lt_pj_items>).
      IF <lt_pj_items> IS NOT INITIAL.
        ls_result-num_records = lines( <lt_pj_items> ).

        LOOP AT <lt_pj_items> ASSIGNING FIELD-SYMBOL(<lr_record>).
          ASSIGN COMPONENT 'TAXBASEAMOUNTINCOUNTRYCRCY' OF STRUCTURE <lr_record> TO FIELD-SYMBOL(<lv_amount>).
          IF sy-subrc = 0.
            lv_debit_amount +=  <lv_amount>.
          ENDIF.
        ENDLOOP.

        ls_result-amount = lv_debit_amount.
        ls_result-cutt_off_dtime = _get_cutoff_date( it_report_end_date ).
      ENDIF.
    ENDIF.

    IF ls_result IS NOT INITIAL.
      CONDENSE: ls_result-num_records.
      APPEND ls_result TO r_result.
    ENDIF.
  ENDMETHOD.


  METHOD _get_rn_am_sj.
    DATA: ls_result       TYPE ty_result,
          lv_debit_amount TYPE dmbtr.
    TRY .
        DATA(lo_records) = io_acr->execute_query(
          iv_query_id = 'SALESJOURNAL'
          it_column_name = VALUE #(
                                      ( CONV #( 'VATREGISTRATION' ) )
                                      ( CONV #( 'CUSTOMER' ) )
                                      ( CONV #( 'BUSINESSPARTNERNAME' ) )
                                      ( CONV #( 'ADDRESSID' ) )
                                      ( CONV #( 'ACCOUNTINGDOCUMENT' ) )
                                      ( CONV #( 'ACCOUNTINGDOCUMENTTYPE' ) )
                                      ( CONV #( 'POSTINGDATE' ) )
                                      ( CONV #( 'AMOUNTINCOMPANYCODECURRENCY' ) )
                                      ( CONV #( 'CASHDISCOUNTAMTINCOCODECRCY' ) )
                                      ( CONV #( 'COMPANYCODECURRENCY' ) )
                                      ( CONV #( 'TAXAMOUNTINCOUNTRYCRCY' ) )
                                      ( CONV #( 'TAXBASEAMOUNTINCOUNTRYCRCY' ) )
                                      ( CONV #( 'COUNTRYCURRENCY' ) )
                                      ( CONV #( 'ORIGINALREFERENCEDOCUMENT' ) )
                                      ( CONV #( 'DOCUMENTREFERENCEID' ) )
                                      ( CONV #( 'TAXCODE' ) )
                                      ( CONV #( 'ACCOUNTINGDOCUMENTHEADERTEXT' ) )
                                  )
            io_msg_handler    = io_msg_handler
          ).
      CATCH cx_srf_error INTO DATA(lx_srf_error).
        RETURN.
    ENDTRY.

    ls_result-num_records = 0.
    ls_result-amount = 0.

    IF lo_records IS NOT INITIAL.
      ASSIGN lo_records->* TO FIELD-SYMBOL(<lt_pj_items>).
      IF <lt_pj_items> IS NOT INITIAL.
        ls_result-num_records = lines( <lt_pj_items> ).

        LOOP AT <lt_pj_items> ASSIGNING FIELD-SYMBOL(<lr_record>).
          ASSIGN COMPONENT 'TAXBASEAMOUNTINCOUNTRYCRCY' OF STRUCTURE <lr_record> TO FIELD-SYMBOL(<lv_amount>).
          IF sy-subrc = 0.
            lv_debit_amount +=  <lv_amount>.
          ENDIF.
        ENDLOOP.

        ls_result-amount = lv_debit_amount.
        ls_result-cutt_off_dtime = _get_cutoff_date( it_report_end_date ).
      ENDIF.
    ENDIF.

    IF ls_result IS NOT INITIAL.
      CONDENSE: ls_result-num_records.
      APPEND ls_result TO r_result.
    ENDIF.
  ENDMETHOD.


  METHOD _get_rn_am_gl.
    DATA: ls_result       TYPE ty_result,
          lv_debit_amount TYPE dmbtr.
    TRY .
        DATA(lo_records) = io_acr->execute_query(
          iv_query_id = 'GENERALLEDGERITEM'
          it_column_name = VALUE #(
                                      ( CONV #( 'BUKRS' ) )
                                        ( CONV #( 'GJAHR' ) )
                                        ( CONV #( 'POPER' ) )
                                        ( CONV #( 'LEDGER' ) )
                                        ( CONV #( 'BUDAT' ) )
                                        ( CONV #( 'XBLNR' ) )
                                        ( CONV #( 'BLART' ) )
                                        ( CONV #( 'DARTXT' ) )
                                        ( CONV #( 'SGTXT' ) )
                                        ( CONV #( 'RACCT' ) )
                                        ( CONV #( 'TXT20' ) )
                                        ( CONV #( 'AWKEY' ) )
                                        ( CONV #( 'MWSKZ' ) )
                                        ( CONV #( 'WAERS' ) )
                                        ( CONV #( 'HSL' ) )
                                        ( CONV #( 'HSL_CREDIT' ) )
                                        ( CONV #( 'HSL_DEBIT' ) )
                                        ( CONV #( 'BELNR' ) )
                                        ( CONV #( 'DATE_VAL' ) )
                                  )
            io_msg_handler    = io_msg_handler
          ).
      CATCH cx_srf_error INTO DATA(lx_srf_error).
        RETURN.
    ENDTRY.

    ls_result-num_records = 0.
    ls_result-amount = 0.

    IF lo_records IS NOT INITIAL.
      ASSIGN lo_records->* TO FIELD-SYMBOL(<lt_pj_items>).
      IF <lt_pj_items> IS NOT INITIAL.
        ls_result-num_records = lines( <lt_pj_items> ).

        LOOP AT <lt_pj_items> ASSIGNING FIELD-SYMBOL(<lr_record>).
          ASSIGN COMPONENT 'HSL_DEBIT' OF STRUCTURE <lr_record> TO FIELD-SYMBOL(<lv_amount>).
          IF sy-subrc = 0.
            lv_debit_amount +=  <lv_amount>.
          ENDIF.
        ENDLOOP.

        ls_result-amount = lv_debit_amount.
        ls_result-cutt_off_dtime = _get_cutoff_date( it_report_end_date ).
      ENDIF.
    ENDIF.

    IF ls_result IS NOT INITIAL.
      CONDENSE: ls_result-num_records.
      APPEND ls_result TO r_result.
    ENDIF.
  ENDMETHOD.


  METHOD _get_rn_am_ib.
    DATA: ls_result       TYPE ty_result,
          lv_debit_amount TYPE dmbtr.
    TRY .
        DATA(lo_records) = io_acr->execute_query(
          iv_query_id = 'YY1_NEWINVENTORY_DETAILS'
          it_column_name = VALUE #(
                                      ( CONV #( 'FISCALENDDATETEXT' ) )
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

    ls_result-num_records = 0.
    ls_result-amount = 0.

    IF lo_records IS NOT INITIAL.
      ASSIGN lo_records->* TO FIELD-SYMBOL(<lt_ib_items>).

      IF <lt_ib_items> IS NOT INITIAL.

        ls_result-num_records = lines( <lt_ib_items> ).

        LOOP AT <lt_ib_items> ASSIGNING FIELD-SYMBOL(<lr_record>).
          ASSIGN COMPONENT 'TOTALVALSTOCKVALUE' OF STRUCTURE <lr_record> TO FIELD-SYMBOL(<lv_amount>).
          IF sy-subrc = 0.
            lv_debit_amount +=  <lv_amount>.
          ENDIF.
        ENDLOOP.

        ls_result-amount = lv_debit_amount.
        ls_result-cutt_off_dtime = _get_cutoff_date( it_report_end_date ).


        SELECT SINGLE FROM I_BusinessUserBasic
        FIELDS PersonFullName
        WHERE UserID = @sy-uname
        INTO @DATA(lv_name).

        ls_result-extracted_by = lv_name.

      ENDIF.
    ENDIF.

    IF ls_result IS NOT INITIAL.
      CONDENSE: ls_result-num_records.
      APPEND ls_result TO r_result.
    ENDIF.
  ENDMETHOD.


  METHOD _get_rn_am_gj.
    DATA: ls_result       TYPE ty_result,
          lv_debit_amount TYPE dmbtr.
    TRY .
        DATA(lo_records) = io_acr->execute_query(
          iv_query_id = 'GENERALJOURNAL'
          it_column_name = VALUE #(
                                      ( CONV #( 'GLACCOUNT' ) )
                                      ( CONV #( 'GLACCOUNTLONGNAME' ) )
                                      ( CONV #( 'ACCOUNTINGDOCUMENT' ) )
                                      ( CONV #( 'BUSINESSAREA' ) )
                                      ( CONV #( 'ACCOUNTINGDOCUMENTTYPE' ) )
                                      ( CONV #( 'ACCOUNTINGDOCUMENTTYPENAME' ) )
                                      ( CONV #( 'POSTINGDATE' ) )
                                      ( CONV #( 'DEBITAMOUNTINCOCODECRCY' ) )
                                      ( CONV #( 'CREDITAMOUNTINCOCODECRCY' ) )
                                      ( CONV #( 'CURRENCY' ) )
                                      ( CONV #( 'ORIGINALREFERENCEDOCUMENT' ) )
                                      ( CONV #( 'DOCUMENTREFERENCEID' ) )
                                      ( CONV #( 'ASSIGNMENTREFERENCE' ) )
                                      ( CONV #( 'CLEARINGACCOUNTINGDOCUMENT' ) )
                                      ( CONV #( 'TAXCODE' ) )
                                      ( CONV #( 'DOCUMENTITEMTEXT' ) )
                                  )
            io_msg_handler    = io_msg_handler
          ).
      CATCH cx_srf_error INTO DATA(lx_srf_error).
        RETURN.
    ENDTRY.

    ls_result-num_records = 0.
    ls_result-amount = 0.

    IF lo_records IS NOT INITIAL.
      ASSIGN lo_records->* TO FIELD-SYMBOL(<lt_pj_items>).
      IF <lt_pj_items> IS NOT INITIAL.
        ls_result-num_records = lines( <lt_pj_items> ).

        LOOP AT <lt_pj_items> ASSIGNING FIELD-SYMBOL(<lr_record>).
          ASSIGN COMPONENT 'DEBITAMOUNTINCOCODECRCY' OF STRUCTURE <lr_record> TO FIELD-SYMBOL(<lv_amount>).
          IF sy-subrc = 0.
            lv_debit_amount +=  <lv_amount>.
          ENDIF.
        ENDLOOP.

        ls_result-amount = lv_debit_amount.
        ls_result-cutt_off_dtime = _get_cutoff_date( it_report_end_date ).
      ENDIF.
    ENDIF.

    IF ls_result IS NOT INITIAL.
      CONDENSE: ls_result-num_records.
      APPEND ls_result TO r_result.
    ENDIF.
  ENDMETHOD.


  METHOD _get_cutoff_date.
    DATA    lv_last_date TYPE datum.
    DATA    lv_last_date_of_month TYPE datum.
    DATA    lt_tax_reporting_date TYPE acrt_ph_vat_tax_reporting_date.
    DATA    ls_tax_reporting_date TYPE LINE OF acrt_ph_vat_tax_reporting_date.

    MOVE-CORRESPONDING it_report_end_date TO lt_tax_reporting_date.
    READ TABLE lt_tax_reporting_date INDEX 1 INTO ls_tax_reporting_date.
    lv_last_date = ls_tax_reporting_date-high.

    TRY.
        cl_scal_utils=>month_names_get(
          EXPORTING
            iv_language = sy-langu
          IMPORTING
            et_month_names = DATA(lt_month_names)
            ev_returncode  = DATA(lv_retcode)
            ).
      CATCH cx_scal INTO DATA(lx_scal_error).
        RETURN.
    ENDTRY.

    ASSIGN lt_month_names[ mnr = lv_last_date+4(2) ] TO FIELD-SYMBOL(<lfs_month_names>).
    IF <lfs_month_names> IS ASSIGNED.
      DATA lv_month_name TYPE string.
      DATA lv_date TYPE string.
      DATA lv_year TYPE string.

      lv_month_name = condense( <lfs_month_names>-ltx ).
      lv_year = lv_last_date+0(4).
    ENDIF.


    CONCATENATE lv_month_name  lv_last_date+6(2) lv_year '11:59:59 PM' INTO rv_cutoff_date SEPARATED BY space.
  ENDMETHOD.


  METHOD create.
    IF mo_dp IS INITIAL.
      mo_dp = NEW zcl_ph_drc_cdj_util( ).
    ENDIF.
    RETURN mo_dp.
  ENDMETHOD.
ENDCLASS.
