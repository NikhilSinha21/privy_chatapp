import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostService {

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

Future<void> createPost(String text) async{
final user = _auth.currentUser!;

final post = {
  "senderId" : user.uid,
  "text" : text,
  "timestamp" : FieldValue.serverTimestamp() 
};

await _firestore.collection("posts").add(post);
}

Stream<QuerySnapshot> getpost (){
 return _firestore.collection("posts").orderBy("timestamp",descending: true).snapshots();
}


}