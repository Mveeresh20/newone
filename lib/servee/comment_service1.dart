import 'package:cloud_firestore/cloud_firestore.dart';

class CommentService1 {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getComments(String postId) {
    return _firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<void> addComment(
      String postId, String content, String authorId) async {
    await _firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add({
      'content': content,
      'author_id': authorId,
      'support_count': 0,
      'oppose_count': 0,
      'is_reported': false,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteComment(String postId, String commentId) async {
    await _firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .delete();
  }

  Future<void> reportComment(String postId, String commentId) async {
    await _firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .update({'is_reported': true});
  }
}
