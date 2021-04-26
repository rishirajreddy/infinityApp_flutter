import 'package:InfinitApp/constants.dart';
import 'package:InfinitApp/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:InfinitApp/widgets/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email;
  String password;
  bool showSpinner = false;
  final _authenticate = FirebaseAuth.instance;
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
                text: 'Login',
                onTap: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final user = await _authenticate.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                    setState(() {
                      Alert(
                          context: context,
                          style: AlertStyle(backgroundColor: kLoginButtonColor),
                          title: 'Invalid Credentials',
                          desc:
                              'There is no user record corresponding to this identifier.',
                          buttons: [
                            DialogButton(
                              color: Colors.blue,
                              child: Text(
                                "Retry",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              width: 120,
                            )
                          ]).show();
                      showSpinner = false;
                    });
                  }
                },
                color: kLoginButtonColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
