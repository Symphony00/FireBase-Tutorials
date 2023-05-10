import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_intro/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../components/round_button.dart';
import '../../provider/loading_provider.dart';
import '../../utils/utils.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({super.key, required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

FirebaseAuth _auth = FirebaseAuth.instance;
TextEditingController verifyCodeController = TextEditingController();

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  @override
  Widget build(BuildContext context) {
    final loadingObj = Provider.of<LoadingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Number"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            TextFormField(
              controller: verifyCodeController,
              decoration: InputDecoration(hintText: "Enter 6 digits Code"),
            ),
            const SizedBox(
              height: 50,
            ),
            RoundButton(
                buttonText: 'Verify',
                onPress: () async {
                  loadingObj.setLoading(true);
                  final credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: verifyCodeController.text.toString());
                  try {
                    await _auth.signInWithCredential(credential);
                  } catch (e) {
                    loadingObj.setLoading(false);
                  }
                  Navigator.pushNamed(context, RoutesNames.posts);
                })
          ],
        ),
      ),
    );
    ;
  }
}
