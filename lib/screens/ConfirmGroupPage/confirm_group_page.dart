import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sushi/components/separator_height.dart';
import 'package:sushi/model/Response/ResponseStatus.dart';
import 'package:sushi/model/Response/SearchGroup.dart';
import 'package:sushi/network/GroupPartecipateNetwork/group_partecipate_network.dart';
import 'package:sushi/utils/popup.dart';

class ConfirmGroupPage extends StatelessWidget {
  final SearchGroup searchGroup;
  final String userId;

  const ConfirmGroupPage({
    Key key,
    this.searchGroup,
    this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Conferma",
          ),
        ),
        body: ListView(
          padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(25),
            right: ScreenUtil().setWidth(25),
            top: ScreenUtil().setWidth(30),
          ),
          children: <Widget>[
            Hero(
              tag: searchGroup.id,
              child: CircleAvatar(
                radius: ScreenUtil().setWidth(60),
              ),
            ),
            SeparatorHeight(20),
            Text(
              searchGroup.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(18),
              ),
            ),
            Text(
              searchGroup.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(18),
                color: Colors.black54,
              ),
            ),
            SeparatorHeight(50),
            Text(
              "Vuoi mandare la richiesta di partecipazione al gruppo?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: ScreenUtil().setSp(16)),
            ),
            SeparatorHeight(25),
            Builder(
              builder: (bContext) {
                return Row(
                  children: <Widget>[
                    Expanded(
                      child: IconButton(
                        icon: Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                        iconSize: ScreenUtil().setWidth(40),
                        onPressed: () async {
                          final progress = ProgressHUD.of(bContext);
                          progress.show();

                          ResponseStatus status =
                              await GroupPartecipateNetwork.sendPending(
                            searchGroup.id,
                            userId,
                          );

                          progress.dismiss();

                          if (status.success) {
                            await Popup.success(
                              bContext,
                              'La richiesta al gruppo ${searchGroup.name} è stata inviata correttamente',
                            );
                            Navigator.pop(context, true);
                          } else {
                            print(status.data);
                            await Popup.error(
                              context,
                              'La richiesta al gruppo ${searchGroup.name} non è andata a buon fine. Riprova',
                            );
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Theme.of(context).accentColor,
                        ),
                        iconSize: ScreenUtil().setWidth(40),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
