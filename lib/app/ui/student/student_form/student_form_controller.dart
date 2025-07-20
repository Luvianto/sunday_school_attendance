import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/models/student_model.dart';
import 'package:sunday_school_attendance/app/services/student_service.dart';

class StudentFormController extends GetxController {
  final studentService = StudentService();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

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

  void saveStudents() async {
    if (isLoading.value) return;
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    final newStudent = StudentModel(
        id: student.id, name: nameController.text.trim(), status: true);

    final result = student.id != null
        ? await studentService.updateStudent(newStudent)
        : await studentService.addStudent(newStudent);
    if (result.isSuccess) {
      Get.back(result: true);
    }
    if (result.isError) {
      errorMessage.value = result.message!;
      Get.snackbar('Error', result.message!,
          snackPosition: SnackPosition.BOTTOM);
    }

    isLoading.value = false;
  }
}
