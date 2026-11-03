CLASS zcl_fiwtph_prepare_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

public section.
  types:
    BEGIN OF ty_vartypes,
        char10 TYPE c LENGTH 10,
        char4  TYPE c LENGTH 4,
        char5  TYPE c LENGTH 5,
    END OF ty_vartypes,

    BEGIN OF ty_ph_prepare_data ,
        filename1604E            TYPE srf_value,
        filename1604F            TYPE srf_value,
        filename0619E            TYPE srf_value,
        filename0619F            TYPE srf_value,
        filename1600VT           TYPE srf_value,
        firstdigits_tin          TYPE stceg,
        last_five_tin            TYPE stceg,
        firstdigits_tin_supplier TYPE stceg,
        last_five_tin_supplier   TYPE stceg,
        filename_1601EQ          TYPE srf_value,
        filename_1601FQ          TYPE srf_value,
        postingperiod_qtr        TYPE c LENGTH 8,
        sequence_number          TYPE int8,
        result_date              TYPE c LENGTH 8,
      END OF ty_ph_prepare_data .
  types:
    tt_ph_prepare_data TYPE STANDARD TABLE OF ty_ph_prepare_data  WITH NON-UNIQUE DEFAULT KEY .

  class-methods get_file_name_1604e
    importing
      !IV_TIN_NUMBER type STCEG
      !IV_PERIOD type ty_vartypes-char10
    exporting
      !ET_MESSAGES type SRFT_MESSAGE
      !EV_ENTITY type TY_PH_PREPARE_DATA .

   class-methods get_file_name_1604f
    importing
      !IV_TIN_NUMBER type STCEG
      !IV_PERIOD type ty_vartypes-char10
    exporting
      !ET_MESSAGES type SRFT_MESSAGE
      !EV_ENTITY type TY_PH_PREPARE_DATA .

   CLASS-METHODS modify_wt_taxcode
      IMPORTING
      !iv_taxcode TYPE ty_vartypes-char4
      EXPORTING
      !ET_MESSAGES type SRFT_MESSAGE
      !ev_taxcode TYPE ty_vartypes-char5.

   class-methods get_file_name_1600vt
    importing
      !IV_TIN_NUMBER type STCEG
      !IV_PERIOD type ty_vartypes-char10
    exporting
      !ET_MESSAGES type SRFT_MESSAGE
      !EV_ENTITY type TY_PH_PREPARE_DATA .


protected section.
private section.
ENDCLASS.



CLASS ZCL_FIWTPH_PREPARE_DATA IMPLEMENTATION.


  METHOD get_file_name_1604e.
    DATA: lv_value      TYPE stceg.
    CLEAR ev_entity.
    CLEAR et_messages.
    IF iv_tin_number IS NOT INITIAL.
      lv_value = iv_tin_number.
      REPLACE ALL OCCURRENCES OF '-' IN lv_value WITH ' '.
      CONDENSE lv_value NO-GAPS .
    ENDIF.

    DATA(lv_year) = iv_period+0(4).
    DATA(lv_month) = iv_period+4(2).
    CONCATENATE lv_value lv_month lv_year '1604E.DAT' INTO ev_entity-filename1604E.
  ENDMETHOD.


  METHOD get_file_name_1604f.
    DATA: lv_value      TYPE stceg.
    CLEAR ev_entity.
    CLEAR et_messages.
    IF iv_tin_number IS NOT INITIAL.
      lv_value = iv_tin_number.
      REPLACE ALL OCCURRENCES OF '-' IN lv_value WITH ' '.
      CONDENSE lv_value NO-GAPS .
    ENDIF.

    DATA(lv_year) = iv_period+0(4).
    DATA(lv_month) = iv_period+4(2).
    CONCATENATE lv_value lv_month lv_year '1604F.DAT' INTO ev_entity-filename1604F.
  ENDMETHOD.


  METHOD modify_wt_taxcode.
    ev_taxcode = |W{ iv_taxcode }|.
  ENDMETHOD.


  METHOD get_file_name_1600vt.
    DATA: lv_value      TYPE stceg.
    CLEAR ev_entity.
    CLEAR et_messages.
    IF iv_tin_number IS NOT INITIAL.
      lv_value = iv_tin_number.
      REPLACE ALL OCCURRENCES OF '-' IN lv_value WITH ' '.
      CONDENSE lv_value NO-GAPS .
    ENDIF.

    DATA(lv_year) = iv_period+0(4).
    DATA(lv_month) = iv_period+4(2).
    CONCATENATE lv_value lv_month lv_year '1600VT.DAT' INTO ev_entity-filename1600vt.
  ENDMETHOD.
ENDCLASS.
