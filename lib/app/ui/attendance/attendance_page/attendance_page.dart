import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/common/widgets/custom_card.dart';
import 'package:sunday_school_attendance/app/common/widgets/custom_loading.dart';
import 'package:sunday_school_attendance/app/ui/attendance/attendance_page/attendance_controller.dart';

class AttendancePage extends GetView<AttendanceController> {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.refreshPage,
      child: Stack(
        children: [
          Obx(() {
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: controller.attendanceList
                  .map((attendance) => CustomCard(
                        title: attendance.timestamp.toString(),
                        subtitle: attendance.timestamp.toString(),
                        onTap: () => controller.toDetail(attendance),
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
    );
  }
}
