import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/models/session_model.dart';
import 'package:sunday_school_attendance/app/routes/app_routes.dart';
import 'package:sunday_school_attendance/app/services/session_service.dart';

class SessionController extends GetxController {
  final SessionService sessionService = SessionService();

  var isLoading = true.obs;
  var errorMessage = ''.obs;

  var sessionList = <SessionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSessionList();
  }

  // Function 'refresh' udah dipake, jadi namanya 'refreshPage'
  Future<void> refreshPage() async {
    isLoading.value = true;
    errorMessage.value = '';

    // Supaya user bisa melihat loading
    Future.delayed(Duration(seconds: 1), fetchSessionList);
  }

  void toDetail(SessionModel selectedSession) {
    Get.toNamed(
      AppRoutes.session,
      arguments: selectedSession,
    )?.then((result) {
      if (result == true) {
        fetchSessionList();
      }
    });
  }

  void openForm() {
    Get.toNamed(AppRoutes.session + AppRoutes.form)?.then((result) {
      if (result == true) {
        fetchSessionList();
      }
    });
  }

  Future<void> fetchSessionList() async {
    try {
      isLoading.value = true;
      final sessions = await sessionService.getSessionList();
      sessionList.value = sessions;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
