class StudentAttendanceModel {
  final String? id;
  final String studentId;
  final String attendanceId;

  StudentAttendanceModel({
    this.id,
    required this.studentId,
    required this.attendanceId,
  });

  factory StudentAttendanceModel.fromFirestore(
      Map<String, dynamic> json, String? id) {
    return StudentAttendanceModel(
      studentId: json['student_id'],
      attendanceId: json['attendance_id'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'student_id': studentId,
      'attendance_id': attendanceId,
    };
  }
}
