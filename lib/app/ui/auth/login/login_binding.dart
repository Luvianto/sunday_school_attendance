import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/ui/auth/login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
