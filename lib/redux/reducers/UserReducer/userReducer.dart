import 'package:sushi/model/Store/User.dart';
import 'package:sushi/redux/actions/UserActions/user_actions.dart';
import 'package:sushi/redux/store/AppState.dart';

AppState userReducer(AppState state, dynamic action) {
  switch (action.type) {
    case UserActions.SaveUser:
      User user = action.payload as User;
      state.user = user;
      return state;
      break;
  }

  return state;
}
