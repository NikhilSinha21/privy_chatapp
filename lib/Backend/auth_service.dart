import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


ValueNotifier<AuthService> authService = ValueNotifier(AuthService());
class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

User? get currentUser => firebaseAuth.currentUser;


// Stream of auth state changes (login/logout)
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  Future<UserCredential> signIn ({
   
   required String email,
   required String password,
  })async{
    return await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }
  
  
  Future<UserCredential> createAccount ({
   
   required String email,
   required String password,
   required String name,
  })async{
    UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);


    //Storing UserData in Database
    await FirebaseFirestore.instance.collection("users").doc(userCredential.user!.uid).set({
      "name":name,
      "email":email,
      "createdAt": FieldValue.serverTimestamp(),
    });
   return userCredential;
  }
   
   Future<DocumentSnapshot> getUserData(String uid)async{
      
      return await FirebaseFirestore.instance.collection("users").doc(uid).get();
   }


   Future <void> updateUserData(String uid,Map<String, dynamic> data) {
    
    return FirebaseFirestore.instance.collection("users").doc(uid).update(data);
   }


  Future<void> signOut() async{
     await firebaseAuth.signOut();
  }

  Future<void> resetPassword({
    required String email
  })async{
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }
  Future <void> updateUserName({
    required String username,
  })async{
    await currentUser!.updateDisplayName(username);
  }
  Future<void>deleteAccount ({
    required String email,
    required String password,
  }) async{
    AuthCredential credential = EmailAuthProvider.credential(email:email , password : password);
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.delete();
    await firebaseAuth.signOut();

  }


  Future<void>resetPasswordfromcurrentPassword ({
    required String currentpassword,
    required String newpassword,
    required String email,
  }) async{
      AuthCredential credential = EmailAuthProvider.credential(email:email , password : currentpassword);
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.updatePassword(newpassword);

  }
}