import 'package:Privy/Backend/auth_service.dart';
import 'package:Privy/Backend/changeuserprofiledata.dart';
import 'package:Privy/Frontend/Homepage/logos.dart';
import 'package:Privy/Frontend/Homepage/message.dart';
import 'package:Privy/Frontend/Profile/Userprofile/settingbuttons.dart';
import 'package:Privy/Frontend/Things/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProfileDataUpdate extends StatefulWidget {
  const UserProfileDataUpdate({super.key});

  @override
  State<UserProfileDataUpdate> createState() => _UserProfileDataUpdateState();
}

class _UserProfileDataUpdateState extends State<UserProfileDataUpdate> {
  final AuthService auth = AuthService();
  final confirmChange = ChangeUserProfileData();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    final userId = auth.currentUser!.uid;
    return FirebaseFirestore.instance.collection('users').doc(userId).get();
  } 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(
                  child: Text("No user data found",
                      style: TextStyle(color: Colors.white)));
            }

            final data = snapshot.data!.data()!;
            nameController.text = data['name'] ?? '';
            usernameController.text = data['username'] ?? '';
            bioController.text = data['bio'] ?? '';
            emailController.text = data['email'] ?? '';

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Settingbuttons.returnbutton(context),
                        const SizedBox(width: 8),
                        Settingbuttons.textsupportcolor(
                          "Edit Profile",
                          20,
                          Colors.white,
                          FontWeight.bold,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Center(child: UserAvatar(radius: 35,)),
                    const SizedBox(height: 22),
                    Center(
                      child: Settingbuttons.textsupportcolor(
                        "Change profile picture",
                        16,
                        linkcolor,
                        FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Settingbuttons.textfield(
                        "Name", Colors.white,100,nameController),
                    const SizedBox(height: 15),
                    Settingbuttons.textfield(
                        "Username", Colors.white,100, usernameController),
                    const SizedBox(height: 15),
                    Settingbuttons.textfield(
                        "Bio", Colors.white,130,bioController),
                    const SizedBox(height: 15),
                    Settingbuttons.textfield(
                        "Email", Colors.white,100,emailController),
                    const SizedBox(height: 25),
                    Center(
                      child: ElevatedButton(
                        
                        onPressed:(){ confirmChange.confirmAndSave(
                          context,
                          nameController,
                          usernameController,
                          bioController,
                          emailController,
                          );},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: backgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              color: messagecontainerColor,
                              width: 2,
                            )
                          ),
                        ),
                        child: Settingbuttons.textsupportcolor("Save Changes",16,linkcolor,FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
