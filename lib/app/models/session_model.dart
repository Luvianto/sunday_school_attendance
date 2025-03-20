import 'package:flutter/material.dart';

class SessionModel {
  final String? id;
  final String name;
  final int startHour;
  final int startMinute;
  final int endHour;
  final int endMinute;

  SessionModel({
    this.id,
    required this.name,
    required this.startHour,
    required this.startMinute,
    required this.endHour,
    required this.endMinute,
  });

  factory SessionModel.fromMap(Map<String, dynamic> map, {String? id}) {
    return SessionModel(
      id: id,
      name: map['name'],
      startHour: map['startHour'],
      startMinute: map['startMinute'],
      endHour: map['endHour'],
      endMinute: map['endMinute'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'startHour': startHour,
      'startMinute': startMinute,
      'endHour': endHour,
      'endMinute': endMinute,
    };
  }

  TimeOfDay get startTime => TimeOfDay(hour: startHour, minute: startMinute);
  TimeOfDay get endTime => TimeOfDay(hour: endHour, minute: endMinute);
}
