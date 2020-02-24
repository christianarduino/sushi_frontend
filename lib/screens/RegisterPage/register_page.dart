import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sushi/components/arrow_back.dart';
import 'package:sushi/components/background.dart';
import 'package:sushi/components/custom_button.dart';
import 'package:sushi/components/custom_text_field.dart';
import 'package:sushi/model/TextField/InputField.dart';
import 'package:sushi/utils/column_builder.dart';
import 'package:sushi/utils/input_text_field.dart';

class RegisterPage extends StatelessWidget {
  final InputTextField inputTextField = InputTextField();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Background(),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(20),
                ),
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(25),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(25),
                left: ScreenUtil().setWidth(25),
              ),
              child: ArrowBack(
                color: Theme.of(context).primaryColor,
                size: ScreenUtil().setWidth(30),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Form(
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(50),
                  ),
                  shrinkWrap: true,
                  children: <Widget>[
                    SizedBox(
                      height: ScreenUtil().setHeight(50),
                    ),
                    ColumnBuilder(
                      itemCount: inputTextField.inputs.length,
                      itemBuilder: (_, int i) {
                        InputField input = inputTextField.inputs[i];
                        bool isConfirm = input.label.contains("Conferma");
                        return CustomTextField(
                          label: input.label,
                          textInputAction: isConfirm
                              ? TextInputAction.done
                              : TextInputAction.next,
                          isObscured: input.isObscured,
                          kType: input.kType,
                          padding: isConfirm ? EdgeInsets.zero : null,
                          inputTextField: inputTextField,
                        );
                      },
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(55),
                    ),
                    CustomButton(
                      label: "Registrati",
                      onTap: () {},
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Hai già un account? "),
                        GestureDetector(
                          child: Text(
                            "Accedi",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
