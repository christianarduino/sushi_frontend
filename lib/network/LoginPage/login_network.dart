import 'package:sushi/api/make_request.dart';
import 'package:sushi/model/Request/LoginRequestModel.dart';
import 'package:sushi/model/Response/ResponseStatus.dart';
import 'package:sushi/model/Store/User.dart';
import 'package:sushi/utils/input_text_field.dart';

class LoginNetwork {
  static Future<ResponseStatus> login(InputTextField inputData) async {
    try {
      LoginRequestModel model = LoginRequestModel.fromInput(inputData);
      dynamic decodedJson = await MakeRequest.post("user/login", model.toMap());
      if (decodedJson['error']) {
        return ResponseStatus(false, decodedJson['message']);
      } else {
        User user = User.fromJson(decodedJson['user']);
        return ResponseStatus(true, user);
      }
    } catch (e) {
      return ResponseStatus(false, "Si è verificato un errore. Riprova");
    }
  }
}
