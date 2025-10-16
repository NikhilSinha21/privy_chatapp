import 'package:Privy/Backend/post_service.dart';
import 'package:Privy/Backend/user_settings_backend.dart';
import 'package:Privy/Frontend/Homepage/logos.dart';
import 'package:Privy/Frontend/Homepage/message.dart';
import 'package:Privy/Frontend/Profile/Userprofile/settingbuttons.dart';
import 'package:Privy/Frontend/Things/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Privy/AppName/app_name.dart';
import 'package:Privy/Backend/auth_service.dart';


class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool _isMenuOpen = false;
  final PostService post = PostService();
  final usersetting = UserSettingsBackend();

  void toggleMenu() {
    setState(() => _isMenuOpen = !_isMenuOpen);
  }

  @override
  Widget build(BuildContext context) {
    final user = authService.value.currentUser;

    return FutureBuilder<String?>(
      future: post.bio,
      builder: (context, bioSnapshot) {
        final bioText = bioSnapshot.data ?? "";

        return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future:
              FirebaseFirestore.instance.collection('users').doc(user?.uid).get(),
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
              body: Container(
                decoration: const BoxDecoration(
                 color: backgroundColor,
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Bar
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Settingbuttons.returnbutton(context),
                            AppName.appname,
                          ],
                        ),
                      ),

                      const Divider(color: Colors.white24),

                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 30),

                              // User Info Section
                              Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: messagecontainerColor,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const UserAvatar(radius: 40),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Settingbuttons.textsupportcolor(
                                            username,
                                            22,
                                            Colors.white,
                                            FontWeight.bold,
                                          ),
                                          const SizedBox(height: 6),
                                          Container(
                                            margin: const EdgeInsets.only(top: 4),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.08),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              bioText.isNotEmpty
                                                  ? bioText
                                                  : "No bio added yet",
                                              style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 13,
                                                fontStyle: FontStyle.italic,
                                                height: 1.4,
                                              ),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 30),
                              const Divider(color: Colors.white30),
                              const SizedBox(height: 15),

                              // Settings Header
                              Settingbuttons.text("Settings", 25),
                              const SizedBox(height: 20),

                              // Settings Options
                              Container(
                                decoration: BoxDecoration(
                                  color: messagecontainerColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                            '/userprofileupdataupdate');
                                      },
                                      child: Settingbuttons.textsupportcolor(
                                        "Profile Update",
                                        18,
                                        Colors.white,
                                        FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    GestureDetector(
                                      onTap: () {
                                        usersetting.askForSignOut(context);
                                      },
                                      child: Settingbuttons.textsupportcolor(
                                        "Sign Out",
                                        18,
                                        Colors.white,
                                        FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    GestureDetector(
                                      onTap: () {
                                        usersetting.askForAccountDelete(context);
                                      },
                                      child: Settingbuttons.textsupportcolor(
                                        "Delete Account",
                                        18,
                                        Colors.redAccent,
                                        FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 30),
                              Center(
                                child: Text(
                                  "Stay private, stay secure.",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 13,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
