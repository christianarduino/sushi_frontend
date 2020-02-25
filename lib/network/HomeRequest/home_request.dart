import 'package:sushi/api/make_request.dart';
import 'package:sushi/model/Response/Groups.dart';
import 'package:sushi/model/Response/ResponseStatus.dart';

class HomeRequest {
  static Future<ResponseStatus> getGroups(String userId) async {
    try {
      dynamic decodedJson = await MakeRequest.get("group/user/$userId");

      if (decodedJson['error'])
        return ResponseStatus(false, decodedJson['message']);

      print(userId);
      Groups groups = Groups.fromJson(decodedJson);
      return ResponseStatus(true, groups);
    } catch (e) {
      return ResponseStatus(false, "Qualcosa è andato storto. Aggiorna");
    }
  }
}
