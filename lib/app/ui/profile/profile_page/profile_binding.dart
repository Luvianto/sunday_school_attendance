import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/ui/profile/profile_page/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
