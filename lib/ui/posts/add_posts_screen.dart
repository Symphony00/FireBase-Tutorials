import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_intro/components/round_button.dart';
import 'package:firebase_intro/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../provider/loading_provider.dart';

class AddPostsScreen extends StatefulWidget {
  const AddPostsScreen({super.key});

  @override
  State<AddPostsScreen> createState() => _AddPostsScreenState();
}

TextEditingController addPostsController = TextEditingController();
final databaseRef = FirebaseDatabase.instance.ref('Posts');

class _AddPostsScreenState extends State<AddPostsScreen> {
  @override
  Widget build(BuildContext context) {
    final loadingObj = Provider.of<LoadingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Post'),
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
                  databaseRef.child(id).set({
                    'id': id,
                    'desc': addPostsController.text.toString(),
                  }).then((value) {
                    loadingObj.setLoading(false);
                    Utils().showToast('Post Added Succesfully');
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
