import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/models/enums.dart';
import 'package:sunday_school_attendance/app/models/user_model.dart';
import 'package:sunday_school_attendance/app/routes/app_routes.dart';
import 'package:sunday_school_attendance/app/services/auth_service.dart';
import 'package:sunday_school_attendance/app/ui/auth/login/login_controller.dart';

class RegisterController extends GetxController {
  final loginController = Get.find<LoginController>();
  final authService = AuthService();

  var isLoading = false.obs;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
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
    );

    if (result.isSuccess) {
      createUserData(result.data!);
    } else {
      Get.snackbar('Error!', result.message ?? 'Error tidak diketahui');
      isLoading.value = false;
    }
  }

  void createUserData(User user) async {
    final newUser = UserModel(
      id: user.uid,
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      role: role,
    );

    final result = await authService.addUser(newUser);

    if (result.isSuccess) {
      Get.offAllNamed(AppRoutes.home, arguments: newUser);
    } else {
      Get.snackbar('Error!', result.message ?? 'Error tidak diketahui');
      isLoading.value = false;
    }
  }
}
