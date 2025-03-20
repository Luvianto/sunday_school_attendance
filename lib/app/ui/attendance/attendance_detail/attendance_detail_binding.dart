import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/ui/attendance/attendance_detail/attendance_detail_controller.dart';

class AttendanceDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AttendanceDetailController>(() => AttendanceDetailController());
  }
}
