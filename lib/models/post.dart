import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String postId;
  final String authorId;
  final String title;
  final String content;
  final String category;
  final List<String> tags;
  final DateTime createdAt;
  final bool isPoll;
  final List<String>? pollOptions;
  final Map<String, int>? pollResults;

  PostModel({
    required this.postId,
    required this.authorId,
    required this.title,
    required this.content,
    required this.category,
    required this.tags,
    required this.createdAt,
    this.isPoll = false,
    this.pollOptions,
    this.pollResults,
  });

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      postId: map['post_id'],
      authorId: map['author_id'],
      title: map['title'],
      content: map['content'],
      category: map['category'],
      tags: List<String>.from(map['tags']),
      createdAt: (map['created_at'] as Timestamp).toDate(),
      isPoll: map['is_poll'] ?? false,
      pollOptions: map['poll_options'] != null
          ? List<String>.from(map['poll_options'])
          : null,
      pollResults: map['poll_results'] != null
          ? Map<String, int>.from(map['poll_results'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'post_id': postId,
      'author_id': authorId,
      'title': title,
      'content': content,
      'category': category,
      'tags': tags,
      'created_at': createdAt,
      'is_poll': isPoll,
      'poll_options': pollOptions,
      'poll_results': pollResults,
    };
  }
}


