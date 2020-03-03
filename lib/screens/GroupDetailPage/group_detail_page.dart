import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redux/redux.dart';
import 'package:sushi/components/separator_height.dart';
import 'package:sushi/model/Response/Groups.dart';
import 'package:sushi/model/Response/ResponseStatus.dart';
import 'package:sushi/network/GroupDetailNetwork/group_detail_network.dart';
import 'package:sushi/redux/actions/NewGroupActions/new_group_actions.dart';
import 'package:sushi/redux/store/AppState.dart';
import 'package:sushi/screens/AddMemberPage/add_member_page.dart';
import 'package:sushi/screens/GroupDetailPage/components/grid_card.dart';
import 'package:sushi/screens/HomePage/home_page.dart';
import 'package:sushi/utils/popup.dart';

class GroupDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
      converter: (store) => store,
      builder: (context, store) {
        Group group = store.state.selectedGroup.group;
        return ProgressHUD(
          child: Scaffold(
            appBar: AppBar(
              title: Text(group.name),
            ),
            body: Scaffold(
              body: ListView(
                padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(25),
                  right: ScreenUtil().setWidth(25),
                  top: ScreenUtil().setWidth(30),
                ),
                children: <Widget>[
                  CircleAvatar(
                    radius: ScreenUtil().setWidth(60),
                  ),
                  SeparatorHeight(20),
                  Text(
                    group.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(18),
                      color: Colors.black54,
                    ),
                  ),
                  SeparatorHeight(50),
                  GridView(
                    padding: EdgeInsets.all(
                      ScreenUtil().setWidth(9),
                    ),
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 5 / 4,
                      crossAxisSpacing: ScreenUtil().setWidth(20),
                      mainAxisSpacing: ScreenUtil().setWidth(20),
                    ),
                    shrinkWrap: true,
                    children: <Widget>[
                      GridCard(
                        icon: Icons.check,
                        iconColor: Colors.green,
                        title: "Conferma richieste",
                      ),
                      Builder(builder: (bContext) {
                        return GridCard(
                          icon: Icons.add,
                          iconColor: Colors.indigo,
                          title: "Aggiungi membri",
                          onTap: () async {
                            store.dispatch(ResetMember());
                            List<String> ids = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => AddMemberPage(
                                  groupId: group.id,
                                  isFromDetail: true,
                                ),
                              ),
                            );
                            if (ids == null)
                              return Popup.error(
                                context,
                                'Non hai aggiunto nessun utente. Premi su "Salva" dopo averli selezionati',
                              );

                            final progress = ProgressHUD.of(bContext);
                            progress.show();
                            ResponseStatus status =
                                await GroupDetailNetwork.addMember(
                              ids,
                              group.id,
                            );
                            progress.dismiss();
                            if (!status.success)
                              return await Popup.error(context, status.data);

                            return await Popup.success(
                              context,
                              "Complimenti, hai aggiunti ${ids.length} utenti al gruppo",
                            );
                          },
                        );
                      }),
                      GridCard(
                        icon: Icons.edit,
                        iconColor: Colors.blue,
                        title: "Modifica gruppo",
                      ),
                      Builder(builder: (bContext) {
                        return GridCard(
                          icon: Icons.delete_outline,
                          iconColor: Colors.red,
                          title: "Elimina gruppo",
                          onTap: () async {
                            final progress = ProgressHUD.of(bContext);
                            bool wantDelete;
                            await Popup.confirm(context,
                                "Sicuro di voler eliminare il gruppo con tutti gli eventi?",
                                onOk: () async {
                              wantDelete = true;
                              Navigator.pop(bContext);
                            }, onCancel: () async {
                              wantDelete = false;
                              Navigator.pop(bContext);
                            });

                            if (wantDelete) {
                              progress.show();

                              ResponseStatus status =
                                  await GroupDetailNetwork.deleteGroup(
                                group.id,
                              );

                              progress.dismiss();

                              if (!status.success)
                                return await Popup.error(context, status.data);

                              await Popup.success(
                                context,
                                "Gruppo eliminato con successo",
                              );
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                  (Route<dynamic> route) => false);
                            }
                          },
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
