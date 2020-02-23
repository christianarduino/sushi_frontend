import 'dart:io';

import 'package:flutter/material.dart';

class ArrowBack extends StatelessWidget {
  final double size;
  final Color color;

  const ArrowBack({Key key, this.size, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
        size: size,
        color: color,
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
