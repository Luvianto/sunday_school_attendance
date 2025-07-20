import 'dart:convert';

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
              children: controller.studentList
                  .map((student) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(student.name,
                              style: Theme.of(context).textTheme.bodyLarge),
                          leading: CircleAvatar(
                            radius: 32,
                            backgroundImage: student.profilePicture != null ||
                                    student.profilePicture!.isNotEmpty
                                ? MemoryImage(
                                    base64Decode(student.profilePicture!))
                                : null,
                            child: student.profilePicture == null ||
                                    student.profilePicture!.isEmpty
                                ? Text(student.name[0].toUpperCase())
                                : null,
                          ),
                          onTap: () => controller.toDetail(student),
                        ),
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
