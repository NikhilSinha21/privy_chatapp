import 'package:Privy/Frontend/Profile/Userprofile/userprofiledataupdate.dart';
import 'package:flutter/material.dart';
import 'package:Privy/Frontend/Authentication/loadingpage.dart';
import 'package:Privy/Frontend/Profile/Userprofile/user_profile.dart';
import 'package:Privy/Frontend/Authentication/login.dart';
import 'package:Privy/Frontend/Authentication/registration.dart';
import 'package:Privy/Frontend/Homepage/homepage.dart';
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

      initialRoute: '/loading',
      routes:  {
        '/loading' : (context) =>  const Loadingpage(),
         '/' : (context) => const Login(),
         '/register' : (context) =>const Registration(),
          '/homepage' : (context) => const Homepage(),
          '/userprofile':(context) => const UserProfile(),
          '/userprofileupdataupdate' : (context) =>  const UserProfileDataUpdate()
      },
    );
  }
}


