CLASS zcl_ph_1600vt DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  TYPES:  BEGIN OF ty_output,
            compcode  TYPE bukrs,
            acctdoc   TYPE i_operationalacctgdocitem-AccountingDocument,
            acctdocitm   TYPE i_operationalacctgdocitem-AccountingDocumentItem,
            total_amt TYPE dmbtr,
          END OF ty_output,

          tt_output TYPE STANDARD TABLE OF ty_output.

  CLASS-METHODS: get_tot_amt  IMPORTING iv_reportenty   TYPE srf_reporting_entity
                                        iv_reportid     TYPE srf_rep_cat_id
                                        iv_reportrunid  TYPE srf_report_run_id
                                        iv_ctrykey      TYPE char2
                                        iv_compcode     TYPE bukrs OPTIONAL
                                        iv_taxbase_amt  TYPE dmbtr OPTIONAL
                                        iv_tax_amt      TYPE dmbtr OPTIONAL
                                        iv_acctdoc      TYPE i_operationalacctgdocitem-AccountingDocument OPTIONAL
                                        iv_acctdocitm   TYPE i_operationalacctgdocitem-AccountingDocumentItem OPTIONAL
                              EXPORTING es_output       TYPE ty_output
*                                        et_output       TYPE tt_output
                                        et_message      TYPE srft_message.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_PH_1600VT IMPLEMENTATION.


  METHOD get_tot_amt.
    es_output-total_amt = iv_taxbase_amt + iv_tax_amt.
  ENDMETHOD.
ENDCLASS.
