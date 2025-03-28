import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/common/widgets/custom_app_bar.dart';
import 'package:sunday_school_attendance/app/common/widgets/custom_loading.dart';
import 'package:sunday_school_attendance/app/common/widgets/custom_popup_menu_item.dart';
import 'package:sunday_school_attendance/app/ui/student/student_detail/student_detail_controller.dart';

class StudentDetailPage extends GetView<StudentDetailController> {
  const StudentDetailPage({super.key});

  List<PopupMenuEntry<String>> buildMenuItems() {
    return [
      CustomPopupMenuItem(
        value: 'edit',
        icon: Icons.edit_outlined,
        text: 'Edit',
        iconColor: Get.theme.colorScheme.outline,
      ),
      CustomPopupMenuItem(
        value: 'delete',
        icon: Icons.delete_outline,
        text: 'Delete',
        iconColor: Get.theme.colorScheme.error,
        textColor: Get.theme.colorScheme.error,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onBack: Get.back,
        title: Text('Profil Murid'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => buildMenuItems(),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: controller.refreshPage,
        child: Obx(() {
          if (controller.isLoading.value) {
            return const CustomLoading();
          }
          if (controller.errorMessage.value.isNotEmpty) {
            return Center(child: Text(controller.errorMessage.value));
          }
          return ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                        controller.student.value!.name,
                        style: Get.theme.textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(controller.student.value!.name),
                    ],
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
