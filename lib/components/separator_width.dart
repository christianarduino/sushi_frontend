import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SeparatorWidth extends StatelessWidget {
  final double width;

  const SeparatorWidth(this.width);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().setHeight(width),
    );
  }
}
