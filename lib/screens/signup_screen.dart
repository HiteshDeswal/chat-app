import 'package:chat_box/screens/login_screen.dart';
import'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

    class SignUp extends StatefulWidget {
      const SignUp({Key? key}) : super(key: key);

      @override
      _SignUpState createState() => _SignUpState();
    }

    class _SignUpState extends State<SignUp> {

      final auth = FirebaseAuth.instance;
      late String email, password;
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Register'),
          ),
          body: Column(
            children: [
              SizedBox( height: 300.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Email'
                  ),
                  onChanged: (value){

                    setState(() {
                      email = value.trim();
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
                      password = value.trim();
                    });
                  },

                ),
              ),

              SizedBox(height: 8,),

              MaterialButton(onPressed: () async {
                try {
                  final newuser = await auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  if(newuser !=  null)
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context)
                      => Login()));
                    }

                }
                catch(e){
                  print(e);
                }
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
