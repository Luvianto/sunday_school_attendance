import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/models/user_model.dart';
import 'package:sunday_school_attendance/app/routes/app_routes.dart';
import 'package:sunday_school_attendance/app/services/auth_service.dart';

class LoginController extends GetxController {
  final authService = AuthService();

  var isLoading = true.obs;
  var errorMessage = ''.obs;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordVisible = true.obs;
  var authUser = Rxn<UserModel>();

  void togglePassword() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  @override
  void onInit() async {
    super.onInit();
    final result = await authService.isAuthenticated();
    if (result.isSuccess) {
      authUser.value = result.data;
    } else {
      errorMessage.value = result.error ?? 'Error tidak diketauhi';
    }
    isLoading.value = false;
  }

  void login() async {
    if (!formKey.currentState!.validate()) {
      return null;
    }

    isLoading.value = true;
    final result = await authService.signIn(
      emailController.text,
      passwordController.text,
    );
    if (result.isSuccess) {
      await fetchUserDetail(result.data!);
    } else {
      errorMessage.value = result.error ?? 'Error tidak diketauhi';
    }
    isLoading.value = false;
  }

  Future<void> fetchUserDetail(User user) async {
    final userDetail = await authService.getUserDetail(user.uid);
    if (userDetail.isSuccess) {
      authUser.value = userDetail.data;
      Get.offAllNamed(AppRoutes.home);
    } else {
      errorMessage.value = userDetail.error ?? 'Error tidak diketauhi';
    }
  }

  void toRegister() {
    Get.toNamed(AppRoutes.register);
  }
}
