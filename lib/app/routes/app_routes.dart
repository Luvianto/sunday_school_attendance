import 'package:get/get.dart';
import 'package:sunday_school_attendance/app/common/middlewares/attendance_middleware.dart';
import 'package:sunday_school_attendance/app/common/middlewares/session_middleware.dart';
import 'package:sunday_school_attendance/app/common/middlewares/student_middleware.dart';
import 'package:sunday_school_attendance/app/pages/home/home_binding.dart';
import 'package:sunday_school_attendance/app/pages/home/home_page.dart';
import 'package:sunday_school_attendance/app/pages/session_detail/session_detail_binding.dart';
import 'package:sunday_school_attendance/app/pages/session_detail/session_detail_page.dart';
import 'package:sunday_school_attendance/app/pages/session_form/session_form_binding.dart';
import 'package:sunday_school_attendance/app/pages/session_form/session_form_page.dart';
import 'package:sunday_school_attendance/app/ui/attendance/attendance_detail/attendance_detail_binding.dart';
import 'package:sunday_school_attendance/app/ui/attendance/attendance_detail/attendance_detail_page.dart';
import 'package:sunday_school_attendance/app/ui/attendance/attendance_form/attendance_form_binding.dart';
import 'package:sunday_school_attendance/app/ui/attendance/attendance_form/attendance_form_page.dart';
import 'package:sunday_school_attendance/app/ui/auth/login/login_binding.dart';
import 'package:sunday_school_attendance/app/ui/auth/login/login_page.dart';
import 'package:sunday_school_attendance/app/ui/auth/register/register_binding.dart';
import 'package:sunday_school_attendance/app/ui/auth/register/register_page.dart';
import 'package:sunday_school_attendance/app/ui/student/student_detail/student_detail_binding.dart';
import 'package:sunday_school_attendance/app/ui/student/student_detail/student_detail_page.dart';
import 'package:sunday_school_attendance/app/ui/student/student_edit/student_edit_page.dart';
import 'package:sunday_school_attendance/app/ui/student/student_edit/student_edit_binding.dart';
import 'package:sunday_school_attendance/app/ui/student/student_form/student_form_binding.dart';
import 'package:sunday_school_attendance/app/ui/student/student_form/student_form_page.dart';
import 'package:sunday_school_attendance/app/ui/student/student_search/student_search_binding.dart';
import 'package:sunday_school_attendance/app/ui/student/student_search/student_search_page.dart';

class AppRoutes {
  static const login = '/login';
  static const register = '/register';

  static const home = '/home';
  static const session = '/session';
  static const student = '/student';
  static const attendance = '/attendance';

  static const form = '/form';
  static const edit = '/edit';
  static const search = '/search';

  static final routes = [
    GetPage(
      name: login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: register,
      page: () => RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: session,
      page: () => SessionDetailPage(),
      binding: SessionDetailBinding(),
      middlewares: [SessionMiddleware()],
    ),
    GetPage(
      name: session + form,
      page: () => SessionFormPage(),
      binding: SessionFormBinding(),
      middlewares: [SessionMiddleware()],
    ),
    GetPage(
      name: attendance,
      page: () => AttendanceDetailPage(),
      binding: AttendanceDetailBinding(),
      middlewares: [AttendanceMiddleware()],
    ),
    GetPage(
      name: attendance + form,
      page: () => AttendanceFormPage(),
      binding: AttendanceFormBinding(),
      middlewares: [AttendanceMiddleware()],
    ),
    GetPage(
      name: student,
      page: () => StudentDetailPage(),
      binding: StudentDetailBinding(),
      middlewares: [StudentMiddleware()],
    ),
    GetPage(
      name: student + edit,
      page: () => StudentEditPage(),
      binding: StudentEditBinding(),
      middlewares: [StudentMiddleware()],
    ),
    GetPage(
      name: student + form,
      page: () => StudentFormPage(),
      binding: StudentFormBinding(),
      middlewares: [StudentMiddleware()],
    ),
    GetPage(
      name: student + search,
      page: () => StudentSearchPage(),
      binding: StudentSearchBinding(),
      middlewares: [StudentMiddleware()],
    ),
  ];
}
