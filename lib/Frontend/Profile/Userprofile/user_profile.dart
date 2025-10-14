import 'package:Privy/Backend/post_service.dart';
import 'package:Privy/Backend/user_settings_backend.dart';
import 'package:Privy/Frontend/Homepage/message.dart';
import 'package:Privy/Frontend/Profile/Userprofile/settingbuttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Privy/AppName/app_name.dart';
import 'package:Privy/Backend/auth_service.dart';
import 'package:Privy/Frontend/Things/color.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool _isMenuOpen = false;
  final PostService post = PostService();
  final usersetting =UserSettingsBackend();
  void toggleMenu() {
    setState(() => _isMenuOpen = !_isMenuOpen);
  }


  @override
  Widget build(BuildContext context) {
    final user = authService.value.currentUser;

    return FutureBuilder<String?>(
      future: post.bio, // Get bio from PostService
      builder: (context, bioSnapshot) {
        final bioText = bioSnapshot.data ?? "";

        return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance.collection('users').doc(user?.uid).get(),
          builder: (context, snapshot) {
            String username = "";
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data!.exists) {
                final data = snapshot.data!.data()!;
                username = data['name'] ?? user?.displayName ?? "Unknown";
              } else {
                username = user?.displayName ?? "Unknown";
              }
            }

            return Scaffold(
              backgroundColor: backgroundColor,
              body: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10, right: 10, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Settingbuttons.returnbutton(context),
                          const Spacer(),
                          AppName.appname,
                        ],
                      ),
                    ),
                    const Divider(color: messagecontainerColor),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 50),
                            Container(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const UserAvatarforgoingtosetting(),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 20,),
                                      Settingbuttons.textsupportcolor(
                                          username,
                                          20,
                                          Colors.white,
                                          FontWeight.bold),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width *0.6,
                                        child: Settingbuttons.textsupportcolor(
                                            bioText,
                                            12,
                                            Colors.white,
                                            FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  const SizedBox(width: 12),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Divider(),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: Settingbuttons.text("Settings", 25),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 25, top: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context,'/userprofileupdataupdate');
                                      },
                                      child: Settingbuttons.text("Profile Update", 18)),
                                  Container(
                                    padding: const EdgeInsets.only(left: 10, top: 12, bottom: 15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Settingbuttons.text("Change Profile Pic", 16),
                                        const SizedBox(height: 8),
                                        Settingbuttons.text("Change Name", 16),
                                        const SizedBox(height: 8),
                                        Settingbuttons.text("Change Password", 16),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: (){
                                        
                                        usersetting.askForSignOut(context);
                                      },
                                      child: Settingbuttons.text("Sign Out", 18)),
                                  const SizedBox(height: 15),
                                  GestureDetector(
                                      onTap:(){ usersetting.askForAccountDelete(context);},
                                      child: Settingbuttons.textsupportcolor(
                                          "Delete Account",
                                          18,
                                          deletecolor,
                                          FontWeight.bold)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
