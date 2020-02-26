import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redux/redux.dart';
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
  Future<ResponseStatus> _usersList;
  final _searchQuery = new TextEditingController();
  Timer _debounce;

  @override
  void initState() {
    super.initState();
    _searchQuery.addListener(_onSearchChanged);
    getUserId();
  }

  @override
  void dispose() {
    _debounce.cancel();
    _searchQuery.removeListener(_onSearchChanged);
    _searchQuery.dispose();
    super.dispose();
  }

  getUserId() async {
    await Future.delayed(Duration.zero, () {
      AppState state = StoreProvider.of<AppState>(context).state;
      userId = state.user.id;
    });
  }

  //delay on search
  _onSearchChanged() async {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 600), () {
      if (_searchQuery.text.length > 2) {
        setState(() {
          _usersList = AddMemberNetwork.getUsers(userId, _searchQuery.text);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
          child: TextField(
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
            controller: _searchQuery,
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

          return StoreConnector<AppState, Store<AppState>>(
            converter: (store) => store,
            builder: (context, store) {
              NewGroup newGroup = store.state.newGroup;
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
          );
        },
      ),
    );
  }
}
