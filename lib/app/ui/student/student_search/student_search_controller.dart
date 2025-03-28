import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/models/student_model.dart';
import 'package:sunday_school_attendance/app/routes/app_routes.dart';
import 'package:sunday_school_attendance/app/services/student_service.dart';

class StudentSearchController extends GetxController {
  final studentService = StudentService();
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var isSearching = true.obs;

  final searchController = TextEditingController();

  var studentList = <StudentModel>[];
  var filteredStudentList = <StudentModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    final argument = Get.arguments;
    if (argument is List<StudentModel>) {
      studentList = argument;
      filteredStudentList.assignAll(studentList);
    }
    isLoading.value = false;
  }

  @override
  void onReady() {
    super.onReady();
    if (isSearching.value) {
      Get.focusScope?.requestFocus();
    }
  }

  Future<void> refreshPage() async {
    if (isLoading.value) return;
    isLoading.value = true;
    errorMessage.value = '';

    studentList = [];
    filteredStudentList.value = [];

    await fetchStudentList();
    Future.delayed(Duration(seconds: 2), () {
      isLoading.value = false;
    });
  }

  Future<void> fetchStudentList() async {
    isLoading.value = true;
    final result = await studentService.getStudentList();
    if (result.isSuccess && result.isNotEmpty) {
      studentList = result.data!;
      filteredStudentList.assignAll(studentList);
    }
    if (result.isEmpty) {
      errorMessage.value = 'Belum ada data!\nScroll ke bawah untuk refresh!';
    }
    if (result.isError) {
      errorMessage.value = result.message!;
    }
    isLoading.value = false;
  }

  void searchStudent(String input) {
    if (input.isEmpty) {
      filteredStudentList.assignAll(studentList);
    } else {
      filteredStudentList.assignAll(
        studentList.where((student) =>
            student.name.toLowerCase().contains(input.toLowerCase())),
      );
    }
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

  void toggleSearch() => isSearching.toggle();
}
