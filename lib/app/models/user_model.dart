import 'package:sunday_school_attendance/app/models/enums.dart';

class UserModel {
  final String? id;
  final String name;
  final String email;
  final UserRole role;
  final String? profilePictureUrl;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.role,
    this.profilePictureUrl,
  });

  factory UserModel.fromFirestore(Map<String, dynamic> json, String? id) {
    return UserModel(
      id: id,
      name: json['name'],
      email: json['email'],
      role: UserRole.values.firstWhere((e) => e.name == json['role']),
      profilePictureUrl: json['profile_picture_url'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'role': role.name,
      'profile_picture_url': profilePictureUrl ?? '',
    };
  }
}
