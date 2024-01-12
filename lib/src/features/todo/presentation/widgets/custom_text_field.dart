import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final int? maxLines;
  final Function(String value) onChange;

  const CustomTextField({
    this.labelText,
    this.hintText,
    this.maxLines,
    required this.onChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        onChange(value);
      },
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        filled: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide.none,
        ),
      ),
      maxLines: maxLines,
    );
  }
}
