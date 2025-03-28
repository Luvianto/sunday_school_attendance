import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/routes/app_routes.dart';
import 'package:sunday_school_attendance/app/services/auth_service.dart';

class LoginController extends GetxController {
  final authService = AuthService();

  var isLoading = true.obs;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordVisible = true.obs;

  void togglePassword() {
    isPasswordVisible.toggle();
  }

  @override
  void onInit() async {
    super.onInit();
    final result = await authService.isAuthenticated();
    if (result.isEmpty) {
      isLoading.value = false;
    } else {
      Get.offAllNamed(AppRoutes.home, arguments: result.data);
    }
  }

  void login() async {
    if (!formKey.currentState!.validate()) return null;

    isLoading.value = true;
    final result = await authService.signIn(
      emailController.text,
      passwordController.text,
    );
    if (result.isNotEmpty) {
      await fetchUserDetail(result.data!);
    } else {
      Get.snackbar('Error!', result.message ?? 'Error tidak diketahui');
      isLoading.value = false;
    }
  }

  Future<void> fetchUserDetail(User user) async {
    final result = await authService.getUserDetail(user.uid);
    if (result.isNotEmpty) {
      Get.offAllNamed(AppRoutes.home, arguments: result.data);
    } else {
      Get.snackbar('Error!', result.message ?? 'Error tidak diketahui');
    }
  }

  void toRegister() {
    Get.toNamed(AppRoutes.register);
  }
}
