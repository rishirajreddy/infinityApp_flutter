import 'package:InfinitApp/constants.dart';
import 'package:InfinitApp/screens/login_screen.dart';
import 'package:InfinitApp/screens/registration_screen.dart';
import 'package:InfinitApp/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:delayed_display/delayed_display.dart';

class ChatApp extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _ChatAppState createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> with TickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  Animation animation2;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation2 = ColorTween(begin: Colors.white, end: kdarkThemeColor)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation2.value,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/infinity.png'),
                    height: animation.value * 100,
                  ),
                ),
              ),
              DelayedDisplay(
                delay: Duration(seconds: 2),
                fadingDuration: Duration(milliseconds: 1000),
                child: Text(
                  'InfinitChat',
                  style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Righteous'),
                ),
              )
            ],
          ),
          SizedBox(
            height: 48.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 15.0),
            child: RoundedButton(
              text: 'Login',
              onTap: () {
                Navigator.pushNamed(context, LoginPage.id);
              },
              color: kLoginButtonColor,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 15.0),
            child: RoundedButton(
              text: 'SignUp',
              fontColor: Colors.black,
              onTap: () {
                Navigator.pushNamed(context, SignUp.id);
              },
              color: kSignUpButtonColor,
            ),
          )
        ],
      ),
    );
  }
}
