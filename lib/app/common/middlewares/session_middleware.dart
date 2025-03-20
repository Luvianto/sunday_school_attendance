import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/pages/session/session_controller.dart';
import 'package:sunday_school_attendance/app/routes/app_routes.dart';

class SessionMiddleware extends GetMiddleware {
  // Middleware digunakan dalam app_routes.dart
  // Fungsinya, mencegah ganti halaman jika controller belum ada
  // Dalam kasus ini SessionController

  @override
  RouteSettings? redirect(String? route) {
    if (!Get.isRegistered<SessionController>()) {
      return const RouteSettings(name: AppRoutes.home);
    }
    return null;
  }
}
