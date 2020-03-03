import 'package:sushi/model/Store/User.dart';

class SearchUser {
  List<User> users = [];
  List<String> userIds = [];

  addMember(User newUser) {
    users = [...users, newUser];
    userIds = [...userIds, newUser.id];
  }

  removeUser(User deleteUser) {
    users =
        users.where((user) => user.username != deleteUser.username).toList();
    userIds = userIds.where((id) => id != deleteUser.id).toList();
  }

  bool contains(User searchUser) {
    try {
      this.users.firstWhere((user) => user.username == searchUser.username);
      return true;
    } catch (e) {
      return false;
    }
  }
}
