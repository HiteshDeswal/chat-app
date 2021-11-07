import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_screen.dart';

    class SignUp extends StatefulWidget {
      const SignUp({Key? key}) : super(key: key);

      @override
      _SignUpState createState() => _SignUpState();
    }

    class _SignUpState extends State<SignUp> {

      final formkey = GlobalKey<FormState>();
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
              SizedBox( height: 150.0),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formkey,
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
                          if(formkey.currentState!.validate()){
                            try {
                              final newuser = await auth.createUserWithEmailAndPassword
                                (email: emailcontroller.text, password: passwordcontroller.text);
                              if(newuser != null)
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context)
                                => Login()));
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
                          color: Colors.redAccent,
                          child: Text("Register", style: TextStyle(
                              color: Colors.white, fontSize: 17
                          ),
                          ),
                        ),
                        SizedBox(height: 8,),

                        MaterialButton(onPressed: ()=>
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context)
                          => Login()))
                        },
                          minWidth: 400.0,
                          height: 42.0,
                          color: Colors.blueAccent,
                          child: Text("Already register Sign in", style: TextStyle(
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
  final text = "Register Succesful";
  final snackbar = SnackBar(content: Text(text));
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
