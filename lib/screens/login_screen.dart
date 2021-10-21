import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';

class Login extends StatefulWidget {

  const Login({Key? key}) : super(key: key);


  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // bool showSpinner = false;


   late String _email, _password;
  final auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Email'
                ),
                onChanged: (value){

                  setState(() {
                    _email = value.trim();
                  });
                },

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Password'
                ),
                onChanged: (value){
                  setState(() {
                    _password = value.trim();
                  });
                },

              ),
            ),

            SizedBox(height: 8,),

            MaterialButton(onPressed: ()=>

            {
              auth.signInWithEmailAndPassword(email: _email, password: _password),
              Navigator.push(context, MaterialPageRoute(builder: (context)
              => HomeScreen()))
            },
              minWidth: 400.0,
              height: 42.0,
              color: Colors.blueAccent,
              child: Text("Sign In", style: TextStyle(
                  color: Colors.white, fontSize: 17
              ),),

            ),

            SizedBox(height: 8,),

            MaterialButton(onPressed: ()=>
            {
              auth.createUserWithEmailAndPassword(email: _email, password: _password),
              Navigator.push(context, MaterialPageRoute(builder: (context)
              => HomeScreen()))
            },
              minWidth: 400.0,
              height: 42.0,
              color: Colors.redAccent,
              child: Text("Register", style: TextStyle(
                  color: Colors.white, fontSize: 17
              ),),
            )

          ],
        ),
      );
  }
}
