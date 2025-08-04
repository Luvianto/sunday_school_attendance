import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sunday_school_attendance/app/models/attendance_model.dart';
import 'package:sunday_school_attendance/app/routes/app_routes.dart';
import 'package:sunday_school_attendance/app/services/attendance_service.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceController extends GetxController {
  AttendanceService attendanceService = AttendanceService();

  var isLoading = true.obs;
  var errorMessage = ''.obs;

  var attendanceList = <AttendanceModel>[].obs;

  final now = DateTime.now();

  final firstDay = DateTime.utc(2010, 10, 16);
  final lastDay = DateTime.utc(2030, 3, 14);

  var selectedDay = DateTime.now().obs;
  var focusedDay = DateTime.now().obs;
  var calendarFormat = CalendarFormat.month.obs;

  var day = DateFormat.d('id_ID').format(DateTime.now());
  var weekday = DateFormat.EEEE('id_ID').format(DateTime.now());
  var month = DateFormat.MMMM('id_ID').format(DateTime.now());
  var year = DateFormat.y('id_ID').format(DateTime.now());

  var formattedDate = "".obs;

  void setFormattedDate(DateTime value) {
    day = DateFormat.d('id_ID').format(value);
    weekday = DateFormat.EEEE('id_ID').format(value);
    month = DateFormat.MMMM('id_ID').format(value);
    year = DateFormat.y('id_ID').format(value);
    formattedDate.value = "$weekday, $day $month $year";
    update();
  }

  @override
  void onInit() {
    super.onInit();
    final today = DateTime(now.year, now.month, now.day);
    setFormattedDate(now);
    fetchAttendanceListByDate(today);
  }

  // Function 'refresh' udah dipake, jadi namanya 'refreshPage'
  Future<void> refreshPage() async {
    isLoading.value = true;
    errorMessage.value = '';

    // Supaya user bisa melihat loading
    Future.delayed(Duration(seconds: 2), () {
      fetchAttendanceListByDate(selectedDay.value);
      isLoading.value = false;
    });
  }

  void toDetail(AttendanceModel selectedAttendance) {
    Get.toNamed(
      AppRoutes.attendance,
      arguments: selectedAttendance,
    )?.then((result) {
      if (result == true) {
        fetchAttendanceListByDate;
      }
    });
  }

  void openForm() {
    Get.toNamed(AppRoutes.attendance + AppRoutes.form)?.then((result) {
      if (result == true) {
        fetchAttendanceListByDate;
      }
    });
  }

  void fetchAttendanceListByDate([DateTime? date]) async {
    attendanceList.clear();
    date ??= DateTime(now.year, now.month, now.day);
    isLoading.value = true;
    final result = await attendanceService.getAttendanceListByDate(date);
    debugPrint(result.data.toString());
    debugPrint(result.message);
    if (result.isSuccess && result.isNotEmpty) {
      attendanceList.value = result.data!;
    } else {
      errorMessage.value = result.message!;
    }
    isLoading.value = false;
  }

  void resetSelectedDay() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    selectedDay.value = today;
    focusedDay.value = today;
    setFormattedDate(today);
  }

  void onPageChanged(DateTime dayFocused) {
    final now = DateTime.now();
    if (now.year == dayFocused.year && now.month == dayFocused.month) {
      final today = DateTime(now.year, now.month, now.day);
      selectedDay.value = today;
      focusedDay.value = today;
      setFormattedDate(today);
      fetchAttendanceListByDate(today);
    } else {
      final firstDayOfMonth = DateTime(dayFocused.year, dayFocused.month, 1);
      selectedDay.value = firstDayOfMonth;
      focusedDay.value = firstDayOfMonth;
      setFormattedDate(firstDayOfMonth);
      fetchAttendanceListByDate(firstDayOfMonth);
    }
  }

  void setCalendarFormat(CalendarFormat format) {
    calendarFormat.value = format;
  }

  void onDaySelected(DateTime daySelected, DateTime dayFocused) {
    selectedDay.value = daySelected;
    focusedDay.value = daySelected;
    attendanceList.clear();
    setFormattedDate(daySelected);
    fetchAttendanceListByDate(daySelected);
  }
}
