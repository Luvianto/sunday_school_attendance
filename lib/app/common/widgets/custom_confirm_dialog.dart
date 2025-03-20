import 'package:flutter/material.dart';

class CustomConfirmDialog extends StatelessWidget {
  final Widget child;
  final void Function()? onConfirm;
  final void Function()? onCancel;

  const CustomConfirmDialog({
    super.key,
    required this.child,
    this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          const SizedBox(height: 16.0),
          //
          child,
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: onCancel,
                child: const Text("Batal"),
              ),
              TextButton(
                onPressed: onConfirm,
                child: const Text("Simpan"),
              ),
            ],
          ),
          //
          const SizedBox(height: 16.0),
          //
        ],
      ),
    );
  }
}
