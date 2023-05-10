import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_intro/components/round_button.dart';
import 'package:firebase_intro/routes/routes_name.dart';
import 'package:firebase_intro/utils/utils.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

final auth = FirebaseAuth.instance;
final forgotController = TextEditingController();

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: forgotController,
              decoration: const InputDecoration(
                hintText: 'Add Email',
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            RoundButton(
                buttonText: 'Forgot',
                onPress: () {
                  auth
                      .sendPasswordResetEmail(
                          email: forgotController.text.toString())
                      .then((value) {
                    Utils().showToast("Password Reset Email Sent");
                    Navigator.pushNamed(context, RoutesNames.login);
                  }).onError((error, stackTrace) {
                    Utils().showToast(error.toString());
                  });
                })
          ],
        ),
      ),
    );
  }
}
