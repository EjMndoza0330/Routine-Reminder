import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'widgets/primary_button.dart';
import 'widgets/progress_bar.dart';
import 'apptheme.dart';
import 'task.dart';
import 'success.dart';
import 'taskmodal.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

//------------------------------------------------------------------------------fields
  double get percentage  =>
    tasks.isEmpty ? 0.0 : tasks.where((t) => t.isCompleted).length / tasks.length;
  late int streak = 0;
  bool _streakCountedToday = false;
  DateTime lastAccessedDate = DateTime.now();
  bool _isSameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;
//------------------------------------------------------------------------------fields

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
  }
//--------------------------------------------------------------------------------to call the Task Modal

//-------------------------------------------------------------------------------- Checking if the day has changed to reset the tasks and update the streak
@override
void initState() {
  super.initState();
  _checkNewDay();
}


void _checkNewDay() async {
  final now = DateTime.now();

  if (_isSameDay(now, lastAccessedDate)){
    
  }
  else{
    setState(() {
      for (final task in tasks){
        task.isCompleted = false;
      }
      lastAccessedDate = now;
      _streakCountedToday = false;
    });
  }
}
//-------------------------------------------------------------------------------- Checking if the day has changed to reset the tasks and update the streak

//--------------------------------------------------------------------------Sample Task Inputs
  List<Task> tasks = [
    
    Task(name: 'Clean Desk', time: const TimeOfDay(hour: 9, minute: 0)),
    Task(name: 'Clean Living Room', time: const TimeOfDay(hour: 10, minute: 0)),
    Task(name: 'Clean Kitchen', time: const TimeOfDay(hour: 11, minute: 0)),
    Task(name: 'Clean PC', time: const TimeOfDay(hour: 12, minute: 0)),
    Task(name: 'Clean Dishes', time: const TimeOfDay(hour: 13, minute: 0)),
  ]; 
//-------------------------------------------------------------------------Sample Task Inputs


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                      leading: Checkbox(
                        value: t.isCompleted,
                        onChanged: (checked) {
                          setState(() {
                            tasks[index].isCompleted = checked ?? false;
                          });
                          if (percentage == 1.0 && !_streakCountedToday) {
                            _completedAllTasks();
                            _streakCountedToday = true;
                          }
                        },
                      ), 
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              t.name,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                          Text(
                            t.time.format(context),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.edge),
                          IconButton(
                            onPressed: () => _handleTaskModal(existingTask: t, index: index),
                            style: IconButton.styleFrom(
                              foregroundColor: theme.colorScheme.onSurface,
                            ),
                            icon: Icon(Icons.edit),
                            iconSize: 20,
                          ),

                          IconButton(
                            onPressed: () => setState(() => tasks.removeAt(index)),
                            style: IconButton.styleFrom(
                              foregroundColor: theme.colorScheme.error,
                            ),
                            icon: Icon(Icons.delete),
                            iconSize: 20,
                          ),
                        ],
                      ),
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
