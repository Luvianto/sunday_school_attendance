import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomLabel extends StatelessWidget {
  final String label;

  const CustomLabel({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(label, style: Get.textTheme.bodyLarge),
    );
  }
}
