import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:follow_my_voyage/constants.dart';
import 'welcome_screen.dart';

final _firestore = FirebaseFirestore.instance;

class CommentsScreen extends StatefulWidget {
  static String id = 'comments_screen';

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final _auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();
  User loggedInUser;
  String messageText;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if(user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pushNamed(context, WelcomeScreen.id);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessageStream(),
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
                    FlatButton(
                      onPressed: () {
                        _firestore.collection('messages').add({
                          'text':   messageText,
                          'sender': loggedInUser.email,
                        });
                        messageTextController.clear();
                      },
                      child: Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
        ),
    );
  }
}
class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - (AppBar().preferredSize.height + 102),
      child: StreamBuilder(
          stream: _firestore.collection('messages').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            return ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data();
                return MessageBubble(data['sender'], data['text']);
              }).toList(),
            );
          }
      ),
    );
  }
}


class MessageBubble extends StatelessWidget {
  MessageBubble(this.sender, this.text);
  final String sender;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              Text(sender),
              Material(
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                    child: Text(
                      '$text',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                ),
            ),
          ]),
    );
  }
}