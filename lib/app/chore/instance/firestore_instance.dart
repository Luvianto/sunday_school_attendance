import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sunday_school_attendance/app/chore/handler/firebase_exception.dart';
import 'package:sunday_school_attendance/app/chore/handler/service_result.dart';

class FirestoreInstance {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<ServiceResult<List<T>>> getCollection<T>(
    Future<QuerySnapshot<Map<String, dynamic>>> query,
    T Function(Map<String, dynamic>, String) fromJson,
  ) async {
    try {
      final snapshot = await query;
      if (snapshot.docs.isEmpty) return ServiceResult.empty();

      final data = snapshot.docs.map((doc) {
        return fromJson(doc.data(), doc.id);
      }).toList();

      return ServiceResult.success(data: data);
    } on FirebaseException catch (e) {
      return ServiceResult.failure(firestoreException(e));
    } catch (e) {
      return ServiceResult.failure('Error getCollection: ${e.toString()}');
    }
  }

  Future<ServiceResult<T>> getDocument<T>(
    Future<DocumentSnapshot<Map<String, dynamic>>> query,
    T Function(Map<String, dynamic>, String) fromJson,
  ) async {
    try {
      final doc = await query;
      if (!doc.exists) return ServiceResult.empty();

      final data = fromJson(doc.data()!, doc.id);
      return ServiceResult.success(data: data);
    } on FirebaseException catch (e) {
      return ServiceResult.failure(firestoreException(e));
    } catch (e) {
      return ServiceResult.failure('Error getDocument: ${e.toString()}');
    }
  }

  Future<ServiceResult> addDocument(
      String collection, Map<String, dynamic> data) async {
    try {
      await firestore.collection(collection).add(data);
      return ServiceResult.success();
    } on FirebaseException catch (e) {
      return ServiceResult.failure(firestoreException(e));
    } catch (e) {
      return ServiceResult.failure('Error addDocument: ${e.toString()}');
    }
  }

  Future<ServiceResult> updateDocument(
      String collection, String docId, Map<String, dynamic> data) async {
    try {
      await firestore.collection(collection).doc(docId).update(data);
      return ServiceResult.success();
    } on FirebaseException catch (e) {
      return ServiceResult.failure(firestoreException(e));
    } catch (e) {
      return ServiceResult.failure('Error updateDocument: ${e.toString()}');
    }
  }

  Future<ServiceResult> deleteDocument(String collection, String docId) async {
    try {
      await firestore.collection(collection).doc(docId).delete();
      return ServiceResult.success();
    } on FirebaseException catch (e) {
      return ServiceResult.failure(firestoreException(e));
    } catch (e) {
      return ServiceResult.failure('Error deleteDocument: ${e.toString()}');
    }
  }
}
