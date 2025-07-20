import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/models/student_model.dart';
import 'package:sunday_school_attendance/app/services/student_service.dart';

class StudentFormController extends GetxController {
  final studentService = StudentService();

  final formKey = GlobalKey<FormState>();
  final nameControllers = TextEditingController();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  void saveStudents() async {
    if (isLoading.value) return;
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    final student =
        StudentModel(name: nameControllers.text.trim(), status: true);

    debugPrint('${student.name} sedang ditambah...');
    final result = await studentService.addStudent(student);
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
