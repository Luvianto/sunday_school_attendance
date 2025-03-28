import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/models/student_model.dart';
import 'package:sunday_school_attendance/app/services/student_service.dart';

class StudentEditController extends GetxController {
  final studentService = StudentService();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  var isLoading = false.obs;

  late StudentModel student;

  @override
  void onInit() {
    super.onInit();
    final argument = Get.arguments;
    if (argument is StudentModel) {
      student = argument;
      nameController.text = student.name;
    }
  }

  void editStudent() async {
    isLoading.value = true;
    final newStudent = StudentModel(id: student.id, name: nameController.text);
    final result = await studentService.updateStudent(newStudent);
    if (result.isSuccess) {
      Get.back(result: true);
    }
    isLoading.value = false;
  }
}
