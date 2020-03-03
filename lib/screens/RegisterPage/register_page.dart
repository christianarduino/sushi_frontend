import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redux/redux.dart';
import 'package:sushi/components/background.dart';
import 'package:sushi/components/custom_button.dart';
import 'package:sushi/components/custom_text_field.dart';
import 'package:sushi/components/separator_height.dart';
import 'package:sushi/model/Response/ResponseStatus.dart';
import 'package:sushi/model/TextField/InputField.dart';
import 'package:sushi/network/RegisterPage/register_network.dart';
import 'package:sushi/redux/actions/UserActions/user_actions.dart';
import 'package:sushi/redux/store/AppState.dart';
import 'package:sushi/screens/HomePage/home_page.dart';
import 'package:sushi/utils/column_builder.dart';
import 'package:sushi/utils/popup.dart';
import 'package:sushi/utils/field_user.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FieldUser inputTextField = FieldUser();

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Sign Up",
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Background(),
              Align(
                alignment: Alignment.center,
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(50),
                    ),
                    shrinkWrap: true,
                    children: <Widget>[
                      ColumnBuilder(
                        itemCount: inputTextField.inputs.length,
                        itemBuilder: (_, int i) {
                          InputField input = inputTextField.inputs[i];
                          if (!input.label.contains("gruppo")) {
                            bool isConfirm = input.label.contains("Conferma");
                            return CustomTextField(
                              inputField: input,
                              padding: isConfirm ? EdgeInsets.zero : null,
                              inputTextField: inputTextField,
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                      SeparatorHeight(55),
                      StoreConnector<AppState, Store<AppState>>(
                          converter: (store) => store,
                          builder: (context, store) {
                            return CustomButton(
                              label: "Registrati",
                              onTap: () async {
                                final progress = ProgressHUD.of(context);
                                progress.show();
                                if (_formKey.currentState.validate()) {
                                  ResponseStatus status =
                                      await RegisterNetwork.signUp(
                                    inputTextField,
                                  );
                                  progress.dismiss();
                                  if (!status.success) {
                                    return Popup.error(
                                      context,
                                      status.data,
                                    );
                                  }

                                  store.dispatch(SaveUser(status.data));
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(),
                                      ),
                                      (Route<dynamic> route) => false);
                                }
                              },
                            );
                          }),
                      SeparatorHeight(10),
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
      ),
    );
  }
}
