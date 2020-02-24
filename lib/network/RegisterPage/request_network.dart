import 'package:sushi/model/Request/RegisterRequestModel.dart';
import 'package:sushi/utils/input_text_field.dart';

class RequestNetwork {
  static signUp(InputTextField inputData) {
    RegisterRequestModel model = RegisterRequestModel.fromInput(inputData);
  }
}
