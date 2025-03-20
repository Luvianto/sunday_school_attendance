import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/pages/session_form/session_form_controller.dart';

class SessionFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SessionFormController>(() => SessionFormController());
  }
}
