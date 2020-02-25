import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sushi/components/custom_text_field.dart';
import 'package:sushi/model/TextField/InputField.dart';
import 'package:sushi/utils/column_builder.dart';
import 'package:sushi/utils/field_user.dart';

class CreateGroupPage extends StatefulWidget {
  @override
  _CreateGroupPageState createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  FieldUser fieldUser = FieldUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          "Crea un nuovo gruppo",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(50),
        ),
        children: <Widget>[
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
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
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.add_circle_outline,
                  size: ScreenUtil().setWidth(25),
                  color: Theme.of(context).accentColor,
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(30),
                ),
                Text(
                  "Aggiungi membri",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(17),
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ],
            ),
            onTap: () {
              print("Add members pressed");
            },
          ),
        ],
      ),
    );
  }
}
