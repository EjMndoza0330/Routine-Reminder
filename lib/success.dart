import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'widgets/progress_bar.dart';
import 'widgets/primary_button.dart';
import 'apptheme.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({
    super.key,
    required this.streak,
    required this.progress,
  });
  final int streak;
  final double progress;

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.standard),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(AppSpacing.base),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: theme.colorScheme.primary,
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'CONGRADULATIONS!',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.standard),
                Container(
                  padding: EdgeInsets.all(AppSpacing.standard),
                  child: Icon(
                    Icons.celebration,
                    size: (274.r).clamp(120.0, 200.0),
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: AppSpacing.edge),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'STREAK UPDATED!',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                          Text(
                            'NEW STREAK: ${widget.streak}',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.local_fire_department,
                      size: 120.r,
                      color: theme.colorScheme.primary,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'PROGRESS:',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.edge),
                    ProgressBar(
                      progress: widget.progress,
                      height: 20.h,
                      width: 300.w,
                    ),
                    const SizedBox(height: AppSpacing.edge),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "You've completed all tasks for today.",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                        Text(
                          "Keep up the good work",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.edge),
                  ],
                ),
                Align(
                  //------------------------------------------------------------Primary Button
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.40,
                    child: PrimaryButton(
                      label: 'RETURN DASHBOARD',
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ), //----------------------------------------------------------------Primary Button
              ],
            ),
          ),
        ),
      ),
    );
  }
}
