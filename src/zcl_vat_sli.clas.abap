CLASS zcl_vat_sli DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    interfaces IF_BADI_INTERFACE .
    interfaces IF_PH_VAT_IMPORTATION_SL .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_VAT_SLI IMPLEMENTATION.


  method IF_PH_VAT_IMPORTATION_SL~GET_IMPORTATION_SUMMARY_LIST.
*--------------------------------------------------------------------*
* this is an example for enhancement 'PH VAT Summary List'
*
* Import parameter:
*    COMPANYCODE: Company Code
*    FISCALYEAR: A table contain all the fiscal years
*    POSTINGPERIOD: A table contain all the fiscal years
*    TAXCODE: A table contain all the fiscal yearse
*    GLACCOUNT: A table contain all the fiscal years
*    SUPPLIER: A table contain all the fiscal years
*    RDOCODE: RDO Code
*    FILEFORMAT: target file format
*                if FILEFORMAT equals "CSV"，
*                   fill the changing table CSVFILEITEMDETAIL
*                if FILEFORMAT equals "DAT"
*                   fill the changing table DATFILEHEADER and DATFILEITEMDETAIL
* Changing parameter:
*    CSVFILEITEMDETAIL: the returning data for CSV file
*    DATFILEITEMDETAIL: the returning data for DAT file detail
*    DATFILEHEADER：the returning data for DAT file header
*--------------------------------------------------------------------*

*****************Field Mapping***************
*--------------------------------------------------------------------*
*DAT File Header
*ACRS_PH_VAT_ISL_DAT_HS-PH_INDICATOR          Indicator: H,P
*ACRS_PH_VAT_ISL_DAT_HS-TINNUMBER             Tax Identification Number
*ACRS_PH_VAT_ISL_DAT_HS-REGISTEREDNAME        Company Name
*ACRS_PH_VAT_ISL_DAT_HS-LASTNAME              Last Name
*ACRS_PH_VAT_ISL_DAT_HS-FIRSTNAME             First Name
*ACRS_PH_VAT_ISL_DAT_HS-MIDDLENAME            Middle Name
*ACRS_PH_VAT_ISL_DAT_HS-TRADENAME             Trade Name
*ACRS_PH_VAT_ISL_DAT_HS-ADDRESS1              Sub-street Street Barangay
*ACRS_PH_VAT_ISL_DAT_HS-ADDRESS2              City/Municipality Province Zip Code
*ACRS_PH_VAT_ISL_DAT_HS-TOTALDUTIABLEVALUE    Total Dutiable Value
*ACRS_PH_VAT_ISL_DAT_HS-TOTALCHARGES          Total Charges
*ACRS_PH_VAT_ISL_DAT_HS-TOTALEXEMPT           Total Exempt
*ACRS_PH_VAT_ISL_DAT_HS-TOTALTAXABLEGOODS     Total Taxable Goods
*ACRS_PH_VAT_ISL_DAT_HS-TOTALVATPAYABLE       Total Vat Payable
*ACRS_PH_VAT_ISL_DAT_HS-RDOCODE               RDO Code
*ACRS_PH_VAT_ISL_DAT_HS-TAXABLEMONTH          Taxable Month
*ACRS_PH_VAT_ISL_DAT_HS-FISCALYEARENDING      Fiscal Month End

*DAT File Details
*ACR_PH_VAT_ISL_ITEM-PH_INDICATOR             Indicator: D,P
*ACR_PH_VAT_ISL_ITEM-IMPORTENTRY              import_Entry
*ACR_PH_VAT_ISL_ITEM-ASSESSMENTDATE           assessmentDate
*ACR_PH_VAT_ISL_ITEM-SUPPLIERNAME             supplier
*ACR_PH_VAT_ISL_ITEM-IMPORTATIONDATE          importationDate
*ACR_PH_VAT_ISL_ITEM-IMPORTATIONCOUNTRY       country
*ACR_PH_VAT_ISL_ITEM-DUTIABLEVALUE            dutiableValue
*ACR_PH_VAT_ISL_ITEM-CHARGES                  charges
*ACR_PH_VAT_ISL_ITEM-EXEMPTAMOUNT             exempt
*ACR_PH_VAT_ISL_ITEM-TAXABLEGOODS             taxableGoods
*ACR_PH_VAT_ISL_ITEM-VATRATE                  vatRate
*ACR_PH_VAT_ISL_ITEM-VATPAYABLE               vatPayable
*ACR_PH_VAT_ISL_ITEM-ORNUMBER                 ORNumber
*ACR_PH_VAT_ISL_ITEM-PAYMENTDATE              paymentDate
*ACR_PH_VAT_ISL_ITEM-TINOFOWNER               Tax Identification Number
*ACR_PH_VAT_ISL_ITEM-TAXABLEMOUNTH            Taxable Month

*CSV File Details
*ACRS_PH_VAT_ISL_DETAILITEM-PH_INDICATOR          Indicator
*ACRS_PH_VAT_ISL_DETAILITEM-IMPORTENTRY           import_Entry
*ACRS_PH_VAT_ISL_DETAILITEM-ASSESSMENTDATE        assessmentDate
*ACRS_PH_VAT_ISL_DETAILITEM-SUPPLIERNAME          supplier
*ACRS_PH_VAT_ISL_DETAILITEM-IMPORTATIONDATE       importationDate
*ACRS_PH_VAT_ISL_DETAILITEM-IMPORTATIONCOUNTRY    country
*ACRS_PH_VAT_ISL_DETAILITEM-DUTIABLEVALUE         dutiableValue
*ACRS_PH_VAT_ISL_DETAILITEM-CHARGES               charges
*ACRS_PH_VAT_ISL_DETAILITEM-EXEMPTAMOUNT          exempt
*ACRS_PH_VAT_ISL_DETAILITEM-TAXABLEGOODS          taxableGoods
*ACRS_PH_VAT_ISL_DETAILITEM-VATRATE               vatRate
*ACRS_PH_VAT_ISL_DETAILITEM-VATPAYABLE            vatPayable
*ACRS_PH_VAT_ISL_DETAILITEM-ORNUMBER              ORNumber
*ACRS_PH_VAT_ISL_DETAILITEM-PAYMENTDATE           paymentDate
*ACRS_PH_VAT_ISL_DETAILITEM-TINOFOWNER            Tax Identification Number
*ACRS_PH_VAT_ISL_DETAILITEM-TAXABLEMOUNTH         Taxable Month

   IF FILEFORMAT = 'DAT'.
    DATA: lt_datfileitemdetail TYPE ACR_PH_VAT_ISL_ITEM,
          ls_datfileitemdetail LIKE LINE OF lt_datfileitemdetail.

    "Adding values
*    ls_datfileitemdetail-SUPPLIERNAME = 'SUPPLIERNAME'.
*    APPEND ls_datfileitemdetail TO lt_datfileitemdetail.
*    DATFILEITEMDETAIL = lt_datfileitemdetail.

  ENDIF.


  endmethod.
ENDCLASS.
