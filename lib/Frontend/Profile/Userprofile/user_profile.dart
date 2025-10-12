import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Privy/AppName/app_name.dart';
import 'package:Privy/Backend/auth_service.dart';
import 'package:Privy/Frontend/Homepage/backgroundforsetting.dart';
import 'package:Privy/Frontend/Things/app_text_style.dart';
import 'package:Privy/Frontend/Things/color.dart';
import 'package:Privy/Frontend/Things/text_names.dart';

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
                      // Navigation on successful sign out
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/',
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 254, 90, 78)),
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
                    TextSpan(text: " \nyour Account", style: AppTextStyle.username),
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
                      Navigator.pop(context); // Close bottom sheet
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
                              const SnackBar(content: Text("No authenticated user found or email is missing.")),
                            );
                            return;
                        }

                        // **FIX: Re-authenticate user before deletion**
                        final AuthCredential credential = EmailAuthProvider.credential(
                          email: user.email!,
                          password: passwordController.text,
                        );

                        await user.reauthenticateWithCredential(credential);

                        // If re-authentication succeeds, proceed to delete the account
                        await authService.value.deleteAccount(
                          email: user.email!,
                          password: passwordController.text,
                        );

                        // **SUCCESS CASE: Show Snackbar and Navigate**
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Account deleted successfully."),
                          ),
                        );

                        // Navigate to login screen
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/',
                          (route) => false,
                        );
                      } on FirebaseAuthException catch (e) {
                        // **ERROR CASE: Show Snackbar and DO NOT Navigate**
                        String message = "Failed to delete account";
                        if (e.code == 'wrong-password') {
                          message = "Incorrect password, please try again.";
                        } else if (e.code == 'requires-recent-login') {
                          message = "Please sign in again before deleting your account.";
                        }
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(message)),
                        );
                      } catch (e) {
                        // **GENERIC ERROR CASE: Show Snackbar and DO NOT Navigate**
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Something went wrong: $e")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 254, 90, 78)),
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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: SafeArea(
        child: Stack(
          children: [
            const Backgroundforsetting(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, right: 10, left: 20),
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
                Expanded(
                  child: SingleChildScrollView(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 50),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  AssetImage("assets/images/user_logo.png"),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(TextNames.username,
                                    style: AppTextStyle.settingusername),
                                Text(TextNames.userid,
                                    style: AppTextStyle.timedate),
                              ],
                            ),
                            Spacer(),
                            SizedBox(width: 12),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Divider(),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: askForSignOut,
                          child: const Text(
                            "Sign out",
                            style: AppTextStyle.username,
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: askForAccountDelete,
                          child: const Text(
                            "Delete account",
                            style: AppTextStyle.username,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}