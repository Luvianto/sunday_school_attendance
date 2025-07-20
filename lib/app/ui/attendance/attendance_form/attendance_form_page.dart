import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/common/widgets/attendance_card.dart';
import 'package:sunday_school_attendance/app/common/widgets/custom_loading.dart';
import 'package:sunday_school_attendance/app/common/widgets/page_layout.dart';
import 'package:sunday_school_attendance/app/ui/attendance/attendance_form/attendance_form_controller.dart';

class AttendanceFormPage extends GetView<AttendanceFormController> {
  const AttendanceFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: 'Absensi Baru',
      backInvoked: Get.back,
      body: RefreshIndicator(
        onRefresh: controller.refreshPage,
        child: Stack(
          children: [
            Obx(() {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: controller.studentList
                    .map((student) => AttendanceCard(
                          title: student.name,
                          onTap: () => controller.toggleStatus(student),
                        ))
                    .toList(),
              );
            }),
            Obx(() {
              if (controller.isLoading.value) {
                return CustomLoading();
              }
              return Center(
                child: Text(
                  controller.errorMessage.value,
                  textAlign: TextAlign.center,
                ),
              );
            })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.saveAttendance,
        child: Icon(Icons.save),
      ),
    );
  }
}
