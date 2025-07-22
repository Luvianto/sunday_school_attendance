import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/models/attendance_model.dart';
import 'package:sunday_school_attendance/app/routes/app_routes.dart';
import 'package:sunday_school_attendance/app/services/attendance_service.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceController extends GetxController {
  AttendanceService attendanceService = AttendanceService();

  var isLoading = true.obs;
  var errorMessage = ''.obs;

  var attendanceList = <AttendanceModel>[].obs;

  final firstDay = DateTime.utc(2010, 10, 16);
  final lastDay = DateTime.utc(2030, 3, 14);

  var selectedDay = DateTime.now().obs;
  var focusedDay = DateTime.now().obs;
  var calendarFormat = CalendarFormat.month.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAttendanceList();
  }

  // Function 'refresh' udah dipake, jadi namanya 'refreshPage'
  Future<void> refreshPage() async {
    isLoading.value = true;
    attendanceList.clear();
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

  void fetchAttendanceListByDate(DateTime date) async {
    isLoading.value = true;
    final result = await attendanceService.getAttendanceListByDate(date);
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

  void resetSelectedDay() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    selectedDay.value = today;
    focusedDay.value = today;
  }

  void onPagesChanged(DateTime dayFocused) {
    final now = DateTime.now();
    if (now.year == dayFocused.year && now.month == dayFocused.month) {
      selectedDay.value = DateTime(now.year, now.month, now.day);
      focusedDay.value = DateTime(now.year, now.month, now.day);
    } else {
      final firstDayOfMonth = DateTime(dayFocused.year, dayFocused.month, 1);
      selectedDay.value = firstDayOfMonth;
      focusedDay.value = firstDayOfMonth;
    }
  }

  void setCalendarFormat(CalendarFormat format) {
    calendarFormat.value = format;
  }

  void setSelectedDay(DateTime daySelected, DateTime dayFocused) {
    selectedDay.value = daySelected;
    focusedDay.value = daySelected;
    attendanceList.clear();
    fetchAttendanceListByDate(daySelected);
  }
}
