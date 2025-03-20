import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/ui/attendance/attendance_page/attendance_page.dart';
import 'package:sunday_school_attendance/app/pages/profile/profile_view.dart';
import 'package:sunday_school_attendance/app/pages/session/session_page.dart';

class HomeController extends GetxController {
  // Dibuat sebagai Map agar mudah saat
  // merombak halaman dengan bottom navigation

  final List<Map<String, dynamic>> navigation = [
    {
      'view': AttendancePage(),
      'icon': Icons.calendar_month,
      'label': 'Absensi',
    },
    {
      'view': SessionPage(),
      'icon': Icons.calendar_month,
      'label': 'Murid',
    },
    {
      'view': ProfileView(),
      'icon': Icons.person,
      'label': 'Profil',
    },
  ];

  // Perlu dikembalikan sebagai Widget/String (as Widget/as String)
  // Karena sebelumnya dianggap sebagai class dynamic

  var currentIndex = 0.obs;

  List<Widget> get pages =>
      navigation.map((item) => item['view'] as Widget).toList();

  List<String> get labels =>
      navigation.map((item) => item['label'] as String).toList();

  List<BottomNavigationBarItem> get items => navigation
      .map((item) => BottomNavigationBarItem(
            icon: Icon(item['icon'] as IconData),
            label: item['label'] as String,
          ))
      .toList();

  void changePage(int index) {
    currentIndex.value = index;
  }
}
