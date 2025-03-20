import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/models/session_model.dart';
import 'package:sunday_school_attendance/app/services/attendance_service.dart';

class AttendanceFormController extends GetxController {
  final attendanceService = AttendanceService();
  SessionModel? attendance;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAttendance();
  }

  void fetchAttendance() {
    final arguments = Get.arguments;
    if (arguments is SessionModel) {
      attendance = arguments;
      nameController.text = attendance!.name;
    }
    isLoading.value = false;
  }

  void saveAttendance() async {
    try {
      // final newAttendance = SessionModel(
      //   id: attendance?.id,
      //   name: nameController.text,

      // );

      // if (session != null && session!.id != null) {
      //   await sessionService.updateSession(newSession);
      // } else {
      //   await sessionService.addSession(newSession);
      // }

      Get.back(result: true);
    } catch (e) {
      print('saveSession: $e');
      throw e.toString();
    }
  }
}
