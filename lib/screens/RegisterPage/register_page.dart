import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sushi/components/arrow_back.dart';
import 'package:sushi/components/background.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Background(),
            Padding(
              padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(25),
                left: ScreenUtil().setWidth(25),
              ),
              child: ArrowBack(
                color: Theme.of(context).primaryColor,
                size: ScreenUtil().setWidth(30),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(50),
                ),
                shrinkWrap: true,
                children: <Widget>[],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
