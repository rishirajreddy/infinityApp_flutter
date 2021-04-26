import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({this.text, this.onTap, this.color, this.fontColor});

  final String text;
  final Function onTap;
  final Color color;
  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 20.0,
      color: color,
      borderRadius: BorderRadius.circular(30.0),
      child: MaterialButton(
        onPressed: onTap,
        minWidth: 200.0,
        height: 42.0,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 20.0, fontFamily: 'Montserrat', color: fontColor),
          ),
        ),
      ),
    );
  }
}
