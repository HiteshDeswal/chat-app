import 'package:chat_box/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class Login extends StatefulWidget {

  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formkey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // SizedBox(height: 100,
          // child:   Image.asset("images/logooo.png"),
          // ),
          SizedBox( height: 150.0),
        Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailcontroller,
                      decoration: InputDecoration(
                          hintText: 'Email',
                          icon: Icon(CupertinoIcons.envelope)
                      ),

                      validator: (value) {
                        if(value!.isEmpty)
                        {
                          return " Email is required ";

                        }
                        return null;
                      },
                      onSaved: (value) {
                        emailcontroller.text = value!;
                      },

                    ),

                    TextFormField(
                      controller: passwordcontroller,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Password',

                          icon: Icon(CupertinoIcons.lock)
                      ),

                      validator: (value) {
                        if(value!.isEmpty)
                        {
                          return " Password is required ";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        passwordcontroller.text = value!;
                      },
                    ),
                    SizedBox(height: 8,),

                    MaterialButton(onPressed: () async {
                      if(_formkey.currentState!.validate()){
                        try {
                          final newuser = await auth.signInWithEmailAndPassword
                            (email: emailcontroller.text,
                              password: passwordcontroller.text);

                          if(newuser != null)
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (context)
                            => SignUp()));
                          }
                          showSnackbar(context);

                        }
                        catch(e){
                          print(e);
                        }
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

              )
          )
        ],
      ),
    );
  }
}

void showSnackbar(BuildContext context) {
  final text = "Login Succesful";
  final snackbar = SnackBar(content: Text(text));
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
