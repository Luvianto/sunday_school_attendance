import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sunday_school_attendance/app/models/enums.dart';

class AttendanceModel {
  final String? id;
  final String studentId;
  final Timestamp timestamp;
  final SessionType sessionType;
  final AttendanceStatus status;

  // SessionType dan AttendanceStatus berupa enum
  // dan disimpan dalan bentuk String di firestore

  AttendanceModel({
    required this.id,
    required this.studentId,
    required this.timestamp,
    required this.sessionType,
    required this.status,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json, {String? id}) {
    return AttendanceModel(
      id: id,
      studentId: json['student_id'],
      timestamp: json['timestamp'],
      sessionType:
          SessionType.values.firstWhere((e) => e.name == json['sessionType']),
      status:
          AttendanceStatus.values.firstWhere((e) => e.name == json['status']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'timestamp': timestamp,
      'session_type': sessionType.name,
      'status': status.name,
    };
  }
}
