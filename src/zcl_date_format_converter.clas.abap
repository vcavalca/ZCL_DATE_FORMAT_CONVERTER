class ZCL_DATE_FORMAT_CONVERTER definition
  public
  final
  create public .

public section.

  class-methods FORMAT_DATE
    importing
      value(DATE_IN) type C         " Input date string
    exporting
      value(DATE_OUT) type DATUM .  " Output date in SAP internal format
protected section.
PRIVATE SECTION.

  CLASS-METHODS convert_date_bar
    IMPORTING
      VALUE(date_in)  TYPE c        " Input date string with slashes (/)
    EXPORTING
      VALUE(date_out) TYPE datum .  " Output date in SAP internal format

  CLASS-METHODS convert_date_dash
    IMPORTING
      VALUE(date_in)  TYPE c        " Input date string with dashes (-)
    EXPORTING
      VALUE(date_out) TYPE datum .  " Output date in SAP internal format

  CLASS-METHODS convert_date_dot
    IMPORTING
      VALUE(date_in)  TYPE c        " Input date string with dots (.)
    EXPORTING
      VALUE(date_out) TYPE datum .  " Output date in SAP internal format
ENDCLASS.



CLASS ZCL_DATE_FORMAT_CONVERTER IMPLEMENTATION.


  METHOD convert_date_bar.

    DATA lv_convert_date(10) TYPE c.

    lv_convert_date = date_in.

    " Check if the input date follows the format YYYY/MM/DD
    FIND REGEX '^\d{4}[/]\d{1,2}[/]\d{1,2}$' IN lv_convert_date.
    IF sy-subrc IS INITIAL.
      " If the input date is in the YYYY/MM/DD format, convert it to the SAP internal format
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

      " Check if the input date follows the format DD/MM/YYYY
      FIND REGEX '^\d{1,2}[/]\d{1,2}[/]\d{4}$' IN lv_convert_date.
      IF sy-subrc IS INITIAL.
        " If the input date is in the DD/MM/YYYY format, convert it to the SAP internal format
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

    " Set the output date to the converted date
    IF sy-subrc IS INITIAL.
      date_out = lv_convert_date .
    ENDIF.

  ENDMETHOD.


  METHOD convert_date_dash.

    DATA lv_convert_date(10) TYPE c.

    lv_convert_date = date_in.

    " Check if the input date follows the format YYYY-MM-DD
    FIND REGEX '^\d{4}[-]\d{1,2}[-]\d{1,2}$' IN lv_convert_date.
    IF sy-subrc IS INITIAL.
      " If the input date is in the YYYY-MM-DD format, convert it to the SAP internal format
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

      " Check if the input date follows the format DD-MM-YYYY
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

    " Set the output date to the converted date
    IF sy-subrc IS INITIAL.
      date_out = lv_convert_date .
    ENDIF.

  ENDMETHOD.


  METHOD convert_date_dot.

    DATA: lv_convert_date(10) TYPE c.

    lv_convert_date = date_in.

    " Check if the input date follows the format YYYY.MM.DD
    FIND REGEX '^\d{4}[.]\d{1,2}[.]\d{1,2}$' IN lv_convert_date.
    IF sy-subrc IS INITIAL.
      " If the input date is in the YYYY.MM.DD format, convert it to the SAP internal format
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

      " Check if the input date follows the format DD.MM.YYYY
      FIND REGEX '^\d{1,2}[.]\d{1,2}[.]\d{4}$' IN lv_convert_date.
      IF sy-subrc IS INITIAL.
        " If the input date is in the DD.MM.YYYY format, convert it to the SAP internal format
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

    " Set the output date to the converted date
    IF sy-subrc IS INITIAL.
      date_out = lv_convert_date.
    ENDIF.

  ENDMETHOD.


  METHOD format_date.

    DATA: lv_convert_date(10) TYPE c,
          lv_aux_out          TYPE datum.

    lv_convert_date = date_in.  " Store the input date in a temporary variable.

    " Search for '/' in the input date string.
    SEARCH lv_convert_date FOR '/' AND MARK.
    IF sy-subrc IS INITIAL.
      " Call the method to convert the date with slashes.
      zcl_date_format_converter=>convert_date_bar(
                                                        EXPORTING
                                                          date_in  = lv_convert_date
                                                        IMPORTING
                                                          date_out = lv_aux_out ).
    ENDIF.

    " Search for '-' in the input date string.
    SEARCH lv_convert_date FOR '-' AND MARK.
    IF sy-subrc IS INITIAL.
      " Call the method to convert the date with dashes.
      zcl_date_format_converter=>convert_date_dash(
                                                        EXPORTING
                                                          date_in  = lv_convert_date
                                                        IMPORTING
                                                          date_out = lv_aux_out ).
    ENDIF.

    " Search for '.' in the input date string.
    SEARCH lv_convert_date FOR '\.' AND MARK.
    IF sy-subrc IS INITIAL.
      " Call the method to convert the date with dots.
      zcl_date_format_converter=>convert_date_dot(
                                                        EXPORTING
                                                          date_in  = lv_convert_date
                                                        IMPORTING
                                                          date_out = lv_aux_out ).
    ENDIF.

    date_out = lv_aux_out.  " Store the converted date in the output variable.

  ENDMETHOD.
ENDCLASS.
