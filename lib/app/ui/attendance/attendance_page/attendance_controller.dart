import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/models/session_model.dart';
import 'package:sunday_school_attendance/app/routes/app_routes.dart';
import 'package:sunday_school_attendance/app/services/attendance_service.dart';

class AttendanceController extends GetxController {
  AttendanceService attendanceService = AttendanceService();

  var isLoading = true.obs;
  var errorMessage = ''.obs;

  var attendanceList = <SessionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = false;
  }

  // Function 'refresh' udah dipake, jadi namanya 'refreshPage'
  Future<void> refreshPage() async {
    isLoading.value = true;
    errorMessage.value = '';

    // Supaya user bisa melihat loading
    Future.delayed(Duration(seconds: 1), fetchSessionList);
  }

  void toDetail(SessionModel selectedAttendance) {
    Get.toNamed(
      AppRoutes.attendance,
      arguments: selectedAttendance,
    )?.then((result) {
      if (result == true) {
        fetchSessionList();
      }
    });
  }

  void openForm() {
    Get.toNamed(AppRoutes.attendance + AppRoutes.form)?.then((result) {
      if (result == true) {
        fetchSessionList();
      }
    });
  }

  Future<void> fetchSessionList() async {
    try {
      isLoading.value = true;
      final sessions = await attendanceService.getAttendanceList();
      attendanceList.value = sessions;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
