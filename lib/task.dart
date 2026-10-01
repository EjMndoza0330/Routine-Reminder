import 'package:flutter/material.dart';

class Task {
  String name;
  TimeOfDay time;
  bool isCompleted;
  List<bool> recurrence;

  Task({required this.name, required this.time, this.isCompleted = false, List<bool>? recurrence}) : recurrence = recurrence ?? List.filled(7, false);

  Map<String, dynamic> toMap() => {
    'name': name,
    'time': time,
    'isCompleted': isCompleted,
    'recurrence': recurrence,
  };

  bool get isOverdue{
    final now = TimeOfDay.now();
    final nowMinutes = now.hour * 60 + now.minute;
    final taskMinutes = time.hour * 60 + time.minute;
    return !isCompleted && nowMinutes > taskMinutes;
  }

}
