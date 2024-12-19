import 'package:chats_project/MVVM/view/auth/login.dart';
import 'package:chats_project/MVVM/view/chats.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authgate extends StatelessWidget {
  const Authgate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text("Error=${snapshot.error}");
        } else if (snapshot.hasData) {
          return const Chats();
        } else {
          return const Login();
        }
      },
    );
  }
}
