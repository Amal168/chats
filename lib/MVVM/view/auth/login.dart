import 'dart:math';

import 'package:chats_project/MVVM/model/firebaseSurvices.dart';
import 'package:chats_project/MVVM/view/auth/forgot.dart';
import 'package:chats_project/MVVM/view/auth/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final email = TextEditingController();
  final pass = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(220, 220, 220, 1),
      body: Center(
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
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
                    "Welcome back you have been missed!",
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
                      if (value!.isEmpty) {
                        return "Enter Email";
                      }
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter Password",
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        )),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Forgot()));
                      },
                      child: Text("Forgot Password?"),
                    ),
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
                            try {
                              await Firebasesurvices().signin(
                                context: context,
                                user: email.text,
                                password: pass.text,
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    margin: EdgeInsets.all(20),
                                    behavior: SnackBarBehavior.floating,
                                    content: Text('Error: $e')),
                              );
                            }
                          }
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Or continue with"),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          await Firebasesurvices().googleUser(context);
                        },
                        child: Container(
                            width: 100,
                            height: 100,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white30,
                                  blurRadius: 20.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white),
                              color: Colors.white,
                            ),
                            child: const Image(
                              image: NetworkImage(
                                  "https://imagepng.org/wp-content/uploads/2019/08/google-icon.png",
                                  scale: 0.5),
                              width: 20,
                            )),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                margin: EdgeInsets.all(20),
                                behavior: SnackBarBehavior.floating,
                                content: Text("This function is not avalable")),
                          );
                        },
                        child: Container(
                            width: 100,
                            height: 100,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white30,
                                  blurRadius: 20.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white),
                              color: Colors.white,
                            ),
                            child: const Image(
                              image: NetworkImage(
                                  "https://th.bing.com/th/id/OIP.pW0TOZyl_OZMIuo5HjUsyQHaIf?rs=1&pid=ImgDetMain",
                                  scale: 0.5),
                              width: 20,
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have account",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Register()));
                          },
                          child: Text(
                            "Register now",
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
