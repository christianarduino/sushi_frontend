import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sushi/redux/store/AppState.dart';

class ConfirmRequestPage extends StatelessWidget {
  void fetchPendingUsers(Store<AppState> store) {}

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>();
  }
}
