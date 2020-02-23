import 'package:flutter/material.dart';
import 'package:sushi/model/TextField/InputField.dart';

class InputTextField {
  String name;
  String surname;
  String username;
  String email;
  String password;
  String confirmPassword;

  String groupName;
  String groupDescription;

  List<InputField> inputs = [
    InputField(label: "Inserisci username"),
    InputField(label: "Inserisci password", isObscured: true),
  ];

  setData(String inputValue, String label) {
    switch (label) {
      case "Inserisci username":
        username = inputValue;
        print(username);
        break;
      case "Insersici password":
        password = inputValue;
        break;
    }
  }
}
