class ZCL_DATE_FORMAT_CONVERTER definition
  public
  final
  create public .

public section.

  class-methods FORMAT_DATE
    importing
      value(DATE_IN) type C
    exporting
      value(DATE_OUT) type DATUM .
protected section.
PRIVATE SECTION.

  CLASS-METHODS convert_date_bar
    IMPORTING
      VALUE(date_in)  TYPE c
    EXPORTING
      VALUE(date_out) TYPE datum .
  CLASS-METHODS convert_date_dash
    IMPORTING
      VALUE(date_in)  TYPE c
    EXPORTING
      VALUE(date_out) TYPE datum .
  CLASS-METHODS convert_date_dot
    IMPORTING
      VALUE(date_in)  TYPE c
    EXPORTING
      VALUE(date_out) TYPE datum .
ENDCLASS.



CLASS ZCL_DATE_FORMAT_CONVERTER IMPLEMENTATION.


  METHOD convert_date_bar.

    DATA lv_convert_date(10) TYPE c.

    lv_convert_date = date_in.

    " YYYY/MM/DD
    FIND REGEX '^\d{4}[/]\d{1,2}[/]\d{1,2}$' IN lv_convert_date.
    IF sy-subrc IS INITIAL.
      CALL FUNCTION '/SAPDMC/LSM_DATE_CONVERT'
        EXPORTING
          date_in             = lv_convert_date
          date_format_in      = 'DYMD'
          to_output_format    = ' '
          to_internal_format  = 'X'
        IMPORTING
          date_out            = lv_convert_date
        EXCEPTIONS
          illegal_date        = 1
          illegal_date_format = 2
          no_user_date_format = 3
          OTHERS              = 4.

    ELSE.

      " DD/MM/YYYY
      FIND REGEX '^\d{1,2}[/]\d{1,2}[/]\d{4}$' IN lv_convert_date.
      IF sy-subrc IS INITIAL.
        CALL FUNCTION '/SAPDMC/LSM_DATE_CONVERT'
          EXPORTING
            date_in             = lv_convert_date
            date_format_in      = 'DDMY'
            to_output_format    = ' '
            to_internal_format  = 'X'
          IMPORTING
            date_out            = lv_convert_date
          EXCEPTIONS
            illegal_date        = 1
            illegal_date_format = 2
            no_user_date_format = 3
            OTHERS              = 4.
      ENDIF.

    ENDIF.

    IF sy-subrc IS INITIAL.
      date_out = lv_convert_date .
    ENDIF.

  ENDMETHOD.


  METHOD convert_date_dash.

    DATA lv_convert_date(10) TYPE c.

    lv_convert_date = date_in.

    " YYYY-MM-DD
    FIND REGEX '^\d{4}[-]\d{1,2}[-]\d{1,2}$' IN lv_convert_date.
    IF sy-subrc IS INITIAL.
      CALL FUNCTION '/SAPDMC/LSM_DATE_CONVERT'
        EXPORTING
          date_in             = lv_convert_date
          date_format_in      = 'DYMD'
          to_output_format    = ' '
          to_internal_format  = 'X'
        IMPORTING
          date_out            = lv_convert_date
        EXCEPTIONS
          illegal_date        = 1
          illegal_date_format = 2
          no_user_date_format = 3
          OTHERS              = 4.
    ELSE.

      " DD-MM-YYYY
      FIND REGEX '^\d{1,2}[-]\d{1,2}[-]\d{4}$' IN lv_convert_date.
      IF sy-subrc IS INITIAL.
        CALL FUNCTION '/SAPDMC/LSM_DATE_CONVERT'
          EXPORTING
            date_in             = lv_convert_date
            date_format_in      = 'DDMY'
            to_output_format    = ' '
            to_internal_format  = 'X'
          IMPORTING
            date_out            = lv_convert_date
          EXCEPTIONS
            illegal_date        = 1
            illegal_date_format = 2
            no_user_date_format = 3
            OTHERS              = 4.
      ENDIF.

    ENDIF.

    IF sy-subrc IS INITIAL.
      date_out = lv_convert_date .
    ENDIF.

  ENDMETHOD.


  METHOD convert_date_dot.

    DATA: lv_convert_date(10) TYPE c.

    lv_convert_date = date_in.

    " YYYY.MM.DD
    FIND REGEX '^\d{4}[.]\d{1,2}[.]\d{1,2}$' IN lv_convert_date.
    IF sy-subrc IS INITIAL.
      CALL FUNCTION '/SAPDMC/LSM_DATE_CONVERT'
        EXPORTING
          date_in             = lv_convert_date
          date_format_in      = 'DYMD'
          to_output_format    = ' '
          to_internal_format  = 'X'
        IMPORTING
          date_out            = lv_convert_date
        EXCEPTIONS
          illegal_date        = 1
          illegal_date_format = 2
          no_user_date_format = 3
          OTHERS              = 4.
    ELSE.

      " DD.MM.YYYY
      FIND REGEX '^\d{1,2}[.]\d{1,2}[.]\d{4}$' IN lv_convert_date.
      IF sy-subrc IS INITIAL.
        CALL FUNCTION '/SAPDMC/LSM_DATE_CONVERT'
          EXPORTING
            date_in             = lv_convert_date
            date_format_in      = 'DDMY'
            to_output_format    = ' '
            to_internal_format  = 'X'
          IMPORTING
            date_out            = lv_convert_date
          EXCEPTIONS
            illegal_date        = 1
            illegal_date_format = 2
            no_user_date_format = 3
            OTHERS              = 4.
      ENDIF.

    ENDIF.

    IF sy-subrc IS INITIAL.
      date_out = lv_convert_date.
    ENDIF.

  ENDMETHOD.


  METHOD FORMAT_DATE.

    DATA: lv_convert_date(10) TYPE c,
          lv_aux_out          TYPE datum.

    lv_convert_date = date_in.

    SEARCH lv_convert_date FOR '/' AND MARK.
    IF sy-subrc IS INITIAL.
      zcl_date_format_converter=>convert_date_bar(
                                                        EXPORTING
                                                          date_in  = lv_convert_date
                                                        IMPORTING
                                                          date_out = lv_aux_out ).
    ENDIF.

    SEARCH lv_convert_date FOR '-' AND MARK.
    IF sy-subrc IS INITIAL.
      zcl_date_format_converter=>convert_date_dash(
                                                        EXPORTING
                                                          date_in  = lv_convert_date
                                                        IMPORTING
                                                          date_out = lv_aux_out ).
    ENDIF.

    SEARCH lv_convert_date FOR '\.' AND MARK.
    IF sy-subrc IS INITIAL.
      zcl_date_format_converter=>convert_date_dot(
                                                        EXPORTING
                                                          date_in  = lv_convert_date
                                                        IMPORTING
                                                          date_out = lv_aux_out ).
    ENDIF.

    date_out = lv_aux_out.

  ENDMETHOD.
ENDCLASS.
