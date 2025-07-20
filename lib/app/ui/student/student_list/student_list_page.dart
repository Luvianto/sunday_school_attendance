import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: controller.studentList
                  .map((student) => ListTile(
                        title: Text(student.name),
                        leading: CircleAvatar(
                          radius: 16,
                          // backgroundImage: student.profilePictureUrl != null ||
                          //         student.profilePictureUrl!.isNotEmpty
                          //     ? NetworkImage(student.profilePictureUrl!)
                          //     : null,
                          child: student.profilePictureUrl == null ||
                                  student.profilePictureUrl!.isEmpty
                              ? Text(student.name[0].toUpperCase())
                              : null,
                        ),
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
