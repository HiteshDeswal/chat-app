import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  late String messages;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async
  {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch(e)
    {
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Box'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messages = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        hintText: 'Type your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _firestore.collection('messages').add({
                        'text': messages,
                        'sender': loggedInUser.email
                      });

                    },
                    child: Text(
                      'Send',
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
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
