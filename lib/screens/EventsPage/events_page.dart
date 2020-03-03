import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sushi/model/Response/Events.dart';
import 'package:sushi/model/Response/Groups.dart';
import 'package:sushi/redux/store/AppState.dart';
import 'package:sushi/screens/GroupDetailPage/group_detail_page.dart';

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
    return StoreConnector<AppState, Group>(
        converter: (store) => store.state.selectedGroup.group,
        builder: (context, group) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                group.name,
              ),
              actions: <Widget>[
                Builder(
                  builder: (context) {
                    if (group.isAdmin)
                      return Padding(
                        padding: EdgeInsets.only(
                          right: ScreenUtil().setWidth(15),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.people_outline,
                          ),
                          iconSize: ScreenUtil().setWidth(30),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => GroupDetailPage(),
                              ),
                            );
                          },
                        ),
                      );

                    return SizedBox.shrink();
                  },
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
                          "Non hai ancora creato\nnessun evento per questo gruppo.\n\n\Premi + per crearne uno!",
                          textAlign: TextAlign.center,
                        ),
                      );

                    return Column();
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
        });
  }
}
