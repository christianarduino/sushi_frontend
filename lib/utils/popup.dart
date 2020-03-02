import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class Popup {
  static success(BuildContext context, String desc) async {
    await AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.SCALE,
      headerAnimationLoop: false,
      btnOk: FlatButton(
        child: Text("Ok"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      tittle: "Successo",
      desc: desc,
    ).show();
  }

  static error(BuildContext context, String desc) async {
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

  static info(BuildContext context) async {
    await AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      headerAnimationLoop: false,
      btnOk: FlatButton(
        child: Text("Ok"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      tittle: "",
      desc: """
      Romana: il conto verrà diviso per tutti i partecipanti del gruppo, considerando nel prezzo anche i prodotti fuori dal menu all you can eat.
      
      Equo: ognuno paga la sua quota, quindi chi ordina prodotti al di fuori del menù all you can eat, dovrà pagarli singolarmente
      """
          .trim(),
    ).show();
  }

  static confirm(BuildContext context, String desc,
      {Function onOk, onCancel}) async {
    await AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.SCALE,
      headerAnimationLoop: false,
      btnOk: FlatButton(
        child: Text("Conferma"),
        onPressed: onOk,
      ),
      btnCancel: FlatButton(
        child: Text("Annulla"),
        onPressed: onCancel,
      ),
      tittle: "Attenzione",
      desc: desc,
    ).show();
  }
}
