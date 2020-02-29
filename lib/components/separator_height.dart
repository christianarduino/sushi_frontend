import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SeparatorHeight extends StatelessWidget {
  final double height;

  const SeparatorHeight(this.height);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().setHeight(height),
    );
  }
}
