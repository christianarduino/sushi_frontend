import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOutlineButton extends StatelessWidget {
  final String label;
  final Function onTap;
  final Color borderColor;

  const CustomOutlineButton({Key key, this.label, this.onTap, this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      child: Text(
        label,
        style: TextStyle(color: borderColor),
      ),
      highlightedBorderColor: borderColor,
      borderSide: BorderSide(color: borderColor),
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtil().setHeight(20),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      onPressed: onTap,
    );
  }
}
