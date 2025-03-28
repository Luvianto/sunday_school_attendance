import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/models/student_model.dart';
import 'package:sunday_school_attendance/app/routes/app_routes.dart';
import 'package:sunday_school_attendance/app/services/student_service.dart';

class StudentListController extends GetxController {
  final studentService = StudentService();

  var isLoading = true.obs;
  var isSearching = false.obs;
  var errorMessage = ''.obs;

  var studentList = <StudentModel>[].obs;

  final searchController = TextEditingController();

  void toggleSearch() {
    isSearching.toggle();
  }

  @override
  void onInit() async {
    super.onInit();
    await fetchStudentList();
  }

  Future<void> refreshPage() async {
    if (isLoading.value) return;
    studentList.value = [];
    errorMessage.value = '';
    isLoading.value = true;
    await fetchStudentList();
    Future.delayed(Duration(seconds: 2), () {
      isLoading.value = false;
    });
  }

  void toDetail(StudentModel selectedStudent) {
    if (isLoading.value) return;
    Get.toNamed(
      AppRoutes.student,
      arguments: selectedStudent,
    )?.then((result) {
      if (result == true) {
        fetchStudentList();
      }
    });
  }

  void toSearch() {
    if (isLoading.value) return;
    Get.toNamed(
      AppRoutes.student + AppRoutes.search,
      arguments: studentList,
    );
  }

  void openForm() {
    if (isLoading.value) return;
    Get.toNamed(AppRoutes.student + AppRoutes.form)?.then((result) {
      if (result == true) {
        fetchStudentList();
      }
    });
  }

  Future<void> fetchStudentList() async {
    isLoading.value = true;
    final result = await studentService.getStudentList();
    if (result.isSuccess && result.isNotEmpty) {
      studentList.value = result.data!;
    }
    if (result.isEmpty) {
      errorMessage.value = 'Belum ada data!\nScroll ke bawah untuk refresh!';
    }
    if (result.isError) {
      errorMessage.value = result.message!;
    }
    isLoading.value = false;
  }
}
