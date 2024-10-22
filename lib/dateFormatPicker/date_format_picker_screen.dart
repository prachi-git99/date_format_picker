import 'package:flutter/material.dart';

import 'date_format_picker_logic.dart';

class MyDatePicker extends StatefulWidget {
  @override
  _MyDatePickerState createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  final MyDatePickerLogic _logic = MyDatePickerLogic();

  String _selectedDateFormat = 'dd/mm/yyyy'; // Default format

  final TextEditingController _dateController = TextEditingController();

  String? _errorMessage;

  void _onDateInputChange(String value) {
    // Validate the date while typing
    setState(() {
      _errorMessage = _logic.validateDate(value, _selectedDateFormat);
    });

    // Auto insert separators when reaching the right positions
    if ((_selectedDateFormat.startsWith('yyyy') &&
            (value.length == 4 || value.length == 7)) ||
        (!_selectedDateFormat.startsWith('yyyy') &&
            (value.length == 2 || value.length == 5))) {
      _dateController.text = _logic.formatDate(value, _selectedDateFormat);
      _dateController.selection = TextSelection.fromPosition(
        TextPosition(offset: _dateController.text.length),
      );
    } else {
      _logic.handleBackspace(_dateController, value, _selectedDateFormat);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Select Date Format',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blueAccent, width: 2),
              ),
              child: DropdownButton<String>(
                value: _selectedDateFormat,
                isExpanded: true,
                underline: Container(),
                onChanged: (String? newFormat) {
                  setState(() {
                    _selectedDateFormat = newFormat!;
                    _dateController.clear();
                  });
                },
                items: _logic.dateFormats
                    .map<DropdownMenuItem<String>>((String format) {
                  return DropdownMenuItem<String>(
                    value: format,
                    child: Text(
                      format,
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Enter Date',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: _selectedDateFormat,
                counterText: "",
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.blueAccent, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorText: _errorMessage,
                errorStyle: const TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
              ),
              keyboardType: TextInputType.datetime,
              onChanged: _onDateInputChange,
              maxLength: 10, // Limit input length based on format
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black87,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
