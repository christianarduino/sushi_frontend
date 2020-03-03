import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redux/redux.dart';
import 'package:sushi/model/Response/ResponseStatus.dart';
import 'package:sushi/model/Store/NewGroup.dart';
import 'package:sushi/model/Store/SearchUser.dart';
import 'package:sushi/model/Store/User.dart';
import 'package:sushi/network/AddMemberNetwork/add_member_network.dart';
import 'package:sushi/redux/actions/NewGroupActions/new_group_actions.dart';
import 'package:sushi/redux/store/AppState.dart';
import 'package:sushi/utils/functions.dart';

class AddMemberPage extends StatefulWidget {
  final bool isFromDetail;
  final String groupId;

  const AddMemberPage({Key key, @required this.isFromDetail, this.groupId})
      : super(key: key);

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
        final String userId = store.state.loggedUser.id;
        final SearchUser searchUser = store.state.searchUser;
        return Scaffold(
          appBar: AppBar(
            title: TextField(
              controller: controller,
              autofocus: true,
              cursorColor: Theme.of(context).primaryColor,
              decoration: getStyle(context, Style.searchTextField),
              onChanged: (String text) {
                if (_debounce?.isActive ?? false) _debounce.cancel();
                _debounce = Timer(
                  Duration(milliseconds: 600),
                  () async {
                    if (text.length > 2) {
                      setState(
                        () {
                          _usersList = widget.isFromDetail
                              ? AddMemberNetwork.searchAddUser(
                                  userId,
                                  text,
                                  widget.groupId,
                                )
                              : AddMemberNetwork.searchUser(userId, text);
                        },
                      );
                    }
                  },
                );
              },
            ),
          ),
          floatingActionButton: Builder(
            builder: (context) {
              if (widget.isFromDetail && searchUser.users.isNotEmpty)
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: ScreenUtil().setWidth(10),
                  ),
                  child: FloatingActionButton.extended(
                    label: Text("Salva"),
                    icon: Icon(Icons.save),
                    onPressed: () => Navigator.pop(context, searchUser.userIds),
                  ),
                );

              return SizedBox.shrink();
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
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
                  bool isSelected = searchUser.contains(user);
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
