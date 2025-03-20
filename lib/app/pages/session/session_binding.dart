import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/pages/session/session_controller.dart';

class SessionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SessionController>(() => SessionController());
  }
}
