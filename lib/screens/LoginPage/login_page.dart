import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redux/redux.dart';
import 'package:sushi/components/background.dart';
import 'package:sushi/components/custom_button.dart';
import 'package:sushi/components/custom_outline_button.dart';
import 'package:sushi/components/custom_text_field.dart';
import 'package:sushi/model/Response/ResponseStatus.dart';
import 'package:sushi/model/TextField/InputField.dart';
import 'package:sushi/network/LoginPage/login_network.dart';
import 'package:sushi/redux/actions/UserActions/user_actions.dart';
import 'package:sushi/redux/store/AppState.dart';
import 'package:sushi/screens/HomePage/home_page.dart';
import 'package:sushi/screens/RegisterPage/register_page.dart';
import 'package:sushi/utils/column_builder.dart';
import 'package:sushi/utils/popup.dart';
import 'package:sushi/utils/field_user.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FieldUser inputTextField = FieldUser();

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Scaffold(
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ColumnBuilder(
                        itemCount: inputTextField.inputs.length,
                        itemBuilder: (_, int i) {
                          InputField input = inputTextField.inputs[i];
                          bool isUsername = input.label.contains("username");
                          bool isPassword = input.label == "Inserisci password";
                          if (isUsername || isPassword) {
                            return CustomTextField(
                              inputField: input,
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
                      StoreConnector<AppState, Store<AppState>>(
                        converter: (store) => store,
                        builder: (context, store) {
                          return CustomButton(
                            label: "Accedi",
                            onTap: () async {
                              final progress = ProgressHUD.of(context);
                              progress.show();
                              ResponseStatus status = await LoginNetwork.login(
                                inputTextField,
                              );
                              progress.dismiss();
                              if (!status.success) {
                                return Popup.errorWithMessage(
                                  context,
                                  status.data,
                                );
                              }

                              store.dispatch(SaveUser(status.data));
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => HomePage(),
                                ),
                              );
                            },
                          );
                        },
                      )
                    ],
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
      ),
    );
  }
}
