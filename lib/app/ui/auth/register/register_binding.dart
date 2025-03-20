import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/ui/auth/register/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
