import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_intro/routes/routes_name.dart';
import 'package:flutter/material.dart';

import '../ui/auth/login_screen.dart';

class SplashServices {
  void isLogin(BuildContext context) async {
    await Firebase.initializeApp();

    FirebaseAuth _auth = FirebaseAuth.instance;

    final currentUser = _auth.currentUser;

    // Timer(const Duration(seconds: 5), () {
    //   Navigator.pushNamed(context, RoutesNames.posts);
    // });

    if (currentUser != null) {
      Timer(const Duration(seconds: 5), () {
        Navigator.pushNamed(context, RoutesNames.firestorePosts);
      });
    } else {
      Timer(const Duration(seconds: 5), () {
        Navigator.pushNamed(context, RoutesNames.login);
      });
    }
  }
}
