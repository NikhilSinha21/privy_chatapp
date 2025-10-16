import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PresenceServer {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> initialize() async {
    final user = _auth.currentUser;
    if (user == null) return;

    // Mark user online when app starts
    await _firestore.collection("users").doc(user.uid).update({
      "isOnline": true,
      "lastActive": FieldValue.serverTimestamp(),
    });

    // Mark offline when app goes to background or closed
    _auth.userChanges().listen((user) async {
      if (user == null) return;
      await _firestore.collection("users").doc(user.uid).update({
        "isOnline": true,
        "lastActive": FieldValue.serverTimestamp(),
      });
    });
  }

  Future<void> markOffline() async {
    final user = _auth.currentUser;
    if (user == null) return;
    await _firestore.collection("users").doc(user.uid).update({
      "isOnline": false,
      "lastActive": FieldValue.serverTimestamp(),
    });
  }

  Stream<bool> userOnlineStatus(String uid) {
    return _firestore.collection("users").doc(uid).snapshots().map((doc) {
      if (!doc.exists) return false;
      return (doc.data()?["isOnline"] ?? false) as bool;
    });
  }
}
