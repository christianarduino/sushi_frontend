import 'package:sushi/model/Response/Groups.dart';
import 'package:sushi/redux/actions/SelectedGroupActions/selected_group_actions.dart';
import 'package:sushi/redux/store/AppState.dart';

AppState selectedGroupReducer(AppState state, dynamic action) {
  switch (action.type) {
    case SelectedGroupActions.RemoveGroup:
      state.selectedGroup = null;
      return state;
    case SelectedGroupActions.SaveGroup:
      state.selectedGroup = action.payload as Group;
      return state;
  }

  return state;
}
