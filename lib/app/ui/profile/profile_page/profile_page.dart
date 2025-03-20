import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/common/widgets/custom_button.dart';
import 'package:sunday_school_attendance/app/ui/profile/profile_page/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 40,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.profile.value!.fullName,
                    style: Get.theme.textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(controller.profile.value!.email),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          CustomButton(onPressed: () {}, label: 'Edit Profil'),
          const SizedBox(height: 16),
          CustomButton(
            onPressed: controller.logout,
            label: 'Logout',
            backgroundColor: Get.theme.colorScheme.error,
          ),
        ],
      ),
    );
  }
}
