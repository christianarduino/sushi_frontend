import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sushi/model/TextField/InputField.dart';
import 'package:sushi/utils/input_text_field.dart';

class CustomTextField extends StatelessWidget {
  final EdgeInsets padding;
  final InputTextField inputTextField;
  final InputField inputField;

  CustomTextField({
    this.padding,
    this.inputTextField,
    this.inputField,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          EdgeInsets.only(
            bottom: ScreenUtil().setHeight(30),
          ),
      child: TextFormField(
        textCapitalization: inputField.textCapitalization,
        textInputAction: inputField.textInputAction,
        keyboardType: inputField.kType,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).accentColor,
              width: 1.0,
            ),
          ),
          labelText: inputField.label,
        ),
        obscureText: inputField.isObscured,
        onChanged: (String text) {
          inputTextField.setData(text, inputField.label);
        },
        validator: (String text) {
          if (text.isEmpty) return "Campo vuoto";
          return inputTextField.validate(inputField.label, text);
        },
      ),
    );
  }
}
