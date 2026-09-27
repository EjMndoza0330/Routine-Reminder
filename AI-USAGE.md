# AI usage

This project was built with AI assistance. This file is the record of it. It is
graded as the finals badge, and it is worth 100 points.

Start it in week 1 and keep it up as you go. The commit history of this file is
part of the evidence: a file written all at once the night before the deadline
looks exactly like what it is.

## 1. How I used AI

### 2026-09-21 to 2026-09-23 - 1st Week apptheme.dart CardThemeData error

- **Tool:** Google Gemini
- **What I asked for:**
  > I asked "Are there any Logic errors in the code?" in the apptheme.dart file
- **What it gave back:**
  > Invalid Class Name: The cardTheme parameter within ThemeData requires a CardTheme object, but the code attempts to use CardThemeData, which does not exist in the Flutter framework.
  > Redundant Spacing Values: Inside the AppSpacing class, both the base and tight variables are assigned the exact same value of 8. Semantic spacing variables should have distinctly scaled numbers to be logically useful.
  > Type Assignment Mismatch: The variables in the AppSpacing class are explicitly typed as double, but they are assigned integer literals (8, 16, 24) instead of standard floating-point values (8.0, 16.0, 24.0).
- **What I kept, what I changed, and why:**
  - I kept the Data in ```CardThemeData``` as that is correct, and the AI got wrong. 
  - I changed the Spacing Value for the base and tight as stated they are the same value, which is redudant.
  - I changed the assigned values of ```AppSpacing``` to float values 
- **Commit:** https://github.com/EjMndoza0330/Routine-Reminder/commit/b9b0d71538d6d03686282a20f8c86d8ec294f842

- **Tool:** Google Gemini
- **What I asked for:**
  > I added more tasks on the list, it isnt scrolling, how can i do that?
- **What it gave back:**
  > The issue occurs because your `ListView.builder` is placed directly inside a Column. A Column does not constrain the height of its children, meaning the `ListView` expands to full size to render every    > task at once, which disables its ability to scroll. To fix this, wrap the `ListView.builder` inside an `Expanded` widget. This forces the list to calculate the exact remaining vertical space on the
  > screen and activates its internal scrolling mechanism.
- **What I kept, what I changed, and why:**
  - All I changed was adding Expanded on the `ListView.builder`.
- **Commit:** https://github.com/EjMndoza0330/Routine-Reminder/commit/978f466a2d39f35cf84aa7b82f110dd661ec55ae

---

### 2026-09-26 to 2026-09-27 - 2st Week 
- **Tool:** Google Gemini
- **What I asked for:**
  - "is the formula for how `width * progress.clamp(0.0, 1.0)` the problem? because the bar fills up before it even goes 100%"
- **What it gave back:**
   - "The formula itself (width * progress.clamp(0.0, 1.0)) is mathematically correct — at 50% progress with `width: 300`, that's `150`, half the bar. So the real bug is somewhere else. Your instinct about sizing is close, but the actual likely cause: `width: 300.w` is a fixed value passed in from dashboard.dart, not derived from the actual available space. If the real screen is narrower than what `300.w` scales to (or the Card's padding/margins eat into that space), the outer track container itself overflows or gets clipped by its parent — so what you're seeing isn't "progress filling early," it's the whole bar (track + fill) rendering past its intended bounds, making the fill look proportionally bigger than it is. Fix: make the bar size itself from its parent's actual constraints, using FractionallySizedBox instead of manual pixel math. This removes the fixed-width guessing entirely and can't overflow"
- **What I kept, what I changed, and why:**
  - I clamped the progress to minimum 0.0 to maximum 1.0 so it wouldn't overflow and go pass 100%(I forgot to do it).
  - Got rid of the `width` parameter, using `LayoutBuilder` that reads `constraints.maxWidth` from what wraps it.
  - `FractionallySizedBox(widthFactor: clamped)` is equivalent to `width * progress`. It is the same ratio math, but Flutter determines the ratio at render time against the actual `width` that it took up in the layout, so it cannot ever be mismatched or overflow its container.  
- **Commit:** https://github.com/EjMndoza0330/Routine-Reminder/commit/31573e106a30a86889219df41d848c495a1b9d10

- **Tool:** Google Gemini
- **What I asked for:**
  - "How did this error occur?" `TypeError: null: type 'Null' is not a subtype of type 'double' See also: https://docs.flutter.dev/dev/testing/errors`
- **What it gave back:**
   - "The error is coming from the Checkbox's `onChanged` in dashboard.dart — that block isn't valid Dart. Fix — move the if check outside setState"
- **What I kept, what I changed, and why:**
  - I moved the `if` statement outside of `setState` while still inside `onChanged` in the `Checkbox()`. 
- **Commit:** https://github.com/EjMndoza0330/Routine-Reminder/commit/31573e106a30a86889219df41d848c495a1b9d10



## 2. Where the AI got it wrong

Three cases. Be specific. If you write that the AI was never wrong, this section
scores zero.

### Case 1 - 

- **What it gave me:**
  > Invalid Class Name: The cardTheme parameter within ThemeData requires a CardTheme object, but the code attempts to use CardThemeData, which does not exist in the Flutter framework.
- **What was wrong with it:** Google Gemini said that ```CardThemeData``` is invalid and said it does not exist in the Flutter framework
- **What I did instead:**
  > I kept it as ```CardThemeData``` as I found out through research on Google that what it told me was based on an older version of Flutter 
- **Commit:** https://github.com/EjMndoza0330/Routine-Reminder/commit/b9b0d71538d6d03686282a20f8c86d8ec294f842

### Case 2 - 

- **What it gave me:**
  ```
   Checkbox(
  value: t.isCompleted,
  onChanged: (checked) => setState(() {
    tasks[index].isCompleted = checked ?? false;
    percentage = tasks.where((task) => task.isCompleted).length / tasks.length;

    if (percentage == 1.0) {
      _completeAllTasks();
    }
  }),
  ),
  ```

- **What was wrong with it:**
  > It caused `TypeError: null: type 'Null' is not a subtype of type 'double' See also: https://docs.flutter.dev/dev/testing/errors`
-  **What I did instead:**
  > I moved the `if` statement outside of the `setState()` and also added `tasks.isEmpty ? 0.0 : ...`
- **Commit:** https://github.com/EjMndoza0330/Routine-Reminder/commit/31573e106a30a86889219df41d848c495a1b9d10
  
---

## 3. Who wrote what

At least a fifth of this project is code you wrote yourself. Name it, and explain
it in your own words.

### Written by me
- **File:** progress_bar.dart (update - 2026/09/26)
- **Commit:** https://github.com/EjMndoza0330/Routine-Reminder/commit/31573e106a30a86889219df41d848c495a1b9d10
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
  > `FractionallySizedBox(widthFactor: clamped)` computes the fill bar's pixel width.

- **File:** primary_button.dart
- **Commit:** https://github.com/EjMndoza0330/Routine-Reminder/commit/978f466a2d39f35cf84aa7b82f110dd661ec55ae#diff-35a6fe6fe9fa0492b4ade31fe99944cc541ffbf5b1542b70f167baa06524f0ad
- **What it does and why it is built this way:**
  > **What it does:**
  > It's a reusable button widget that wraps Flutter's `FilledButton`. You give it a `label` and an `onPressed` callback, and it renders a styled filled button matching the app's theme.
  > **Why it's built this way:**
  > `required this.label`, optional `onPressed` forces a label, but lets you pass null for `onPressed` to show a disabled button.
  > `FilledButton.styleFrom(...)` — customizes padding, colors, and corner radius in one call.
  > `RoundedRectangleBorder` gives it slightly rounded (8px) corners instead of Material's default pill shape.

- **File:** task.dart (update - 2026/009/26)
- **Commit:** https://github.com/EjMndoza0330/Routine-Reminder/commit/31573e106a30a86889219df41d848c495a1b9d10
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
