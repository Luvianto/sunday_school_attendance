import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/models/attendance_model.dart';
import 'package:sunday_school_attendance/app/models/student_attendance_model.dart';
import 'package:sunday_school_attendance/app/models/student_model.dart';
import 'package:sunday_school_attendance/app/services/attendance_service.dart';
import 'package:sunday_school_attendance/app/services/student_attendance_service.dart';
import 'package:sunday_school_attendance/app/services/student_service.dart';

class AttendanceFormController extends GetxController {
  final studentService = StudentService();
  final attendanceService = AttendanceService();
  final studentAttendanceService = StudentAttendanceService();

  var isLoading = true.obs;
  var errorMessage = ''.obs;

  var studentList = <StudentModel>[].obs;
  var selectedStudents = <StudentModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchStudentList();
    isLoading.value = false;
  }

  Future<void> refreshPage() async {
    isLoading.value = true;
    errorMessage.value = '';

    selectedStudents.clear();
    studentList.clear();
    await fetchStudentList();

    Future.delayed(Duration(seconds: 2), () {
      isLoading.value = false;
    });
  }

  Future<void> fetchStudentList() async {
    final result = await studentService.getStudentList();
    if (result.isSuccess && result.isNotEmpty) {
      studentList.value = result.data!;
    } else {
      errorMessage.value = result.message!;
    }
  }

  void selectStudent(StudentModel student) {
    final newSelectedStudents = selectedStudents;
    if (newSelectedStudents.contains(student)) {
      newSelectedStudents.remove(student);
    } else {
      newSelectedStudents.add(student);
    }
    selectedStudents = newSelectedStudents;
  }

  bool isSelected(StudentModel student) {
    return selectedStudents.contains(student);
  }

  void saveAttendance() async {
    final batch = FirebaseFirestore.instance.batch();

    try {
      final docRef = FirebaseFirestore.instance
          .collection(attendanceService.collectionName)
          .doc();
      final attendance = AttendanceModel(
        timestamp: Timestamp.now(),
      );
      batch.set(docRef, attendance.toFirestore());
      for (final student in selectedStudents) {
        final studentAttendanceRef = FirebaseFirestore.instance
            .collection(studentAttendanceService.collectionName)
            .doc();

        final studentAttendance = StudentAttendanceModel(
          id: studentAttendanceRef.id,
          studentId: student.id!,
          attendanceId: docRef.id,
        );

        batch.set(studentAttendanceRef, studentAttendance.toFirestore());
      }
      await batch.commit();
      Get.back();
    } catch (e) {
      Get.snackbar('Error', 'Mohon coba kembali nanti',
          snackPosition: SnackPosition.BOTTOM);
      debugPrint('attendance_form_controller/saveAttendance: $e');
    }
  }
}
