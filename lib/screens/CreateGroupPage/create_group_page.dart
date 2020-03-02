import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redux/redux.dart';
import 'package:sushi/components/custom_button.dart';
import 'package:sushi/components/custom_text_field.dart';
import 'package:sushi/components/icon_with_label.dart';
import 'package:sushi/components/separator_height.dart';
import 'package:sushi/model/Response/ResponseStatus.dart';
import 'package:sushi/model/Store/NewGroup.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Crea un nuovo gruppo",
        ),
      ),
      body: Form(
        key: _formKey,
        child: StoreConnector<AppState, Store<AppState>>(
          converter: (store) => store,
          onDispose: (store) => store.dispatch(RemoveGroup()),
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
                    int numMember = store.state.newGroup.users.length;
                    bool isEmpty = numMember == 0;
                    String concat =
                        numMember == 1 ? "membro aggiunto" : "membri aggiunti";
                    return IconWithLabel(
                      label: isEmpty ? "Aggiungi membri" : "$numMember $concat",
                      icon: Icons.add_circle_outline,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddMemberPage(),
                          ),
                        );
                      },
                    );
                  },
                ),
                SeparatorHeight(40),
                /*Row(
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        child: Icon(
                          Icons.info_outline,
                          color: Theme.of(context).accentColor,
                        ),
                        onTap: () => Popup.info(context),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: DropdownButton(
                        isExpanded: true,
                        value: dropdownValue,
                        hint: Text("Metodo di pagamento"),
                        onChanged: (type) {
                          PaymentType paymentType = type;
                          setState(() {
                            dropdownValue = paymentType;
                          });
                          store.dispatch(SelectPayment(paymentType));
                        },
                        items: [
                          DropdownMenuItem(
                            child: Text("Romana"),
                            value: PaymentType.Romana,
                          ),
                          DropdownMenuItem(
                            child: Text("Equo"),
                            value: PaymentType.Equo,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),*/
                //SeparatorHeight(40),
                CustomButton(
                  label: "Crea",
                  onTap: () async {
                    if (_formKey.currentState.validate()) {
                      store.dispatch(SelectNameAndDesc(fieldUser));
                      String userId = store.state.user.id;
                      NewGroup group = store.state.newGroup;
                      ResponseStatus status =
                          await CreateGroupNetwork.createGroup(group, userId);

                      if (!status.success)
                        await Popup.error(context, status.data);
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
