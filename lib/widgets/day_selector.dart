import 'package:flutter/material.dart';

class DaySelector extends StatelessWidget {
  const DaySelector ({super.key, required this.recurrence, required this.onChanged});

  final List<bool> recurrence;
  final ValueChanged<List<bool>> onChanged;

  static const _labels = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  @override
  Widget build(BuildContext context){
    final theme = Theme.of(context);

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, 
    children: List.generate(7, (index) {
      final selected = recurrence[index];
      return GestureDetector(
        onTap: (){
          final updated = List<bool>.from(recurrence);
          updated[index] = !updated[index];
          onChanged(updated);
        },
        child: Container(width: 36, height: 36, alignment: Alignment.center, decoration: BoxDecoration(
          shape: BoxShape.circle, color: selected ? theme.colorScheme.primary : theme.colorScheme.secondary.withValues(alpha: 0.4),
          border: Border.all(color: theme.colorScheme.primary, width: 1)),
          child: Text(
            _labels[index],
            style: theme.textTheme.labelLarge?.copyWith(color: selected ? theme.colorScheme.onPrimary : theme.colorScheme.onSecondary),
          )
        )
      );
    }),);
  }
}
