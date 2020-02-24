import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class DialogMessage {
  static errorWithMessage(BuildContext context, String desc) async {
    await AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.SCALE,
      headerAnimationLoop: false,
      btnOk: FlatButton(
        child: Text("Riprova"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      tittle: "Attenzione",
      desc: desc,
    ).show();
  }
}
