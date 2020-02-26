import 'package:sushi/model/Store/User.dart';
import 'package:sushi/redux/actions/NewGroupActions/new_group_actions.dart';
import 'package:sushi/redux/store/AppState.dart';
import 'package:sushi/screens/CreateGroup/create_group_page.dart';
import 'package:sushi/utils/field_user.dart';

AppState newGroupReducer(AppState state, dynamic action) {
  switch (action.type) {
    case NewGroupActions.SelectNameAndDesc:
      state.newGroup.nameAndDesc = action.payload as FieldUser;
      return state;
    case NewGroupActions.AddMember:
      state.newGroup.addMember = action.payload as User;
      return state;
    case NewGroupActions.RemoveMember:
      User user = action.payload as User;
      state.newGroup.removeUser(user);
      return state;
    case NewGroupActions.SelectLocal:
      state.newGroup.local = action.payload as String;
      return state;
    case NewGroupActions.SelectPayment:
      state.newGroup.payment = action.payload as PaymentType;
      return state;
  }

  return state;
}
