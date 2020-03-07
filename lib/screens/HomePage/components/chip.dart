import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function onTap;

  const CustomChip({Key key, this.isSelected, this.onTap, this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        margin: EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 20,
        ),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).accentColor : Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: !isSelected
              ? [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    spreadRadius: 1.0,
                    offset: Offset(
                      5.0, // horizontal, move right 10
                      3.0, // vertical, move down 10
                    ),
                  )
                ]
              : null,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10.0,
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : null,
              fontWeight: isSelected ? FontWeight.w500 : null,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
