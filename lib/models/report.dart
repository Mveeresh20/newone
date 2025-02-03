import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  final String reportId;
  final String contentId;
  final String reportType;
  final String reason;
  final DateTime reportedAt;

  ReportModel({
    required this.reportId,
    required this.contentId,
    required this.reportType,
    required this.reason,
    required this.reportedAt,
  });

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
      reportId: map['report_id'],
      contentId: map['content_id'],
      reportType: map['report_type'],
      reason: map['reason'],
      reportedAt: (map['reported_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'report_id': reportId,
      'content_id': contentId,
      'report_type': reportType,
      'reason': reason,
      'reported_at': reportedAt,
    };
  }
}
