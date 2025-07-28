import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/common/widgets/custom_loading.dart';
import 'package:sunday_school_attendance/app/common/widgets/student_list_view.dart';
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
