import 'package:firebase_auth/firebase_auth.dart';
import 'package:sunday_school_attendance/app/chore/handler/firebase_exception.dart';
import 'package:sunday_school_attendance/app/chore/handler/service_result.dart';
import 'package:sunday_school_attendance/app/chore/instance/firestore_instance.dart';
import 'package:sunday_school_attendance/app/models/user_model.dart';

class AuthService extends FirestoreInstance {
  final _auth = FirebaseAuth.instance;
  final _collectionName = 'users';

  Future<ServiceResult<User>> signIn(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        signOut();
        return ServiceResult.failure(
          'Terjadi kesalahan! Silakan login kembali!',
        );
      }

      return ServiceResult.success(data: user);
    } on FirebaseAuthException catch (e) {
      return ServiceResult.failure(firebaseAuthException(e));
    } catch (e) {
      return ServiceResult.failure('signIn: $e');
    }
  }

  Future<ServiceResult<User>> signUp(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        signOut();
        return ServiceResult.failure(
          'Terjadi kesalahan! Silakan login kembali!',
        );
      }

      return ServiceResult.success(data: user);
    } on FirebaseAuthException catch (e) {
      return ServiceResult.failure(firebaseAuthException(e));
    } on FirebaseException catch (e) {
      return ServiceResult.failure(firestoreException(e));
    } catch (e) {
      return ServiceResult.failure('signUp: $e');
    }
  }

  Future<ServiceResult<UserModel?>> isAuthenticated() async {
    final user = _auth.currentUser;
    if (user != null) {
      final result = await getUserDetail(user.uid);
      return ServiceResult.success(data: result.data);
    }
    return ServiceResult.success();
  }

  Future<ServiceResult<UserModel?>> getUserDetail(String uid) async {
    return await getDocument(
      firestore.collection(_collectionName).doc(uid).get(),
      UserModel.fromFirestore,
    );
  }

  Future<ServiceResult<void>> signOut() async {
    try {
      await _auth.signOut();
      return ServiceResult.success();
    } on FirebaseAuthException catch (e) {
      return ServiceResult.failure(firebaseAuthException(e));
    } catch (e) {
      return ServiceResult.failure('signOut: $e');
    }
  }

  Future<ServiceResult> addUser(UserModel newUser) async {
    try {
      await firestore
          .collection(_collectionName)
          .doc(newUser.id!)
          .set(newUser.toFirestore());
      return ServiceResult.success();
    } on FirebaseAuthException catch (e) {
      return ServiceResult.failure(firebaseAuthException(e));
    } catch (e) {
      return ServiceResult.failure('signOut: $e');
    }
  }
}
