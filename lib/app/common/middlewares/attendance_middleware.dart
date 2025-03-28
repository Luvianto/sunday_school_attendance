import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/routes/app_routes.dart';
import 'package:sunday_school_attendance/app/ui/attendance/attendance_page/attendance_controller.dart';

class AttendanceMiddleware extends GetMiddleware {
  // Middleware digunakan dalam app_routes.dart
  // Fungsinya, mencegah ganti halaman jika controller belum ada
  // Dalam kasus ini AttendanceController

  @override
  RouteSettings? redirect(String? route) {
    if (!Get.isRegistered<AttendanceController>()) {
      return const RouteSettings(name: AppRoutes.home);
    }
    return null;
  }
}
