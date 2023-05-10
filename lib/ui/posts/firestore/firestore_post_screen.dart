import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_intro/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../routes/routes_name.dart';

class FirestorePostScreen extends StatefulWidget {
  const FirestorePostScreen({super.key});

  @override
  State<FirestorePostScreen> createState() => _FirestorePostScreenState();
}

FirebaseAuth _auth = FirebaseAuth.instance;

final postStream = FirebaseFirestore.instance.collection('Posts').snapshots();
final searchController = TextEditingController();
final postCollection = FirebaseFirestore.instance.collection('Posts');

TextEditingController editController = TextEditingController();

class _FirestorePostScreenState extends State<FirestorePostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Posts from Firestore'),
          actions: [
            IconButton(
                onPressed: () {
                  _auth.signOut();
                  Navigator.pushNamed(context, RoutesNames.login);
                },
                icon: const Icon(Icons.logout_outlined))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              RoutesNames.firestoreaddPosts,
            );
          },
          child: const Icon(Icons.post_add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: 'Search',
                ),
                onChanged: (String value) {
                  setState(() {});
                },
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: postStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("Some Error");
                    } else {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              String title =
                                  snapshot.data!.docs[index]['desc'].toString();
                              String id =
                                  snapshot.data!.docs[index]['id'].toString();
                              if (searchController.text.toString().isEmpty) {
                                return ListTile(
                                  title: Text(snapshot.data!.docs[index]['desc']
                                      .toString()),
                                  subtitle: Text(snapshot
                                      .data!.docs[index]['id']
                                      .toString()),
                                  trailing:
                                      PopupMenuButton(itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                          child: ListTile(
                                        onTap: () {
                                          Navigator.pop(context);

                                          showMyDialog(
                                              title,
                                              snapshot.data!.docs[index]['id']
                                                  .toString());
                                        },
                                        title: const Text('Edit'),
                                        leading: const Icon(Icons.edit),
                                      )),
                                      PopupMenuItem(
                                          child: ListTile(
                                        onTap: () {
                                          postCollection.doc(id).delete();
                                          Navigator.pop(context);
                                        },
                                        title: Text('Delete'),
                                        leading: Icon(Icons.delete),
                                      ))
                                    ];
                                  }),
                                );
                              } else if (title.toLowerCase().contains(
                                  searchController.text
                                      .toLowerCase()
                                      .toString())) {
                                return ListTile(
                                  title: Text(snapshot.data!.docs[index]['desc']
                                      .toString()),
                                );
                              } else {
                                return Container();
                              }
                            }),
                      );
                    }
                  })
            ],
          ),
        ));
  }

  Future<void> showMyDialog(String oldDesc, String id) async {
    editController.text = oldDesc;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update'),
            content: Container(
              child: TextField(
                controller: editController,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    postCollection.doc(id).update(
                        {'desc': editController.text.toString()}).then((value) {
                      Utils().showToast("Updated");
                    }).onError((error, stackTrace) {
                      Utils().showToast(error.toString());
                    });
                  },
                  child: Text('Update'))
            ],
          );
        });
  }
}
