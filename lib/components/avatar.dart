import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Avatar extends StatelessWidget {
  final double width;
  final Function onTap;

  const Avatar({Key key, this.width, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Center(
        child: Hero(
          tag: "avatar",
          child: CircleAvatar(
            radius: width,
            backgroundImage: NetworkImage(
              "https://www.w3schools.com/howto/img_avatar.png",
            ),
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
