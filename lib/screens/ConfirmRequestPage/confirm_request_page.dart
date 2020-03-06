import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sushi/model/Response/ResponseStatus.dart';
import 'package:sushi/model/Store/SearchUser.dart';
import 'package:sushi/model/Store/User.dart';
import 'package:sushi/network/ConfirmRequestNetwork/confirm_request_network.dart';
import 'package:sushi/redux/actions/NewGroupActions/new_group_actions.dart';
import 'package:sushi/redux/store/AppState.dart';
import 'package:sushi/utils/popup.dart';

class ConfirmRequestPage extends StatefulWidget {
  @override
  _ConfirmRequestPageState createState() => _ConfirmRequestPageState();
}

class _ConfirmRequestPageState extends State<ConfirmRequestPage> {
  Future<ResponseStatus> futurePending;

  void fetchPendingUsers(Store<AppState> store) async {
    String groupId = store.state.selectedGroup.group.id;
    futurePending = ConfirmRequestNetwork.getPending(groupId);
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: StoreConnector<AppState, Store<AppState>>(
        onInit: (store) => fetchPendingUsers(store),
        onDispose: (store) => store.dispatch(ResetMember()),
        converter: (store) => store,
        builder: (sContext, store) {
          final SearchUser searchUser = store.state.searchUser;
          final String groupId = store.state.selectedGroup.group.id;
          final bool isEmpty = searchUser.userIds.isEmpty;
          return Scaffold(
            appBar: AppBar(
              title: Text("Richieste"),
            ),
            floatingActionButton: isEmpty
                ? null
                : Padding(
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: FloatingActionButton.extended(
                      icon: Icon(Icons.save),
                      label: Text("Aggiungi"),
                      onPressed: () async {
                        final progress = ProgressHUD.of(sContext);
                        progress.show();
                        ResponseStatus status =
                            await ConfirmRequestNetwork.addUsers(
                          groupId,
                          searchUser.userIds,
                        );
                        progress.dismiss();

                        if (!status.success)
                          return await Popup.error(sContext, status.data);

                        await Popup.success(sContext, status.data);
                        Navigator.pop(context);
                      },
                    ),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: FutureBuilder(
              future: futurePending,
              builder: (_, AsyncSnapshot<ResponseStatus> snapshot) {
                if (snapshot.connectionState != ConnectionState.done)
                  return Center(child: CircularProgressIndicator());

                ResponseStatus status = snapshot.data;
                if (!status.success) return Center(child: Text(status.data));

                List<User> users = status.data as List<User>;

                if (users.isEmpty)
                  return Center(
                    child: Text(
                      "Nessuna richiesta da accettare",
                    ),
                  );

                return ListView.builder(
                  padding: EdgeInsets.only(bottom: 85),
                  itemCount: users.length,
                  itemBuilder: (_, int i) {
                    User user = users[i];
                    bool isSelected = searchUser.contains(user);
                    print(isSelected);
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
      ),
    );
  }
}
