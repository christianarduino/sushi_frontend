import 'package:sushi/utils/field_user.dart';

class RegisterRequestModel {
  String name;
  String surname;
  String username;
  String email;
  String password;

  RegisterRequestModel(
      this.name, this.surname, this.username, this.email, this.password);

  RegisterRequestModel.fromInput(FieldUser inputData)
      : name = inputData.name,
        surname = inputData.surname,
        username = inputData.username,
        email = inputData.email,
        password = inputData.password;

  Map<String, String> toMap() {
    return {
      "name": name,
      "surname": surname,
      "username": username,
      "email": email,
      "password": password,
    };
  }
}
