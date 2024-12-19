import 'package:chats_project/MVVM/view/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  final forgot = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 162, 161, 161),
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text(
          "Forgot Password",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Enter your email",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: forgot,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter your Email";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Your Email Please",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              const Color.fromARGB(255, 27, 246, 34))),
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: forgot.text);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Message is send")));
                          ;
                        }
                      },
                      child: Text(
                        "Send",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                ),
                TextButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>Login()));
                }, child: Text("Back to Login page",style: TextStyle(color: Colors.black),))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
