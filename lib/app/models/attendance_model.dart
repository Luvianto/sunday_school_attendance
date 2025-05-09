import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sunday_school_attendance/app/models/enums.dart';
import 'package:sunday_school_attendance/app/models/student_model.dart';

class AttendanceModel {
  final String? id;
  final Timestamp timestamp;
  final SessionType sessionType;
  final List<StudentModel> studentList;

  AttendanceModel({
    this.id,
    required this.timestamp,
    required this.sessionType,
    required this.studentList,
  });

  factory AttendanceModel.fromFirestore(Map<String, dynamic> json, String? id) {
    return AttendanceModel(
      id: id,
      timestamp: json['timestamp'],
      sessionType: SessionType.values.firstWhere(
        (e) => e.name == json['session_type'],
      ),
      studentList: (json['student_list'] as List)
          .map((student) => StudentModel.fromFirestore(student, student['id']))
          .toList(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'timestamp': timestamp,
      'session_type': sessionType.name,
      'student_list': studentList.map((e) => e.toFirestore()).toList()
    };
  }
}
