import 'package:sunday_school_attendance/app/models/enums.dart';
import 'package:sunday_school_attendance/app/models/student_model.dart';

class StudentAttendanceModel {
  final String studentId;
  final String studentName;
  final AttendanceStatus attendanceStatus;

  StudentAttendanceModel({
    required this.studentId,
    required this.studentName,
    required this.attendanceStatus,
  });

  factory StudentAttendanceModel.fromStudent(StudentModel student) {
    return StudentAttendanceModel(
      studentId: student.id!,
      studentName: student.name,
      attendanceStatus: AttendanceStatus.absent,
    );
  }

  factory StudentAttendanceModel.fromFirestore(Map<String, dynamic> json) {
    return StudentAttendanceModel(
      studentId: json['student_id'],
      studentName: json['student_name'],
      attendanceStatus: AttendanceStatus.values.firstWhere(
        (e) => e.name == json['attendance_status'],
      ),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'student_id': studentId,
      'student_name': studentName,
      'attendance_status': attendanceStatus.name,
    };
  }
}
