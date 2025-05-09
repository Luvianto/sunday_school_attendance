import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/models/attendance_model.dart';
import 'package:sunday_school_attendance/app/models/enums.dart';
import 'package:sunday_school_attendance/app/models/student_model.dart';
import 'package:sunday_school_attendance/app/services/attendance_service.dart';
import 'package:sunday_school_attendance/app/services/student_service.dart';

class AttendanceFormController extends GetxController {
  final studentService = StudentService();
  final attendanceService = AttendanceService();

  final sessionTypeList = SessionType.values;
  var selectedSession = SessionType.morning.obs;

  var isLoading = true.obs;
  var errorMessage = ''.obs;

  var studentList = <StudentModel>[].obs;
  var presentStudents = <StudentModel>[];

  @override
  void onInit() {
    super.onInit();
    fetchStudentList();
    isLoading.value = false;
  }

  Future<void> refreshPage() async {
    isLoading.value = true;

    presentStudents = [];
    studentList.value = [];
    await fetchStudentList();

    Future.delayed(Duration(seconds: 2), () {
      isLoading.value = false;
    });
  }

  Future<void> fetchStudentList() async {
    final result = await studentService.getStudentList();
    if (result.isSuccess && result.isNotEmpty) {
      studentList.value = result.data!;
    }
    if (result.isEmpty) {
      errorMessage.value =
          'Belum ada murid untuk diabsen!\nTambahkan murid terlebih dahulu!';
    }
    if (result.isError) {
      errorMessage.value = result.message!;
    }
  }

  void onSelect(SessionType? value) {
    selectedSession.value = value!;
  }

  void toggleStatus(StudentModel student) {
    if (presentStudents.contains(student)) {
      presentStudents.remove(student);
    } else {
      presentStudents.add(student);
    }
  }

  void saveAttendance() {
    final attendance = AttendanceModel(
      timestamp: Timestamp.now(),
      sessionType: selectedSession.value,
      studentList: presentStudents,
    );
    attendanceService.addAttendance(attendance);
    Get.back();
  }
}
