import 'package:redux/redux.dart';
import 'package:sushi/redux/reducers/NewGroupReducer/new_group_reducer.dart';
import 'package:sushi/redux/reducers/UserReducer/userReducer.dart';

final reducers = combineReducers([
  userReducer,
  newGroupReducer,
]);
