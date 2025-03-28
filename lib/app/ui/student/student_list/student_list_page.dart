import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/common/widgets/custom_card.dart';
import 'package:sunday_school_attendance/app/common/widgets/custom_loading.dart';
import 'package:sunday_school_attendance/app/ui/student/student_list/student_list_controller.dart';

class StudentListPage extends GetView<StudentListController> {
  const StudentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.refreshPage,
      child: Stack(
        children: [
          Obx(() {
            if (controller.isLoading.value) {
              return const SizedBox.shrink();
            }
            if (controller.errorMessage.value.isNotEmpty) {
              return const SizedBox.shrink();
            }
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: controller.studentList
                  .map((student) => CustomCard(
                        title: student.name,
                        subtitle: student.name,
                        onTap: () => controller.toDetail(student),
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
