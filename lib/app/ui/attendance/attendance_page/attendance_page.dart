import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/common/widgets/custom_card.dart';
import 'package:sunday_school_attendance/app/common/widgets/page_layout.dart';
import 'package:sunday_school_attendance/app/ui/attendance/attendance_page/attendance_controller.dart';

class AttendancePage extends GetView<AttendanceController> {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }
        if (controller.attendanceList.isEmpty) {
          return Center(child: Text("Belum ada data!"));
        }
        return RefreshIndicator(
          onRefresh: controller.refreshPage,
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            children: controller.attendanceList.map(
              (attendance) {
                return CustomCard(
                  title: attendance.name,
                  subtitle: '${attendance.startTime} - ${attendance.endTime}',
                  onTap: () => controller.toDetail(attendance),
                );
              },
            ).toList(),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.openForm,
        child: Icon(Icons.add),
      ),
    );
  }
}
