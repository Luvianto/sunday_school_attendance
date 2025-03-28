import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/models/student_model.dart';
import 'package:sunday_school_attendance/app/services/student_service.dart';

class StudentDetailController extends GetxController {
  final studentService = StudentService();

  var isLoading = true.obs;
  var errorMessage = ''.obs;

  final student = Rxn<StudentModel>();

  @override
  void onInit() {
    super.onInit();
    fetchStudent();
  }

  Future<void> refreshPage() async {}

  Future<void> fetchStudent() async {
    isLoading.value = true;
    final argument = Get.arguments;
    if (argument is StudentModel) {
      final result = await studentService.getStudent(argument.id!);
      if (result.isSuccess && result.isNotEmpty) {
        student.value = result.data!;
      }
      if (result.isEmpty) {
        errorMessage.value = 'Data tidak ditemukan!\nKembali ke halaman utama!';
      }
      if (result.isError) {
        errorMessage.value = result.message!;
      }
    }
    isLoading.value = false;
  }

  void deleteStudent() {
    studentService.deleteStudent(student.value!.id!);
    Get.back(result: true);
  }
}
