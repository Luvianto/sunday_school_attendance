import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/ui/attendance/attendance_form/attendance_form_controller.dart';

class AttendanceFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AttendanceFormController>(() => AttendanceFormController());
  }
}
