class StudentModel {
  final String? id;
  final String name;
  final bool status; // Whether the student is still active or not
  final String? profilePicture;

  StudentModel({
    this.id,
    required this.name,
    required this.status,
    this.profilePicture,
  });

  factory StudentModel.fromFirestore(Map<String, dynamic> json, String? id) {
    return StudentModel(
      id: id,
      name: json['name'],
      status: json['status'],
      profilePicture: json['profile_picture'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'status': status,
      'profile_picture': profilePicture ?? '',
    };
  }
}
