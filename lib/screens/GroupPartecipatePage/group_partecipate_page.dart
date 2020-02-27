import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sushi/components/search_appbar.dart';
import 'package:sushi/redux/store/AppState.dart';

class GroupPartecipatePage extends StatefulWidget {
  @override
  _GroupPartecipatePageState createState() => _GroupPartecipatePageState();
}

class _GroupPartecipatePageState extends State<GroupPartecipatePage> {
  @override
  Widget build(BuildContext context) {
    String userId;

    return StatefulBuilder(
      builder: (_, setState) {
        return StoreConnector<AppState, Store<AppState>>(
          onInit: (store) => userId = store.state.user.id,
          converter: (store) => store,
          builder: (_, store) {
            return Scaffold(
              appBar: SearchAppBar(
                onSearch: (String term) {
                  print(term);
                },
              ),
            );
          },
        );
      },
    );
  }
}
