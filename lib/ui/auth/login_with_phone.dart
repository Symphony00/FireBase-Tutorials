import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_intro/components/round_button.dart';
import 'package:firebase_intro/provider/loading_provider.dart';
import 'package:firebase_intro/routes/routes_name.dart';
import 'package:firebase_intro/ui/auth/verify_phone_code.dart';
import 'package:firebase_intro/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginWihtPhoneNumber extends StatefulWidget {
  const LoginWihtPhoneNumber({super.key});

  @override
  State<LoginWihtPhoneNumber> createState() => _LoginWihtPhoneNumberState();
}

FirebaseAuth _auth = FirebaseAuth.instance;
TextEditingController phoneNumberController = TextEditingController();

class _LoginWihtPhoneNumberState extends State<LoginWihtPhoneNumber> {
  @override
  Widget build(BuildContext context) {
    final loadingObj = Provider.of<LoadingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Login With Number"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              obscureText: true,
              controller: phoneNumberController,
              decoration: const InputDecoration(
                hintText: "+92 301 701 3327",
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            RoundButton(
                buttonText: 'Login',
                onPress: () {
                  loadingObj.setLoading(true);
                  _auth.verifyPhoneNumber(
                      phoneNumber: phoneNumberController.text.toString(),
                      verificationCompleted: (_) {
                        loadingObj.setLoading(false);
                      },
                      verificationFailed: (e) {
                        Utils().showToast(e.toString());
                        loadingObj.setLoading(false);
                      },
                      codeSent: (String verificationId, int? token) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VerifyCodeScreen(
                                    verificationId: verificationId)));
                        loadingObj.setLoading(false);
                      },
                      codeAutoRetrievalTimeout: (e) {
                        Utils().showToast(e);
                        loadingObj.setLoading(false);
                      });
                })
          ],
        ),
      ),
    );
  }
}
