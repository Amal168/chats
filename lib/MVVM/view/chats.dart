import 'package:chats_project/MVVM/model/firebaseSurvices.dart';
import 'package:chats_project/utils.dart';
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
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                Firebasesurvices().signout();
              },
              icon: Icon(Icons.logout)),
        ],
        title: Text(
          "Chats",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
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
                    child: Text("There are no chats available."),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  reverse: false,
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(),
                            trailing: IconButton(
                                onPressed: () async {
                                  await Firebasepage()
                                      .deleteData(documentId: data.id);
                                },
                                icon: Icon(Icons.delete)),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data['email'].toString()),
                                Text(data['chats'].toString()),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: formkey,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextFormField(
                        controller: inchats,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter something";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Chats",
                          hintStyle: TextStyle(fontSize: 20),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15)),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  height: 60,
                  color: Colors.black12,
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
                  child: Icon(Icons.send),
                ),
              ),
            ],
          ),
          Text(
            "Loged in as ${user?.email}",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
