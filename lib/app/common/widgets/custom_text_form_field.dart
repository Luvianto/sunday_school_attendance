import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextFormField extends StatelessWidget {
  final bool readOnly;
  final bool autofocus;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.readOnly = false,
    this.autofocus = false,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      autofocus: autofocus,
      onChanged: onChanged,
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Get.theme.colorScheme.outlineVariant),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide:
              BorderSide(color: Get.theme.colorScheme.outlineVariant, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide:
              BorderSide(color: Get.theme.colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(color: Get.theme.colorScheme.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(color: Get.theme.colorScheme.error, width: 2),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
