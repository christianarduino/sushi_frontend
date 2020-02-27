import 'package:sushi/api/make_request.dart';
import 'package:sushi/model/Request/LoginRequestModel.dart';
import 'package:sushi/model/Response/ResponseStatus.dart';
import 'package:sushi/model/Store/User.dart';
import 'package:sushi/utils/field_user.dart';

class LoginNetwork {
  static Future<ResponseStatus> login(FieldUser inputData) async {
    try {
      LoginRequestModel model = LoginRequestModel.fromInput(inputData);
      dynamic decodedJson =
          await MakeRequest.post("user/login", model.toJson());
      if (decodedJson['error']) {
        return ResponseStatus(false, decodedJson['message']);
      } else {
        User user = User.fromJson(decodedJson['user']);
        return ResponseStatus(true, user);
      }
    } catch (e) {
      print(e);
      return ResponseStatus(false, "Si è verificato un errore. Riprova");
    }
  }
}
