import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:redux/redux.dart';
import 'package:sushi/components/avatar.dart';
import 'package:sushi/model/Response/ResponseStatus.dart';
import 'package:sushi/network/HomeRequest/home_request.dart';
import 'package:sushi/redux/store/AppState.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<ResponseStatus> groups;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    groups = getGroups();
  }

  Future<ResponseStatus> getGroups() async {
    String userId;
    await Future.delayed(Duration.zero, () {
      AppState state = StoreProvider.of(context).state;
      userId = state.user.id;
    });
    return HomeRequest.getGroups(userId);
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
      converter: (store) => store,
      builder: (context, store) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).canvasColor,
            elevation: 0,
            title: Text(
              "Home",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  right: ScreenUtil().setWidth(20),
                ),
                child: Avatar(
                  width: ScreenUtil().setWidth(25),
                  onTap: () => print("avatar"),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: FutureBuilder(
              future: Future.delayed(Duration(seconds: 3)),
              builder: (_, AsyncSnapshot snapshot) {
                if (snapshot.connectionState != ConnectionState.done)
                  return Center(
                    child: CircularProgressIndicator(),
                  );

                return SmartRefresher(
                  header: WaterDropMaterialHeader(
                    backgroundColor: Theme.of(context).accentColor,
                  ),
                  controller: _refreshController,
                  onLoading: _onLoading,
                  onRefresh: _onRefresh,
                  enablePullDown: true,
                  child: Column(
                    children: <Widget>[
                      Text("Prova"),
                    ],
                  ),
                );
              },
            ),
          ),
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            heroTag: 'speed-dial-hero-tag',
            shape: CircleBorder(),
            overlayColor: Colors.black,
            overlayOpacity: 0.2,
            curve: Curves.fastOutSlowIn,
            children: [
              SpeedDialChild(
                child: Icon(Icons.add),
                backgroundColor: Colors.green,
                label: 'Crea gruppo',
                labelStyle: TextStyle(
                  fontSize: ScreenUtil().setSp(16.0),
                ),
                onTap: () => print('Crea gruppo'),
              ),
              SpeedDialChild(
                child: Icon(Icons.people),
                backgroundColor: Colors.blue,
                label: 'Partecipa ad un gruppo',
                labelStyle: TextStyle(
                  fontSize: ScreenUtil().setSp(16.0),
                ),
                onTap: () => print('Partecipa ad un gruppo'),
              ),
            ],
          ),
        );
      },
    );
  }
}
