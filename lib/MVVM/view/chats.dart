import 'package:chats_project/MVVM/model/firebaseSurvices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final inchats = TextEditingController();
  final emailController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Chats",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Firebasesurvices().signout();
            },
            icon: Icon(Icons.logout)),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("user").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final docs = snapshot.data!.docs;
          if (docs == null || docs.isEmpty) {
            return Center(
              child: Text("there is no chats avalable"),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            reverse: false,
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index];
              return Card(
                child: ListTile(
                  trailing: IconButton(
                      onPressed: () async {
                        await Firebasepage().deleteData(documentId: data.id);
                      },
                      icon: Icon(Icons.delete)),
                  title: Column(
                    children: [
                      Text(
                        data['email'].toString(),
                      ),
                      Text(
                        data['chats'].toString(),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        decoration: ,
        margin: EdgeInsets.all(5),
        height: 80,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                child: TextFormField(
                    controller: inchats,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "enter Something";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)),
                      fillColor: Colors.black54,
                      filled: true,
                    )),
              ),
            ),
            MaterialButton(
                height: 60,
                color: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () async {
                  if (formkey.currentState!.validate()) {
                    try {
                      await Firebasepage().createdata(
                          FirebaseAuth.instance.currentUser!.email.toString(),
                          inchats.text);
                      inchats.clear();
                    } catch (e) {
                      print('Error: $e');
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("Error: $e")));
                    }
                  }
                },
                child: Icon(Icons.send)),
          ],
        ),
      ),
    );
  }
}
