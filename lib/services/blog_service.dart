import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BlogService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Save blog post
  Future<void> saveBlogPost(String title, String content) async {
    User? user = _auth.currentUser;

    if (user != null) {
      Map<String, dynamic> post = {
        'title': title,
        'content': content,
        'userId': user.uid,
        'createdAt': FieldValue.serverTimestamp(),
      };

      await _firestore
          .collection('posts')
          .add(post)
          .then((_) => print("Blog post saved successfully"))
          .catchError((error) => print("Failed to save blog post: $error"));
    } else {
      print("No user is signed in.");
    }
  }

  // Get all posts
  Stream<List<Map<String, dynamic>>> getAllPosts() {
    return _firestore.collection('posts').snapshots().map(
          (querySnapshot) =>
              querySnapshot.docs.map((doc) => doc.data()).toList(),
        );
  }
}
