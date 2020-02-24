import 'package:flutter/cupertino.dart';

class InputField {
  final String label;
  final bool isObscured;
  final TextInputAction textInputAction;
  final TextInputType kType;
  final TextCapitalization textCapitalization;

  InputField({
    this.label,
    this.isObscured = false,
    this.textInputAction = TextInputAction.next,
    this.kType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
  });
}
