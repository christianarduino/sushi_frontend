import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconWithLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function onTap;

  const IconWithLabel({Key key, this.icon, this.label, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Icon(
              icon,
              size: ScreenUtil().setWidth(25),
              color: Theme.of(context).accentColor,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(17),
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
