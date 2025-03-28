import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/models/student_model.dart';
import 'package:sunday_school_attendance/app/services/student_service.dart';

class StudentFormController extends GetxController {
  final studentService = StudentService();

  final formKey = GlobalKey<FormState>();
  final nameControllers = <TextEditingController>[TextEditingController()].obs;

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  void addNameField() {
    nameControllers.add(TextEditingController());
  }

  List<Widget> buildTextFormFields(List<Widget> widgets) {
    List<Widget> fields = [];
    for (int i = 0; i < nameControllers.length; i++) {
      fields.addAll(widgets);
    }
    return fields;
  }

  void saveStudents() async {
    if (isLoading.value) return;
    isLoading.value = true;

    List<StudentModel> studentList = nameControllers
        .map((controller) => StudentModel(name: controller.text))
        .toList();

    int addedStudent = 0;
    List<String> failedStudents = [];

    for (final student in studentList) {
      debugPrint('${student.name} sedang ditambah...');
      final result = await studentService.addStudent(student);
      if (result.isSuccess) {
        addedStudent++;
        debugPrint('Berhasil tambah ${student.name}');
      }
      if (result.isError) {
        failedStudents.add(student.name);
        debugPrint('Gagal tambah ${student.name}');
        debugPrint('Gagal tambah ${result.message}');
      }
    }

    isLoading.value = false;

    if (failedStudents.isNotEmpty) {
      Get.snackbar(
        'Peringatan!',
        'Berhasil: $addedStudent, Gagal: ${failedStudents.length}\n'
            'Murid yang gagal: ${failedStudents.join(', ')}',
        duration: const Duration(seconds: 5),
      );
    } else {
      Get.snackbar(
        'Berhasil!',
        'Berhasil menambahkan semua murid',
      );
    }
  }
}
