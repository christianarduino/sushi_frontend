import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sushi/components/avatar.dart';
import 'package:sushi/components/custom_button.dart';
import 'package:sushi/model/Store/User.dart';
import 'package:sushi/redux/store/AppState.dart';
import 'package:sushi/screens/ProfilePage/components/groups_counter.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, User>(
      converter: (store) => store.state.user,
      builder: (context, user) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              user.username,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            elevation: 0,
            backgroundColor: Theme.of(context).canvasColor,
            iconTheme: IconThemeData(
              color: Theme.of(context).primaryColor,
            ),
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(25),
            ),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: ScreenUtil().setWidth(20),
                ),
                child: Avatar(
                  width: ScreenUtil().setWidth(70),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Text(
                user.name + " " + "Arduino",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(18),
                ),
              ),
              Text(
                user.email,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(60),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: GroupsCounter(
                      counter: "0",
                      label: "Amministratore",
                    ),
                  ),
                  Expanded(
                    child: GroupsCounter(
                      counter: "0",
                      label: "Membro",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(60),
              ),
              CustomButton(
                label: "Modifica dati",
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}
