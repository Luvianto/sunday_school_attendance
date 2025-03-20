import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class CustomTimePicker extends StatelessWidget {
  final TimeOfDay initialTime;
  final Function(TimeOfDay) onTimeSelected;
  final double? spacing;
  final double? itemWidth;
  final double? itemHeight;

  const CustomTimePicker({
    super.key,
    required this.initialTime,
    required this.onTimeSelected,
    this.spacing,
    this.itemWidth,
    this.itemHeight,
  });

  @override
  Widget build(BuildContext context) {
    // tanggal, bulan, dan tahun initialDateTime tidak akan digunakan jadi di hardcode
    DateTime initialDateTime = DateTime(
      2025, // tahun
      1, // bulan
      1, // tanggal
      initialTime.hour,
      initialTime.minute,
    );

    return TimePickerSpinner(
      time: initialDateTime,
      is24HourMode: false, // Menggunakan sistem PM/AM dari pada 0-24 jam
      isForce2Digits: true, // Menambahkan '0' di depan jika digit hanya satu
      normalTextStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
      highlightedTextStyle: Theme.of(context).textTheme.displaySmall,
      spacing: spacing ?? 20,
      itemHeight: itemHeight ?? 54,
      itemWidth: itemWidth ?? 54,
      onTimeChange: (time) {
        onTimeSelected(TimeOfDay(hour: time.hour, minute: time.minute));
      },
    );
  }
}
