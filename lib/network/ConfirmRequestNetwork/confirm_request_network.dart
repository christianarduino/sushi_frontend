import 'package:sushi/api/make_request.dart';
import 'package:sushi/model/Response/ResponseStatus.dart';
import 'package:sushi/model/Store/User.dart';

class ConfirmRequestNetwork {
  static Future<ResponseStatus> getPending(String groupId) async {
    try {
      final decodedJson = await MakeRequest.get("group/pending/$groupId");
      if (decodedJson['error'])
        return ResponseStatus(false, decodedJson['message']);

      List<User> users = decodedJson['users']
          .map<User>((user) => User.fromJson(user))
          .toList();
      return ResponseStatus(true, users);
    } catch (e) {
      print(e);
      return ResponseStatus(false, "Si è verificato un errore. Riprova");
    }
  }
}
