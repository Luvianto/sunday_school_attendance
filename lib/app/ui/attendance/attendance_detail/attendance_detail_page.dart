import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/common/widgets/page_layout.dart';
import 'package:sunday_school_attendance/app/common/widgets/student_list_view.dart';
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
      body: RefreshIndicator(
        onRefresh: controller.refreshPage,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Obx(() {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  controller.attendance.value != null
                      ? controller.attendance.value!.timestamp.toString()
                      : 'Absensi',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              );
            }),
            const SizedBox(height: 8.0),
            Obx(() {
              if (controller.studentAttendanceList.isEmpty) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Center(
                    child: Text(controller.errorMessage.value),
                  ),
                );
              }
              return Column(
                children: controller.studentList
                    .map(
                      (student) => StudentListView(
                        studentName: student.name,
                        studentProfilePicture: student.profilePicture,
                        onTap: () {
                          controller.toDetail(student);
                        },
                      ),
                    )
                    .toList(),
              );
            }),
          ],
        ),
      ),
    );
  }
}
