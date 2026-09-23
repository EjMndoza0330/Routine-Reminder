import 'package:flutter/material.dart';

class Task {
  String name;
  TimeOfDay time;
  bool isCompleted;

  Task({required this.name, required this.time, this.isCompleted = false});
}
