import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostService {

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

Future<void> createPost(String text) async{
final user = _auth.currentUser!;
final userDoc = await FirebaseFirestore.instance.collection("users").doc(user.uid).get();
final username = userDoc.data()?['name'] ?? "Unknown";
final post = {
  "senderId" : user.uid,
  "username": username,
  "text" : text,
  "timestamp" : FieldValue.serverTimestamp() 
};

await _firestore.collection("posts").add(post);
}

Stream<QuerySnapshot> getposts (){
 return _firestore.collection("posts").orderBy("timestamp",descending: false).snapshots();
}

Future<void> addReaction(String postId , String emoji ) async{

final userId = _auth.currentUser!.uid;

final query = await _firestore.collection("reaction").where("postId",isEqualTo: postId).where("emoji",isEqualTo: emoji).where("userId", isEqualTo: userId).get();


if(query.docs.isEmpty){
 
 await _firestore.collection("reaction").add({
  "postId": postId,
      "emoji": emoji,
      "userId": userId,
      "timestamp": FieldValue.serverTimestamp(),
  
 }); 
}
else {
    // Remove reaction if it exists (toggle)
     
    await _firestore.collection("reaction").doc(query.docs.first.id).delete();
  }
}

Stream<QuerySnapshot> getreaction (String postId){
  return _firestore.collection("reaction").where("postId", isEqualTo: postId).snapshots();
}

Future<void> deletePost(String postId) async {
  await FirebaseFirestore.instance.collection('posts').doc(postId).delete();
}



  /// Returns the current user's bio from Firestore
  Future<String?> get bio async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return null;

    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      return doc.data()?['bio'] as String?;
    } catch (e) {
      return null;
    }
  }
Stream<QuerySnapshot> getLatestPosts({int limit = 30}) {
  return _firestore
      .collection("posts")
      .orderBy("timestamp", descending: true)
      .limit(limit)
      .snapshots();
}

Future<List<QueryDocumentSnapshot>> getOlderPosts(Timestamp lastTime, {int limit = 20}) async {
  final query = await _firestore
      .collection("posts")
      .orderBy("timestamp", descending: true)
      .startAfter([lastTime])
      .limit(limit)
      .get();
  return query.docs;
}


}
