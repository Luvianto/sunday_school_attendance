import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sunday_school_attendance/app/chore/handler/firebase_exception.dart';
import 'package:sunday_school_attendance/app/chore/handler/service_result.dart';
import 'package:sunday_school_attendance/app/models/session_model.dart';

class SessionService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final collectionName = 'sessions';

  Future<List<SessionModel>> getSessionList() async {
    try {
      final snapshot = await firestore.collection(collectionName).get();
      return snapshot.docs.map((doc) {
        return SessionModel.fromMap(doc.data(), id: doc.id);
      }).toList()
        // Sortir list berdasarkan startHour dan minute terkecil (Paling pagi)
        // Karena firestore mewajibkan penggunaan index untuk orderBy 2 kolom
        ..sort((a, b) {
          // Jika fungsi dibawah return:
          //  1  → a < b  (Ditukar)
          // -1  → a > b  (Tidak terjadi apa-apa)
          //  0  → a = b  (Lanjut membandingkan menit)
          int compareHour = a.startHour.compareTo(b.startHour);
          return compareHour != 0
              ? compareHour
              : a.startMinute.compareTo(b.startMinute);
        });
    } catch (e) {
      throw Exception("getSessionList: $e");
    }
  }

  Future<ServiceResult<SessionModel?>> getSession(String sessionId) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(sessionId)
          .get();

      if (doc.exists) {
        final data = SessionModel.fromMap(
          doc.data() as Map<String, dynamic>,
          id: doc.id,
        );
        return ServiceResult.success(data: data);
      }

      return ServiceResult.failure("Sesi tidak ditemukan!");
    } on FirebaseException catch (e) {
      return ServiceResult.failure(firestoreException(e));
    } catch (e) {
      return ServiceResult.failure("Error getSession: $e");
    }
  }

  Future<void> addSession(SessionModel session) async {
    try {
      await firestore.collection(collectionName).add(session.toMap());
    } catch (e) {
      throw Exception("Error addSession: $e");
    }
  }

  Future<void> updateSession(SessionModel session) async {
    if (session.id == null) {
      throw Exception("Error updateSession: ID kosong.");
    }

    try {
      await firestore
          .collection(collectionName)
          .doc(session.id)
          .update(session.toMap());
    } catch (e) {
      throw Exception("Error updateSession: $e");
    }
  }

  Future<void> deleteSession(String sessionId) async {
    try {
      await firestore.collection(collectionName).doc(sessionId).delete();
    } catch (e) {
      throw Exception("Error deleteSession: $e");
    }
  }
}
