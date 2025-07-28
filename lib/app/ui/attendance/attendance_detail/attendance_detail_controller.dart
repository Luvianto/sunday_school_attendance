import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/models/attendance_model.dart';
import 'package:sunday_school_attendance/app/models/student_attendance_model.dart';
import 'package:sunday_school_attendance/app/models/student_model.dart';
import 'package:sunday_school_attendance/app/services/attendance_service.dart';
import 'package:sunday_school_attendance/app/services/student_attendance_service.dart';
import 'package:sunday_school_attendance/app/services/student_service.dart';

class AttendanceDetailController extends GetxController {
  final studentService = StudentService();
  final attendanceService = AttendanceService();
  final studentAttendanceService = StudentAttendanceService();

  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var isEdited = false.obs;
  var attendance = Rxn<AttendanceModel>();

  var studentAttendanceList = <StudentAttendanceModel>[];
  var studentList = <StudentModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAttendance();
    fetchStudentAttendanceList();
  }

  Future<void> refreshPage() async {}

  void fetchAttendance() async {
    isLoading.value = true;
    final argument = Get.arguments;
    if (argument is AttendanceModel) {
      final result = await attendanceService.getAttendance(argument.id!);
      if (result.isSuccess && result.isNotEmpty) {
        attendance.value = result.data!;
      }
      if (result.isEmpty) {
        errorMessage.value = result.message!;
      }
      if (result.isError) {
        errorMessage.value = result.message!;
      }
    }
    isLoading.value = false;
  }

  void fetchStudentAttendanceList() async {
    isLoading.value = true;
    final argument = Get.arguments;
    if (argument is AttendanceModel) {
      final result =
          await studentAttendanceService.getStudentAttendanceList(argument.id!);
      if (result.isSuccess && result.isNotEmpty) {
        studentAttendanceList = result.data!;
        studentAttendanceList.map((studentAttendance) {
          fetchStudentDetail(studentAttendance.studentId);
        });
      }
      if (result.isEmpty) {
        errorMessage.value = result.message!;
      }
      if (result.isError) {
        errorMessage.value = result.message!;
      }
    }
    isLoading.value = false;
  }

  void fetchStudentDetail(String studentId) async {
    final result = await studentService.getStudent(studentId);
    if (result.isSuccess && result.isNotEmpty) {
      studentList.add(result.data!);
    }
    if (result.isEmpty) {
      errorMessage.value = result.message!;
    }
    if (result.isError) {
      errorMessage.value = result.message!;
    }
  }

  void closePage() {
    Get.back(result: isEdited);
  }

  void openForm() {}
  void deleteAttendance() {}
  void toDetail(StudentModel student) {}
}
