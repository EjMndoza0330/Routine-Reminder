import 'package:flutter/material.dart';
import '../apptheme.dart';
import '../task.dart';
import 'widgets/day_selector.dart';

class TaskModal extends StatefulWidget {
  const TaskModal({super.key, this.task,});
  final Task? task; // null = Add mode, non-null = Edit mode//to check if a day is selected or not
  @override
  State<TaskModal> createState() => _TaskModalState();
}

class _TaskModalState extends State<TaskModal> {
  late final TextEditingController _nameController;
  late TimeOfDay _selectedTime;
  late List<bool> _recurrence;
  bool _showNameError = false;
  bool _showDaysError = false; 

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.task?.name ?? '');
    _selectedTime = widget.task?.time ?? const TimeOfDay(hour: 12, minute: 0);
    _recurrence = widget.task?.recurrence != null
        ? List<bool>.from(widget.task!.recurrence)
        : List.filled(7, false);
  }

  @override
  void dispose() {
    _nameController.dispose(); // controllers leak memory if not disposed
    super.dispose();
  }

  void _save() {
    final name = _nameController.text.trim();
    final noDays = !_recurrence.any((d) => d);
    if (name.isEmpty || noDays) { //if name is empty, it shouldn't save
      setState(() { 
        _showNameError = name.isEmpty;
        _showDaysError = noDays;});
      return;
    }
    final task = Task(
      name: name,
      time: _selectedTime,
      isCompleted: widget.task?.isCompleted ?? false,
      recurrence: _recurrence,
    );
    Navigator.pop(context, task);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEditing = widget.task != null;

    return Dialog(
      backgroundColor: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.edge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  title and close icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isEditing ? 'EDIT TASK' : 'ADD TASK',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context), //closes the modal (X) icon
                  icon: const Icon(Icons.close),
                  color: theme.colorScheme.onSurface,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.edge),

            // Task name
            Text(
              'TASK NAME:',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSpacing.base),
            TextField(
              controller: _nameController,
              onChanged: (_) {
                if (_showNameError) setState(() => _showNameError = false);
              },
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
              decoration: InputDecoration(
                hintText: 'Enter Text',
                errorText: _showNameError ? 'Task name cannot be empty' : null,
                filled: true,
                fillColor: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
              ),
            ),
            const SizedBox(height: AppSpacing.standard),

            // Schedule (your finished DayChipSelector)
            Text(
              'SCHEDULE:',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSpacing.base),
            DaySelector(
              recurrence: _recurrence,
              onChanged: (updated) => setState(() {
              _recurrence = updated;
              if (updated.any((d) => d)) _showDaysError = false;
              }),
            ),
            if (_showDaysError)
             Padding(
              padding: const EdgeInsets.only(top: AppSpacing.base),
              child: Text('Select at least one day', style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.error))
             ),

             const SizedBox(height: AppSpacing.standard),

            // Time
            Text(
              'TIME:',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSpacing.base),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: TextEditingController(
                      text:
                          '${_selectedTime.hourOfPeriod == 0 ? 12 : _selectedTime.hourOfPeriod}:${_selectedTime.minute.toString().padLeft(2, '0')}',
                    ),
                    readOnly: true,
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: _selectedTime,
                        builder: (context, child){
                          return Theme(data: Theme.of(context).copyWith(
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                foregroundColor: theme.colorScheme.onSurface
                              ),
                            ),
                          ),
                          child: child!,
                          );
                        }
                      );
                      if (picked != null) {
                        setState(() => _selectedTime = picked);
                      }
                    },
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.base),
                DropdownButton<DayPeriod>(
                  value: _selectedTime.period,
                  dropdownColor: theme.colorScheme.surface,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                  items: const [
                    DropdownMenuItem(value: DayPeriod.am, child: Text('AM')),
                    DropdownMenuItem(value: DayPeriod.pm, child: Text('PM')),
                  ],
                  onChanged: (period) {
                    if (period == null) return;
                    setState(() {
                      final hour = period == DayPeriod.pm
                          ? (_selectedTime.hourOfPeriod == 0 ? 12 : _selectedTime.hourOfPeriod) + 12
                          : (_selectedTime.hourOfPeriod == 0 ? 0 : _selectedTime.hourOfPeriod);
                      _selectedTime = TimeOfDay(hour: hour % 24, minute: _selectedTime.minute);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.standard),

            // Save button
            Align(
              alignment: Alignment.center,
              child: FilledButton(
                onPressed: _save,
                child: const Text('SAVE TASK'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}