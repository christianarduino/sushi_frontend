import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redux/redux.dart';
import 'package:sushi/components/search_api.dart';
import 'package:sushi/model/Response/ResponseStatus.dart';
import 'package:sushi/model/Store/NewGroup.dart';
import 'package:sushi/model/Store/User.dart';
import 'package:sushi/network/AddMemberNetwork/add_member_network.dart';
import 'package:sushi/redux/actions/NewGroupActions/new_group_actions.dart';
import 'package:sushi/redux/store/AppState.dart';

class AddMemberPage extends StatelessWidget {
  String userId;
  NewGroup newGroup;
  Future<ResponseStatus> _usersList;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return StoreConnector<AppState, Store<AppState>>(
          onInit: (store) {
            userId = store.state.user.id;
            newGroup = store.state.newGroup;
          },
          converter: (store) => store,
          builder: (context, store) {
            NewGroup newGroup = store.state.newGroup;
            return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Theme.of(context).primaryColor,
                ),
                backgroundColor: Theme.of(context).canvasColor,
                elevation: 0,
                title: Padding(
                  padding: EdgeInsets.only(
                    right: ScreenUtil().setWidth(40),
                    bottom: ScreenUtil().setWidth(10),
                  ),
                  child: SearchApi(
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 1.0,
                        ),
                      ),
                    ),
                    onSearch: (String term) async {
                      setState(() {
                        _usersList = AddMemberNetwork.getUsers(userId, term);
                      });
                    },
                  ),
                ),
              ),
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
          });
    });
  }
}
