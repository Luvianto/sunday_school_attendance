import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sunday_school_attendance/app/chore/handler/firebase_handler.dart';
import 'package:sunday_school_attendance/app/chore/handler/service_result.dart';
import 'package:sunday_school_attendance/app/models/user_model.dart';
import 'package:sunday_school_attendance/app/models/enums.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<ServiceResult<User>> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user == null) {
        return ServiceResult(error: 'Error signIn: User kosong!');
      }
      return ServiceResult(data: user);
    } on FirebaseAuthException catch (e) {
      return ServiceResult(error: handleFirebaseAuth(e));
    }
  }

  Future<ServiceResult<UserModel>> signUp(
    String email,
    String password,
    String fullName,
    UserRole role,
  ) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user == null) {
        return ServiceResult(error: 'Error signUp: User kosong!');
      }

      final userModel = UserModel(
        id: user.uid,
        fullName: fullName,
        email: email,
        role: role,
      );

      await _firestore
          .collection('users')
          .doc(user.uid)
          .set(userModel.toJson());

      return ServiceResult(data: userModel);
    } on FirebaseAuthException catch (e) {
      return ServiceResult(error: handleFirebaseAuth(e));
    } on FirebaseException catch (e) {
      return ServiceResult(error: handleFirestore(e));
    } catch (e) {
      return ServiceResult(error: 'Error signUp: $e');
    }
  }

  Future<ServiceResult<UserModel?>> isAuthenticated() async {
    final user = _auth.currentUser;
    if (user != null) {
      return await getUserDetail(user.uid);
    } else {
      return ServiceResult(error: 'Error isAuth:');
    }
  }

  Future<ServiceResult<UserModel?>> getUserDetail(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        final userModel =
            UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
        return ServiceResult(data: userModel);
      } else {
        return ServiceResult();
      }
    } on FirebaseException catch (e) {
      return ServiceResult(error: handleFirestore(e));
    } catch (e) {
      return ServiceResult(error: 'Error fetchUserDetail: $e');
    }
  }
}
