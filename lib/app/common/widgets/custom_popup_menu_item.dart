import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomPopupMenuItem extends PopupMenuItem<String> {
  CustomPopupMenuItem({
    super.key,
    required String value,
    required IconData icon,
    required String text,
    Color? iconColor,
    Color? textColor,
  }) : super(
          value: value,
          child: Row(
            children: [
              Icon(icon, color: iconColor),
              const SizedBox(width: 12.0),
              Text(
                text,
                style: Get.theme.textTheme.bodyLarge?.copyWith(
                  color: textColor,
                ),
              ),
            ],
          ),
        );
}
