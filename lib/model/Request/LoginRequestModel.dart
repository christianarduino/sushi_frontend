import 'dart:convert';

import 'package:sushi/utils/field_user.dart';

class LoginRequestModel {
  final String username;
  final String password;

  LoginRequestModel(this.username, this.password);

  LoginRequestModel.fromInput(FieldUser inputData)
      : this.username = inputData.username,
        this.password = inputData.password;

  String toJson() {
    return jsonEncode({
      "username": username,
      "password": password,
    });
  }
}
