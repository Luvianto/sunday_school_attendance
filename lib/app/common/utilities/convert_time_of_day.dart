import 'package:flutter/material.dart';

class ConvertTimeOfDay {
  static String toHourMinutePeriod(TimeOfDay timeOfDay) {
    final time = timeOfDay;
    int timeHour = time.hour;

    String period = timeHour >= 12 ? 'PM' : 'AM';
    // Jika lebih dari 12 maka dikurang 12
    // Jika tidak lebih dari 12 maka tidak maka tidak berubah, kecali 0
    timeHour = timeHour > 12 ? timeHour - 12 : (timeHour == 0 ? 12 : timeHour);

    String hour = timeHour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');

    return '$hour:$minute $period';
  }
}
