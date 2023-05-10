import 'package:firebase_intro/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../components/round_button.dart';
import '../../provider/loading_provider.dart';
import '../../routes/routes_name.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

final formKey2 = GlobalKey<FormState>();
FirebaseAuth _auth = FirebaseAuth.instance;

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final loadingObj = Provider.of<LoadingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('SignUp'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: formKey2,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          hintText: "Email", prefixIcon: Icon(Icons.email)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Your Email";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          hintText: "Password", prefixIcon: Icon(Icons.lock)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Your password";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                )),
            RoundButton(
              buttonText: 'SignUp',
              onPress: () {
                loadingObj.setLoading(true);
                formKey2.currentState!.validate();
                _auth
                    .createUserWithEmailAndPassword(
                        email: emailController.text.toString(),
                        password: passwordController.text.toString())
                    .then((value) {
                  loadingObj.setLoading(false);
                  Navigator.pushNamed(context, RoutesNames.posts);
                }).onError((error, stackTrace) {
                  loadingObj.setLoading(false);

                  Utils().showToast(error.toString());
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have account?"),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesNames.login);
                    },
                    child: Text("Log In"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
