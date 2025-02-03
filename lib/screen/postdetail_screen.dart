import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techslave/servee/comment_service1.dart';
import 'package:techslave/servee/post_service1.dart';
import 'package:techslave/servee/vote_service1.dart';
// import 'PostService.dart';
// import 'CommentService.dart';
// import 'VoteService.dart';

class PostDetailScreen extends StatefulWidget {
  final String postId;

  PostDetailScreen({required this.postId});

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final PostService1 _postService = PostService1();
  final CommentService1 _commentService = CommentService1();
  final VoteService1 _voteService = VoteService1();

  late Stream<DocumentSnapshot> postStream;
  late Stream<QuerySnapshot> commentsStream;

  @override
  void initState() {
    super.initState();
    postStream = _postService.getPost(widget.postId);
    commentsStream = _commentService.getComments(widget.postId);
  }

  void _vote(String commentId, bool isSupport) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference commentRef = FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.postId)
        .collection('comments')
        .doc(commentId);

    DocumentSnapshot commentSnapshot = await commentRef.get();

    if (commentSnapshot.exists) {
      Map<String, dynamic> commentData =
          commentSnapshot.data() as Map<String, dynamic>;
      Map<String, dynamic> votes = commentData['votes'] ?? {};

      if (votes.containsKey(userId)) {
        
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('You can only vote once!')));
        return;
      }

    
      await commentRef.update({
        'votes.$userId': isSupport ? 'support' : 'oppose',
        'support_count': FieldValue.increment(isSupport ? 1 : 0),
        'oppose_count': FieldValue.increment(isSupport ? 0 : 1),
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Your vote has been recorded')));
    }
  }

  
  
  void _reportComment(String commentId) {
    _commentService.reportComment(widget.postId, commentId);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Comment reported')));
  }

  
  void _deleteComment(String commentId, String commentAuthorId) {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    if (currentUserId != commentAuthorId) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You can only delete your own comments')));
      return;
    }
    _commentService.deleteComment(widget.postId, commentId);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Comment deleted')));
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _commentController = TextEditingController();
    final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(title: Text('Post Details')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<DocumentSnapshot>(
              stream: postStream,
              builder: (context, postSnapshot) {
                if (!postSnapshot.hasData) return CircularProgressIndicator();

                var postData = postSnapshot.data!;
                var postTitle = postData['title'];
                var postContent = postData['content'];
                var postTags = List<String>.from(postData['tags']);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(postTitle,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text(postContent),
                    SizedBox(height: 16),
                    Text('Tags: ${postTags.join(', ')}'),
                    SizedBox(height: 16),
                  ],
                );
              },
            ),
            Divider(),

            // Comment Section
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                labelText: 'Add a comment...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _commentService.addComment(
                      widget.postId,
                      _commentController.text.trim(),
                      currentUserId,
                    );
                    _commentController.clear();
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            StreamBuilder<QuerySnapshot>(
              stream: commentsStream,
              builder: (context, commentsSnapshot) {
                if (!commentsSnapshot.hasData)
                  return CircularProgressIndicator();

                var commentsData = commentsSnapshot.data!.docs;

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: commentsData.length,
                  itemBuilder: (context, index) {
                    var commentData = commentsData[index];
                    String commentId = commentData.id;
                    String commentContent = commentData['content'];
                    int supportCount = commentData['support_count'];
                    int opposeCount = commentData['oppose_count'];
                    String commentAuthorId = commentData['author_id'];
                    bool isReported = commentData['is_reported'];

                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(commentContent),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.thumb_up),
                                  onPressed: () => _vote(commentId, true),
                                ),
                                Text('$supportCount'),
                                IconButton(
                                  icon: Icon(Icons.thumb_down),
                                  onPressed: () => _vote(commentId, false),
                                ),
                                Text('$opposeCount'),
                              ],
                            ),
                            if (isReported)
                              Text('This comment has been reported',
                                  style: TextStyle(color: Colors.red)),
                            if (commentAuthorId == currentUserId)
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () =>
                                    _deleteComment(commentId, commentAuthorId),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  
}

