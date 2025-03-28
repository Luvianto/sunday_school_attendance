import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/ui/student/student_search/student_search_controller.dart';

class StudentSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentSearchController>(() => StudentSearchController());
  }
}
