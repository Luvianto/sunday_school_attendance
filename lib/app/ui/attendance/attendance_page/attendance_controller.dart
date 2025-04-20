import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/models/attendance_model.dart';
import 'package:sunday_school_attendance/app/routes/app_routes.dart';
import 'package:sunday_school_attendance/app/services/attendance_service.dart';

class AttendanceController extends GetxController {
  AttendanceService attendanceService = AttendanceService();

  var isLoading = true.obs;
  var errorMessage = ''.obs;

  var attendanceList = <AttendanceModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAttendanceList();
  }

  // Function 'refresh' udah dipake, jadi namanya 'refreshPage'
  Future<void> refreshPage() async {
    isLoading.value = true;
    errorMessage.value = '';

    // Supaya user bisa melihat loading
    Future.delayed(Duration(seconds: 1), fetchAttendanceList);
  }

  void toDetail(AttendanceModel selectedAttendance) {
    Get.toNamed(
      AppRoutes.attendance,
      arguments: selectedAttendance,
    )?.then((result) {
      if (result == true) {
        fetchAttendanceList();
      }
    });
  }

  void openForm() {
    Get.toNamed(AppRoutes.attendance + AppRoutes.form)?.then((result) {
      if (result == true) {
        fetchAttendanceList();
      }
    });
  }

  void fetchAttendanceList() async {
    isLoading.value = true;
    final result = await attendanceService.getAttendanceList();
    if (result.isSuccess && result.isNotEmpty) {
      attendanceList.value = result.data!;
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
