import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupsCounter extends StatelessWidget {
  final String counter;
  final String label;

  const GroupsCounter({Key key, this.counter, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          counter,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(16),
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(16),
          ),
        ),
      ],
    );
  }
}
