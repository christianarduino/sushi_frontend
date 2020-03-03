import 'package:sushi/api/make_request.dart';
import 'package:sushi/model/Response/ResponseStatus.dart';
import 'package:sushi/model/Store/User.dart';

class AddMemberNetwork {
  static Future<ResponseStatus> searchUser(String userId, String term) async {
    try {
      String query = "userId=$userId&term=$term";
      dynamic decodedJson =
          await MakeRequest.get("group/user/create-search?$query");
      List<dynamic> jsonUsers = decodedJson['users'] as List<dynamic>;
      List<User> users = jsonUsers
          .map<User>(
            (json) => User.fromJson(json),
          )
          .toList();
      return ResponseStatus(true, users);
    } catch (e) {
      print(e);
      return ResponseStatus(false, "Qualcosa è andato storto. Riprova");
    }
  }

  static Future<ResponseStatus> searchAddUser(
      String userId, String term, String groupId) async {
    try {
      String query = "userId=$userId&term=$term&groupId=$groupId";
      dynamic decodedJson =
          await MakeRequest.get("group/user/add-search?$query");
      List<dynamic> jsonUsers = decodedJson['users'] as List<dynamic>;
      List<User> users = jsonUsers
          .map<User>(
            (json) => User.fromJson(json),
          )
          .toList();
      return ResponseStatus(true, users);
    } catch (e) {
      print(e);
      return ResponseStatus(false, "Qualcosa è andato storto. Riprova");
    }
  }
}
