import 'package:chat_box/screens/welcome_scrren.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState(){
    super.initState();
    _navigatetohome();

  }
  _navigatetohome() async{
    await Future.delayed
      (Duration(milliseconds: 2500),(){});
    Navigator.pushReplacement(
        context, MaterialPageRoute(
        builder: (context)=>WelcomeScreen()));

  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Flexible(
          child: Image.asset("images/first.png"),
        ),
      ),
    );
  }
}
