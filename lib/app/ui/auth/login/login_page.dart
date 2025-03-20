import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/common/utilities/input_validator.dart';
import 'package:sunday_school_attendance/app/common/widgets/custom_button.dart';
import 'package:sunday_school_attendance/app/common/widgets/custom_label.dart';
import 'package:sunday_school_attendance/app/common/widgets/custom_text_form_field.dart';
import 'package:sunday_school_attendance/app/ui/auth/login/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        children: [
          const SizedBox(height: 80.0),
          //
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/app_icon.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          //
          const SizedBox(height: 80.0),
          //
          CustomLabel(label: 'Email'),
          CustomTextFormField(
            hintText: 'example@gmail.com',
            controller: controller.emailController,
            validator: emailValidator,
          ),
          //
          const SizedBox(height: 16.0),
          //
          CustomLabel(label: 'Kata sandi'),
          Obx(
            () => CustomTextFormField(
              hintText: 'Kata sandi Anda',
              controller: controller.passwordController,
              obscureText: controller.isPasswordVisible.value,
              validator: passwordValidator,
              suffixIcon: IconButton(
                onPressed: controller.togglePassword,
                icon: Icon(
                  controller.isPasswordVisible.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
              ),
            ),
          ),
          //
          const SizedBox(height: 24.0),
          //
          CustomButton(
            label: 'LOGIN',
            onPressed: controller.login,
          ),
          //
          const SizedBox(height: 36.0),
          //
          Text(
            'Belum memiliki akun? ',
            style: Get.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          GestureDetector(
            onTap: controller.toRegister,
            child: Text(
              'Daftar sekarang',
              textAlign: TextAlign.center,
              style: Get.textTheme.bodyLarge!
                  .copyWith(color: Get.theme.colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }
}
