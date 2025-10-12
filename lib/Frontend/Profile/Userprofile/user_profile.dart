import 'package:Privy/Backend/post_service.dart';
import 'package:Privy/Frontend/Profile/Userprofile/settingbuttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Privy/AppName/app_name.dart';
import 'package:Privy/Backend/auth_service.dart';
import 'package:Privy/Frontend/Things/app_text_style.dart';
import 'package:Privy/Frontend/Things/color.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool _isMenuOpen = false;

  void toggleMenu() {
    setState(() => _isMenuOpen = !_isMenuOpen);
  }

  void askForSignOut() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 200,
          decoration: const BoxDecoration(
            gradient: myGradient,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Are you sure you want to log out?",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/',
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 254, 90, 78)),
                    child: const Text(
                      "Log out",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void askForAccountDelete() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 200,
          decoration: const BoxDecoration(
            gradient: myGradient,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                        text: "Are you sure you want to",
                        style: AppTextStyle.username),
                    TextSpan(text: " Delete", style: AppTextStyle.Delete),
                    TextSpan(
                        text: " \nyour Account",
                        style: AppTextStyle.username),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      final passwordController = TextEditingController();

                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Confirm Password"),
                            content: TextField(
                              controller: passwordController,
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                              onSubmitted: (_) => Navigator.pop(context, true),
                              decoration: const InputDecoration(
                                hintText: "Enter your password",
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text("Confirm"),
                              ),
                            ],
                          );
                        },
                      );

                      if (confirmed != true) return;

                      try {
                        final user = FirebaseAuth.instance.currentUser;
                        if (user == null || user.email == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "No authenticated user found or email is missing.")),
                          );
                          return;
                        }

                        final AuthCredential credential =
                            EmailAuthProvider.credential(
                          email: user.email!,
                          password: passwordController.text,
                        );

                        await user.reauthenticateWithCredential(credential);

                        await authService.value.deleteAccount(
                          email: user.email!,
                          password: passwordController.text,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Account deleted successfully."),
                          ),
                        );

                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/',
                          (route) => false,
                        );
                      } on FirebaseAuthException catch (e) {
                        String message = "Failed to delete account";
                        if (e.code == 'wrong-password') {
                          message = "Incorrect password, please try again.";
                        } else if (e.code == 'requires-recent-login') {
                          message =
                              "Please sign in again before deleting your account.";
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(message)),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("Something went wrong: $e")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 254, 90, 78)),
                    child: const Text(
                      "Delete",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = authService.value.currentUser;

    return FutureBuilder(
      future:
          FirebaseFirestore.instance.collection('users').doc(user?.uid).get(),
      builder: (context, snapshot) {
        String username = "Loading...";

        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data!.exists) {
            final data = snapshot.data!.data() as Map<String, dynamic>;
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
                  margin:
                      const EdgeInsets.only(top: 10, right: 10, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Image.asset(
                          "assets/images/backward.png",
                          height: 45,
                          width: 45,
                        ),
                      ),
                      const Spacer(),
                      AppName.appname,
                    ],
                  ),
                ),
                const Divider(color: messagecontainerColor),
                Expanded(
                  child: SingleChildScrollView(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 50),
                        Container(
                          padding:
                              const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const CircleAvatar(
                                radius: 35,
                                backgroundImage: AssetImage(
                                    "assets/images/user_logo.png"),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                children: [
                                  Settingbuttons.textsupportcolor(
                                      username,
                                      20,
                                      Colors.white,
                                      FontWeight.bold),
                                  
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
                          padding: const EdgeInsets.only(
                              left: 25, top: 15),
                          child: Column(
                            mainAxisAlignment:
                                MainAxisAlignment.start,
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Settingbuttons.text("Profile Update", 18),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 12, bottom: 15),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Settingbuttons.text(
                                        "Change Profile Pic", 16),
                                    const SizedBox(height: 8),
                                    Settingbuttons.text(
                                        "Change Name", 16),
                                    const SizedBox(height: 8),
                                    Settingbuttons.text(
                                        "Change Password", 16),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                  onTap: askForSignOut,
                                  child: Settingbuttons.text(
                                      "Sign Out", 18)),
                              const SizedBox(height: 15),
                              GestureDetector(
                                  onTap: askForAccountDelete,
                                  child: Settingbuttons
                                      .textsupportcolor(
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
  }
}