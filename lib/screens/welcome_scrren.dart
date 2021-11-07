import 'package:flutter/material.dart';
import 'login_screen.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: primaryColor,

      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("images/welcomeImage.png",
              height: 250,),
            SizedBox(height: 20,),
            Text('Welcome to the Chat Box',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 28),),
            SizedBox(height: 30,),
            MaterialButton(
              elevation: 0,
              height: 50,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Login()));
              },
              color: Colors.greenAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Get Started',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  Icon(Icons.arrow_forward_rounded)
                ],
              ),
            )],
        ),
      ),
    );
  }
}
