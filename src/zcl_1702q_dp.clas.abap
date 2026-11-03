CLASS zcl_1702q_dp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: BEGIN OF ts_sectgl,
             section TYPE c LENGTH 10,
             gl      TYPE saknr,
           END OF ts_sectgl,
           tt_sectgl TYPE STANDARD TABLE OF ts_sectgl WITH EMPTY KEY,

           tr_bupla  TYPE RANGE OF bupla,

           BEGIN OF ts_pdf_content,
             companycode   TYPE bukrs,
             businessplace TYPE bupla,
             fiscalyear    TYPE gjahr,
             fiscqrtr      TYPE zst_1702q-fiscqrtr,
             p0f1          TYPE zst_1702q-p0f1,
             p0f2          TYPE zst_1702q-p0f2,
             p0f3          TYPE zst_1702q-p0f3,
             p4s4f1        TYPE zst_1702q-p4s4f1,
             p4s4f4        TYPE zst_1702q-p4s4f4,
             p4s4f5        TYPE zst_1702q-p4s4f5,
             p4s2f1        TYPE zst_1702q-p4s2f1,
             p4s2f2        TYPE zst_1702q-p4s2f2,
             p4s2f3        TYPE zst_1702q-p4s2f3,
             p4s2f4        TYPE zst_1702q-p4s2f4,
             p4s2f5        TYPE zst_1702q-p4s2f5,
             p4s2f6        TYPE zst_1702q-p4s2f6,
             p4s2f7        TYPE zst_1702q-p4s2f7,
             p4s2f8        TYPE zst_1702q-p4s2f8,
             p4s2f9        TYPE zst_1702q-p4s2f9,
             p4s3f1        TYPE zst_1702q-p4s3f1,
             p4s3f2        TYPE zst_1702q-p4s3f2,
             p4s3f3        TYPE zst_1702q-p4s3f3,
             p4s3f4        TYPE zst_1702q-p4s3f4,
*             p4s3f6        TYPE zst_1702q-p4s3f6,
             p6s1f16       TYPE zst_1702q-p6s1f16,
           END OF ts_pdf_content,
           tt_pdf_content TYPE STANDARD TABLE OF ts_pdf_content WITH EMPTY KEY,

           BEGIN OF ts_docs,
             companycode                 TYPE bukrs,
             accoundingdocument          TYPE belnr_d,
             fiscalyear                  TYPE gjahr,
             accountingdocumentitem      TYPE i_glaccountlineitem-LedgerGLLineItem,
             businessplace               TYPE bupla,
             companycodecurrency         TYPE waers,
             amountincompanycodecurrency TYPE i_glaccountlineitem-amountincompanycodecurrency,
             fiscalperiod                TYPE i_glaccountlineitem-fiscalperiod,
             fiscqrtr                    TYPE zst_1702q-fiscqrtr,
             section                     TYPE c LENGTH 10,
             gl                          TYPE saknr,
           END OF ts_docs,
           tt_docs TYPE STANDARD TABLE OF ts_docs WITH EMPTY KEY,
           BEGIN OF ts_pdf_split,
             companycode   TYPE bukrs,
             businessplace TYPE bupla,
             fiscalyear    TYPE gjahr,
             fiscqrtr      TYPE zst_1702q-fiscqrtr,
             fname         TYPE string,
           END OF ts_pdf_split,
           tt_pdf_split TYPE STANDARD TABLE OF ts_pdf_split WITH EMPTY KEY.

    CLASS-METHODS get_docs IMPORTING i_companycode   TYPE srft_long_selopt
                                     i_businessplace TYPE srft_long_selopt OPTIONAL
                                     i_postingdate   TYPE srft_long_selopt
                                     i_p1f12         TYPE zde_1702_p1f12 OPTIONAL
                           EXPORTING et_docs         TYPE tt_docs
                                     et_message      TYPE srft_message.

    CLASS-METHODS get_pdf_content IMPORTING i_companycode   TYPE srft_long_selopt OPTIONAL
                                            i_businessplace TYPE srft_long_selopt OPTIONAL
                                            i_postingdate   TYPE srft_long_selopt OPTIONAL
                                            i_fiscalyear    TYPE gjahr OPTIONAL
                                            i_fiscqrtr      TYPE zst_1702q-fiscqrtr OPTIONAL
                                            i_p1f12         TYPE zst_1702q-p1f12 OPTIONAL
                                  EXPORTING et_content      TYPE tt_pdf_content
                                            et_message      TYPE srft_message.

    CLASS-METHODS get_pdf_split IMPORTING i_companycode   TYPE srft_long_selopt OPTIONAL
                                          i_businessplace TYPE srft_long_selopt OPTIONAL
                                          i_postingdate   TYPE srft_long_selopt OPTIONAL
                                          i_p1f12         TYPE zst_1702q-p1f12 OPTIONAL
                                EXPORTING et_pdf_split    TYPE tt_pdf_split
                                          et_message      TYPE srft_message.

    CLASS-METHODS substring
      IMPORTING
        !iv_value          TYPE srf_value
        !iv_start_position TYPE i
        !iv_length         TYPE i
      EXPORTING
        !ev_result         TYPE srf_value
        !et_message        TYPE srft_message .



  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA: mo_app         TYPE REF TO zcl_1702q_dp.
    CLASS-METHODS create
      RETURNING
        VALUE(r_result) TYPE REF TO zcl_1702q_dp.

    METHODS get_fdt_config IMPORTING i_bukrs       TYPE bukrs
                                     i_section     TYPE ts_sectgl-section
                           RETURNING VALUE(result) TYPE tt_sectgl
                           RAISING   cx_fdt_function_process_api.

    DATA: mt_doclines    TYPE zcl_1702q_dp=>tt_docs,
          mt_pdf_content TYPE zcl_1702q_dp=>tt_pdf_content,
          mt_pdf_split   TYPE zcl_1702q_dp=>tt_pdf_split,
          m_getdoc_done  TYPE abap_bool.

    METHODS get_doclines
      IMPORTING i_companycode   TYPE srft_long_selopt OPTIONAL
                i_businessplace TYPE srft_long_selopt OPTIONAL
                i_postingdate   TYPE srft_long_selopt OPTIONAL
                i_p1f12         TYPE zst_1702q-p1f12 OPTIONAL
      RETURNING VALUE(r_result) TYPE zcl_1702q_dp=>tt_docs.

    METHODS get_ctw IMPORTING i_asof        TYPE abap_boolean DEFAULT abap_false
                              i_qrtr        TYPE zst_1702q-fiscqrtr
                              i_fiscyear    TYPE gjahr
                              i_companycode TYPE bukrs
                              i_bupla       TYPE tr_bupla
                    RETURNING VALUE(result) TYPE i_glaccountlineitem-amountincompanycodecurrency.
    METHODS compute_prevtaxin
      IMPORTING
        i_companycode   TYPE bukrs
        i_businessplace TYPE tr_bupla
        i_fiscalyear    TYPE gjahr
        i_fiscalqrtr    TYPE p
        i_p1f12         TYPE zst_1702q-p1f12 OPTIONAL
      EXPORTING
        e_1st_taxinc    TYPE i_glaccountlineitem-amountincompanycodecurrency
        e_2nd_taxinc    TYPE i_glaccountlineitem-amountincompanycodecurrency
        e_3rd_taxinc    TYPE i_glaccountlineitem-amountincompanycodecurrency
        e_1st_grossinc  TYPE i_glaccountlineitem-amountincompanycodecurrency
        e_2nd_grossinc  TYPE i_glaccountlineitem-amountincompanycodecurrency
        e_3rd_grossinc  TYPE i_glaccountlineitem-amountincompanycodecurrency.

ENDCLASS.



CLASS ZCL_1702Q_DP IMPLEMENTATION.


  METHOD get_docs.

    DATA(lo_app) = create( ).

    et_docs = lo_app->get_doclines(
        i_companycode = i_companycode
        i_businessplace = i_businessplace
        i_postingdate = i_postingdate
        i_p1f12 = i_p1f12
    ).

    IF et_docs IS INITIAL.
      et_message = VALUE #(
          (
              msgty = 'E'
              msgid = 'V4'
              msgno = '213'
          )
      ).
    ENDIF.

    lo_app->m_getdoc_done = abap_true.

  ENDMETHOD.


  METHOD create.

    IF mo_app IS INITIAL.
      mo_app = NEW zcl_1702q_dp( ).
    ENDIF.

    RETURN mo_app.

  ENDMETHOD.


  METHOD get_doclines.

    DATA: lt_gllist TYPE tt_sectgl,
          lr_postdt LIKE i_postingdate.

    IF mt_doclines IS INITIAL AND m_getdoc_done = abap_false.

      TRY.
          APPEND LINES OF get_fdt_config(
            i_bukrs =  CONV #( i_companycode[ 1 ]-low )
            i_section = 'P4S4F1'
          ) TO lt_gllist.
          APPEND LINES OF get_fdt_config(
            i_bukrs =  CONV #( i_companycode[ 1 ]-low )
            i_section = 'P4S2F1' ) TO lt_gllist.
          APPEND LINES OF get_fdt_config(
            i_bukrs =  CONV #( i_companycode[ 1 ]-low )
            i_section = 'P4S2F2' ) TO lt_gllist.
          IF i_p1f12 = '1'."applicable to itemized deduction only
            APPEND LINES OF get_fdt_config(
              i_bukrs =  CONV #( i_companycode[ 1 ]-low )
              i_section = 'P4S2F6' ) TO lt_gllist.
          ENDIF.
          APPEND LINES OF get_fdt_config(
            i_bukrs =  CONV #( i_companycode[ 1 ]-low )
            i_section = 'P4S2F4' ) TO lt_gllist.
          APPEND LINES OF get_fdt_config(
            i_bukrs =  CONV #( i_companycode[ 1 ]-low )
            i_section = 'P6S1F16' ) TO lt_gllist.

          IF lt_gllist IS NOT INITIAL.
            DATA(lr_businessplace) = i_businessplace.
            "removed businessplace in selection screen.
            CLEAR: lr_businessplace.

            SELECT FROM I_GLAccountLineItem AS a
            INNER JOIN @lt_gllist AS b ON
              a~glaccount = b~gl
            INNER JOIN i_journalentry AS c ON
                a~companycode = c~companycode AND
                a~accountingdocument = c~accountingdocument AND
                a~fiscalyear = c~fiscalyear
            LEFT OUTER JOIN i_operationalacctgdocitem AS d ON
                d~companycode         = a~companycode AND
                d~accountingdocument  = a~accountingdocument AND
                d~fiscalyear          = a~fiscalyear
            FIELDS a~companycode,
                   a~accountingdocument,
                   a~fiscalyear,
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
            WHERE a~companycode IN @i_companycode AND
                  ( ( d~businessplace IN @lr_businessplace AND d~accountingdocument IS NOT NULL ) OR d~accountingdocument IS NULL )
                  AND
                  a~postingdate IN @i_postingdate AND
                  a~ledger = '0L'
                  "a~postingdate IN @lr_postdt AND
*                  AND c~reversedocument IS INITIAL
            INTO TABLE @mt_doclines.

            SORT mt_doclines BY accoundingdocument accountingdocumentitem.
            DELETE ADJACENT DUPLICATES FROM mt_doclines
              COMPARING accoundingdocument accountingdocumentitem.

          ENDIF.

        CATCH cx_fdt_function_process_api INTO DATA(lx_fdt).
          " intentionally left blank
          IF sy-subrc = 0.
          ENDIF.
      ENDTRY.

    ENDIF.

    RETURN mt_doclines.

  ENDMETHOD.


  METHOD get_pdf_content.

    DATA: lr_gjahr      TYPE RANGE OF gjahr,
          lr_perod      TYPE RANGE OF zst_1702q-fiscqrtr,
          lr_postdt     LIKE i_postingdate,
          lr_bupla      TYPE tr_bupla,
          lv_1st_taxinc TYPE i_glaccountlineitem-amountincompanycodecurrency,
          lv_2nd_taxinc TYPE i_glaccountlineitem-amountincompanycodecurrency,
          lv_3rd_taxinc TYPE i_glaccountlineitem-amountincompanycodecurrency.

    FIELD-SYMBOLS: <lv_out> TYPE zst_1702q-p4s3f1.

    CLEAR et_content.

    DATA(lo_app) = create( ).

    IF i_fiscalyear IS NOT INITIAL.
      lr_gjahr = VALUE #(
          (
              sign = 'I'
              option = 'EQ'
              low = i_fiscalyear
          )
      ).
    ENDIF.

    IF i_fiscqrtr IS NOT INITIAL.
      lr_perod = VALUE #(
          (
              sign = 'I'
              option = 'EQ'
              low = i_fiscqrtr
          )
      ).
    ENDIF.

    IF lo_app->mt_pdf_content IS NOT INITIAL.
      LOOP AT lo_app->mt_pdf_content INTO DATA(ls_content)
          WHERE fiscalyear IN lr_gjahr AND
                fiscqrtr IN lr_perod.
        APPEND ls_content TO et_content.
      ENDLOOP.
      RETURN.
    ENDIF.

    DATA(lt_doclines) = lo_app->get_doclines(
        i_companycode = i_companycode
        i_businessplace = i_businessplace
        i_postingdate = i_postingdate
        i_p1f12 = i_p1f12
    ).

    IF lt_doclines IS INITIAL.
      et_message = VALUE #(
        (
            msgty = 'E'
            msgid = 'V4'
            msgno = '213'
        )
    ).
    ENDIF.

    lr_bupla = VALUE #(
        FOR _doclinesint IN lt_doclines
        (
            sign = 'I'
            option = 'EQ'
            low = _doclinesint-businessplace
        )
    ).
    SORT lr_bupla BY low.
    DELETE ADJACENT DUPLICATES FROM lr_bupla COMPARING low.

    LOOP AT lt_doclines INTO DATA(ls_doclines)
        WHERE fiscalyear IN lr_gjahr AND
              fiscqrtr IN lr_perod
        GROUP BY (
            companycode = ls_doclines-companycode
*            businessplace = ls_doclines-businessplace
            fiscalyear = ls_doclines-fiscalyear
            fiscqrtr = ls_doclines-fiscqrtr
        )
        REFERENCE INTO DATA(lo_doclines).

      APPEND INITIAL LINE TO et_content ASSIGNING FIELD-SYMBOL(<ls_content>).
      <ls_content>-companycode = lo_doclines->companycode.
*      <ls_content>-businessplace = lo_doclines->businessplace.
      <ls_content>-fiscalyear = lo_doclines->fiscalyear.
      <ls_content>-fiscqrtr = lo_doclines->fiscqrtr.
      <ls_content>-p0f1 = '1'.
      <ls_content>-p0f2 = <ls_content>-fiscalyear && '12'.
      <ls_content>-p0f3 = lo_doclines->fiscqrtr.

      LOOP AT GROUP lo_doclines INTO DATA(_doclines).

        ASSIGN COMPONENT _doclines-section OF STRUCTURE <ls_content> TO FIELD-SYMBOL(<lv_field>).
        CHECK sy-subrc = 0.

        <lv_field> += _doclines-amountincompanycodecurrency.

      ENDLOOP.

      <ls_content>-p4s2f3 = abs( <ls_content>-p4s2f1 ) - abs( <ls_content>-p4s2f2 ).
      <ls_content>-p4s2f5 = abs( <ls_content>-p4s2f3 ) + abs( <ls_content>-p4s2f4 ).
      <ls_content>-p4s2f7 = abs( <ls_content>-p4s2f5 ) - abs( <ls_content>-p4s2f6 ).

      lo_app->compute_prevtaxin(
        EXPORTING
          i_companycode = lo_doclines->companycode
          i_businessplace = lr_bupla
          i_fiscalyear = lo_doclines->fiscalyear
          i_fiscalqrtr = ( lo_doclines->fiscqrtr - 1 )
          i_p1f12 = i_p1f12
        IMPORTING
          e_1st_taxinc    = lv_1st_taxinc
          e_2nd_taxinc    = lv_2nd_taxinc
          e_3rd_taxinc    = lv_3rd_taxinc
          e_1st_grossinc  = <ls_content>-p4s3f1
          e_2nd_grossinc  = <ls_content>-p4s3f2
          e_3rd_grossinc  = <ls_content>-p4s3f3
      ).

      CASE lo_doclines->fiscqrtr.
        WHEN 1.
          ASSIGN <ls_content>-p4s3f1 TO <lv_out>.
        WHEN 2.
          ASSIGN <ls_content>-p4s3f2 TO <lv_out>.
        WHEN 3.
          ASSIGN <ls_content>-p4s3f3 TO <lv_out>.
      ENDCASE.

      IF <lv_out> IS ASSIGNED.
*        <lv_out> = <ls_content>-p4s2f7.
*        <lv_out> = <ls_content>-p4s2f5.
        <lv_out>  = <ls_content>-p4s2f3 + abs( <ls_content>-p4s2f4 ).
      ENDIF.

      <ls_content>-p4s3f4 = round( val = <ls_content>-p4s3f1 dec = 0 ) + round( val = <ls_content>-p4s3f2 dec = 0 ) + round( val = <ls_content>-p4s3f3 dec = 0 ).
*      <ls_content>-p4s3f6 = <ls_content>-p4s3f4 * ( 2 / 100 ).

      <ls_content>-p4s2f8 = round( val = lv_1st_taxinc dec = 0 ) + round( val = lv_2nd_taxinc dec = 0 ) + round( val = lv_3rd_taxinc dec = 0 ).

      <ls_content>-p4s2f9 = <ls_content>-p4s2f7 + <ls_content>-p4s2f8.

      <ls_content>-p4s4f4 = lo_app->get_ctw(
                              i_asof        = abap_true
                              i_qrtr        = ( lo_doclines->fiscqrtr - 1 )
                              i_fiscyear    = lo_doclines->fiscalyear
                              i_companycode = lo_doclines->companycode
                              i_bupla       = lr_bupla
                            ).

      <ls_content>-p4s4f5 = lo_app->get_ctw(
                              i_qrtr        = ( lo_doclines->fiscqrtr )
                              i_fiscyear    = lo_doclines->fiscalyear
                              i_companycode = lo_doclines->companycode
                              i_bupla       = lr_bupla
                            ).

      UNASSIGN <lv_out>.

    ENDLOOP.

    lo_app->mt_pdf_content = et_content.

  ENDMETHOD.


  METHOD get_pdf_split.

    DATA(lo_app) = create( ).

    IF lo_app->mt_pdf_split IS NOT INITIAL.
      et_pdf_split = lo_app->mt_pdf_split.
      RETURN.
    ENDIF.

    lo_app->get_pdf_content(
      EXPORTING
        i_companycode = i_companycode
        i_businessplace = i_businessplace
        i_postingdate = i_postingdate
        i_p1f12 = i_p1f12
      IMPORTING
        et_content = DATA(lt_content)
        et_message = et_message
    ).

    IF et_message IS NOT INITIAL.
      RETURN.
    ENDIF.

    et_pdf_split = VALUE #(
        FOR _content IN lt_content
        (
             companycode = _content-companycode
             businessplace = _content-businessplace
             fiscalyear = _content-fiscalyear
             fiscqrtr = _content-fiscqrtr
             fname = |{ _content-businessplace }_{ _content-fiscalyear }{ _content-fiscqrtr }|
        )
    ).

    lo_app->mt_pdf_split = et_pdf_split.

  ENDMETHOD.


  METHOD get_ctw.

    DATA: lr_fiscperiod TYPE RANGE OF i_operationalacctgdocitem-fiscalperiod,
          lr_gllist     TYPE RANGE OF saknr.

    TRY.

        DATA(lt_gllist) = get_fdt_config(
                      i_bukrs =  i_companycode
                      i_section = COND #(
                        WHEN i_asof = abap_true THEN 'P4S4F4'
                        ELSE 'P4S4F5'
                      )
                  ).

        IF lt_gllist IS NOT INITIAL.

          lr_gllist = VALUE #(
              FOR _gllist IN lt_gllist
              (
                  sign = 'I'
                  option = 'EQ'
                  low = _gllist-gl
              )
          ).

          lr_fiscperiod = VALUE #(
              (
                  sign = 'I'
                  option = COND #(
                      WHEN i_asof = abap_true THEN 'LE'
                      ELSE 'BT'
                  )
                  low = COND #(
                      WHEN i_asof = abap_true
                          THEN COND #(
                              WHEN i_qrtr = 1 THEN '003'
                              WHEN i_qrtr = 2 THEN '006'
                              WHEN i_qrtr = 3 THEN '009'
                              WHEN i_qrtr = 4 THEN '012'
                          )
                      ELSE  COND #(
                              WHEN i_qrtr = 1 THEN '001'
                              WHEN i_qrtr = 2 THEN '004'
                              WHEN i_qrtr = 3 THEN '007'
                              WHEN i_qrtr = 4 THEN '010'
                          )
                  )
                  high = COND #(
                      WHEN i_asof = abap_false
                          THEN COND #(
                              WHEN i_qrtr = 1 THEN '003'
                              WHEN i_qrtr = 2 THEN '006'
                              WHEN i_qrtr = 3 THEN '009'
                              WHEN i_qrtr = 4 THEN '012'
                          )
                  )
              )
          ).

          DATA(lr_bupla) = i_bupla.
          CLEAR: lr_bupla. "hidden businessplace in

          SELECT FROM i_glaccountlineitem AS a
          INNER JOIN i_journalentry AS b ON
          a~companycode = b~companycode AND
          a~accountingdocument = b~accountingdocument AND
          a~fiscalyear = b~fiscalyear
          LEFT OUTER JOIN i_operationalacctgdocitem AS d ON
              d~companycode         = a~companycode AND
              d~accountingdocument  = a~accountingdocument AND
              d~fiscalyear          = a~fiscalyear
          FIELDS
            a~accountingdocument,
            a~LedgerGLLineItem,
            a~amountincompanycodecurrency
          WHERE a~companycode = @i_companycode AND
            ( ( d~businessplace IN @lr_bupla AND d~accountingdocument IS NOT NULL ) OR d~accountingdocument IS NULL )
                  AND
                a~fiscalperiod IN @lr_fiscperiod AND
                a~fiscalyear = @i_fiscyear AND
                a~glaccount IN @lr_gllist AND
                a~ledger = '0L'
*                AND b~reversedocument IS INITIAL
           GROUP BY
             a~accountingdocument,
             a~LedgerGLLineItem,
             a~amountincompanycodecurrency
          INTO TABLE @DATA(lt_results).

          result = REDUCE #(
              INIT out TYPE i_glaccountlineitem-amountincompanycodecurrency
              FOR _row IN lt_results
              NEXT out = out + _row-AmountInCompanyCodeCurrency
              ).

        ENDIF.

      CATCH cx_fdt_function_process_api.
        "handle exception
        IF sy-subrc = 0.
        ENDIF.
    ENDTRY.

  ENDMETHOD.


  METHOD compute_prevtaxin.

    TYPES: BEGIN OF lty_prev_quarters,
             fiscqrtr TYPE n LENGTH 3,
             p4s2f1   TYPE i_glaccountlineitem-amountincompanycodecurrency,
             p4s2f2   TYPE i_glaccountlineitem-amountincompanycodecurrency,
             p4s2f4   TYPE i_glaccountlineitem-amountincompanycodecurrency,
             p4s2f6   TYPE i_glaccountlineitem-amountincompanycodecurrency,
           END OF lty_prev_quarters.

    DATA: lt_prev_quarters TYPE STANDARD TABLE OF lty_prev_quarters.

    DATA: lt_gllist         TYPE tt_sectgl,
          lr_perod          TYPE RANGE OF fins_fiscalperiod,
          lv_1st_taxble_inc TYPE i_glaccountlineitem-amountincompanycodecurrency,
          lv_2nd_taxble_inc TYPE i_glaccountlineitem-amountincompanycodecurrency,
          lv_3rd_taxble_inc TYPE i_glaccountlineitem-amountincompanycodecurrency.
    FIELD-SYMBOLS: <lv_out> TYPE i_glaccountlineitem-amountincompanycodecurrency.

    CHECK i_fiscalqrtr > 0.

    TRY.
        APPEND LINES OF get_fdt_config(
          i_bukrs =  i_companycode
          i_section = 'P4S2F1' ) TO lt_gllist.
        APPEND LINES OF get_fdt_config(
          i_bukrs =  i_companycode
          i_section = 'P4S2F2' ) TO lt_gllist.
        APPEND LINES OF get_fdt_config(
          i_bukrs =  i_companycode
          i_section = 'P4S2F4' ) TO lt_gllist.
        IF i_p1f12 = '1'."applicable to itemized deduction only
          APPEND LINES OF get_fdt_config(
            i_bukrs =  i_companycode
            i_section = 'P4S2F6' ) TO lt_gllist.
        ENDIF.
        IF lt_gllist IS NOT INITIAL.

          DATA(lr_businessplace) = i_businessplace.
          CLEAR: lr_businessplace.

          lr_perod = VALUE #( (
              sign = 'I'
              option = 'LE'
              low = COND #(
                  WHEN i_fiscalqrtr = 1 THEN '003'
                  WHEN i_fiscalqrtr = 2 THEN '006'
                  WHEN i_fiscalqrtr = 3 THEN '009'
                  WHEN i_fiscalqrtr = 4 THEN '012'
              ) )
          ).

          SELECT FROM i_glaccountlineitem AS a
          INNER JOIN @lt_gllist AS b ON
            a~glaccount = b~gl
          INNER JOIN i_journalentry AS c ON
              a~companycode = c~companycode AND
              a~accountingdocument = c~accountingdocument AND
              a~fiscalyear = c~fiscalyear
          LEFT OUTER JOIN i_operationalacctgdocitem AS d ON
              d~companycode         = a~companycode AND
              d~accountingdocument  = a~accountingdocument AND
              d~fiscalyear          = a~fiscalyear
          FIELDS
            a~accountingdocument,
            a~LedgerGLLineItem,
            a~amountincompanycodecurrency,
            b~section,
                 CASE
                  WHEN a~fiscalperiod BETWEEN '001' AND '003'
                      THEN 1
                  WHEN a~fiscalperiod BETWEEN '004' AND '006'
                      THEN 2
                  WHEN a~fiscalperiod BETWEEN '007' AND '009'
                      THEN 3
                  WHEN a~fiscalperiod BETWEEN '010' AND '012'
                      THEN 4
                 END AS fiscqrtr
*                 SUM( a~amountincompanycodecurrency ) AS amount
          WHERE a~companycode = @i_companycode AND
*                d~businessplace = @i_businessplace AND
            ( ( d~businessplace IN @lr_businessplace AND d~accountingdocument IS NOT NULL ) OR d~accountingdocument IS NULL )
                  AND
                a~fiscalyear = @i_fiscalyear AND
                a~fiscalperiod IN @lr_perod AND
                a~ledger = '0L'
*                AND c~reversedocument IS INITIAL
          GROUP BY
              a~accountingdocument,
              a~LedgerGLLineItem,
              a~amountincompanycodecurrency,
              b~section,
              a~fiscalperiod
          INTO TABLE @DATA(lt_lines).

          SORT lt_lines BY fiscqrtr.

          LOOP AT lt_lines INTO DATA(ls_line) GROUP BY ( fiscqrtr = ls_line-fiscqrtr )
          REFERENCE INTO DATA(lo_item).
            " get the summation per fiscal quarter

            APPEND REDUCE
              lty_prev_quarters(
                               INIT    _out TYPE lty_prev_quarters
                                 FOR _item IN GROUP lo_item
                               NEXT _out = VALUE
                               #(
                             fiscqrtr = lo_item->fiscqrtr
                             p4s2f1 =  REDUCE #(
                                      INIT _val = CONV i_glaccountlineitem-amountincompanycodecurrency( 0 )
                                         FOR _lines IN lt_lines
                                         WHERE ( fiscqrtr = lo_item->fiscqrtr AND
                                                 section = 'P4S2F1' )
                                         NEXT _val += _lines-amountincompanycodecurrency )

                             p4s2f2 =  REDUCE #(
                                      INIT _val = CONV i_glaccountlineitem-amountincompanycodecurrency( 0 )
                                         FOR _lines IN lt_lines
                                         WHERE ( fiscqrtr = lo_item->fiscqrtr AND
                                                 section = 'P4S2F2' )
                                         NEXT _val += _lines-amountincompanycodecurrency )

                             p4s2f4 =  REDUCE #(
                                      INIT _val = CONV i_glaccountlineitem-amountincompanycodecurrency( 0 )
                                         FOR _lines IN lt_lines
                                         WHERE ( fiscqrtr = lo_item->fiscqrtr AND
                                                 section = 'P4S2F4' )
                                         NEXT _val += _lines-amountincompanycodecurrency )
                             " Itemized deduction
                             p4s2f6 =  REDUCE #(
                                      INIT _val = CONV i_glaccountlineitem-amountincompanycodecurrency( 0 )
                                         FOR _lines IN lt_lines
                                         WHERE ( fiscqrtr = lo_item->fiscqrtr AND
                                                 section = 'P4S2F6' )
                                         NEXT _val += _lines-amountincompanycodecurrency )
                                 )
                               )
            TO lt_prev_quarters ASSIGNING FIELD-SYMBOL(<ls_doc>).
          ENDLOOP.

          LOOP AT lt_prev_quarters INTO DATA(ls_lines).

            IF ls_lines-fiscqrtr <= i_fiscalqrtr.
              CASE ls_lines-fiscqrtr.
                WHEN 1.
                  e_1st_taxinc   = abs( ls_lines-p4s2f1 )
                                 - abs( ls_lines-p4s2f2 )
                                 + abs( ls_lines-p4s2f4 ).
                  DATA(lv_deduction) = COND dmbtr(
                                    WHEN i_p1f12 = '2' "OSD
                                     THEN round( val = abs( e_1st_taxinc ) * 40 / 100 dec = 0 )
                                     ELSE abs( ls_lines-p4s2f6 ) ). " itemized
                  e_1st_taxinc = e_1st_taxinc - lv_deduction.

                  e_1st_grossinc =  abs( ls_lines-p4s2f1 )
                                  - abs( ls_lines-p4s2f2 )
                                  + abs( ls_lines-p4s2f4 ) .
                WHEN 2.
                  e_2nd_taxinc   =  abs( ls_lines-p4s2f1 )
                                  - abs( ls_lines-p4s2f2 )
                                  + abs( ls_lines-p4s2f4 ).

                  lv_deduction = COND dmbtr( WHEN i_p1f12 = '2' "OSD
                                       THEN round( val = abs( e_2nd_taxinc ) * 40 / 100 dec = 0 )
                                       ELSE abs( ls_lines-p4s2f6 ) ). " itemized

                  e_2nd_taxinc = e_2nd_taxinc - lv_deduction.

                  e_2nd_grossinc =  abs( ls_lines-p4s2f1 )
                                  - abs( ls_lines-p4s2f2 )
                                  + abs( ls_lines-p4s2f4 ) .

                WHEN 3.
                  e_3rd_taxinc   = abs( ls_lines-p4s2f1 )
                                 - abs( ls_lines-p4s2f2 )
                                 + abs( ls_lines-p4s2f4 ).
                  lv_deduction = COND dmbtr(
                                WHEN i_p1f12 = '2' "OSD
                                 THEN round( val = abs( e_3rd_taxinc ) * 40 / 100 dec = 0 )
                                ELSE abs( ls_lines-p4s2f6 ) ). " itemized

                  e_3rd_taxinc = e_3rd_taxinc - lv_deduction.


                  e_3rd_grossinc =  abs( ls_lines-p4s2f1 )
                                  - abs( ls_lines-p4s2f2 )
                                  + abs( ls_lines-p4s2f4 ) .
              ENDCASE.

            ENDIF.
          ENDLOOP.


*          LOOP AT lt_lines INTO DATA(ls_lines).
*
*            "p4s2f1 - p4s2f2.
*            IF ls_lines-section = 'P4S2F2' OR
*                "p4s2f3 - p4s2f4.
**               ls_lines-section = 'P4S2F4' OR  "Should be addition and not subtraction
*                ls_lines-section = 'P4S2F1' OR
*                "p4s2f5 - p4s2f6.
*               ls_lines-section = 'P4S2F6'.
*              ls_lines-amountincompanycodecurrency *= -1.
*
*            ENDIF.
*
*            IF ls_lines-fiscqrtr <= i_fiscalqrtr.
*              CASE ls_lines-fiscqrtr.
*                WHEN 1.
*                  ASSIGN e_1st_taxinc TO <lv_out>.
*                WHEN 2.
*                  ASSIGN e_2nd_taxinc TO <lv_out>.
*                WHEN 3.
*                  ASSIGN e_3rd_taxinc TO <lv_out>.
*              ENDCASE.
*
*              IF <lv_out> IS ASSIGNED.
*                <lv_out> += ls_lines-amountincompanycodecurrency.
*              ENDIF.
*            ENDIF.
*
*            IF ls_lines-section <> 'P4S2F6'.
*              "Get gross income P4S3F1, P4S3F2, P4S3F3
*              UNASSIGN:   <lv_out>.
*              CASE ls_lines-fiscqrtr.
*                WHEN 1.
*                  ASSIGN e_1st_grossinc TO <lv_out>.
*                WHEN 2.
*                  ASSIGN e_2nd_grossinc TO <lv_out>.
*                WHEN 3.
*                  ASSIGN e_3rd_grossinc TO <lv_out>.
*              ENDCASE.
*
*              "Exclude deduction to get gross income per quarter
*              IF <lv_out> IS ASSIGNED.
*                <lv_out> += ls_lines-amountincompanycodecurrency.
*              ENDIF.
*            ENDIF.
*
*          ENDLOOP.

        ENDIF.

      CATCH cx_fdt_function_process_api.
        "handle exception
        IF sy-subrc = 0.
        ENDIF.
    ENDTRY.

  ENDMETHOD.


  METHOD substring.
    TRY .

        DATA(lv_length) = strlen( iv_value ).

        IF  " empty, nothing to return
           lv_length IS INITIAL OR
            " starting position is more than string length, doesn't make sense
            " to still process
           iv_start_position > lv_length.
          RETURN.
        ENDIF.

        " compute allowable string length by checking if
        " asked position and length can still fulfill request
        " otherwise set the max offset allowed based on difference
        IF lv_length < ( iv_start_position + iv_length ).
          DATA(lv_maxlength) = lv_length - iv_start_position.
        ELSE.
          lv_maxlength = iv_length.
        ENDIF.

        ev_result = iv_value+iv_start_position(lv_maxlength).
*      Cause: Illegal offset or length specified in off and len.
      CATCH cx_sy_range_out_of_bounds.
        "handle exception
        IF sy-subrc = 0.
        ENDIF.
    ENDTRY.
  ENDMETHOD.


  METHOD get_fdt_config.

    FIELD-SYMBOLS: <lt_table> TYPE ANY TABLE.
    CONSTANTS:lv_function_id TYPE if_fdt_function_process_api=>v_function_id VALUE 'FA163EC4D60C1FD0A8CCEB97DFBAC9BE'.
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
