import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/models/user_model.dart';
import 'package:sunday_school_attendance/app/routes/app_routes.dart';
import 'package:sunday_school_attendance/app/services/auth_service.dart';

class ProfileController extends GetxController {
  final authService = AuthService();
  final profile = Rxn<UserModel>();

  void logout() async {
    final result = await authService.signOut();
    if (result.isSuccess) {
      // loginController.authUser = null;
      Get.offAllNamed(AppRoutes.login);
    } else {
      Get.snackbar('Error!', result.error!);
    }
  }
}
