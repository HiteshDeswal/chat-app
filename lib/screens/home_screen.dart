import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
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
        actions: [
          IconButton(onPressed: (){
            _auth.signOut();
            Navigator.pop(context);
          },
              icon: Icon(Icons.close) ),
        ],
        title: Text('Chat Box'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),

            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
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
                      messageTextController.clear();
                      _firestore.collection('messages').add({
                        'text': messages,
                        'sender': loggedInUser.email
                      });
                    },
                    child: Text(
                      'Send',
                      style: TextStyle(
                        color: Colors.white,
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



class MessageStream extends StatelessWidget {
  const MessageStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
        {
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final messages = snapshot.data!.docs;

          List<MessageBubble> messageBubbles = [];
          for(var message in messages)
          {
            var messageText = message['text'];
            var messageSender = message['sender'] ;
            final currentUser = loggedInUser.email;

            final messageBubble = MessageBubble(
                text:  messageText,
                sender: messageSender,
                isMe: currentUser == messageSender );

            messageBubbles.add(messageBubble);
          }

          return Expanded(
            child: ListView(
              reverse: true,
              children: messageBubbles,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            ),
          );
        }
    );
  }
}


class MessageBubble extends StatelessWidget {
  // const MessageBubble({Key? key}) : super(key: key);

  MessageBubble({required this.text, required this.sender, required this.isMe});

  final String text;
  final String sender;
  final bool isMe;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment
            : isMe ? CrossAxisAlignment.end: CrossAxisAlignment.start,
        children: [
          Text(sender ,
            style: TextStyle(fontSize: 12,
                color: Colors.black),
          ),
          Material(
            borderRadius: BorderRadius.circular(25.0),
            elevation: 10.0,
            color: isMe ? Colors.lightGreen : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
              child: Text
                (text,
                style: TextStyle(
                    fontSize: 20,
                    color: isMe ? Colors.white : Colors.black54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
