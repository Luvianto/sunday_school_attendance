import 'dart:convert';

import 'package:flutter/material.dart';

class StudentListView extends StatelessWidget {
  final String studentName;
  final String? studentProfilePicture;
  final void Function()? onTap;
  final bool isSelected;

  const StudentListView({
    super.key,
    required this.studentName,
    required this.studentProfilePicture,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(studentName, style: Theme.of(context).textTheme.bodyLarge),
        leading: CircleAvatar(
          radius: 32,
          backgroundImage:
              studentProfilePicture != null && studentProfilePicture!.isNotEmpty
                  ? MemoryImage(base64Decode(studentProfilePicture!))
                  : null,
          child: studentProfilePicture == null && studentProfilePicture!.isEmpty
              ? Text(studentName[0].toUpperCase())
              : null,
        ),
        onTap: onTap,
      ),
    );
  }
}
