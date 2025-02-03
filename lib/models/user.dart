import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  final String anonymousName;
  final DateTime createdAt;

  UserModel(
      {required this.userId,
      required this.anonymousName,
      required this.createdAt});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['user_id'],
      anonymousName: map['anonymous_name'],
      createdAt: (map['created_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'anonymous_name': anonymousName,
      'created_at': createdAt,
    };
  }
}


