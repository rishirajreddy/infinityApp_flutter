import 'package:flutter/material.dart';

const kLoginButtonColor = Color(0xFF2C75FD);
const kSignUpButtonColor = Colors.white;
const kdarkThemeColor = Color(0xFF252331);
const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

var kInputTextDecoration = InputDecoration(
  hintText: 'Enter Your Value',
  hintStyle: TextStyle(color: Color(0xFFafecfe)),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(32.0),
    borderSide: BorderSide(color: Colors.blue, width: 1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kLoginButtonColor, width: 2.0),
    borderRadius: BorderRadius.circular(32.0),
  ),
);
