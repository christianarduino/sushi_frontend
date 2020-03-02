import 'package:sushi/model/Response/Groups.dart';

enum SelectedGroupActions {
  SaveGroup,
  RemoveGroup,
}

class SaveSelectedGroup {
  final Group payload;
  final SelectedGroupActions type = SelectedGroupActions.SaveGroup;

  SaveSelectedGroup(this.payload);
}

class RemoveSelectedGroup {
  final SelectedGroupActions type = SelectedGroupActions.RemoveGroup;
}
