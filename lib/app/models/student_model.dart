class StudentModel {
  final String? id;
  final String name;
  final bool status; // Whether the student is still active or not
  final String? profilePictureUrl;

  StudentModel({
    this.id,
    required this.name,
    required this.status,
    this.profilePictureUrl,
  });

  factory StudentModel.fromFirestore(Map<String, dynamic> json, String? id) {
    return StudentModel(
      id: id,
      name: json['name'],
      status: json['status'],
      profilePictureUrl: json['profile_picture_url'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'status': status,
      'profile_picture_url': profilePictureUrl ?? '',
    };
  }
}
