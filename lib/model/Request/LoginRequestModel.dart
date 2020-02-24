import 'package:sushi/utils/input_text_field.dart';

class LoginRequestModel {
  final String username;
  final String password;

  LoginRequestModel(this.username, this.password);

  LoginRequestModel.fromInput(InputTextField inputData)
      : this.username = inputData.username,
        this.password = inputData.password;

  Map<String, String> toMap() {
    return {
      "username": username,
      "password": password,
    };
  }
}
