import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  final dynamic title;

  CustomAppBar({this.title});

  Widget renderTitle(BuildContext context) {
    if (this.title.runtimeType == String)
      return Text(
        title,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      );

    return this.title;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).canvasColor,
      iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      title: renderTitle(context),
      elevation: 0,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget get child => null;
}
