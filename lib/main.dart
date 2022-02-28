import 'package:admin_app_grocery/screens/login_screen.dart';
import 'package:admin_app_grocery/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBXPVjFC8IRVeLDN6B_E2Y8RcdQpc1PGdg", // Your apiKey
      appId: "1:147156304764:web:96b516fa253cfea5da9af9", // Your appId
      messagingSenderId: "147156304764", // Your messagingSenderId
      projectId: "grocery-application-3329d", // Your projectId
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.deepPurple),
      title: "Grocery App Admin Dashboard",
    );
  }
}
