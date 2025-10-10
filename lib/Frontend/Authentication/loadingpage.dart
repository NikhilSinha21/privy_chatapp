import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:privy_chat_chat_app/AppName/app_name.dart';

class Loadingpage extends StatefulWidget {
  const Loadingpage({super.key});

  @override
  State<Loadingpage> createState() => _LoadingpageState();
}

class _LoadingpageState extends State<Loadingpage> {
  bool _hasChecked = false; // prevent duplicate navigation

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_hasChecked) {
      _hasChecked = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _checkLogin();
      });
    }
  }

  Future<void> _checkLogin() async {
    final user = FirebaseAuth.instance.currentUser;

    // Add a short delay (optional, smoother transition)
    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return; // make sure widget is still active

    if (user != null) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/homepage',
        (Route<dynamic> route) => false,
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/',
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: AppName.appname, // your unchanged UI
        ),
      ),
    );
  }
}
