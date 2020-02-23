import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Function onTap;
  final Padding padding;

  const CustomButton(
      {Key key, this.label, this.backgroundColor, this.onTap, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: backgroundColor ?? Theme.of(context).accentColor,
      textColor: Colors.white,
      padding: padding ??
          EdgeInsets.symmetric(
            vertical: ScreenUtil().setHeight(20),
          ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(label),
      onPressed: onTap,
    );
  }
}
