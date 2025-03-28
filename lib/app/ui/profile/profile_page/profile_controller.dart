import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/models/user_model.dart';
import 'package:sunday_school_attendance/app/routes/app_routes.dart';
import 'package:sunday_school_attendance/app/services/auth_service.dart';

class ProfileController extends GetxController {
  final authService = AuthService();
  final profile = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    final argument = Get.arguments;
    if (argument is UserModel?) {
      profile.value = argument;
    }
  }

  void logout() async {
    final result = await authService.signOut();
    if (result.isSuccess) {
      Get.offAllNamed(AppRoutes.login);
    } else {
      Get.snackbar('Error!', result.message!);
    }
  }
}
