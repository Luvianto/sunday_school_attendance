import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/common/utilities/convert_time_of_day.dart';
import 'package:sunday_school_attendance/app/common/widgets/custom_confirm_dialog.dart';
import 'package:sunday_school_attendance/app/common/widgets/custom_time_picker.dart';
import 'package:sunday_school_attendance/app/models/session_model.dart';
import 'package:sunday_school_attendance/app/services/session_service.dart';

class SessionFormController extends GetxController {
  final SessionService sessionService = SessionService();
  SessionModel? session;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();

  var startTime = Rxn<TimeOfDay>();
  var endTime = Rxn<TimeOfDay>();

  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSession();
  }

  void fetchSession() {
    final arguments = Get.arguments;
    if (arguments is SessionModel) {
      session = arguments;
      startTime.value = session!.startTime;
      endTime.value = session!.endTime;

      nameController.text = session!.name;
      startTimeController.text =
          ConvertTimeOfDay.toHourMinutePeriod(session!.startTime);
      endTimeController.text =
          ConvertTimeOfDay.toHourMinutePeriod(session!.endTime);
    }
    isLoading.value = false;
  }

  // Untuk CustomTimePicker
  Future<void> selectTime(
    Rxn<TimeOfDay> time,
    TextEditingController controller,
  ) async {
    final selectedTime = await Get.dialog<TimeOfDay>(
      CustomConfirmDialog(
        onConfirm: () {
          Get.back(result: time.value);
        },
        onCancel: Get.back,
        child: CustomTimePicker(
          initialTime: time.value ?? TimeOfDay.now(),
          onTimeSelected: (selected) => time.value = selected,
        ),
      ),
    );

    if (selectedTime != null) {
      time.value = selectedTime;
      controller.text = ConvertTimeOfDay.toHourMinutePeriod(selectedTime);
    }
  }

  void selectStartTime() => selectTime(startTime, startTimeController);
  void selectEndTime() => selectTime(endTime, endTimeController);

  void saveSession() async {
    try {
      final newSession = SessionModel(
        id: session?.id,
        name: nameController.text,
        startHour: startTime.value!.hour,
        startMinute: startTime.value!.minute,
        endHour: endTime.value!.hour,
        endMinute: endTime.value!.minute,
      );

      if (session != null && session!.id != null) {
        await sessionService.updateSession(newSession);
      } else {
        await sessionService.addSession(newSession);
      }

      Get.back(result: true);
    } catch (e) {
      debugPrint('saveSession: $e');
      throw e.toString();
    }
  }
}
