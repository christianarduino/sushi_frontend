import 'dart:convert';

import 'package:sushi/api/make_request.dart';
import 'package:sushi/model/Response/ResponseStatus.dart';

class GroupDetailNetwork {
  static Future<ResponseStatus> deleteGroup(String groupId) async {
    try {
      dynamic decodedJson = await MakeRequest.delete("group/$groupId");
      print(decodedJson);
      if (decodedJson['error'])
        return ResponseStatus(false, decodedJson['message']);

      return ResponseStatus(true, "Gruppo eliminato con successo!");
    } catch (e) {
      print(e);
      return ResponseStatus(false, "Si è verificato un errore. Riprova");
    }
  }

  static Future<ResponseStatus> addMember(
      List<String> ids, String groupId) async {
    try {
      dynamic decodedJson = await MakeRequest.post(
        "group/user/$groupId",
        jsonEncode({"userIds": ids}),
      );
      print(decodedJson);
      if (decodedJson['error'])
        return ResponseStatus(false, decodedJson['message']);

      return ResponseStatus(true, "Utenti aggiunti con successo!");
    } catch (e) {
      print(e);
      return ResponseStatus(false, "Si è verificato un errore. Riprova");
    }
  }
}
