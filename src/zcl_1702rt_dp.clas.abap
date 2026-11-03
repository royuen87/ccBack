CLASS zcl_1702rt_dp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: BEGIN OF ts_sectgl,
             section TYPE c LENGTH 10,
             gl      TYPE saknr,
           END OF ts_sectgl,
           tt_sectgl TYPE STANDARD TABLE OF ts_sectgl WITH EMPTY KEY,

           BEGIN OF ts_pdf_content,
             bukrs TYPE bukrs,
             bupla TYPE i_operationalacctgdocitem-businessplace,
             gjahr TYPE gjahr,
             p4f27 TYPE i_operationalacctgdocitem-amountincompanycodecurrency,
             p4f30 TYPE i_operationalacctgdocitem-amountincompanycodecurrency,
             p4f32 TYPE i_operationalacctgdocitem-amountincompanycodecurrency,
           END OF ts_pdf_content,
*           tt_pdf_content TYPE STANDARD TABLE OF ts_pdf_content WITH EMPTY KEY,
           tt_pdf_content TYPE STANDARD TABLE OF zst_1702rt WITH EMPTY KEY,

           BEGIN OF ts_docitems,
             companycode                 TYPE bukrs,
             accoundingdocument          TYPE belnr_d,
             fiscalyear                  TYPE gjahr,
*             accountingdocumentitem      TYPE buzei,
             accountingdocumentitem      TYPE I_GLAccountLineItem-LedgerGLLineItem,
             businessplace               TYPE bupla,
             companycodecurrency         TYPE waers,
             amountincompanycodecurrency TYPE i_journalentryitem-amountincompanycodecurrency,
             fiscalperiod                TYPE i_journalentryitem-fiscalperiod,
             fiscqrtr                    TYPE zst_1702q-fiscqrtr,
             section                     TYPE c LENGTH 10,
             gl                          TYPE saknr,
           END OF ts_docitems,
           tt_docitems TYPE STANDARD TABLE OF ts_docitems WITH EMPTY KEY.

    CLASS-METHODS get_docs IMPORTING i_companycode   TYPE srft_long_selopt
                                     i_businessplace TYPE srft_long_selopt OPTIONAL
                                     i_postingdate   TYPE srft_long_selopt
                           EXPORTING et_docs         TYPE tt_docitems
                                     et_message      TYPE srft_message.

    CLASS-METHODS get_pdf_content IMPORTING i_companycode   TYPE srft_long_selopt
                                            i_businessplace TYPE srft_long_selopt
                                            i_postingdate   TYPE srft_long_selopt
                                            i_compname      TYPE zde_text76
                                            i_compaddr      TYPE zde_text76
                                  EXPORTING et_content      TYPE tt_pdf_content
                                            et_message      TYPE srft_message.

  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA: mo_dp TYPE REF TO zcl_1702rt_dp.
    DATA: mt_docs    TYPE tt_docitems,
          mt_content TYPE zcl_1702rt_dp=>tt_pdf_content.
    METHODS get_fdt_config IMPORTING i_bukrs       TYPE bukrs
                                     i_section     TYPE zde_section
                           RETURNING VALUE(result) TYPE tt_sectgl
                           RAISING   cx_fdt_function_process_api.
    METHODS get_doc_items
      IMPORTING
        i_companycode   TYPE srft_long_selopt
        i_businessplace TYPE srft_long_selopt
        i_postingdate   TYPE srft_long_selopt
      EXPORTING
        e_items         TYPE tt_docitems.
    CLASS-METHODS create
      RETURNING
        VALUE(r_result) TYPE REF TO zcl_1702rt_dp.
ENDCLASS.



CLASS ZCL_1702RT_DP IMPLEMENTATION.


  METHOD get_docs.
    DATA(lo_dp) = create( ).

    lo_dp->get_doc_items(
        EXPORTING
            i_companycode   = i_companycode
            i_businessplace = i_businessplace
            i_postingdate   = i_postingdate
        IMPORTING
            e_items         = DATA(lt_items)
    ).

    et_docs = lt_items.

  ENDMETHOD.


  METHOD create.
    IF mo_dp IS INITIAL.
      mo_dp = NEW zcl_1702rt_dp( ).
    ENDIF.
    RETURN mo_dp.
  ENDMETHOD.


  METHOD get_doc_items.

    DATA: lt_gllist TYPE tt_sectgl,
          lv_bukrs  TYPE bukrs.

    IF mt_docs IS INITIAL.
      lv_bukrs = |{ VALUE #( i_companycode[ 1 ]-low OPTIONAL ) }|.

      TRY.

          APPEND LINES OF get_fdt_config( i_bukrs = lv_bukrs i_section = 'P4F44' ) TO lt_gllist.
          APPEND LINES OF get_fdt_config( i_bukrs = lv_bukrs i_section = 'P4F27' ) TO lt_gllist.
          APPEND LINES OF get_fdt_config( i_bukrs = lv_bukrs i_section = 'P4F28' ) TO lt_gllist.
          APPEND LINES OF get_fdt_config( i_bukrs = lv_bukrs i_section = 'P4F30' ) TO lt_gllist.
          APPEND LINES OF get_fdt_config( i_bukrs = lv_bukrs i_section = 'P4F32' ) TO lt_gllist.
          APPEND LINES OF get_fdt_config( i_bukrs = lv_bukrs i_section = 'P4F48' ) TO lt_gllist.
          APPEND LINES OF get_fdt_config( i_bukrs = lv_bukrs i_section = 'P4F49' ) TO lt_gllist.
          APPEND LINES OF get_fdt_config( i_bukrs = lv_bukrs i_section = 'P4S2' ) TO lt_gllist.
          APPEND LINES OF get_fdt_config( i_bukrs = lv_bukrs i_section = 'P6F1F3' ) TO lt_gllist.
          APPEND LINES OF get_fdt_config( i_bukrs = lv_bukrs i_section = 'P6S1F11' ) TO lt_gllist.
          APPEND LINES OF get_fdt_config( i_bukrs = lv_bukrs i_section = 'P6S1F13' ) TO lt_gllist.
          APPEND LINES OF get_fdt_config( i_bukrs = lv_bukrs i_section = 'P6S1F14' ) TO lt_gllist.
          APPEND LINES OF get_fdt_config( i_bukrs = lv_bukrs i_section = 'P6S1F15' ) TO lt_gllist.
          APPEND LINES OF get_fdt_config( i_bukrs = lv_bukrs i_section = 'P6S1F16' ) TO lt_gllist.
          APPEND LINES OF get_fdt_config( i_bukrs = lv_bukrs i_section = 'P6S1F17' ) TO lt_gllist.
          APPEND LINES OF get_fdt_config( i_bukrs = lv_bukrs i_section = 'P6S1F17B' ) TO lt_gllist.
          APPEND LINES OF get_fdt_config( i_bukrs = lv_bukrs i_section = 'P6S1F17D' ) TO lt_gllist.
          APPEND LINES OF get_fdt_config( i_bukrs = lv_bukrs i_section = 'P6S1F17E' ) TO lt_gllist.
          APPEND LINES OF get_fdt_config( i_bukrs = lv_bukrs i_section = 'P6S1F17F' ) TO lt_gllist.
          APPEND LINES OF get_fdt_config( i_bukrs = lv_bukrs i_section = 'P6S1F17G' ) TO lt_gllist.
          APPEND LINES OF get_fdt_config( i_bukrs = lv_bukrs i_section = 'P6S1F17H' ) TO lt_gllist.
          APPEND LINES OF get_fdt_config( i_bukrs = lv_bukrs i_section = 'P6S1F17I' ) TO lt_gllist.
          APPEND LINES OF get_fdt_config( i_bukrs = lv_bukrs i_section = 'P6S1F2' ) TO lt_gllist.
          APPEND LINES OF get_fdt_config( i_bukrs = lv_bukrs i_section = 'P6S1F5' ) TO lt_gllist.
          APPEND LINES OF get_fdt_config( i_bukrs = lv_bukrs i_section = 'P6S1F6' ) TO lt_gllist.
          APPEND LINES OF get_fdt_config( i_bukrs = lv_bukrs i_section = 'P6S1F8' ) TO lt_gllist.
          APPEND LINES OF get_fdt_config( i_bukrs = lv_bukrs i_section = 'P6S1F9' ) TO lt_gllist.
          APPEND LINES OF get_fdt_config( i_bukrs = lv_bukrs i_section = 'P6S2F1' ) TO lt_gllist.


          IF lt_gllist IS NOT INITIAL.
            IF i_businessplace IS NOT INITIAL.
              DATA(lr_businessplace) = i_businessplace.
              lr_businessplace = VALUE #( BASE lr_businessplace
                                ( sign = 'I'
                                  selopt_option = 'EQ'
                                  low = space
                                ) ).
            ENDIF.

            SELECT FROM I_GLAccountLineItem AS a
*            SELECT FROM i_journalentryitem AS a
*           SELECT FROM i_operationalacctgdocitem AS a
            INNER JOIN @lt_gllist AS b ON
              a~glaccount = b~gl
            INNER JOIN i_journalentry AS c ON
                a~companycode = c~companycode AND
                a~accountingdocument = c~accountingdocument AND
                a~fiscalyear = c~fiscalyear
            LEFT OUTER JOIN i_operationalacctgdocitem AS d ON
                a~companycode = d~companycode AND
                a~accountingdocument = d~accountingdocument AND
                a~fiscalyear = d~fiscalyear
            FIELDS
*              a~SourceLedger,
*              a~LedgerGLLineItem,
*              a~Ledger,
*              a~BusinessTransactionCategory,
*              a~BusinessTransactionType,
*              a~FinancialClosingStep,
*              a~ControllingBusTransacType,
                   a~companycode,
                   a~accountingdocument,
                   a~fiscalyear,
*                   a~accountingdocumentitem,
                   a~LedgerGLLineItem,
                   d~businessplace,
                   a~companycodecurrency,
                   a~amountincompanycodecurrency,
                   a~fiscalperiod,
                   CASE
                    WHEN a~fiscalperiod >= '001' AND a~fiscalperiod <= '003' THEN 1
                    WHEN a~fiscalperiod >= '004' AND a~fiscalperiod <= '006' THEN 2
                    WHEN a~fiscalperiod >= '007' AND a~fiscalperiod <= '009' THEN 3
                    WHEN a~fiscalperiod >= '010' AND a~fiscalperiod <= '012' THEN 4
                   END AS fiscqrtr,
                   b~section,
                   b~gl
            WHERE a~Ledger = '0L' AND
                  a~companycode IN @i_companycode AND
                  a~postingdate IN @i_postingdate AND
*                  c~reversedocument IS INITIAL AND
                    ( ( d~businessplace IN @i_businessplace
                    AND d~accountingdocument IS NOT NULL )
                    OR d~accountingdocument IS NULL )
            INTO TABLE @mt_docs.

          ENDIF.
          SORT mt_docs BY companycode
                   accoundingdocument
                   fiscalyear
                   accountingdocumentitem.

          DELETE ADJACENT DUPLICATES FROM mt_docs COMPARING companycode
                   accoundingdocument
                   fiscalyear
                   accountingdocumentitem.




        CATCH cx_fdt_function_process_api INTO DATA(lx_fdt).
          "handle exception
          IF sy-subrc = 0.
          ENDIF.

      ENDTRY.

    ENDIF.

    e_items = mt_docs.

  ENDMETHOD.


  METHOD get_pdf_content.

    DATA(lo_dp) = create( ).
    lo_dp->get_doc_items(
      EXPORTING
        i_companycode   = i_companycode
        i_businessplace = i_businessplace
        i_postingdate   = i_postingdate
      IMPORTING
        e_items = DATA(lt_items)
    ).

    IF lo_dp->mt_content IS INITIAL.
      "Get company name and separate into 3 rows of 38 characters
      IF i_compname IS NOT INITIAL.
        DATA(lv_length) = strlen( i_compname ).
        IF lv_length > 38.
          DATA(lv_name1) = i_compname(38).
          IF lv_length > 76.
            DATA(lv_name2) = i_compname+38(38).
            DATA(lv_rem3) = lv_length - 76.
            IF lv_rem3 > 0.
              DATA(lv_name3) = lv_name2.
              CLEAR: lv_name3.
              lv_name3 = i_compname+76(lv_rem3).
            ENDIF.
          ELSE.
            DATA(lv_rem2) = lv_length - 38.
            lv_name2 = i_compname+38(lv_rem2).
          ENDIF.
        ELSE.
          lv_name1 = i_compname.
        ENDIF.
      ENDIF.

      "Get company address and separate into 3 rows of 38 characters
      CLEAR:  lv_length,
              lv_rem2,
              lv_rem3.

      IF i_compaddr IS NOT INITIAL.
        lv_length = strlen( i_compaddr ).
        IF lv_length > 38.
          DATA(lv_addr1) = i_compaddr(38).
          IF lv_length > 76.
            DATA(lv_addr2) = i_compaddr+38(38).
            lv_rem3 = lv_length - 76.
            IF lv_rem3 > 0.
              DATA(lv_addr3) = lv_addr2.
              CLEAR: lv_addr3.
              lv_addr3 = i_compaddr+76(lv_rem3).
            ENDIF.
          ELSE.
            lv_rem2 = lv_length - 38.
            lv_addr2 = i_compaddr+38(lv_rem2).
          ENDIF.
        ELSE.
          lv_addr1 = i_compaddr.
        ENDIF.
      ENDIF.

      lo_dp->mt_content = VALUE tt_pdf_content(
          FOR GROUPS _items OF _item IN lt_items
          GROUP BY (
                      bukrs = _item-companycode
*                      bupla = _item-businessplace
                      gjahr = _item-fiscalyear
                   )
        (
          companycode   = _items-bukrs
          businessplace = _item-businessplace
          fiscalyear    = _items-gjahr
*
*          p2no44amt = REDUCE #(
*              INIT out TYPE zst_1702rt-p2no44amt
*              FOR _row IN GROUP _items
*              WHERE ( section = 'P4F44' )
*              NEXT out += _row-amountincompanycodecurrency
*          )
*          p2no27amt = REDUCE #(
*              INIT out TYPE zst_1702rt-p2no27amt
*              FOR _row IN GROUP _items
*              WHERE ( section = 'P4F27' )
*              NEXT out += _row-amountincompanycodecurrency
*          )
*          p2no28amt = REDUCE #(
*              INIT out TYPE zst_1702rt-p2no28amt
*              FOR _row IN GROUP _items
*              WHERE ( section = 'P4F28' )
*              NEXT out += _row-amountincompanycodecurrency
*          )
*          p2no30amt = REDUCE #(
*              INIT out TYPE zst_1702rt-p2no30amt
*              FOR _row IN GROUP _items
*              WHERE ( section = 'P4F30' )
*              NEXT out += _row-amountincompanycodecurrency
*          )
*
*          p2no32amt = REDUCE #(
*              INIT out TYPE zst_1702rt-p2no32amt
*              FOR _row IN GROUP _items
*              WHERE ( section = 'P4F32' )
*              NEXT out += _row-amountincompanycodecurrency
*          )
*          p2no48amt = REDUCE #(
*              INIT out TYPE zst_1702rt-p2no48amt
*              FOR _row IN GROUP _items
*              WHERE ( section = 'P4F48' )
*              NEXT out += _row-amountincompanycodecurrency
*          )
*          p2no49amt = REDUCE #(
*              INIT out TYPE zst_1702rt-p2no49amt
*              FOR _row IN GROUP _items
*              WHERE ( section = 'P4F49' )
*              NEXT out += _row-amountincompanycodecurrency
*          )
*          p3sch2no1amt = REDUCE #(
*              INIT out TYPE zst_1702rt-p3sch2no1amt
*              FOR _row IN GROUP _items
*              WHERE ( section = 'P6S2F1' )
*              NEXT out += _row-amountincompanycodecurrency
*          )
*          p3sch1no3amt = REDUCE #(
*              INIT out TYPE zst_1702rt-p3sch1no3amt
*              FOR _row IN GROUP _items
*              WHERE ( section = 'P6S1F3' )
*              NEXT out += _row-amountincompanycodecurrency
*          )
*          p3sch1no11amt = REDUCE #(
*              INIT out TYPE zst_1702rt-p3sch1no11amt
*              FOR _row IN GROUP _items
*              WHERE ( section = 'P6S1F11' )
*              NEXT out += _row-amountincompanycodecurrency
*          )
*          p3sch1no13amt = REDUCE #(
*              INIT out TYPE zst_1702rt-p3sch1no13amt
*              FOR _row IN GROUP _items
*              WHERE ( section = 'P6S1F13' )
*              NEXT out += _row-amountincompanycodecurrency
*          )
*          p3sch1no14amt = REDUCE #(
*              INIT out TYPE zst_1702rt-p3sch1no14amt
*              FOR _row IN GROUP _items
*              WHERE ( section = 'P6S1F14' )
*              NEXT out += _row-amountincompanycodecurrency
*          )
*          p3sch1no15amt = REDUCE #(
*              INIT out TYPE zst_1702rt-p3sch1no15amt
*              FOR _row IN GROUP _items
*              WHERE ( section = 'P6S1F15' )
*              NEXT out += _row-amountincompanycodecurrency
*          )
*          p3sch1no16amt = REDUCE #(
*              INIT out TYPE zst_1702rt-p3sch1no16amt
*              FOR _row IN GROUP _items
*              WHERE ( section = 'P6S1F16' )
*              NEXT out += _row-amountincompanycodecurrency
*          )
*          p3sch1no17a = REDUCE #(
*              INIT out TYPE zst_1702rt-p3sch1no17a
*              FOR _row IN GROUP _items
*              WHERE ( section = 'P6S1F17' )
*              NEXT out += _row-amountincompanycodecurrency
*          )
*          p3sch1no17b = REDUCE #(
*              INIT out TYPE zst_1702rt-p3sch1no17b
*              FOR _row IN GROUP _items
*              WHERE ( section = 'P6S1F17B' )
*              NEXT out += _row-amountincompanycodecurrency
*          )
*          p3sch1no2amt = REDUCE #(
*              INIT out TYPE zst_1702rt-p3sch1no2amt
*              FOR _row IN GROUP _items
*              WHERE ( section = 'P6S1F2' )
*              NEXT out += _row-amountincompanycodecurrency
*          )
*          p3sch1no6amt = REDUCE #(
*              INIT out TYPE zst_1702rt-p3sch1no6amt
*              FOR _row IN GROUP _items
*              WHERE ( section = 'P6S1F6' )
*              NEXT out += _row-amountincompanycodecurrency
*          )
*          p3sch1no8amt = REDUCE #(
*              INIT out TYPE zst_1702rt-p3sch1no8amt
*              FOR _row IN GROUP _items
*              WHERE ( section = 'P6S1F8' )
*              NEXT out += _row-amountincompanycodecurrency
*          )
*          p3sch1no9amt = REDUCE #(
*              INIT out TYPE zst_1702rt-p3sch1no9amt
*              FOR _row IN GROUP _items
*              WHERE ( section = 'P6S1F9' )
*              NEXT out += _row-amountincompanycodecurrency
*          )


          p2no44amt = REDUCE #(
              INIT out TYPE dmbtr
              FOR _row IN GROUP _items
              WHERE ( section = 'P4F44' )
              NEXT out += _row-amountincompanycodecurrency
          )
          p2no27amt = REDUCE #(
              INIT out TYPE dmbtr
              FOR _row IN GROUP _items
              WHERE ( section = 'P4F27' )
              NEXT out += _row-amountincompanycodecurrency
          )
          p2no28amt = REDUCE #(
              INIT out TYPE dmbtr
              FOR _row IN GROUP _items
              WHERE ( section = 'P4F28' )
              NEXT out += _row-amountincompanycodecurrency
          )
          p2no30amt = REDUCE #(
              INIT out TYPE dmbtr
              FOR _row IN GROUP _items
              WHERE ( section = 'P4F30' )
              NEXT out += _row-amountincompanycodecurrency
          )

          p2no32amt = REDUCE #(
              INIT out TYPE dmbtr
              FOR _row IN GROUP _items
              WHERE ( section = 'P4F32' )
              NEXT out += _row-amountincompanycodecurrency
          )
          p2no48amt = REDUCE #(
              INIT out TYPE dmbtr
              FOR _row IN GROUP _items
              WHERE ( section = 'P4F48'
                      AND fiscqrtr <> 4 )
              NEXT out += _row-amountincompanycodecurrency
          )
          p2no49amt = REDUCE #(
              INIT out TYPE dmbtr
              FOR _row IN GROUP _items
              WHERE ( section = 'P4F48'
                  AND fiscqrtr = 4 )
              NEXT out += _row-amountincompanycodecurrency
          )
          p3sch2no1amt = REDUCE #(
              INIT out TYPE dmbtr
              FOR _row IN GROUP _items
              WHERE ( section = 'P6S2F1' )
              NEXT out += _row-amountincompanycodecurrency
          )
          p3sch1no3amt = REDUCE #(
              INIT out TYPE dmbtr
              FOR _row IN GROUP _items
              WHERE ( section = 'P6S1F3' )
              NEXT out += _row-amountincompanycodecurrency
          )
          p3sch1no11amt = REDUCE #(
              INIT out TYPE dmbtr
              FOR _row IN GROUP _items
              WHERE ( section = 'P6S1F11' )
              NEXT out += _row-amountincompanycodecurrency
          )
          p3sch1no13amt = REDUCE #(
              INIT out TYPE dmbtr
              FOR _row IN GROUP _items
              WHERE ( section = 'P6S1F13' )
              NEXT out += _row-amountincompanycodecurrency
          )
          p3sch1no14amt = REDUCE #(
              INIT out TYPE dmbtr
              FOR _row IN GROUP _items
              WHERE ( section = 'P6S1F14' )
              NEXT out += _row-amountincompanycodecurrency
          )
          p3sch1no15amt = REDUCE #(
              INIT out TYPE dmbtr
              FOR _row IN GROUP _items
              WHERE ( section = 'P6S1F15' )
              NEXT out += _row-amountincompanycodecurrency
          )
          p3sch1no16amt = REDUCE #(
              INIT out TYPE dmbtr
              FOR _row IN GROUP _items
              WHERE ( section = 'P6S1F16' )
              NEXT out += _row-amountincompanycodecurrency
          )
          p3sch1no17a = REDUCE #(
              INIT out TYPE  dmbtr
              FOR _row IN GROUP _items
              WHERE ( section = 'P6S1F17' )
              NEXT out += _row-amountincompanycodecurrency
          )
          p3sch1no17b = REDUCE #(
              INIT out TYPE dmbtr
              FOR _row IN GROUP _items
              WHERE ( section = 'P6S1F17B' )
              NEXT out += _row-amountincompanycodecurrency
          )
          p3sch1no2amt = REDUCE #(
              INIT out TYPE dmbtr
              FOR _row IN GROUP _items
              WHERE ( section = 'P6S1F2' )
              NEXT out += _row-amountincompanycodecurrency
          )
          p3sch1no5amt = REDUCE #(
              INIT out TYPE dmbtr
              FOR _row IN GROUP _items
              WHERE ( section = 'P6S1F5' )
              NEXT out += _row-amountincompanycodecurrency
          )
          p3sch1no6amt = REDUCE #(
              INIT out TYPE dmbtr
              FOR _row IN GROUP _items
              WHERE ( section = 'P6S1F6' )
              NEXT out += _row-amountincompanycodecurrency
          )
          p3sch1no8amt = REDUCE #(
              INIT out TYPE dmbtr
              FOR _row IN GROUP _items
              WHERE ( section = 'P6S1F8' )
              NEXT out += _row-amountincompanycodecurrency
          )
          p3sch1no9amt = REDUCE #(
              INIT out TYPE dmbtr
              FOR _row IN GROUP _items
              WHERE ( section = 'P6S1F9' )
              NEXT out += _row-amountincompanycodecurrency
          )

          p1no2yy         = _items-gjahr+2(2)
          p1no8name1      = lv_name1
          p1no8name2      = lv_name2
          p1no8name3      = lv_name3
          p1no9addr1      = lv_addr1
          p1no9addr2      = lv_addr2
          p1no9addr3      = lv_addr3
*          p1no10dateinc   = COND #( WHEN _items-bukrs = 'CNTC' THEN '19970714'
*                              ELSE '20001121' )
          p1no17surchg    = 0
          p1no18intrst    = 0
          p1no19comprms   = 0
          p1no21overpay   = abap_true
          p1no22attchmnts = 4
*          p1no23drawee    = 'BPI'
*          p1no23number    = '123456'
          p1no23date      = '99991231'
          p1no23amt       = 0
*          p1no24drawee    = 'BDO'
*          p1no24number    = '1234567'
          p1no24date      = '99991231'
          p1no24amt       = 0
*          p1no25number    = '7654321'
          p1no25date      = '99991231'
          p1no25amt       = 0
*          p1no26others    = 'Others Particular'
          p1no26date      = '99991231'
          p1no26amt       = 0
          p2no40taxrate   = 20
          p2no45amt       = 0
          p2no46amt       = 0
          p2no47amt       = 0
          p2no50amt       = 0
          p2no51amt       = 0
          p2no52amt       = 0
*          p2no53other     = 'Other text'
          p2no53amt       = 0
*          p2no54other     = 'Other text2'
          p2no54amt       = 0
          p3sch1no1amt    = 0
          p3sch1no4amt    = 0
*          p3sch1no5amt    = 0
          p3sch1no7amt    = 0
          p3sch1no10amt   = 0
          p3sch1no12amt   = 0
          p3sch1no17c     = 0
*          p3sch1no17d     = REDUCE #(
*              INIT out TYPE zst_1702rt-p3sch1no17d
*              FOR _row IN GROUP _items
*              WHERE ( section = 'P6S1F17D' )
*              NEXT out += _row-amountincompanycodecurrency
*          )
*          p3sch1no17e     = REDUCE #(
*              INIT out TYPE zst_1702rt-p3sch1no17e
*              FOR _row IN GROUP _items
*              WHERE ( section = 'P6S1F17E' )
*              NEXT out += _row-amountincompanycodecurrency
*          )
*          p3sch1no17f     = REDUCE #(
*              INIT out TYPE zst_1702rt-p3sch1no17f
*              FOR _row IN GROUP _items
*              WHERE ( section = 'P6S1F17F' )
*              NEXT out += _row-amountincompanycodecurrency
*          )
*          p3sch1no17g     = REDUCE #(
*              INIT out TYPE zst_1702rt-p3sch1no17g
*              FOR _row IN GROUP _items
*              WHERE ( section = 'P6S1F17G' )
*              NEXT out += _row-amountincompanycodecurrency
*          )
*          p3sch1no17h     = REDUCE #(
*              INIT out TYPE zst_1702rt-p3sch1no17h
*              FOR _row IN GROUP _items
*              WHERE ( section = 'P6S1F17H' )
*              NEXT out += _row-amountincompanycodecurrency
*          )
*          p3sch1no17i     = REDUCE #(
*              INIT out TYPE zst_1702rt-p3sch1no17i
*              FOR _row IN GROUP _items
*              WHERE ( section = 'P6S1F17I' )
*              NEXT out += _row-amountincompanycodecurrency
*          )

          p3sch1no17d     = REDUCE #(
              INIT out TYPE dmbtr
              FOR _row IN GROUP _items
              WHERE ( section = 'P6S1F17D' )
              NEXT out += _row-amountincompanycodecurrency
          )
          p3sch1no17e     = REDUCE #(
              INIT out TYPE dmbtr
              FOR _row IN GROUP _items
              WHERE ( section = 'P6S1F17E' )
              NEXT out += _row-amountincompanycodecurrency
          )
          p3sch1no17f     = REDUCE #(
              INIT out TYPE dmbtr
              FOR _row IN GROUP _items
              WHERE ( section = 'P6S1F17F' )
              NEXT out += _row-amountincompanycodecurrency
          )
          p3sch1no17g     = REDUCE #(
              INIT out TYPE dmbtr
              FOR _row IN GROUP _items
              WHERE ( section = 'P6S1F17G' )
              NEXT out += _row-amountincompanycodecurrency
          )
          p3sch1no17h     = REDUCE #(
              INIT out TYPE dmbtr
              FOR _row IN GROUP _items
              WHERE ( section = 'P6S1F17H' )
              NEXT out += _row-amountincompanycodecurrency
          )
          p3sch1no17i     = REDUCE #(
              INIT out TYPE dmbtr
              FOR _row IN GROUP _items
              WHERE ( section = 'P6S1F17I' )
              NEXT out += _row-amountincompanycodecurrency
          )

          p3sch1othno17d  = COND #(
            WHEN _items-bukrs = 'CNTC' THEN 'Administrative & Office'
            ELSE 'Admin & Office'
          )
          p3sch1othno17e  = COND #(
            WHEN _items-bukrs = 'CNTC' THEN 'Employee Welfare'
            ELSE 'Miscellaneous'
          )
          p3sch1othno17f  = COND #(
            WHEN _items-bukrs = 'CNTC' THEN 'Insurance'
            ELSE 'Repairs and Maintenance'
          )
          p3sch1othno17g  = COND #(
*            WHEN _items-bukrs = 'CNTC' THEN 'Miscellaneous'
            WHEN _items-bukrs = 'CNTC' THEN 'Utilities & Subsc'
            ELSE 'Subcontracted Services'
          )
          p3sch1othno17h  = COND #(
            WHEN _items-bukrs = 'CNTC' THEN 'Repairs and Maintenance'
            ELSE 'Utilities & Comm'
          )
          p3sch1othno17i  = COND #(
*            WHEN _items-bukrs = 'CNTC' THEN 'Utilities & Subsc'
            WHEN _items-bukrs = 'CNTC' THEN 'Miscellaneous'
            ELSE ' '
          )
*          p3sch2descno1   = 'Desc 1'
*          p3sch2descno2   = 'Desc 2'
*          p3sch2descno3   = 'Desc 3'
*          p3sch2descno4   = 'Desc 4'
*          p3sch2leglno1   = 'Legal 1'
*          p3sch2leglno2   = 'Legal 2'
*          p3sch2leglno3   = 'Legal 3'
*          p3sch2leglno4   = 'Legal 4'
          p3sch2no2amt    = 0
          p3sch2no3amt    = 0
          p3sch2no4amt    = 0
*          p4sch3ano4year  = '2024'
*          p4sch3ano5year  = '2025'
*          p4sch3ano6year  = '2026'
*          p4sch3ano7year  = '2027'
          p4sch3ano4amta  = 0
          p4sch3ano5amta  = 0
          p4sch3ano6amta  = 0
          p4sch3ano7amta  = 0
          p4sch3ano4amtb  = 0
          p4sch3ano5amtb  = 0
          p4sch3ano6amtb  = 0
          p4sch3ano7amtb  = 0
          p4sch3ano4amtc  = 0
          p4sch3ano5amtc  = 0
          p4sch3ano6amtc  = 0
          p4sch3ano7amtc  = 0
          p4sch3ano4amtd  = 0
          p4sch3ano5amtd  = 0
          p4sch3ano6amtd  = 0
          p4sch3ano7amtd  = 0
*          p4sch4ano1year  = '2021'
*          p4sch4ano2year  = '2022'
*          p4sch4ano3year  = '2023'
          p4sch4ano1amta  = 0
          p4sch4ano2amta  = 0
          p4sch4ano3amta  = 0
          p4sch4ano1amtb  = 0
          p4sch4ano2amtb  = 0
          p4sch4ano3amtb  = 0
          p4sch4ano1amtc  = 0
          p4sch4ano2amtc  = 0
          p4sch4ano3amtc  = 0
          p4sch4ano1amtd  = 0
          p4sch4ano2amtd  = 0
          p4sch4ano3amtd  = 0
          p4sch4ano1amte  = 0
          p4sch4ano2amte  = 0
          p4sch4ano3amte  = 0
          p4sch4ano1amtf  = 0
          p4sch4ano2amtf  = 0
          p4sch4ano3amtf  = 0
          p4sch5no1amt    = 0
          p4sch5no2amt    = 0
          p4sch5no3amt    = 0
          p4sch5no5amt    = 0
          p4sch5no6amt    = 0
          p4sch5no7amt    = 0
          p4sch5no8amt    = 0
*          p4sch5no2desc   = 'Desc 2'
*          p4sch5no3desc   = 'Desc 3'
*          p4sch5no5desc   = 'Desc 5'
*          p4sch5no6desc   = 'Desc 6'
*          p4sch5no7desc   = 'Desc 7'
*          p4sch5no8desc   = 'Desc 8'
        )
      ).
    ENDIF.

    et_content = lo_dp->mt_content.

  ENDMETHOD.


  METHOD get_fdt_config.
    FIELD-SYMBOLS: <lt_table> TYPE ANY TABLE.
    CONSTANTS:lv_function_id TYPE if_fdt_function_process_api=>v_function_id VALUE 'FA163EC4D60C1FD0A8CCF02D5F3429BE'.
    DATA: lt_gls    TYPE STANDARD TABLE OF saknr.

    GET TIME STAMP FIELD DATA(lv_timestamp).
    DATA(lo_fdt) = cl_fdt_function_process_api=>create_instance( ).

    DATA(lt_par) = VALUE if_fdt_function_process_api=>th_parambind_tab(
      (
        name = 'IV_BUKRS'
        value = REF #( i_bukrs )
      )
      (
        name = 'IV_SECTION'
        value = REF #( i_section )
      )
    ).

    ASSIGN lt_gls TO <lt_table>.

    lo_fdt->if_fdt_function_process_api~process( EXPORTING iv_function_id = lv_function_id
                                                  iv_timestamp   = lv_timestamp
                                                   "Default L when the trace is abap_false
                                                  iv_trace_mode  = 'L'
                                                  iv_save_trace  = abap_false
                                        IMPORTING ea_result      = <lt_table>
                                        CHANGING  ct_name_value  = lt_par ).

    LOOP AT <lt_table> ASSIGNING FIELD-SYMBOL(<ls_table>).

      APPEND VALUE #(
          section = i_section
          gl = <ls_table>
      ) TO result.

    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
