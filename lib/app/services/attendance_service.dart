import 'package:sunday_school_attendance/app/chore/handler/service_result.dart';
import 'package:sunday_school_attendance/app/chore/instance/firestore_instance.dart';
import 'package:sunday_school_attendance/app/models/attendance_model.dart';

class AttendanceService extends FirestoreInstance {
  final collectionName = 'attendances';

  Future<ServiceResult<List<AttendanceModel>>> getAttendanceList() async {
    return await getCollection(
      firestore.collection(collectionName).orderBy('timestamp').get(),
      AttendanceModel.fromFirestore,
    );
  }

  Future<ServiceResult<AttendanceModel>> getAttendance(
      String attendanceId) async {
    return await getDocument(
      firestore.collection(collectionName).doc(attendanceId).get(),
      AttendanceModel.fromFirestore,
    );
  }

  Future<ServiceResult> addAttendance(AttendanceModel attendance) async {
    return await addDocument(collectionName, attendance.toFirestore());
  }
}
