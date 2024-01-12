import 'package:flutter/material.dart';

Future<DateTime?> datePickerDialog(BuildContext context) {
  return showDatePicker(
    context: context,
    firstDate: DateTime.now(),
    initialDate: DateTime.now(),
    lastDate: DateTime(3030),
  );
}

Future<TimeOfDay?> timePickerDialog(BuildContext context) {
  return showTimePicker(context: context, initialTime: TimeOfDay.now());
}
