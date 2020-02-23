import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sushi/components/background.dart';
import 'package:sushi/components/custom_button.dart';
import 'package:sushi/components/custom_outline_button.dart';
import 'package:sushi/components/custom_text_field.dart';
import 'package:sushi/model/TextField/InputField.dart';
import 'package:sushi/screens/RegisterPage/register_page.dart';
import 'package:sushi/utils/column_builder.dart';
import 'package:sushi/utils/input_text_field.dart';

class LoginPage extends StatelessWidget {
  final InputTextField inputTextField = InputTextField();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Background(),
          Align(
            alignment: Alignment.center,
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(50),
              ),
              shrinkWrap: true,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: 'Il ',
                    style: Theme.of(context).textTheme.body1.copyWith(
                          fontSize: ScreenUtil().setSp(40),
                        ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "sushi ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(text: "aspetta\nsoltanto "),
                      TextSpan(
                        text: 'te 🍣',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(60),
                ),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ColumnBuilder(
                        itemCount: 2,
                        itemBuilder: (_, int i) {
                          InputField input = inputTextField.inputs[i];
                          bool isUsername = input.label.contains("username");
                          bool isPassword = input.label.contains("password");
                          if (isUsername || isPassword) {
                            return CustomTextField(
                              label: input.label,
                              textInputAction: isPassword
                                  ? TextInputAction.done
                                  : TextInputAction.next,
                              isObscured: input.isObscured,
                              kType: input.kType,
                              padding: isPassword ? EdgeInsets.zero : null,
                              inputTextField: inputTextField,
                            );
                          }

                          return SizedBox.shrink();
                        },
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(65),
                      ),
                      CustomButton(
                        label: "Accedi",
                        onTap: () {},
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(40),
                ),
                CustomOutlineButton(
                  label: "Registrati",
                  borderColor: Theme.of(context).accentColor,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RegisterPage(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
