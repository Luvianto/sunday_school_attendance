import 'package:cloud_firestore/cloud_firestore.dart';

String handleFirestore(FirebaseException e) {
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

String handleFirebaseAuth(FirebaseException e) {
  switch (e.code) {
    case 'user-not-found':
      return 'No user found with this email.';
    case 'wrong-password':
      return 'Incorrect password. Please try again.';
    default:
      return 'An unexpected error occurred: ${e.message}';
  }
}
