import 'package:sushi/model/Response/Groups.dart';
import 'package:sushi/model/Store/User.dart';

enum UserActions { SaveUser, SaveUserGroup, ResetData }

class SaveUser {
  UserActions type = UserActions.SaveUser;
  final User payload;

  SaveUser(this.payload);
}

class SaveUserGroup {
  UserActions type = UserActions.SaveUserGroup;
  final Groups payload;

  SaveUserGroup(this.payload);
}

class ResetData {
  UserActions type = UserActions.ResetData;
}
