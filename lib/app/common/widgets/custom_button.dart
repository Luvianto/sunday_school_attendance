import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  final Color? backgroundColor;

  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Get.theme.colorScheme.primary,
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 4,
      ),
      child: Text(
        label,
        style: Get.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: Get.theme.colorScheme.onPrimary,
        ),
      ),
    );
  }
}
