// import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_intro/provider/loading_provider.dart';
import 'package:firebase_intro/routes/routes_name.dart';
import 'package:firebase_intro/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/round_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

final formKey1 = GlobalKey<FormState>();
FirebaseAuth _auth = FirebaseAuth.instance;

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final loadingObj = Provider.of<LoadingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: formKey1,
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .04,
                    ),
                  ],
                )),
            RoundButton(
              buttonText: 'Login',
              onPress: () {
                loadingObj.setLoading(true);
                formKey1.currentState!.validate();
                _auth
                    .signInWithEmailAndPassword(
                        email: emailController.text.toString(),
                        password: passwordController.text.toString())
                    .then((value) {
                  loadingObj.setLoading(false);
                  Utils().showToast(value.user!.email.toString());

                  Navigator.pushNamed(context, RoutesNames.posts);
                }).onError((error, stackTrace) {
                  loadingObj.setLoading(false);

                  Utils().showToast(error.toString());
                });
              },
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesNames.forgotPassword);
                  },
                  child: const Text('Forgot Password?')),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesNames.signup);
                    },
                    child: const Text("Sign Up"))
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, RoutesNames.phoneLogin);
              },
              child: Container(
                height: MediaQuery.of(context).size.height * .06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.black)),
                child: const Center(child: Text("Login With Phone Number")),
              ),
            )
          ],
        ),
      ),
    );
  }
}
