import 'dart:math';

import 'package:chats_project/MVVM/model/firebaseSurvices.dart';
import 'package:chats_project/MVVM/view/auth/login.dart';
import 'package:chats_project/MVVM/view/auth/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final email = TextEditingController();
  final pass = TextEditingController();
  final confermpass = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(220, 220, 220, 1),
      body: Center(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock,
                    size: 90,
                  ),
                  SizedBox(
                    height: 90,
                  ),
                  Text(
                    "Lets create an account for you",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: email,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Email";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter Email",
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: pass,
                    validator: (value) {
                      RegExp regex = RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                      if (value!.isEmpty) {
                        return "Enter Password";
                      }
                      if (!regex.hasMatch(pass.text)) {
                        return "invalid password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter Password",
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: confermpass,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Email";
                      }
                      if (confermpass.text != pass.text) {
                        return "password doesnt match";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter Password",
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    child: MaterialButton(
                        height: 60,
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            if (confermpass.text == pass.text) {
                              await Firebasesurvices().create(
                                user: email.text,
                                password: pass.text,
                                context: context,
                              );
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("cannot register")));
                            }
                          }
                        },
                        child: Text(
                          "SignUp",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have account",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Login()));
                          },
                          child: Text(
                            "Login now",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
