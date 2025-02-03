import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VoteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Save vote (upvote or downvote)
  Future<void> saveVote(String postId, String voteType) async {
    User? user = _auth.currentUser;

    if (user != null) {
      Map<String, dynamic> vote = {
        'postId': postId,
        'userId': user.uid,
        'voteType': voteType, // 'upvote' or 'downvote'
      };

      await _firestore.collection('votes').add(vote)
          .then((_) => print("Vote saved successfully"))
          .catchError((error) => print("Failed to save vote: $error"));
    } else {
      print("No user is signed in.");
    }
  }

  // Get the count of votes for a post (upvotes and downvotes)
  Stream<Map<String, int>> getVotesForPost(String postId) {
    return _firestore
        .collection('votes')
        .where('postId', isEqualTo: postId)
        .snapshots()
        .map((querySnapshot) {
      int upvotes = 0;
      int downvotes = 0;
      for (var doc in querySnapshot.docs) {
        if (doc['voteType'] == 'upvote') {
          upvotes++;
        } else if (doc['voteType'] == 'downvote') {
          downvotes++;
        }
      }
      return {'upvotes': upvotes, 'downvotes': downvotes};
    });
  }
}
