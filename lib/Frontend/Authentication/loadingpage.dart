// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Privy/AppName/app_name.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

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
       _checkLoginAndConfig();
      });
    }
  }

  Future<void> _checkLoginAndConfig() async {
    final user = FirebaseAuth.instance.currentUser;
    final remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(fetchTimeout: Duration(seconds: 10),
      minimumFetchInterval: Duration(seconds: 0),
      ));
    await remoteConfig.fetchAndActivate();

    final showNewHomepage = remoteConfig.getBool('show_new_homepage');
    final jsonString = remoteConfig.getString('homepage_config');
    
    final Map<String, dynamic> config = jsonString.isNotEmpty ? json.decode(jsonString) : {};

    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return; // make sure widget is still active

    if (user != null) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        showNewHomepage ? '/homepagenew' : '/homepage',
        (Route<dynamic> route) => false,
        arguments: config,
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
