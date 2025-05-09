import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/models/attendance_model.dart';
import 'package:sunday_school_attendance/app/services/attendance_service.dart';

class AttendanceDetailController extends GetxController {
  final attendanceService = AttendanceService();

  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var isEdited = false.obs;
  var attendance = Rxn<AttendanceModel>();

  @override
  void onInit() {
    super.onInit();
    fetchAttendance();
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
        errorMessage.value = 'Data tidak ditemukan!\nKembali ke halaman utama!';
      }
      if (result.isError) {
        errorMessage.value = result.message!;
      }
    }
    isLoading.value = false;
  }

  void closePage() {
    Get.back(result: isEdited);
  }

  void openForm() {}
  void deleteAttendance() {}
}
