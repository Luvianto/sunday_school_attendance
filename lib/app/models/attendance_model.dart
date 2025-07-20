import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceModel {
  final String? id;
  final Timestamp timestamp;

  AttendanceModel({
    this.id,
    required this.timestamp,
  });

  factory AttendanceModel.fromFirestore(Map<String, dynamic> json, String? id) {
    return AttendanceModel(
      id: id,
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'timestamp': timestamp,
    };
  }
}
