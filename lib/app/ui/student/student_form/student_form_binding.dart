import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/ui/student/student_form/student_form_controller.dart';

class StudentFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentFormController>(() => StudentFormController());
  }
}
