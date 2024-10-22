import 'package:flutter/material.dart';

class MyDatePickerLogic {
  final List<String> dateFormats = [
    'dd/mm/yyyy',
    'mm/dd/yyyy',
    'dd-mm-yyyy',
    'mm-dd-yyyy',
    'yyyy/mm/dd',
    'yyyy-mm-dd'
  ];

  bool isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  // add separators (/ or -)
  String formatDate(String date, String selectedDateFormat) {
    String separator = selectedDateFormat.contains('/') ? '/' : '-';

    if (selectedDateFormat.startsWith('yyyy')) {
      // For 'yyyy-mm-dd' or 'yyyy/mm/dd' formats
      if (date.length == 4 || date.length == 7) {
        return date + separator;
      }
    } else {
      // For other formats
      if (date.length == 2 || date.length == 5) {
        return date + separator;
      }
    }
    return date;
  }

  // Date validation
  String? validateDate(String date, String selectedDateFormat) {
    try {
      List<String> parts;
      String separator = selectedDateFormat.contains('/') ? '/' : '-';

      if (date.contains(separator)) {
        parts = date.split(separator);
      } else {
        return '';
      }

      int day, month, year;
      if (selectedDateFormat.startsWith('dd')) {
        day = int.parse(parts[0]);
        month = int.parse(parts[1]);
        year = int.parse(parts[2]);
      } else if (selectedDateFormat.startsWith('mm')) {
        month = int.parse(parts[0]);
        day = int.parse(parts[1]);
        year = int.parse(parts[2]);
      } else {
        year = int.parse(parts[0]);
        month = int.parse(parts[1]);
        day = int.parse(parts[2]);
      }

      // Validate year for 4 digits
      if (year.toString().length > 4) {
        return 'Year Format must be YYYY digits';
      }

      // Validate month
      if (month < 1 || month > 12) {
        return 'Month should be between 1 and 12';
      }

      // Validate day
      List<int> daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
      if (isLeapYear(year)) {
        daysInMonth[1] = 29;
      }
      if (day < 1 || day > daysInMonth[month - 1]) {
        return 'Day should be between 1 and ${daysInMonth[month - 1]}';
      }

      return null;
    } catch (e) {
      return '';
    }
  }

  // Backspace handling
  void handleBackspace(TextEditingController dateController, String value,
      String selectedDateFormat) {
    String separator = selectedDateFormat.contains('/') ? '/' : '-';

    if (value.length <= dateController.text.length) {
      if (dateController.text.isNotEmpty &&
          (dateController.text[dateController.text.length - 1] == separator)) {
        // Remove both the separator and the previous character if backspace happens at the separator
        dateController.text =
            dateController.text.substring(0, dateController.text.length - 1);

        dateController.selection = TextSelection.fromPosition(
          TextPosition(offset: dateController.text.length),
        );
      } else {
        dateController.text = value;
        dateController.selection = TextSelection.fromPosition(
          TextPosition(offset: dateController.text.length),
        );
      }
    }

    if (dateController.text.length > 10) {
      dateController.text = dateController.text.substring(0, 10);
      dateController.selection = TextSelection.fromPosition(
        TextPosition(offset: dateController.text.length),
      );
    }
  }
}
