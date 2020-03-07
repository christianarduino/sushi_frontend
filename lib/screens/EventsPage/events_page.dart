import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sushi/model/Response/Events.dart';
import 'package:sushi/model/Response/Groups.dart';
import 'package:sushi/model/Response/ResponseStatus.dart';
import 'package:sushi/model/Store/User.dart';
import 'package:sushi/network/GroupDetailNetwork/group_detail_network.dart';
import 'package:sushi/redux/store/AppState.dart';
import 'package:sushi/screens/GroupDetailPage/group_detail_page.dart';
import 'package:sushi/screens/HomePage/home_page.dart';
import 'package:sushi/utils/popup.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  Future<List<Event>> futureEvents = Future(() => <Event>[]);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          Group group = state.selectedGroup.group;
          User loggedUser = state.loggedUser;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                group.name,
              ),
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    right: ScreenUtil().setWidth(15),
                  ),
                  child: Builder(builder: (bContext) {
                    return IconButton(
                      tooltip: "Exit",
                      icon: Icon(
                        group.isAdmin ? Icons.people_outline : Icons.close,
                      ),
                      iconSize: ScreenUtil().setWidth(30),
                      onPressed: () async {
                        if (group.isAdmin) {
                          return Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => GroupDetailPage(),
                            ),
                          );
                        }

                        bool confirm = false;
                        await Popup.confirm(
                          context,
                          "Sicuro di voler abbandonare il gruppo ${group.name}?",
                          onCancel: () => Navigator.pop(context),
                          onOk: () {
                            confirm = true;
                            Navigator.pop(context);
                          },
                        );

                        if (confirm) {
                          final progress = ProgressHUD.of(bContext);
                          progress.show();
                          List<String> ids = [loggedUser.id];
                          ResponseStatus status =
                              await GroupDetailNetwork.removeMembers(
                            ids,
                            group.id,
                          );
                          progress.dismiss();

                          if (!status.success)
                            return await Popup.error(context, status.data);

                          await Popup.success(context, status.data);

                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                              (Route<dynamic> route) => false);
                        }
                      },
                    );
                  }),
                ),
              ],
            ),
            floatingActionButton: Builder(
              builder: (context) {
                if (group.isAdmin)
                  return FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {},
                  );

                return SizedBox.shrink();
              },
            ),
            body: SafeArea(
              child: FutureBuilder(
                future: futureEvents,
                builder: (_, AsyncSnapshot<List<Event>> snapshot) {
                  if (snapshot.connectionState != ConnectionState.done)
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  if (snapshot.hasData) {
                    List<Event> events = snapshot.data;
                    if (events.isEmpty)
                      return Center(
                        child: Text(
                          group.isAdmin
                              ? "Non hai ancora creato\nnessun evento per questo gruppo.\n\n\Premi + per crearne uno!"
                              : "L'amministratore del gruppo\nnon ha ancora creato nessun evento.\n\nIo gli farei una chiamata\nper andare a mangiare del buon sushi!",
                          textAlign: TextAlign.center,
                        ),
                      );
                  }

                  return Center(
                    child: Text(
                      "Si è verificato un errore. Riprova",
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
