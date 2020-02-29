import 'dart:convert';

import 'package:sushi/model/Store/User.dart';
import 'package:sushi/screens/CreateGroupPage/create_group_page.dart';
import 'package:sushi/utils/enum.dart';
import 'package:sushi/utils/field_user.dart';

class NewGroup {
  String name, description;
  List<User> users = [];
  List<String> userIds = [];
  String localId;
  PaymentType paymentType;

  set nameAndDesc(FieldUser data) {
    name = data.groupName;
    description = data.groupDescription;
  }

  set addMember(User newUser) {
    users = [...users, newUser];
    userIds = [...userIds, newUser.id];
  }

  set local(String id) {
    localId = id;
  }

  set payment(PaymentType type) {
    paymentType = type;
  }

  removeUser(User deleteUser) {
    users =
        users.where((user) => user.username != deleteUser.username).toList();
  }

  bool contains(User searchUser) {
    try {
      this.users.firstWhere((user) => user.username == searchUser.username);
      return true;
    } catch (e) {
      return false;
    }
  }

  String toJson() {
    Map<String, dynamic> body = {
      "name": name,
      "userIds": userIds,
    };
    print("Description: $description");
    if (description != null && description != "")
      body['description'] = description;

    return jsonEncode(body);
  }
}
