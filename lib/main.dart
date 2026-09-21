// This is your app. It runs as it is: press run and you get the screen below.
//
// Nothing here is precious. Change the title, change the colors, delete the
// counter, add your own screens. It exists so that the repository is a working
// Flutter app from minute one instead of an empty folder.
//
// Everything in this file is Module 4 and 5 material: StatelessWidget,
// StatefulWidget, setState, Scaffold, AppBar, Column, Card, FilledButton.

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'apptheme.dart';

void main() {
  runApp(
    // DevicePreview draws a phone frame around your app, so it is judged at the
    // size it was designed for instead of stretched across a laptop window.
    //
    // It is left ON in the deployed build on purpose: your live link is opened
    // on a desktop browser, and a phone layout at full desktop width looks
    // broken when it is not. The toolbar also lets a visitor switch device and
    // orientation.
    //
    // Want the clean app with no frame instead (for a portfolio, or because
    // you made the layout properly responsive)? Add
    //   import 'package:flutter/foundation.dart' show kReleaseMode;
    // and set `enabled: !kReleaseMode`, which drops the frame in release builds.
    DevicePreview(enabled: true, builder: (context) => const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Routine Reminder',
      debugShowCheckedModeBanner: false,
      // These two lines are what make the DevicePreview toolbar actually
      // change the app. Keep them.
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      // Your design system starts here. One seed color generates a full
      // Material palette; swap in your own and every screen follows.
      theme: appTheme,
      home: const Dashboard(),
    );
  }
}

/// The first screen. Replace it with yours.
///
/// It is a StatefulWidget because it remembers something that changes: the
/// counter. A screen that never changes can be a StatelessWidget instead.
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // State: a plain field. Changing it does nothing on its own; the screen only
  // redraws when you change it inside setState.

  @override
  Widget build(BuildContext context) {
    // Reading colors and text styles from the theme, instead of hardcoding
    // them, is what keeps every screen looking like the same app.
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('ROUTINE REMINDER', style: theme.textTheme.headlineSmall),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: Container(
        padding: const EdgeInsets.all(AppSpacing.standard),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.local_fire_department,
              size: 170,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: AppSpacing.base),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('CURRENT STREAK', style: theme.textTheme.bodyMedium),
                const SizedBox(height: AppSpacing.base),
                Text('10', style: theme.textTheme.bodyMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
