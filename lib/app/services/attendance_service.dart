import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sunday_school_attendance/app/models/session_model.dart';

class AttendanceService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final collectionName = 'sessions';

  Future<List<SessionModel>> getAttendanceList() async {
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
}
