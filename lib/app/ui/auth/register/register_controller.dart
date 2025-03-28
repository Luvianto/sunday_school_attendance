import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/models/enums.dart';
import 'package:sunday_school_attendance/app/routes/app_routes.dart';
import 'package:sunday_school_attendance/app/services/auth_service.dart';
import 'package:sunday_school_attendance/app/ui/auth/login/login_controller.dart';

class RegisterController extends GetxController {
  final loginController = Get.find<LoginController>();
  final authService = AuthService();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  final role = UserRole.user; // Default role

  var isPasswordVisible = true.obs;

  void togglePassword() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void register() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;

    final result = await authService.signUp(
      emailController.text.trim(),
      passwordController.text.trim(),
      fullNameController.text.trim(),
      role,
    );

    if (result.isSuccess) {
      Get.offAllNamed(AppRoutes.home, arguments: result.data);
    } else {
      errorMessage.value = result.message ?? '';
    }

    isLoading.value = false;
  }
}
