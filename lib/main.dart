import 'package:chatting_flutter_/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:chatting_flutter_/screens/login_screen.dart';
import 'package:chatting_flutter_/screens/registration_screen.dart';
import 'package:chatting_flutter_/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white))),
      initialRoute: ChatApp.id,
      routes: {
        ChatApp.id: (context) => ChatApp(),
        LoginPage.id: (context) => LoginPage(),
        SignUp.id: (context) => SignUp(),
        ChatScreen.id: (context) => ChatScreen()
      },
    );
  }
}
