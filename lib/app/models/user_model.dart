import 'package:sunday_school_attendance/app/models/enums.dart';

class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final UserRole role;
  final String? profilePictureUrl;

  UserModel({
    this.id,
    required this.fullName,
    required this.email,
    required this.role,
    this.profilePictureUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String? id) {
    return UserModel(
      id: id,
      fullName: json['fullName'],
      email: json['email'],
      role: UserRole.values.firstWhere((e) => e.name == json['role']),
      profilePictureUrl: json['profile_picture_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'role': role.name,
      'profile_picture_url': profilePictureUrl ?? '',
    };
  }
}
