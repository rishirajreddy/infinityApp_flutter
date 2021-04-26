import 'package:chatting_flutter_/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:chatting_flutter_/constants.dart';
import 'package:chatting_flutter_/widgets/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignUp extends StatefulWidget {
  static String id = 'register_screen';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email;
  String password;
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kdarkThemeColor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Container(
                  child: Image.asset(
                    'images/infinity.png',
                    height: 200.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 15.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                style:
                    TextStyle(color: kSignUpButtonColor, fontFamily: 'Ubuntu'),
                decoration: kInputTextDecoration.copyWith(
                    hintText: 'Enter Your Email',
                    hintStyle: TextStyle(fontWeight: FontWeight.w100)),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 15.0),
              child: TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                style:
                    TextStyle(color: kSignUpButtonColor, fontFamily: 'Ubuntu'),
                decoration: kInputTextDecoration.copyWith(
                    hintText: 'Enter Password',
                    hintStyle: TextStyle(fontWeight: FontWeight.w100)),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 60.0),
              child: RoundedButton(
                fontColor: Colors.black,
                text: 'SignUp',
                onTap: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
                color: kSignUpButtonColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
