import 'package:chat_box/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class Login extends StatefulWidget {

  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final auth = FirebaseAuth.instance;
  late String _email, _password;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar
        (backgroundColor: Colors.transparent,
      elevation: 0,
      ),
      body: Column(
          children: [
            SizedBox( height: 100.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Email'
                ),
                onChanged: (value){

                  setState(() {
                    _email = value;
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
                    _password = value;
                  });
                },

              ),
            ),

            SizedBox(height: 8,),

            MaterialButton(onPressed: () async {
              try {
                final newuser = await auth.signInWithEmailAndPassword(
                    email: _email, password: _password);
                if(newuser !=  null)
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context)
                  => HomeScreen()));
                }
              }
              catch(e){
                print(e);
              }
            },
              minWidth: 400.0,
              height: 42.0,
              color: Colors.blueAccent,
              child: Text("Login", style: TextStyle(
                  color: Colors.white, fontSize: 17
              ),),
            ),

            SizedBox(height: 8,),

            MaterialButton(onPressed: ()=>
            {
              Navigator.push(context, MaterialPageRoute(builder: (context)
              => SignUp()))
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
