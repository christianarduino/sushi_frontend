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
    InputField(label: "Inserisci nome"),
    InputField(label: "Inserisci cognome"),
    InputField(label: "Inserisci username"),
    InputField(label: "Inserisci email"),
    InputField(label: "Inserisci password", isObscured: true),
    InputField(label: "Conferma password", isObscured: true),
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
      case "Inserisci nome":
        name = inputValue;
        break;
      case "Inserisci cognome":
        surname = inputValue;
        break;
      case "Inserisci email":
        email = inputValue;
        break;
      case "Conferma password":
        confirmPassword = inputValue;
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
        if (value.contains("@")) {
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
