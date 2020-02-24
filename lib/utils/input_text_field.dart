import 'package:flutter/cupertino.dart';
import 'package:sushi/model/TextField/InputField.dart';
import 'package:sushi/utils/functions.dart';

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
    InputField(
      label: "Inserisci nome",
      textCapitalization: TextCapitalization.words,
    ),
    InputField(
      label: "Inserisci cognome",
      textCapitalization: TextCapitalization.words,
    ),
    InputField(label: "Inserisci username"),
    InputField(label: "Inserisci email"),
    InputField(label: "Inserisci password", isObscured: true),
    InputField(label: "Conferma password", isObscured: true),
  ];

  setData(String inputValue, String label) {
    switch (label) {
      case "Inserisci username":
        this.username = inputValue;
        break;
      case "Inserisci password":
        this.password = inputValue;
        break;
      case "Inserisci nome":
        this.name = capitalize(inputValue);
        break;
      case "Inserisci cognome":
        this.surname = capitalize(inputValue);
        break;
      case "Inserisci email":
        this.email = inputValue;
        break;
      case "Conferma password":
        this.confirmPassword = inputValue;
        break;
    }
  }

  validate(String label, String value) {
    switch (label) {
      case "Insersici password":
        if (value != null && value.length <= 3) {
          return "Inserisci più di 4 caratteri";
        }
        break;
      case "Inserisci email":
        if (!value.contains("@")) {
          return "Inserisci un'email valida";
        }
        break;
      case "Conferma password":
        if (label == "Conferma Password" && value != password) {
          return "Le due password non combaciano";
        }
        break;
      default:
        return null;
    }
  }
}
