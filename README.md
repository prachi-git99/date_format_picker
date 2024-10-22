# DATE FORMAT PICKER
This is a module for picking date format and input the date according to the format

Prerequisites
Flutter 3.16.5 • Dart 3.2.3

Steps to run project
Clone the repo
Check for Flutter and Dart version
Connect with emulator
Run command on terminal: 1. Flutter clean 2. Flutter pub get 3. Flutter run

FEATURES:
1. Auto-Format Input:
As the user enters a date in a TextFormField, the format should automatically insert slashes (/) or dashes (-) depending on the selected date format (e.g., dd/mm/yyyy or mm-dd-yyyy).
2. Date Validation:
Day (dd) should not exceed 31 for months with 31 days, and not exceed 30 for months with 30 days.
For February:
In leap years, day can be 29.
In non-leap years, day must be 28 or less.
Month (mm) should not exceed 12.
Year (yyyy) should always have exactly 4 digits and not exceed a reasonable range of values (e.g., the current year + a few).
3. Error Messages:
If the user enters an invalid day or month, clear error messages should appear explaining the issue (e.g., "Day cannot exceed 31" or "Invalid month").
4. Deletion Handling:
When the user deletes characters, both the digit and the separator (/ or -) should be deleted together (i.e., when backspacing, if the cursor is just after a separator, both the separator and the previous digit are removed).
5. Drop-down Validation:
If a drop-down input is used (for selecting a part of the date, like the month or day), and the user enters an invalid value (e.g., "45" for month), it should display an error message.
6. Double Tap Functionality:
The user can double-tap on specific parts of the date (e.g., the day, month, or year) to highlight or allow easy editing of just that part of the date.
7. Full Deletion Behavior:
On deleting the year, the separators should also be removed automatically as necessary. Similarly, the separators should be deleted when backspacing through the date (not left behind).make an application for this in fluitter
