class StudentModel {
  final String? id;
  final String name;
  final String? profilePictureUrl;

  StudentModel({
    this.id,
    required this.name,
    this.profilePictureUrl,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json, String? id) {
    return StudentModel(
      id: id,
      name: json['name'],
      profilePictureUrl: json['profile_picture_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'profile_picture_url': profilePictureUrl ?? '',
    };
  }
}
