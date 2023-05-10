// In Firestore ==> Collection ==> DOc ==> data
// In Realtime Database ==> Root ==> Node ==> Node ==> data (TRee Structure)

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_intro/components/round_button.dart';
import 'package:firebase_intro/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../../provider/loading_provider.dart';

class FirestoreAddPostScreen extends StatefulWidget {
  const FirestoreAddPostScreen({super.key});

  @override
  State<FirestoreAddPostScreen> createState() => _FirestoreAddPostScreenState();
}

TextEditingController addPostsController = TextEditingController();

final postCollection = FirebaseFirestore.instance.collection('Posts');

class _FirestoreAddPostScreenState extends State<FirestoreAddPostScreen> {
  @override
  Widget build(BuildContext context) {
    final loadingObj = Provider.of<LoadingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Post to Firestore'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              maxLines: 4,
              controller: addPostsController,
              decoration: InputDecoration(
                  hintText: 'Write about your post here',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            const SizedBox(
              height: 30,
            ),
            RoundButton(
                buttonText: 'Add',
                onPress: () {
                  loadingObj.setLoading(true);
                  String id = DateTime.now().millisecondsSinceEpoch.toString();
                  postCollection.doc(id).set({
                    'id': id,
                    'desc': addPostsController.text.toString()
                  }).then((value) {
                    Utils().showToast('Post Added To Firestore');
                    loadingObj.setLoading(false);
                  }).onError((error, stackTrace) {
                    Utils().showToast(error.toString());
                    loadingObj.setLoading(false);
                  });
                })
          ],
        ),
      ),
    );
  }
}
