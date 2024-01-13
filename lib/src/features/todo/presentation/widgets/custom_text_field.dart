import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final int? maxLines;
  final String? initText;
  final Function(String value) onChange;

  const CustomTextFormField({
    this.labelText,
    this.hintText,
    this.maxLines,
    this.initText,
    required this.onChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        onChange(value);
      },
      initialValue: initText,
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
