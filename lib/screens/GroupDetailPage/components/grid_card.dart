import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Function onTap;

  const GridCard({
    Key key,
    this.iconColor,
    this.title,
    this.onTap,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: new BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 5.0,
              spreadRadius: 1.0,
              offset: Offset(4, 4),
            )
          ],
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                icon,
                color: iconColor,
                size: ScreenUtil().setWidth((30)),
              ),
              Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
