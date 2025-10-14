// ignore_for_file: use_build_context_synchronously

import 'package:Privy/Backend/auth_service.dart';
import 'package:Privy/Frontend/Things/app_text_style.dart';
import 'package:Privy/Frontend/Things/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserSettingsBackend {
  


    void askForSignOut(BuildContext context) async {
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







  void askForAccountDelete(BuildContext context) async {
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

}