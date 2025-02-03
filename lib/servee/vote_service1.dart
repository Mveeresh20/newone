import 'package:cloud_firestore/cloud_firestore.dart';

class VoteService1 {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Vote on a comment
  Future<void> voteOnComment(String postId, String commentId, bool isSupport) async {
    final commentRef = _firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId);

    final fieldToUpdate = isSupport ? 'support_count' : 'oppose_count';

    await commentRef.update({
      fieldToUpdate: FieldValue.increment(1),
    });
  }
}

