# ZCL_DATE_FORMAT_CONVERTER

## Overview
ZCL_DATE_FORMAT_CONVERTER is a versatile SAP ABAP class designed to facilitate the conversion of dates between different formats commonly used in ABAP programming. This class provides methods to convert dates with various separators such as slashes (/), dashes (-), and dots (.). It leverages regular expressions to identify the input date format and performs the necessary conversion to SAP internal date format.

## Features
• Supports conversion of date formats with slashes (/), dashes (-), and dots (.).<br>
• Flexible and robust date processing using regular expressions.<br>
• Integration with SAP's date conversion function (/SAPDMC/LSM_DATE_CONVERT).<br>
• Handles both input and output date formats seamlessly.<br>
• Suitable for integration into ABAP programs requiring date format standardization.

## Usage
1. Import the ZCL_DATE_FORMAT_CONVERTER class into your ABAP program.
2. Call the appropriate method based on the input date format:<br>
  • `CONVERT_DATE_BAR`: Converts dates with slashes (/) to SAP internal format.<br>
  • `CONVERT_DATE_DASH`: Converts dates with dashes (-) to SAP internal format.<br>
  • `CONVERT_DATE_DOT`: Converts dates with dots (.) to SAP internal format.<br>
3. Pass the input date string to the respective conversion method.
4. Retrieve the converted date in SAP internal format from the output parameter.

## Example
```abap
DATA(input_date) = '01-01-2020'.
DATA(output_date) TYPE datum.

output_date = zcl_date_format_converter=>format_date(
                date_in = input_date ).
```

## Compatibility
Tested and compatible with SAP ABAP systems.

## License
This project is licensed under the MIT License - see the LICENSE file for details.
