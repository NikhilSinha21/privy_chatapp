import 'package:flutter/material.dart';
import 'package:privy_chat_chat_app/Frontend/Profile/Userprofile/user_profile.dart';
import 'package:privy_chat_chat_app/Frontend/Authentication/login.dart';
import 'package:privy_chat_chat_app/Frontend/Authentication/registration.dart';
import 'package:privy_chat_chat_app/Frontend/Homepage/homepage.dart';


import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Privy",
      debugShowCheckedModeBanner: false,

      initialRoute: '/',
      routes:  {
        '/' : (context) => const Login(),
         '/register' : (context) =>const Registration(),
          '/homepage' : (context) => const Homepage(),
          '/userprofile':(context) => const UserProfile(),
      },
    );
  }
}


