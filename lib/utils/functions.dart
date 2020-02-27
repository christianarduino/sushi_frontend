import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

initStatusBar() async {
  print("called");
  await FlutterStatusbarcolor.setStatusBarColor(Color(0xfffafafa));
  await FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  print("finish call");
}
