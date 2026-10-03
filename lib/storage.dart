import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'task.dart';

class TaskStorage{
  static const _tasksKey = 'tasks';
  static const _streakKey = 'streak';
  static const _lastAccessedKey = 'lastAccessedDate';
  static const _streakCountedKey = 'streakCountedToday';

//-------------------------------------------------------------------Task
   Future<void> saveTasks(List<Task> tasks) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = tasks.map((t) => jsonEncode(t.toMap())).toList();
      await prefs.setStringList(_tasksKey, jsonList);
    } catch (_) {
    // Save failed silently. In-memory state is unaffected, app keeps running.
    }
  }

  Future<List<Task>> loadTask() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = prefs.getStringList(_tasksKey) ?? [];
      return jsonList
      .map((s) => Task.fromMap(jsonDecode(s) as Map<String, dynamic>))
      .toList();
    } catch (_) {
      return []; /// Corrupted or missing data. app starts clean instead of crashing.
    }
  }
//-------------------------------------------------------------------Task

//-------------------------------------------------------------------Streak
  Future<void> saveStreak(int streak) async{
    try{
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_streakKey, streak);
    } catch(_){}
  }

  Future<int> loadStreak() async{
    try{
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt(_streakKey) ?? 0;
    }catch(_){
      return 0;
    }
  }
//-------------------------------------------------------------------Streak

//-------------------------------------------------------------------Last Accessed Date
Future<void> saveLastAccessedDate(DateTime date) async{
  try{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastAccessedKey, date.toIso8601String());
  }catch(_){}
}

Future<DateTime?> loadLastAccessedDate() async{
  try{
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_lastAccessedKey);
    return s == null ? null : DateTime.parse(s);

  }catch(_){
    return null;
  }
}
//-------------------------------------------------------------------Last Accessed Date

//-------------------------------------------------------------------Streak Counted Today
Future<void> saveStreakCountedToday(bool value) async{
  try{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_streakCountedKey, value);
  }catch(_){}
}

Future<bool> loadStreakCountedToday() async{
  try{
    final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(_streakCountedKey) ?? false;
  }catch (_){
    return false;}
}
//-------------------------------------------------------------------Streak Counted Today
}