import 'package:sushi/model/Response/Groups.dart';
import 'package:sushi/model/Store/User.dart';

enum SelectedGroupActions {
  SaveGroup,
  SaveUserPending,
  RemoveUserPending,
  RemoveGroup,
}

class SaveSelectedGroup {
  final Group payload;
  final SelectedGroupActions type = SelectedGroupActions.SaveGroup;

  SaveSelectedGroup(this.payload);
}

class SaveUserPending {
  final User payload;
  final SelectedGroupActions type = SelectedGroupActions.SaveUserPending;

  SaveUserPending(this.payload);
}

class RemoveUserPending {
  final SelectedGroupActions type = SelectedGroupActions.RemoveUserPending;
}

class RemoveSelectedGroup {
  final SelectedGroupActions type = SelectedGroupActions.RemoveGroup;
}
