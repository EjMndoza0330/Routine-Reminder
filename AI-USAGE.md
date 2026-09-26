# AI usage

This project was built with AI assistance. This file is the record of it. It is
graded as the finals badge, and it is worth 100 points.

Start it in week 1 and keep it up as you go. The commit history of this file is
part of the evidence: a file written all at once the night before the deadline
looks exactly like what it is.

## 1. How I used AI

### 2026-09-21 - 1st Week apptheme.dart CardThemeData error

- **Tool:** Google Gemini
- **What I asked for:**
  > I asked "Are there any Logic errors in the code?" in the apptheme.dart file
- **What it gave back:**
  > Invalid Class Name: The cardTheme parameter within ThemeData requires a CardTheme object, but the code attempts to use CardThemeData, which does not exist in the Flutter framework.
  > Redundant Spacing Values: Inside the AppSpacing class, both the base and tight variables are assigned the exact same value of 8. Semantic spacing variables should have distinctly scaled numbers to be logically useful.
  > Type Assignment Mismatch: The variables in the AppSpacing class are explicitly typed as double, but they are assigned integer literals (8, 16, 24) instead of standard floating-point values (8.0, 16.0, 24.0).
- **What I kept, what I changed, and why:**
  - I kept the Data in ```CardThemeData``` as that is correct, and the AI got wrong.
  - I changed the Spacing Value for the base and tight as stated they are the same value.
  - I changed the assigned values of ```AppSpacing``` to float values 
- **Commit:** https://github.com/EjMndoza0330/Routine-Reminder/commit/b9b0d71538d6d03686282a20f8c86d8ec294f842




## 2. Where the AI got it wrong

Three cases. Be specific. If you write that the AI was never wrong, this section
scores zero.

### Case 1 - apptheme.dart CardThemeData error

- **What it gave me:**
  > Invalid Class Name: The cardTheme parameter within ThemeData requires a CardTheme object, but the code attempts to use CardThemeData, which does not exist in the Flutter framework.
- **What was wrong with it:** Google Gemini said that ```CardThemeData``` is invalid and said it does not exist in the Flutter framework
- **What I did instead:**
  > I kept it as ```CardThemeData``` as I found out through research on Google that what it told me was based on an older version of Flutter 
- **Commit:** https://github.com/EjMndoza0330/Routine-Reminder/commit/b9b0d71538d6d03686282a20f8c86d8ec294f842

## 3. Who wrote what

At least a fifth of this project is code you wrote yourself. Name it, and explain
it in your own words.

### Written by me
- **File:** progress_bar.dart
- **Commit:** https://github.com/EjMndoza0330/Routine-Reminder/commit/978f466a2d39f35cf84aa7b82f110dd661ec55ae#diff-35a6fe6fe9fa0492b4ade31fe99944cc541ffbf5b1542b70f167baa06524f0ad
- **What it does and why it is built this way:**
  > **What it does:**
  > A custom progress bar widget. It takes a `progress` value (0.0, 1.0) and renders:
  >
  > -A rounded "track" (background) in a faded secondary color.
  > -A rounded "fill" bar on top, sized to width * progress, in the primary color.
  > -A percentage label centered on top of both.
  > **Why it's built this way:**
  > Two stacked `Containers` instead of the built-in LinearProgressIndicator — can have full control over the colors, rounded corners and can even have a percentage label on top, which the built-in widget   can't easily do.
  > `Stack` layers the fill bar and the text over the track without affecting layout size.
  > `width * progress` computes the fill bar's pixel width.

- **File:** primary_button.dart
- **Commit:** https://github.com/EjMndoza0330/Routine-Reminder/commit/978f466a2d39f35cf84aa7b82f110dd661ec55ae#diff-35a6fe6fe9fa0492b4ade31fe99944cc541ffbf5b1542b70f167baa06524f0ad
- **What it does and why it is built this way:**
  > **What it does:**
  > It's a reusable button widget that wraps Flutter's `FilledButton`. You give it a `label` and an `onPressed` callback, and it renders a styled filled button matching the app's theme.
  > **Why it's built this way:**
  > `required this.label`, optional `onPressed` forces a label, but lets you pass null for `onPressed` to show a disabled button.
  > `FilledButton.styleFrom(...)` — customizes padding, colors, and corner radius in one call.
  > `RoundedRectangleBorder` gives it slightly rounded (8px) corners instead of Material's default pill shape.

- **File:** task.dart
- **Commit:** 
- **What it does and why it is built this way:**
  > **What it does:**
  > There are three fields,` name` and `time` are `required`, `isCompleted` is defaulted to `false` since new tasks are naturally incomplete. `toMap()` converts the object into a `Map<String, dynamic>` a key-value structure.
  > **Why it's built this way:**
  > Instead of loose variables, a class that packages all the information for a particular task together: `name, time` & `status`. This will allow you to create a List<Task> and manipulate tasks in bulk rather than having to manage three separate lists that need to be kept synchronized.
  > Named parameters (`required this.name`, etc.) when creating a task, it's clear what each parameter refers to, and it's easy to avoid accidentally putting the order of the parameters wrong.
The default value for isCompleted is `false` cause a new task starts off without being completed, so don't have to type that out every time.
  > `toMap()` is typically the first step before saving a task to local storage. Converts your object into a simple Map for easy JSON generation.

### The AI-written part I understand best

- **File:**
- **Commit:**
- **What it does and why I kept it:**
