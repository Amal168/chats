import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Firebasesurvices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> signin(
      {required BuildContext context,
      required String password,
      required String user}) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: user, password: password);
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Entered Scussefully")));
      }
      return credential;
    } on FirebaseAuthException {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Something went wrong")));
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<UserCredential?> create({
    required BuildContext context,
    required String user,
    required String password,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: user, password: password);
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("created Scussefully")));
      }
      return credential;
    } on FirebaseAuthException {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Something went wrong")));
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<UserCredential?> googleUser(BuildContext context) async {
    try {
      GoogleSignInAccount? gooogleuser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await gooogleuser?.authentication;
      final googleCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.accessToken);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Something Went Wrong")));
    }
    return null;
  }

  Future<void> signout() async {
    _auth.signOut();
  }
}

class Firebasepage {
  Future createdata(String email, String chats) async {
    final ref = FirebaseFirestore.instance.collection("user");
    return await ref.add({'email':email, 'chats': chats,'createdAt': Timestamp.now(),});
  }

   Future updatedata(String chats, {String? documentId}) async {
    final ref = FirebaseFirestore.instance.collection("user");
    return await ref.doc(documentId).update({'chats': chats});
  }

  Future deleteData({String? documentId}) async {
    final ref = FirebaseFirestore.instance.collection("user");
    return await ref.doc(documentId).delete();
  }
}
