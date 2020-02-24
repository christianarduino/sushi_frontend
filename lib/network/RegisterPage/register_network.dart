import 'package:sushi/api/make_request.dart';
import 'package:sushi/model/Request/RegisterRequestModel.dart';
import 'package:sushi/model/Response/ResponseStatus.dart';
import 'package:sushi/model/Store/User.dart';
import 'package:sushi/utils/input_text_field.dart';

class RegisterNetwork {
  static Future<ResponseStatus> signUp(InputTextField inputData) async {
    RegisterRequestModel model = RegisterRequestModel.fromInput(inputData);
    dynamic decodedJson =
        await MakeRequest.post("user/register", model.toMap());
    if (decodedJson['error']) {
      return ResponseStatus(false, decodedJson['message']);
    } else {
      User user = User.fromJson(decodedJson['user']);
      return ResponseStatus(true, user);
    }
  }
}
