import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sushi/screens/LoginPage/login_page.dart';

void main() {
  runApp(SushiApp());
}

class SushiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).accentColor,
              width: 1.0,
            ),
          ),
          labelStyle: TextStyle(
            color: Colors.grey,
          ),
        ),
        primaryColor: Color(0xFF433C3F),
        cursorColor: Color(0xFFEF586C),
        accentColor: Color(0xFFEF586C),
        textTheme: TextTheme(
          body1: TextStyle(
            color: Color(0xFF433C3F),
          ),
          subtitle: TextStyle(
            color: Color(0xFFD1CFD0),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          Size size = MediaQuery.of(context).size;
          ScreenUtil.init(context, width: size.width, height: size.height);

          return LoginPage();
        },
      ),
    );
  }
}
