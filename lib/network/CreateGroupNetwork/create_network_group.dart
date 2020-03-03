import 'dart:convert';

import 'package:sushi/api/make_request.dart';
import 'package:sushi/model/Response/ResponseStatus.dart';
import 'package:sushi/utils/field_user.dart';

class CreateGroupNetwork {
  static Future<ResponseStatus> createGroup(
    FieldUser fieldUser,
    List<String> userIds,
    String userId,
  ) async {
    try {
      Map<String, dynamic> newGroup = {
        "name": fieldUser.groupName,
        "userIds": userIds,
      };
      if (fieldUser.groupDescription != null &&
          fieldUser.groupDescription != "")
        newGroup['description'] = fieldUser.groupDescription;

      dynamic decodedJson = await MakeRequest.post(
        "group/$userId",
        jsonEncode(newGroup),
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
