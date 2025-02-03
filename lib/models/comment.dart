import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String commentId;
  final String postId;
  final String authorId;
  final String content;
  final int supportCount;
  final int opposeCount;
  final DateTime createdAt;

  CommentModel({
    required this.commentId,
    required this.postId,
    required this.authorId,
    required this.content,
    required this.supportCount,
    required this.opposeCount,
    required this.createdAt,
  });

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      commentId: map['comment_id'],
      postId: map['post_id'],
      authorId: map['author_id'],
      content: map['content'],
      supportCount: map['support_count'],
      opposeCount: map['oppose_count'],
      createdAt: (map['created_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'comment_id': commentId,
      'post_id': postId,
      'author_id': authorId,
      'content': content,
      'support_count': supportCount,
      'oppose_count': opposeCount,
      'created_at': createdAt,
    };
  }
}


