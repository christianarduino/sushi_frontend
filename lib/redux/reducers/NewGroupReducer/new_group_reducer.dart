import 'package:sushi/model/Store/SearchUser.dart';
import 'package:sushi/model/Store/User.dart';
import 'package:sushi/redux/actions/NewGroupActions/new_group_actions.dart';
import 'package:sushi/redux/store/AppState.dart';

AppState newGroupReducer(AppState state, dynamic action) {
  switch (action.type) {
    case NewGroupActions.AddMember:
      state.searchUser.addMember(action.payload as User);
      return state;
    case NewGroupActions.RemoveMember:
      User user = action.payload as User;
      state.searchUser.removeUser(user);
      return state;
    case NewGroupActions.ResetMember:
      state.searchUser.users = <User>[];
      state.searchUser.userIds = <String>[];
      return state;
    case NewGroupActions.RemoveUsers:
      state.searchUser = SearchUser();
      return state;
  }

  return state;
}
