import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/ui/attendance/attendance_page/attendance_controller.dart';
import 'package:sunday_school_attendance/app/pages/session/session_controller.dart';
import 'package:sunday_school_attendance/app/pages/home/home_controller.dart';
import 'package:sunday_school_attendance/app/ui/profile/profile_page/profile_controller.dart';

class HomeBinding extends Bindings {
  // Controller dibuat berdasarkan jumlah "navigation"
  // variable yang ada di HomeController
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<AttendanceController>(() => AttendanceController());
    Get.lazyPut<SessionController>(() => SessionController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
