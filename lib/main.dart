import 'package:firebase_intro/provider/loading_provider.dart';
import 'package:firebase_intro/routes/routes_name.dart';
import 'package:firebase_intro/routes/routes_services.dart';
import 'package:firebase_intro/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => LoadingProvider())],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        initialRoute: RoutesNames.splash,
        onGenerateRoute: RoutesServices.generateRoutes,
      ),
    );
  }
}
