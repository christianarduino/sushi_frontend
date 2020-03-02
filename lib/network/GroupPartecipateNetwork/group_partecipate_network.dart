import 'dart:convert';

import 'package:sushi/api/make_request.dart';
import 'package:sushi/model/Response/ResponseStatus.dart';
import 'package:sushi/model/Response/SearchGroup.dart';

class GroupPartecipateNetwork {
  static Future<ResponseStatus> searchGroup(String term, String userId) async {
    try {
      String query = "userId=$userId&term=$term";
      dynamic decodedJson = await MakeRequest.get("group/search?$query");
      if (decodedJson['error'])
        return ResponseStatus(false, decodedJson['message']);

      List<SearchGroup> searchGroups = decodedJson['groups']
          .map<SearchGroup>((group) => SearchGroup.fromJson(group))
          .toList();
      return ResponseStatus(true, searchGroups);
    } catch (e) {
      print(e);
      return ResponseStatus(false, "Qualcosa è andato storto. Riprova");
    }
  }

  static Future<ResponseStatus> sendPending(
    String groupId,
    String userId,
  ) async {
    try {
      String json = jsonEncode({"userId": userId, "groupId": groupId});
      dynamic decodedJson = await MakeRequest.post("group/pending/send", json);

      return ResponseStatus(!decodedJson['error'], decodedJson['message']);
    } catch (e) {
      print(e);
      return ResponseStatus(false, "Qualcosa è andato storto. Riprova");
    }
  }
}
