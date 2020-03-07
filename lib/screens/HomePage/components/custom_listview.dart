import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redux/redux.dart';
import 'package:sushi/model/Response/Groups.dart';
import 'package:sushi/redux/actions/SelectedGroupActions/selected_group_actions.dart';
import 'package:sushi/redux/store/AppState.dart';
import 'package:sushi/screens/EventsPage/events_page.dart';
import 'dart:math';

class CustomListView extends StatelessWidget {
  final bool isAdmin;
  final Store<AppState> store;
  final List<Group> groups;

  const CustomListView({
    Key key,
    this.groups,
    this.store,
    this.isAdmin,
  }) : super(key: key);

  String genRandomNumber(int min, int max) {
    Random random = new Random();
    int num = min + random.nextInt(max - min);
    return num.toString();
  }

  String getRandomImage() {
    String type = isAdmin ? "admin" : "member";
    return "assets/$type/sushi-${genRandomNumber(1, 5)}.jpg";
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: groups.length,
      itemBuilder: (BuildContext context, int index) {
        Group group = groups[index];
        group.isAdmin = true;
        return GestureDetector(
          child: Container(
            height: ScreenUtil().setHeight(150),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  getRandomImage(),
                ),
              ),
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Color(0x77000000),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            group.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(25),
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(5, 5),
                                  blurRadius: 15.0,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        group.description,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(5, 5),
                              blurRadius: 15.0,
                              color: Colors.black,
                            ),
                          ],
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(14.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          onTap: () {
            store.dispatch(SaveSelectedGroup(group));
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => EventsPage(),
              ),
            );
          },
        );
      },
    );
  }
}
