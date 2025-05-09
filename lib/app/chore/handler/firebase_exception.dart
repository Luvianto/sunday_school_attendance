import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

String firebaseAuthException(FirebaseException e) {
  debugPrint('Exception ${e.code}: ${e.message}');
  switch (e.code) {
    case 'not-found':
      return 'No user found with this email.';
    case 'wrong-password':
      return 'Incorrect password. Please try again.';
    case 'invalid-credential':
      return 'Periksa kembali email dan password Anda!';
    default:
      return 'Terjadi kesalahan, mohon coba lagi dalam beberapa saat!';
  }
}

String firestoreException(FirebaseException e) {
  debugPrint('Exception ${e.code}: ${e.message}');
  debugPrint(e.message);
  switch (e.code) {
    case 'permission-denied':
      return "You don't have permission to access this session.";
    case 'not-found':
      return "The requested session was not found.";
    case 'unavailable':
      return "Firestore service is currently unavailable.";
    case 'deadline-exceeded':
      return "The request took too long. Please try again.";
    case 'invalid-argument':
      return "Invalid session ID.";
    default:
      return "An unexpected error occurred: ${e.message}";
  }
}
