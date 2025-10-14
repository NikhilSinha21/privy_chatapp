import 'package:Privy/Backend/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class ChangeUserProfileData {
 final AuthService auth = AuthService();
 
 Future<void> updateUserData(
    BuildContext context,
    TextEditingController nameController,
    TextEditingController usernameController,
    TextEditingController bioController,
    TextEditingController emailController,
 ) async {
  try{
    final userId = auth.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'name': nameController.text.trim(),
      'username': usernameController.text.trim(),
      'bio': bioController.text.trim(),
      'email': emailController.text.trim(),
    });

    
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
  }
  catch(e){
    null;
  }
  
  }


   Future<void> confirmAndSave(

        context,
        nameController,
        usernameController,
        bioController,
        emailController,
   ) async {
    final shouldSave = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text(
          "Confirm Changes",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          "Are you sure you want to save these changes?",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel", style: TextStyle(color: Colors.redAccent)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Yes, Save", style: TextStyle(color: Colors.greenAccent)),
          ),
        ],
      ),
    );

    if (shouldSave == true) {
      final profileData = ChangeUserProfileData();
      await profileData.updateUserData(
        context,
        nameController,
        usernameController,
        bioController,
        emailController,

      );
    }
  }
}