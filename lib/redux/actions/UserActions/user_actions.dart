import 'package:sushi/model/Store/User.dart';

enum UserActions { SaveUser }

class SaveUser {
  UserActions type = UserActions.SaveUser;
  final User payload;

  SaveUser(this.payload);
}
