import 'package:sunday_school_attendance/app/chore/handler/service_result.dart';
import 'package:sunday_school_attendance/app/chore/instance/firestore_instance.dart';
import 'package:sunday_school_attendance/app/models/student_model.dart';

class StudentService extends FirestoreInstance {
  final String collectionName = 'students';

  Future<ServiceResult<List<StudentModel>>> getStudentList() async {
    return await getCollection(
      firestore.collection(collectionName).orderBy('name').get(),
      StudentModel.fromFirestore,
    );
  }

  Future<ServiceResult<StudentModel>> getStudent(String studentId) async {
    return await getDocument(
      firestore.collection(collectionName).doc(studentId).get(),
      StudentModel.fromFirestore,
    );
  }

  Future<ServiceResult> addStudent(StudentModel student) async {
    return await addDocument(collectionName, student.toFirestore());
  }

  Future<ServiceResult> updateStudent(StudentModel student) async {
    if (student.id == null) {
      return ServiceResult.failure("ID murid tidak ditemukan!");
    }
    return await updateDocument(
        collectionName, student.id!, student.toFirestore());
  }

  Future<ServiceResult> deleteStudent(String studentId) async {
    return await deleteDocument(collectionName, studentId);
  }
}
