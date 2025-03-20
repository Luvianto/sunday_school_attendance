import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/pages/session_detail/session_detail_controller.dart';

class SessionDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SessionDetailController>(() => SessionDetailController());
  }
}
