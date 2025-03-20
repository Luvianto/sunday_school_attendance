import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/pages/profile/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
