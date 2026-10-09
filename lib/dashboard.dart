import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'widgets/primary_button.dart';
import 'widgets/progress_bar.dart';
import 'apptheme.dart';
import 'task.dart';
import 'success.dart';
import 'taskmodal.dart';
import 'storage.dart';
import 'dart:async';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
//-------------------------------------------------------------------Task Storage
  final TaskStorage _storage = TaskStorage();
//-------------------------------------------------------------------Task Storage

//-------------------------------------------------------------------Loading Flag
  bool _isLoading = true;
//-------------------------------------------------------------------Loading Flag

//------------------------------------------------------------------------------fields
  double get percentage  =>
    tasks.isEmpty ? 0.0 : tasks.where((t) => t.isCompleted).length / tasks.length;
  late int streak = 0;
  bool _streakCountedToday = false;
  DateTime lastAccessedDate = DateTime.now();
  bool _isSameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;
  Timer? _ticker;
//------------------------------------------------------------------------------fields


//-------------------------------------------------------------------Loading Task Storage
@override 
void initState() {
  super.initState();
  _loadData();
   _ticker = Timer.periodic(const Duration(seconds: 15), (_) {
    if (!mounted || _isLoading) return;
    _checkNewDay();   // catches midnight with the app left open
    setState(() {});  // re-evaluates isOverdue
  });
}

Future<void> _loadData() async {
  final loadedTasks = await _storage.loadTask();
  final loadedStreak = await _storage.loadStreak();
  final loadedDate = await _storage.loadLastAccessedDate();
  final loadedCounted = await _storage.loadStreakCountedToday();

  setState(() {
    tasks = loadedTasks;
    streak = loadedStreak;
    lastAccessedDate = loadedDate ?? DateTime.fromMillisecondsSinceEpoch(0);
    _streakCountedToday = loadedCounted;
    _isLoading = false;
  });

  _checkNewDay();
}
//-------------------------------------------------------------------Loading Task Storage

@override
void dispose() {
  _ticker?.cancel();
  super.dispose();
}

//-------------------------------------------------------------------------------- Checking if the day has changed to reset the tasks and update the streak
void _checkNewDay() async {
  final now = DateTime.now();

  if (_isSameDay(now, lastAccessedDate)){
    return;
  }
  else{
    setState(() {
      for (final task in tasks){
        task.isCompleted = false;
      }
      lastAccessedDate = now;
      _streakCountedToday = false;
    });
    _storage.saveTasks(tasks);
    _storage.saveLastAccessedDate(now);
    _storage.saveStreakCountedToday(false);
  }
}
//-------------------------------------------------------------------------------- Checking if the day has changed to reset the tasks and update the streak

//-------------------------------------------------------------------------------to update Streak and progress bar
  Future<void> _completedAllTasks() async { //--to update Streak and progress bar
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SuccessScreen(streak: streak + 1, progress: percentage),
      ),
    );

    setState(() {
      streak++;
    });
    _storage.saveStreak(streak);
  }
//--------------------------------------------------------------------------------to update Streak and progress bar

//--------------------------------------------------------------------------------to call the Task Modal
  Future<void> _handleTaskModal({Task? existingTask, int? index}) async {
    final result =  await showDialog<Task>(
      context: context,
      builder: (_) => TaskModal(task: existingTask), 
    );

    if (result == null){ //when the user cancells or exits the modal, it'll do nothing
      return;
    }
    
    setState(() {
      if (index != null){
        tasks[index] = result; //for edit
      }
      else{
        tasks.add(result); //to add
      }
    });

    _storage.saveTasks(tasks);
  }
//--------------------------------------------------------------------------------to call the Task Modal

//--------------------------------------------------------------------------Task LIst
  List<Task> tasks = []; 
//-------------------------------------------------------------------------Task List

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

//-------------------------------------------------------------------Loading Flag
    if (_isLoading){
      return Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: Center(child: CircularProgressIndicator(color: theme.colorScheme.primary),)
      );
    }
//------------------------------------------------------------------Loading Flag    

//---------------------------------------------------------------------------------Confirm Deletion
void _confirmDelete(int index) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: theme.colorScheme.surface,
      title: Text('Delete Task?', style: theme.textTheme.headlineSmall?.copyWith(color: theme.colorScheme.onSurface)),
      content: Text('This will permanently remove "${tasks[index].name}".'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
        child: Text('Cancel', style: TextStyle(color: theme.colorScheme.onSurface)),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text('Delete', style: TextStyle(color: theme.colorScheme.error))
        ),
      ],
    ),
  );
  if (confirmed == true){
    setState(() => tasks.removeAt(index));
    _storage.saveTasks(tasks);
  }
}
//--------------------------------------------------------------------------------Confirm Deletion

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        title: Text(
          'ROUTINE REMINDER',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onPrimary,
          ),
        ),
      ),
      body: Card(
        margin: const EdgeInsets.all(AppSpacing.edge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
//----------------------------------------------------------------Icon + Streak Counter
            Row(
              
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.local_fire_department,
                  size: (155.r).clamp(120.0, 200.0),
                  color: theme.colorScheme.primary,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'CURRENT STREAK',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                      Text(
                        '$streak',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: AppSpacing.base),
              ],
            ),
//-----------------------------------------------------------Icon + Streak Counter

//---------------------------------------------------------------Progress Bar
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Daily Progress',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.edge),
                ProgressBar(progress: percentage, height: 20.h, width: 300.w),
              ], 
            ),
//---------------------------------------------------------------Progress Bar

            const SizedBox(height: AppSpacing.edge),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'TASKS',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.edge),

//------------------------------------------------Task List
            Expanded(
              child: ListView.builder(      
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final t = tasks[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: AppSpacing.edge),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: theme.colorScheme.secondary,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: Checkbox( //---------------------------------Checkbox
                        value: t.isCompleted,
                        onChanged: _streakCountedToday ? null : (checked) {
                          setState(() {
                            tasks[index].isCompleted = checked ?? false;
                          });

                          _storage.saveTasks(tasks);

                          if (percentage == 1.0 && !_streakCountedToday) {
                            _completedAllTasks();
                            _streakCountedToday = true;
                            _storage.saveStreakCountedToday(true);
                          }
                        },
                      ), 
                      title: Text(
                              t.name,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                      subtitle:Padding(padding: const EdgeInsets.only(top: 4),
                      child: Wrap(
                        spacing: AppSpacing.base,
                        runSpacing: 4,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            t.time.format(context),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          Text(t.scheduleLabel, style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.7))),
                          if (t.isOverdue) ...[ //---------------------------------Overdue Tag
                            const SizedBox(width: AppSpacing.edge),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base, vertical: 2),
                              decoration: BoxDecoration(color: theme.colorScheme.error,
                              borderRadius: BorderRadius.circular(12)),
                              child: Text('OVERDUE', style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onError),
                              ), 
                            ),
                          ], 
                        ],
                        
                      ),
                      ),
                      trailing: Row(mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () => _handleTaskModal(existingTask: t, index: index),
                            style: IconButton.styleFrom(
                              foregroundColor: theme.colorScheme.onSurface,
                            ),
                            icon: Icon(Icons.edit),
                            iconSize: 20,
                          ),

                          IconButton(
                            onPressed: t.isCompleted ? null : () => _confirmDelete(index),
                            style: IconButton.styleFrom(
                              foregroundColor: theme.colorScheme.error,
                            ),
                            icon: Icon(Icons.delete),
                            iconSize: 20,
                          ),
                        ],
                      )

                    ),
                  );
                },
              ),
            ),
//------------------------------------------------Task List

            const SizedBox(height: AppSpacing.edge),

//------------------------------------------------------------Primary Button
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.40,
                child: PrimaryButton(label: 'ADD TASK', onPressed: () => _handleTaskModal()),
              ),
            ),
//----------------------------------------------------------------Primary Button
          ], 
//-----------------------------------------------------------------Body column children
        ),
      ),
    );
  }
}
