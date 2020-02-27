import 'package:sushi/api/make_request.dart';
import 'package:sushi/model/Response/ResponseStatus.dart';
import 'package:sushi/model/Store/NewGroup.dart';

class CreateGroupNetwork {
  static Future<ResponseStatus> createGroup(
      NewGroup group, String userId) async {
    try {
      dynamic decodedJson = await MakeRequest.post(
        "group/$userId",
        group.toJson(),
      );
      if (decodedJson['error'])
        return ResponseStatus(
          false,
          decodedJson['message'],
        );

      return ResponseStatus(
        true,
        "Il gruppo è stato creato correttamente. Buon sushi!",
      );
    } catch (e) {
      print(e);
      return ResponseStatus(
        false,
        "Si è verificato un errore nella creazione. Riprova",
      );
    }
  }
}
