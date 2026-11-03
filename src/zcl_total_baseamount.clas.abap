CLASS zcl_total_baseamount DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: BEGIN OF ty_variables,
             "name  TYPE c LENGTH 80,
             fbudat        TYPE c LENGTH 8,
             ccode         TYPE c LENGTH 4,
             tbudat        TYPE c LENGTH 8,
             budat         TYPE c LENGTH 8,
             totalbaseamnt TYPE p DECIMALS 2 LENGTH 15,
             totalamount   TYPE p DECIMALS 2 LENGTH 15,
           END OF ty_variables.
    CLASS-METHODS: compute_total
      "IMPORTING iv_name     TYPE ty_variables-name
      IMPORTING iv_budatstart  TYPE ty_variables-tbudat
                iv_budatend    TYPE ty_variables-fbudat
                iv_companycode TYPE ty_variables-ccode
      EXPORTING ev_total       TYPE ty_variables
                et_message     TYPE srft_message.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TOTAL_BASEAMOUNT IMPLEMENTATION.


  METHOD compute_total.
    CONSTANTS: lc_space TYPE c VALUE ' '.


    IF iv_budatstart IS NOT INITIAL AND iv_companycode IS NOT INITIAL.

      SELECT SINGLE SUM( a~TaxBaseAmountInCoCodeCrcy ) AS totalbase,
             SUM( a~TaxAmountInCoCodeCrcy ) AS totalamnt,
                  a~CompanyCode
            FROM I_OperationalAcctgDocTaxItem AS a
            WHERE
                  ( a~TaxCode = 'V4' OR
                    a~TaxCode = 'V9' )
                  AND
                  a~CompanyCode = @iv_companycode AND EXISTS (
       SELECT b~companycode FROM I_JournalEntry AS b
           WHERE b~AccountingDocument = a~AccountingDocument
             AND b~CompanyCode        = a~CompanyCode
             AND b~FiscalYear         = a~FiscalYear
             AND b~PostingDate >= @iv_budatstart "this would be based on budat to get the period that will be passed on
             AND b~PostingDate <= @iv_budatend
             AND b~IsReversal IS INITIAL  "requested to exclude reversed and reversal documents for 1600VT items
             AND b~IsReversed IS INITIAL
       )

            GROUP BY a~CompanyCode
           INTO @DATA(ls_totaltaxbase).

      ev_total-totalbaseamnt = ls_totaltaxbase-totalbase.
      ev_total-totalamount = ls_totaltaxbase-totalamnt.
      ev_total-ccode = ls_totaltaxbase-CompanyCode.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
