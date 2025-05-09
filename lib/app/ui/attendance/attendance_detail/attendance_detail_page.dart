import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/common/widgets/page_layout.dart';
import 'package:sunday_school_attendance/app/ui/attendance/attendance_detail/attendance_detail_controller.dart';

class AttendanceDetailPage extends GetView<AttendanceDetailController> {
  const AttendanceDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      backInvoked: controller.closePage,
      menuItems: [
        PopupMenuItem(
          onTap: controller.openForm,
          child: Row(
            children: [
              Icon(
                Icons.edit_outlined,
                color: Get.theme.colorScheme.outline,
              ),
              const SizedBox(width: 12.0),
              Text(
                'Edit',
                style: Get.theme.textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        PopupMenuItem(
          onTap: controller.deleteAttendance,
          child: Row(
            children: [
              Icon(
                Icons.delete_outline,
                color: Get.theme.colorScheme.error,
              ),
              const SizedBox(width: 12.0),
              Text(
                'Delete',
                style: Get.theme.textTheme.bodyLarge!.copyWith(
                  color: Get.theme.colorScheme.error,
                ),
              ),
            ],
          ),
        )
      ],
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          if (controller.errorMessage.isNotEmpty) {
            return Center(child: Text(controller.errorMessage.value));
          }
          if (controller.attendance.value == null) {
            return Center(child: Text('Data tidak ditemukan!'));
          }
          return RefreshIndicator(
            onRefresh: controller.refreshPage,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                Text(
                  controller.attendance.value!.sessionType.name,
                  style: Get.theme.textTheme.headlineLarge,
                ),
                //
                SizedBox(height: 4.0),
                //
                Row(
                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      color: Get.theme.colorScheme.onSurfaceVariant,
                      size: 16.0,
                    ),
                    SizedBox(width: 6.0),
                    Text(
                      '08.00 - 10.00',
                      style: Get.theme.textTheme.bodyLarge!.copyWith(
                        color: Get.theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
