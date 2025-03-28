import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/ui/student/student_detail/student_detail_controller.dart';

class StudentDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentDetailController>(() => StudentDetailController());
  }
}
