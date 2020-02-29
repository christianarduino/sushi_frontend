import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sushi/model/Response/ResponseStatus.dart';
import 'package:sushi/model/Response/SearchGroup.dart';
import 'package:sushi/network/GroupPartecipateNetwork/group_partecipate_network.dart';
import 'package:sushi/redux/store/AppState.dart';
import 'package:sushi/screens/ConfirmGroupPage/confirm_group_page.dart';
import 'package:sushi/utils/functions.dart';

class GroupPartecipatePage extends StatefulWidget {
  @override
  _GroupPartecipatePageState createState() => _GroupPartecipatePageState();
}

class _GroupPartecipatePageState extends State<GroupPartecipatePage> {
  String fieldValue;
  String userId;
  ResponseStatus status;
  Timer _debounce;
  TextEditingController controller = TextEditingController();

  updateList() async {
    print(fieldValue);
    status = await GroupPartecipateNetwork.searchGroup(fieldValue, userId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
      key: UniqueKey(),
      onInit: (store) => userId = store.state.user.id,
      converter: (store) => store,
      builder: (context, store) {
        return Scaffold(
          appBar: AppBar(
              title: TextField(
            controller: controller,
            autofocus: true,
            cursorColor: Theme.of(context).primaryColor,
            decoration: getStyle(context, Style.searchTextField),
            onChanged: (String text) {
              if (_debounce?.isActive ?? false) _debounce.cancel();
              _debounce = Timer(Duration(milliseconds: 600), () async {
                if (text.length > 2) {
                  fieldValue = text;
                  setState(() {
                    status = ResponseStatus(null, "");
                  });
                  await updateList();
                }
              });
            },
          )),
          body: Builder(
            builder: (context) {
              if (status == null) {
                return Center(
                  child: Text(
                    "Assicurati di aver inserito\nalmeno 3 caratteri per cercare un utente",
                    textAlign: TextAlign.center,
                  ),
                );
              }

              if (status.success == null)
                return Center(
                  child: CircularProgressIndicator(),
                );

              if (!status.success)
                return Center(
                  child: Text(status.data as String),
                );

              List<SearchGroup> groups = status.data as List<SearchGroup>;
              if (groups.isEmpty)
                return Center(
                  child: Text("Nessun gruppo trovato"),
                );

              return ListView.builder(
                itemCount: groups.length,
                itemBuilder: (_, int i) {
                  SearchGroup searchGroup = groups[i];
                  return ListTile(
                    leading: Hero(tag: searchGroup.id, child: CircleAvatar()),
                    title: Text(searchGroup.name),
                    subtitle: Text(
                      searchGroup.description,
                      maxLines: 2,
                    ),
                    onTap: () async {
                      bool response = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmGroupPage(
                            searchGroup: searchGroup,
                            userId: userId,
                          ),
                        ),
                      );
                      if (response != null) await updateList();
                    },
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
