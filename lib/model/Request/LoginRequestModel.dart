import 'package:sushi/utils/field_user.dart';

class LoginRequestModel {
  final String username;
  final String password;

  LoginRequestModel(this.username, this.password);

  LoginRequestModel.fromInput(FieldUser inputData)
      : this.username = inputData.username,
        this.password = inputData.password;

  Map<String, String> toMap() {
    return {
      "username": username,
      "password": password,
    };
  }
}
