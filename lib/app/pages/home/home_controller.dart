import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/ui/attendance/attendance_page/attendance_controller.dart';
import 'package:sunday_school_attendance/app/ui/attendance/attendance_page/attendance_page.dart';
import 'package:sunday_school_attendance/app/ui/profile/profile_page/profile_page.dart';
import 'package:sunday_school_attendance/app/ui/student/student_list/student_list_controller.dart';
import 'package:sunday_school_attendance/app/ui/student/student_list/student_list_page.dart';

// If you want to add another page into the BottomNavigationBar, follow these steps:

// 1. Add new enum, make sure the name defines your page.
enum HomeTab { attendance, student, profile }

class HomeController extends GetxController {
  // 2. Add a new `title` (displayed as the AppBar title on the corresponding tab)
  final title = const {
    HomeTab.attendance: "Absensi",
    HomeTab.student: "Murid",
    HomeTab.profile: "Profil",
  };

  // 3. Add a new page (the content of the corresponding tab)
  final pages = const {
    HomeTab.attendance: AttendancePage(),
    HomeTab.student: StudentListPage(),
    HomeTab.profile: ProfilePage(),
  };

  // 4. Add a new item for the BottomNavigationBar
  final items = const [
    BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: "Absensi"),
    BottomNavigationBarItem(icon: Icon(Icons.emoji_emotions), label: "Murid"),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
  ];

  // 5. Add new actions for the AppBar, 'null' if no actions are required
  final actions = {
    HomeTab.attendance: [
      IconButton(
        onPressed: Get.find<AttendanceController>().resetSelectedDay,
        icon: Text(
          DateTime.now().day.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
    HomeTab.student: null,
    HomeTab.profile: null,
  };

  // 6. Add floatingActionButton for the Scaffold, 'null' if fab is not required
  final fab = {
    HomeTab.attendance: FloatingActionButton(
      onPressed: Get.find<AttendanceController>().openForm,
      child: const Icon(Icons.add),
    ),
    HomeTab.student: FloatingActionButton(
      onPressed: Get.find<StudentListController>().openForm,
      child: const Icon(Icons.add),
    ),
    HomeTab.profile: null,
  };

  Widget get currentPage => pages[currentTab.value]!;
  String get currentTitle => title[currentTab.value]!;
  List<Widget>? get currentActions => actions[currentTab.value];
  FloatingActionButton? get currentFab => fab[currentTab.value];

  final currentTab = HomeTab.attendance.obs;

  void changePage(int index) {
    currentTab.value = HomeTab.values[index];
  }
}
