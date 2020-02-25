import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:redux/redux.dart';
import 'package:sushi/components/avatar.dart';
import 'package:sushi/model/Response/Groups.dart';
import 'package:sushi/model/Response/ResponseStatus.dart';
import 'package:sushi/network/HomeRequest/home_request.dart';
import 'package:sushi/redux/actions/UserActions/user_actions.dart';
import 'package:sushi/redux/store/AppState.dart';
import 'package:sushi/screens/CreateGroup/create_group_page.dart';
import 'dart:math' as math show pi;

import 'package:sushi/screens/LoginPage/login_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ResponseStatus groupsStatus;
  Groups groups;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  void _onRefresh(Store<AppState> store) async {
    store.dispatch(getGroups);

    if (groupsStatus.success) {
      _refreshController.refreshCompleted();
    } else
      _refreshController.refreshFailed();
  }

  void getGroups(Store<AppState> store) async {
    ResponseStatus status = await HomeRequest.getGroups(store.state.user.id);
    setState(() {
      groupsStatus = status;
    });
    if (groupsStatus.success) {
      setState(() {
        groups = status.data as Groups;
      });
      store.dispatch(SaveUserGroup(groupsStatus.data));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
      onInit: (store) => store.dispatch(getGroups),
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
            leading: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(40),
                onTap: () {
                  store.dispatch(ResetData());
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LoginPage(),
                    ),
                  );
                },
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(math.pi),
                  child: Icon(
                    Icons.exit_to_app,
                    color: Theme.of(context).primaryColor,
                    size: ScreenUtil().setWidth(30),
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  right: ScreenUtil().setWidth(20),
                ),
                child: Avatar(
                  width: ScreenUtil().setWidth(20),
                  onTap: () => print("avatar"),
                ),
              ),
            ],
          ),
          body: Builder(
            builder: (context) {
              if (groupsStatus == null)
                return Center(
                  child: CircularProgressIndicator(),
                );

              if (!groupsStatus.success)
                return SmartRefresher(
                  header: WaterDropMaterialHeader(
                    backgroundColor: Theme.of(context).accentColor,
                  ),
                  controller: _refreshController,
                  onRefresh: () => _onRefresh(store),
                  child: Center(
                    child: Text(
                      "Non è stato possibile trovare i gruppi. Tira giù per aggiornare",
                      textAlign: TextAlign.center,
                    ),
                  ),
                );

              return SafeArea(
                child: SmartRefresher(
                  header: WaterDropMaterialHeader(
                    backgroundColor: Theme.of(context).accentColor,
                  ),
                  controller: _refreshController,
                  onRefresh: () => _onRefresh(store),
                  enablePullDown: true,
                  child: ListView(
                    padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(35),
                      left: ScreenUtil().setWidth(25),
                      right: ScreenUtil().setWidth(25),
                    ),
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Amministratore"),
                          Icon(Icons.search),
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(10),
                      ),
                      Builder(
                        builder: (context) {
                          if (groups.admin.isEmpty)
                            return Container(
                              height: ScreenUtil().setHeight(150),
                              child: Center(
                                child: Text(
                                  "Non sei amministratore di nessun gruppo",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );

                          return GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: groups.admin.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3 / 3,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              Group group = groups.admin[index];
                              return Container(
                                margin: EdgeInsets.all(8),
                                width: double.infinity,
                                height: double.infinity,
                                color: Theme.of(context).accentColor,
                                child: Text(group.name),
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(25),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Membro"),
                          Icon(Icons.search),
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(10),
                      ),
                      Builder(
                        builder: (context) {
                          if (groups.member.isEmpty)
                            return Container(
                              height: ScreenUtil().setHeight(150),
                              child: Center(
                                child: Text(
                                  "Non sei membro di nessun gruppo",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );

                          return GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: groups.member.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3 / 3,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              Group group = groups.member[index];
                              return Container(
                                margin: EdgeInsets.all(8),
                                width: double.infinity,
                                height: double.infinity,
                                color: Theme.of(context).accentColor,
                                child: Text(group.name),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CreateGroupPage(),
                    ),
                  );
                },
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
