import 'package:sushi/model/Store/SearchUser.dart';
import 'package:sushi/model/Store/SelectedGroup.dart';
import 'package:sushi/model/Store/User.dart';

class AppState {
  //logged user data
  User loggedUser;

  //helper class to manage users select
  SearchUser searchUser = SearchUser();

  //selected group data
  SelectedGroup selectedGroup = SelectedGroup();
}
