import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tp/auth/Login.dart';
import 'package:tp/auth/signup.dart';
import 'package:tp/homePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyC9lh3Dcic70vyKF4ilkGNumOXfXtKuTJo",
      appId: "1:613189428281:android:239435c772209f209459e8",
      messagingSenderId: "613189428281",
      projectId: "flutterfirbasetest-a087a",
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print(
          '================================= User is currently signed out!',
        );
      } else {
        print('================================== User is signed in!');
      }
    });
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firbase Test',
      debugShowCheckedModeBanner: false,

      home: (FirebaseAuth.instance.currentUser != null && FirebaseAuth.instance.currentUser!.emailVerified) ? Homepage() : Login(),

      routes: {
        "signup": (context) => Signup(),
        "login": (context) => Login(),
        "homePage": (context) => Homepage(),
      },
    );
  }
}
