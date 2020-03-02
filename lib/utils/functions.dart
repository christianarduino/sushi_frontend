import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

enum Style {
  speedDialText,
  searchTextField,
}

getStyle(BuildContext context, Style style) {
  switch (style) {
    case Style.speedDialText:
      return TextStyle(
        fontSize: ScreenUtil().setSp(16.0),
      );
    case Style.searchTextField:
      return InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.0,
          ),
        ),
      );
  }
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

initStatusBar() async {
  print("called");
  await FlutterStatusbarcolor.setStatusBarColor(Color(0xfffafafa));
  await FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  print("finish call");
}
