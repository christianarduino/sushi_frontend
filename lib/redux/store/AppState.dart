import 'package:sushi/model/Response/Events.dart';
import 'package:sushi/model/Response/Groups.dart';
import 'package:sushi/model/Store/NewGroup.dart';
import 'package:sushi/model/Store/User.dart';

class AppState {
  User user;

  NewGroup newGroup = NewGroup();

  Event selectedEvent;
  Group selectedGroup;
}
