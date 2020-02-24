import 'package:sushi/model/Request/LoginRequestModel.dart';
import 'package:sushi/utils/input_text_field.dart';

class LoginNetwork {
  static login(InputTextField inputData) {
    LoginRequestModel model = LoginRequestModel.fromInput(inputData);
  }
}
