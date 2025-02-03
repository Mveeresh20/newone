import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostService1 {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to fetch post details
  Stream<DocumentSnapshot> getPost(String postId) {
    return _firestore.collection('posts').doc(postId).snapshots();
  }

  // Function to create a new post
  Future<void> createPost({
    required String title,
    required String content,
    required String category,
    required List<String> tags,
    bool enableComments = true,
  }) async {
    String userId = _auth.currentUser!.uid;

    await _firestore.collection('posts').add({
      'title': title,
      'content': content,
      'category': category,
      'tags': tags,
      'author_id': userId,
      'timestamp': FieldValue.serverTimestamp(),
      'enable_comments': enableComments,
    });
  }

  // Function to delete a post
  Future<void> deletePost(String postId) async {
    String userId = _auth.currentUser!.uid;

    DocumentSnapshot post = await _firestore.collection('posts').doc(postId).get();
    if (post['author_id'] != userId) {
      throw Exception('You can only delete your own posts');
    }

    await _firestore.collection('posts').doc(postId).delete();
  }
}

