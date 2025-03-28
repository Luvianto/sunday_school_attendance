import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/ui/student/student_edit/student_edit_controller.dart';

class StudentEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentEditController>(() => StudentEditController());
  }
}
