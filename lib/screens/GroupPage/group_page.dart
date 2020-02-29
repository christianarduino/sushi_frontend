import 'package:flutter/material.dart';
import 'package:sushi/model/Response/Groups.dart';
import 'package:sushi/utils/functions.dart';

class GroupPage extends StatelessWidget {
  final Group group;

  const GroupPage({Key key, this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          group.name,
          style: getStyle(context, Style.appBarTitle),
        ),
      ),
    );
  }
}
