import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/models/session_model.dart';

class AttendanceDetailController extends GetxController {
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var isEdited = false.obs;
  var attendance = Rxn<SessionModel>();

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = false;
  }

  Future<void> refreshPage() async {}

  void closePage() {
    Get.back(result: isEdited);
  }

  void openForm() {}
  void deleteAttendance() {}
}
