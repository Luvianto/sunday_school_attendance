import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/routes/app_routes.dart';
import 'package:sunday_school_attendance/app/ui/student/student_list/student_list_controller.dart';

class StudentMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (!Get.isRegistered<StudentListController>()) {
      return const RouteSettings(name: AppRoutes.home);
    }
    return null;
  }
}
