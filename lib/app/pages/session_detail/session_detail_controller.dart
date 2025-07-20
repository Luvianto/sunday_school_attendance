import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/common/util/convert_time_of_day.dart';
import 'package:sunday_school_attendance/app/models/session_model.dart';
import 'package:sunday_school_attendance/app/routes/app_routes.dart';
import 'package:sunday_school_attendance/app/services/session_service.dart';

class SessionDetailController extends GetxController {
  final SessionService sessionService = SessionService();

  var isLoading = true.obs;
  var errorMessage = ''.obs;
  bool isEdited = false;

  var session = Rxn<SessionModel>();
  String? startTime;
  String? endTime;

  @override
  void onInit() async {
    super.onInit();
    await fetchSession();
    if (session.value != null) {
      startTime = ConvertTimeOfDay.toHourMinutePeriod(session.value!.startTime);
      endTime = ConvertTimeOfDay.toHourMinutePeriod(session.value!.endTime);
    }
  }

  Future<void> fetchSession() async {
    isLoading.value = true;
    final argument = Get.arguments;
    if (argument is SessionModel) {
      final result = await sessionService.getSession(argument.id!);
      if (result.isSuccess) {
        session.value = result.data;
      } else {
        errorMessage.value = result.message!;
      }
    }
    isLoading.value = false;
  }

  void openForm() {
    Get.toNamed(
      AppRoutes.session + AppRoutes.form,
      arguments: session.value,
    )?.then((result) {
      if (result == true) {
        fetchSession();
        isEdited = result;
      }
    });
  }

  void closePage() {
    Get.back(result: isEdited);
  }

  void deleteSession() async {
    if (session.value!.id == null) {
      Get.snackbar("Error deleteSession", "Id Sesi kosong.");
    }

    await sessionService.deleteSession(session.value!.id!);
    Get.back(result: true);
  }
}
