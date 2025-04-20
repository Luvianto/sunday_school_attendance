import 'package:sunday_school_attendance/app/models/enums.dart';
import 'package:sunday_school_attendance/app/models/student_model.dart';

class StudentAttendanceModel {
  final StudentModel student;
  final AttendanceStatus attendanceStatus;

  StudentAttendanceModel({
    required this.student,
    required this.attendanceStatus,
  });

  factory StudentAttendanceModel.fromStudent(StudentModel student) {
    return StudentAttendanceModel(
      student: student,
      attendanceStatus: AttendanceStatus.absent,
    );
  }

  factory StudentAttendanceModel.fromFirestore(
      Map<String, dynamic> json, String? id) {
    return StudentAttendanceModel(
      student: StudentModel.fromFirestore(json['student'], id),
      attendanceStatus: AttendanceStatus.values.firstWhere(
        (e) => e.name == json['attendance_status'],
      ),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'student': student.toFirestore(),
      'attendance_status': attendanceStatus.name,
    };
  }
}
