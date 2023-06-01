// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TextFormFieldComponent extends StatelessWidget {
  final TextEditingController? controller;
  final int? maxLength;
  final String? Function(String?)? validator;
  final String? labelInput;

  const TextFormFieldComponent({
    Key? key,
    this.controller,
    this.maxLength,
    this.validator,
    this.labelInput,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelInput,
        counterText: '',
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }
}
