import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/common/widgets/custom_app_bar.dart';
import 'package:sunday_school_attendance/app/common/widgets/custom_card.dart';
import 'package:sunday_school_attendance/app/common/widgets/custom_loading.dart';
import 'package:sunday_school_attendance/app/common/widgets/custom_text_form_field.dart';
import 'package:sunday_school_attendance/app/ui/student/student_search/student_search_controller.dart';

class StudentSearchPage extends GetView<StudentSearchController> {
  const StudentSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(
          () => CustomAppBar(
            title: !controller.isSearching.value
                ? Text('Cari Murid')
                : CustomTextFormField(
                    autofocus: true,
                    hintText: 'Masukkan nama murid..',
                    controller: controller.searchController,
                    onChanged: controller.searchStudent,
                  ),
            onBack: !controller.isSearching.value
                ? Get.back
                : controller.toggleSearch,
            actions: !controller.isSearching.value
                ? [
                    IconButton(
                      onPressed: controller.toggleSearch,
                      icon: Icon(
                        Icons.search,
                        color: Get.theme.primaryColor,
                      ),
                    )
                  ]
                : [],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: controller.fetchStudentList,
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
                children: [
                  const SizedBox(height: 8.0),
                  ...controller.filteredStudentList.map(
                    (student) => CustomCard(
                      title: student.name,
                      subtitle: student.name,
                      onTap: () {},
                    ),
                  )
                ],
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
    );
  }
}
