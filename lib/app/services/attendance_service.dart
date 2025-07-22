import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sunday_school_attendance/app/chore/handler/service_result.dart';
import 'package:sunday_school_attendance/app/chore/instance/firestore_instance.dart';
import 'package:sunday_school_attendance/app/models/attendance_model.dart';

class AttendanceService extends FirestoreInstance {
  final collectionName = 'attendances';

  Future<ServiceResult<List<AttendanceModel>>> getAttendanceList() async {
    return await getCollection(
      firestore.collection(collectionName).orderBy('timestamp').get(),
      AttendanceModel.fromFirestore,
    );
  }

  Future<ServiceResult<AttendanceModel>> getAttendance(
      String attendanceId) async {
    return await getDocument(
      firestore.collection(collectionName).doc(attendanceId).get(),
      AttendanceModel.fromFirestore,
    );
  }

  Future<ServiceResult<List<AttendanceModel>>> getAttendanceListByDate(
      DateTime date) async {
    final start = date;
    final end = start.add(Duration(days: 1));
    debugPrint(start.toString());
    return await getCollection(
      firestore
          .collection(collectionName)
          .orderBy('timestamp')
          .where('timestamp', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
          .where('timestamp', isLessThan: Timestamp.fromDate(end))
          .get(),
      AttendanceModel.fromFirestore,
    );
  }

  Future<ServiceResult> addAttendance(AttendanceModel attendance) async {
    return await addDocument(collectionName, attendance.toFirestore());
  }
}
