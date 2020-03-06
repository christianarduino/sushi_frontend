import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redux/redux.dart';
import 'package:sushi/components/custom_button.dart';
import 'package:sushi/components/custom_text_field.dart';
import 'package:sushi/components/icon_with_label.dart';
import 'package:sushi/components/separator_height.dart';
import 'package:sushi/model/Response/ResponseStatus.dart';
import 'package:sushi/model/TextField/InputField.dart';
import 'package:sushi/network/CreateGroupNetwork/create_network_group.dart';
import 'package:sushi/redux/actions/NewGroupActions/new_group_actions.dart';
import 'package:sushi/redux/store/AppState.dart';
import 'package:sushi/screens/AddMemberPage/add_member_page.dart';
import 'package:sushi/utils/column_builder.dart';
import 'package:sushi/utils/enum.dart';
import 'package:sushi/utils/field_user.dart';
import 'package:sushi/utils/popup.dart';

class CreateGroupPage extends StatefulWidget {
  @override
  _CreateGroupPageState createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FieldUser fieldUser = FieldUser();
  PaymentType dropdownValue;

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Crea un nuovo gruppo",
          ),
        ),
        body: Form(
          key: _formKey,
          child: StoreConnector<AppState, Store<AppState>>(
            converter: (store) => store,
            onDispose: (store) => store.dispatch(RemoveUsers()),
            builder: (context, store) {
              return ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(50),
                ),
                children: <Widget>[
                  SeparatorHeight(20),
                  ColumnBuilder(
                    itemCount: fieldUser.inputs.length,
                    itemBuilder: (_, int i) {
                      InputField field = fieldUser.inputs[i];
                      if (field.label.contains("gruppo")) {
                        return CustomTextField(
                          inputField: field,
                          inputTextField: fieldUser,
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                  SeparatorHeight(20),
                  Builder(
                    builder: (context) {
                      int numMember = store.state.searchUser.users.length;
                      bool isEmpty = numMember == 0;
                      String concat = numMember == 1
                          ? "membro aggiunto"
                          : "membri aggiunti";
                      return IconWithLabel(
                        label:
                            isEmpty ? "Aggiungi membri" : "$numMember $concat",
                        icon: Icons.add_circle_outline,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddMemberPage(
                                isFromDetail: false,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  SeparatorHeight(40),
                  Builder(
                    builder: (bContext) {
                      return CustomButton(
                        label: "Crea",
                        onTap: () async {
                          if (_formKey.currentState.validate()) {
                            final progress = ProgressHUD.of(bContext);
                            progress.show();
                            store.dispatch(SelectNameAndDesc(fieldUser));
                            String userId = store.state.loggedUser.id;
                            List<String> userIds =
                                store.state.searchUser.userIds;
                            ResponseStatus status =
                                await CreateGroupNetwork.createGroup(
                              fieldUser,
                              userIds,
                              userId,
                            );
                            progress.dismiss();

                            if (!status.success)
                              return await Popup.error(bContext, status.data);

                            await Popup.success(
                              bContext,
                              'Complimenti! Hai creato il tuo gruppo chiamato "${fieldUser.groupName}"',
                            );
                            Navigator.pop(context);
                          }
                        },
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
