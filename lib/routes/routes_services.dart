import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_intro/ui/auth/forgot_password_screen.dart';
import 'package:firebase_intro/ui/auth/login_screen.dart';
import 'package:firebase_intro/ui/auth/login_with_phone.dart';
import 'package:firebase_intro/ui/auth/signup_screen.dart';
import 'package:firebase_intro/routes/routes_name.dart';
import 'package:firebase_intro/ui/auth/verify_phone_code.dart';
import 'package:firebase_intro/ui/posts/add_posts_screen.dart';
import 'package:firebase_intro/ui/posts/firestore/firestore_post_screen.dart';
import 'package:firebase_intro/ui/posts/posts_screen.dart';
import 'package:flutter/material.dart';

import '../ui/posts/firestore/firestore_add_posts_screen.dart';
import '../ui/splash_screen.dart';

class RoutesServices {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case RoutesNames.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RoutesNames.signup:
        return MaterialPageRoute(builder: (context) => const SignupScreen());
      case RoutesNames.posts:
        return MaterialPageRoute(builder: (context) => const PostsScreen());
      case RoutesNames.phoneLogin:
        return MaterialPageRoute(
            builder: (context) => const LoginWihtPhoneNumber());
      case RoutesNames.addPosts:
        return MaterialPageRoute(builder: (context) => const AddPostsScreen());
      case RoutesNames.firestorePosts:
        return MaterialPageRoute(
            builder: (context) => const FirestorePostScreen());

      case RoutesNames.firestoreaddPosts:
        return MaterialPageRoute(
            builder: (context) => const FirestoreAddPostScreen());
      case RoutesNames.forgotPassword:
        return MaterialPageRoute(
            builder: (context) => const ForgotPasswordScreen());

      default:
        return MaterialPageRoute(
            builder: (context) => const Scaffold(
                  body: Center(
                    child: Text("No Routes"),
                  ),
                ));
    }
  }
}
