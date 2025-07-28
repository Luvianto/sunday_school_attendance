import 'package:sunday_school_attendance/app/chore/handler/service_result.dart';
import 'package:sunday_school_attendance/app/chore/instance/firestore_instance.dart';
import 'package:sunday_school_attendance/app/models/student_attendance_model.dart';
import 'package:sunday_school_attendance/app/services/student_service.dart';

class StudentAttendanceService extends FirestoreInstance {
  final studentSevice = StudentService();
  final collectionName = 'student_attendance';

  Future<ServiceResult<List<StudentAttendanceModel>>> getStudentAttendanceList(
      String attendanceId) async {
    return await getCollection(
      firestore
          .collection(collectionName)
          .where('attendance_id', isEqualTo: attendanceId)
          .get(),
      StudentAttendanceModel.fromFirestore,
    );
  }
}
