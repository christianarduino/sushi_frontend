import 'package:sushi/model/Response/Events.dart';
import 'package:sushi/model/Response/Groups.dart';

import 'User.dart';

class SelectedGroup {
  Group group;
  Event selectedEvent;
  List<User> pendingUser = [];
}
