import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sushi/utils/input_text_field.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isObscured;
  final TextInputAction textInputAction;
  final TextInputType kType;
  final EdgeInsets padding;
  final InputTextField inputTextField;

  CustomTextField({
    this.label,
    this.isObscured,
    this.textInputAction,
    this.kType,
    this.padding,
    this.inputTextField,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          EdgeInsets.only(
            bottom: ScreenUtil().setHeight(30),
          ),
      child: TextFormField(
        textInputAction: textInputAction,
        keyboardType: kType,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).accentColor,
              width: 1.0,
            ),
          ),
          labelText: label,
        ),
        obscureText: isObscured,
        onChanged: (String text) {
          inputTextField.setData(text, label);
          print(inputTextField.username);
        },
      ),
    );
  }
}
