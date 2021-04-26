import 'package:flutter/material.dart';
import 'package:chatting_flutter_/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
User loggedinUser;

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String messageText;
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  void getCurrenctUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
        print(loggedinUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrenctUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kdarkThemeColor,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              _auth.signOut();
              Navigator.pop(context);
            },
            child: Center(
              child: Text(
                'SignOut',
                style: TextStyle(
                    fontSize: 16.0,
                    color: kLoginButtonColor,
                    fontFamily: 'Montserrat'),
              ),
            ),
          )
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 22.0,
            ),
            Image.asset(
              'images/infinity.png',
              height: 55,
            ),
          ],
        ),
        backgroundColor: Color(0xFF252331),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': loggedinUser.email,
                        'time': DateTime.now()
                      });
                    },
                    child: Icon(Icons.send_sharp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: kLoginButtonColor,
              ),
            );
          }
          final messages = snapshot.data.docs.reversed;
          List<MessageBox> messageBoxes = [];
          for (var message in messages) {
            final messageText = message.data()['text'];
            final messageSender = message.data()['sender'];
            final messageTime = message.data()['time'];

            final currentUser = loggedinUser.email;

            final messageBox = MessageBox(
                text: messageText,
                sender: messageSender,
                isMe: currentUser == messageSender,
                time: messageTime);
            messageBoxes.add(messageBox);
            messageBoxes.sort((a, b) => b.time.compareTo(a.time));
          }
          return Expanded(
            child: ListView(
                reverse: true,
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                children: messageBoxes),
          );
        });
  }
}

class MessageBox extends StatelessWidget {
  MessageBox({this.text, this.sender, this.isMe, this.time});
  final String text;
  final String sender;
  final bool isMe;
  final Timestamp time;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Material(
            elevation: 20.0,
            borderRadius: BorderRadius.only(
              topLeft: isMe ? Radius.circular(30.0) : Radius.zero,
              topRight: isMe ? Radius.zero : Radius.circular(30.0),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            color: isMe ? kLoginButtonColor : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Text(
                '$text',
                style: TextStyle(
                    color: isMe ? Colors.white : Colors.black,
                    fontSize: 15.0,
                    fontFamily: 'Ubuntu'),
              ),
            ),
          ),
          Text(
            sender,
            style: TextStyle(fontSize: 12.0, color: Colors.grey),
          ),
          Text(
            '${time.toDate().hour}:${time.toDate().minute}',
            style: TextStyle(fontSize: 10.0, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
