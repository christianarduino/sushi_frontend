import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sushi/components/custom_app_bar.dart';
import 'package:sushi/components/search_appbar.dart';
import 'package:sushi/model/Response/ResponseStatus.dart';
import 'package:sushi/model/Store/NewGroup.dart';
import 'package:sushi/model/Store/User.dart';
import 'package:sushi/network/AddMemberNetwork/add_member_network.dart';
import 'package:sushi/redux/actions/NewGroupActions/new_group_actions.dart';
import 'package:sushi/redux/store/AppState.dart';

class AddMemberPage extends StatefulWidget {
  @override
  _AddMemberPageState createState() => _AddMemberPageState();
}

class _AddMemberPageState extends State<AddMemberPage> {
  String userId;
  NewGroup group;
  Timer _debounce;
  TextEditingController controller = TextEditingController();
  Future<ResponseStatus> _usersList;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
      converter: (store) => store,
      builder: (context, store) {
        final String userId = store.state.user.id;
        final NewGroup newGroup = store.state.newGroup;
        return Scaffold(
          appBar: CustomAppBar(
              title: TextField(
            controller: controller,
            autofocus: true,
            cursorColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 1.0,
                ),
              ),
            ),
            onChanged: (String text) {
              if (_debounce?.isActive ?? false) _debounce.cancel();
              _debounce = Timer(Duration(milliseconds: 600), () async {
                if (text.length > 2) {
                  setState(() {
                    _usersList = AddMemberNetwork.searchUser(userId, text);
                  });
                }
              });
            },
          )),
          body: FutureBuilder(
            future: _usersList,
            builder: (_, AsyncSnapshot<ResponseStatus> snapshot) {
              if (_usersList == null) {
                return Center(
                  child: Text(
                    "Assicurati di aver inserito\nalmeno  caratteri per cercare un utente",
                    textAlign: TextAlign.center,
                  ),
                );
              }

              if (snapshot.connectionState != ConnectionState.done)
                return Center(
                  child: CircularProgressIndicator(),
                );

              if (!snapshot.data.success)
                return Center(
                  child: Text(snapshot.data.data),
                );

              List<User> users = snapshot.data.data as List<User>;
              if (users.isEmpty)
                return Center(
                  child: Text("Nessun utente trovato"),
                );

              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (_, int i) {
                  User user = users[i];
                  bool isSelected = newGroup.contains(user);
                  return ListTile(
                    leading: isSelected
                        ? CircleAvatar(
                            child: Icon(Icons.check),
                            backgroundColor: Colors.green,
                          )
                        : CircleAvatar(),
                    title: Text(user.name + " " + user.surname),
                    subtitle: Text(user.username),
                    onTap: () {
                      if (isSelected)
                        store.dispatch(RemoveMember(user));
                      else
                        store.dispatch(AddMember(user));
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
