import 'package:flutter/material.dart';

class Task {
  String name;
  TimeOfDay time;
  bool isCompleted;
  List<bool> recurrence;

  Task({required this.name, required this.time, this.isCompleted = false, List<bool>? recurrence}) : recurrence = recurrence ?? List.filled(7, false);

  Map<String, dynamic> toMap() => {
    'name': name,
    'hour': time.hour,
    'minute':time.minute,
    'isCompleted': isCompleted,
    'recurrence': recurrence,
  };

  factory Task.fromMap(Map<String,dynamic> map) => Task(
    name: map['name'] as String, 
    time: TimeOfDay(
      hour: map['hour'], 
      minute: map['minute'] as int
      ),
    isCompleted: map['isCompleted'] as bool,
    recurrence: List<bool>.from(map['recurrence'] as List),
    );

  bool get isOverdue{
    final now = DateTime.now();
    final todayIndex = now.weekday % 7;

    if(!recurrence[todayIndex]) return false;
    final nowMinutes = now.hour * 60 + now.minute;
    final taskMinutes = time.hour * 60 + time.minute;
    return !isCompleted && nowMinutes > taskMinutes;
  }
}
