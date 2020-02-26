import 'package:sushi/model/Response/Groups.dart';
import 'package:sushi/model/Store/User.dart';
import 'package:sushi/redux/actions/UserActions/user_actions.dart';
import 'package:sushi/redux/store/AppState.dart';

AppState userReducer(AppState state, dynamic action) {
  switch (action.type) {
    case UserActions.SaveUser:
      User user = action.payload as User;
      state.user = user;
      return state;
    case UserActions.SaveUserGroup:
      Groups groups = action.payload as Groups;
      state.user.setGroup(groups);
      return state;
    case UserActions.ResetData:
      state = AppState();
      return state;
  }

  return state;
}
