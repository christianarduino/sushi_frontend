import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/models/persisten-bottom-nav-item.widget.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-bottom-nav-bar-styles.widget.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-nav-bar-scaffold.widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.widget.dart';

class GroupPage extends StatefulWidget {
  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  PersistentTabController _controller;

  @override
  initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: _controller,
      items: [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.home),
          title: ("Home"),
          activeColor: Theme.of(context).accentColor,
          inactiveColor: Theme.of(context).primaryColor,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.attach_money),
          title: ("Home"),
          activeColor: Theme.of(context).accentColor,
          inactiveColor: Theme.of(context).primaryColor,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.settings),
          title: ("Settings"),
          activeColor: Theme.of(context).accentColor,
          inactiveColor: Theme.of(context).primaryColor,
        ),
      ],
      screens: <Widget>[
        Column(),
        Column(),
        Column(),
      ],
      showElevation: true,
      isCurved: true,
      iconSize: 26.0,
      navBarStyle: NavBarStyle.style1,
      onItemSelected: (index) {
        print(index);
      },
    );
  }
}
