# AI usage

This project was built with AI assistance. This file is the record of it. It is
graded as the finals badge, and it is worth 100 points.

Start it in week 1 and keep it up as you go. The commit history of this file is
part of the evidence: a file written all at once the night before the deadline
looks exactly like what it is.

## 1. How I used AI

### 2026-09-21 to 2026-09-23 - 1st Week 

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
  > The issue occurs because your `ListView.builder` is placed directly inside a Column. A Column does not constrain the height of its children, meaning the `ListView` expands to full size to render every task at once, which disables its ability to scroll. To fix this, wrap the `ListView.builder` inside an `Expanded` widget. This forces the list to calculate the exact remaining vertical space on the
 screen and activates its internal scrolling mechanism.
- **What I kept, what I changed, and why:**
  > **What I kept:** the original `List.builder`/`itemBuilder` structure and the `Column` wrapping everything else on the screen — the fix didn't require restructuring my layout, just adding one constraint.
  > **What I changed:** wrapped `ListView.builder` in `Expanded`
  > **Why?:** With a `Column`, all the children are given their default size of unlimited height, and the `ListView` will use that to calculate a size that can include all the tasks, but won't be able to scroll through the extra space. A `Column` with a `ListView` in it renders every task but not enough to be scrolled through because the extra space is not part of the default size of the `ListView` by itself. If this bound is not there, Flutter lacks a "viewport" to scroll. The list was not broken, it only didn't have any horizontal scroll bar inside it.
- **Commit:** https://github.com/EjMndoza0330/Routine-Reminder/commit/978f466a2d39f35cf84aa7b82f110dd661ec55ae

---

### 2026-09-26 to 2026-09-27 - 2nd Week 
- **Tool:** Claude
- **What I asked for:**
  > "How did this error occur?" `TypeError: null: type 'Null' is not a subtype of type 'double' See also: https://docs.flutter.dev/dev/testing/errors`
- **What it gave back:**
   > "The error is coming from the Checkbox's `onChanged` in dashboard.dart — that block isn't valid Dart. Fix — move the if check outside setState"
- **What I kept, what I changed, and why:**
  > **What I kept:** This was correct, but the logic within the `setState` method (updating `tasks[index].isCompleted` and recalculating the percentage) was inside the wrong structure.
  > **What I changed:** Moved the `if (percentage == 1.0) { _completeAllTasks(); }` check from within the `setState()` call to after it.
  > **Why:** The changes to the state that Flutter should respond to and rebuild should be state mutations, not the result of the mutation (such as deciding on what screen to go to if the mutation is success). This also follows the general rule of keeping `setState` callbacks as synchronous, and as narrow in scope as possible, as `_completeAllTasks()` does some async work (await Navigator.push(...)), which should not be in the middle of a `setState` callback, at all.
- **Commit:** https://github.com/EjMndoza0330/Routine-Reminder/commit/31573e106a30a86889219df41d848c495a1b9d10

- **Tool:** Claude
- **What I asked for:** 
  - I asked what is wrong with my layout functions? why can't I get the layout right?" (with a screenshot of the success screen)
- **What it gave back** 
  - Three issues — no `SingleChildScrollView` around the `body` (risk of vertical overflow on shorter devices), the streak `Row` had no `Expanded`/`Flexible` so a longer streak number could push the flame icon off-screen, and the `274.r` celebration icon was too large relative to `flutter_screenutil`'s scaling. Gave the wrapped/fixed version of each.
- **What I kept, what I changed, and why:** 
  > **What I kept:** Overall screen layout and `Center()`/`Column()` structure, nothing required restructuring, but constraints placed around existing structure.
  > **What I changed:** Wrapped the body in a `SingleChildScrollView`, wrapped the streak `Text` column in an `Expanded` inside the `Row` and limited the size of the celebration icon with `.clamp(120.0, 200.0)`.
  >  **Why?:** When a `Column` is not wrapped in a `ScrollView`, it doesn't scroll when it doesn't fit, instead it displays beyond the bottom edge and raises an overflow error. A `SingleChildScrollView` provides this content with a scrollable container inside. Then, each child has a default width of a `Row`, which means a longer streak number won't have anywhere to stop its expansion and could push the flame icon off-screen, preventing the Flame icon from being widened by `Expanded`, which is a column that only absorbs the leftover width. The icon's `.r` value is relative to the design size from `flutter_screenutil`, which means that on another aspect ratio it can fill up the actual screen height in an inappropriate amount when it is scaled, but the `.r` value will force it to stay within a safe range when it is scaled.
- **Commit:** https://github.com/EjMndoza0330/Routine-Reminder/commit/31573e106a30a86889219df41d848c495a1b9d10

---

### 2026-09-28 to 2026-10-04 - 3rd Week 

- **Tool:** Claude
- **What I asked for:** 
  > regarding the data going back to the dashboard task list. that logic will be in the dart file of the modal itself correct? not in the dashboard.dart? 
- **What it gave back** 
  > Disagreed — said the mutation logic belongs in dashboard.dart since it owns the tasks list; the modal's only job is building a Task and calling Navigator.pop(context, task). Explained the split as "modal = build-and-return, dashboard = trigger-and-mutate."
- **What I kept, what I changed, and why:** 
  > **What I changed:** I placed the logic that decides what to do with the returned task from the modal (which is to append to `tasks` list, replace an entry for edit, recalculate the percentage for the progress bar) inside `dashboard`, inside `_handleTaskModal()` rather than inside the `task_modal`'s file.
  > **What I kept:** Kept the modals original responsibility, which is: Building a `Task` object from `form` input and returning it via `Navigator.pop(context, tast)`.
  > **Why?:** The list of tasks is not in the domain of `TaskModal`, it belongs to the `dashboard.dart` file where it is declared and kept in `_DashboardState`. If both widgets mutate the same list, either one of them might do so directly, causing some sort of mutation to be passed in a way that doesn't call for `setState` where it is actually happening, and the modal will be tightly coupled to the internal state of `Dashboard`, making it less reusable. This allows the modal to remain a simple, re-usable, "build and return data" screen, and the dashboard to remain the one place where it determines the action to be taken on the returned Task.
- **Commit:** https://github.com/EjMndoza0330/Routine-Reminder/commit/05cd94c61cc6bca0fe572519b7dda06093cacd82

- **Tool:** Claude
- **What I asked for:** 
  >  Overdue is not working. in the day_selector.dart It only contains a list of Letters to represent the day, but nothing more.
- **What it gave back** 
  > the bug wasn't in day_selector.dart at all — it was in task.dart's isOverdue getter, which had two separate problems: (1) it computed `taskMinutes` using `now.hour * 60 + time.minute`, mixing the current hour with the task's own minute instead of using the task's own hour; and (2) it never referenced `recurrence` at all, so a task scheduled for only one day of the week would show as overdue on every day past its time, not just its scheduled day. Gave the fix for both — correcting the time math to `time.hour * 60 + time.minute`, and adding a check against `recurrence[now.weekday % 7]` before evaluating time at all.
- **What I kept, what I changed, and why:** 
  > **What I changed:** the overall structure of the `isOverdue` as a computed getter on Task itself, not the logic living in `dashboard`, that is correct, it was just the calculation was wrong.
  > **What I kept:** Replaced the time comparison with using `time.hour`, `time.minute` consistently – a task can only be overdue on a day it is scheduled for (with a `recurrence[todayIndex]` check, but with `now.weekday % 7` to convert from the Dart's Monday first weekday numbering to the my Sunday first weekday number.
  > **Why?:** A getter belongs on `Task` because the overdue-ness is a property of each task comparing itself against the current time. It should't need `dashboard` to compute it externally. The time bug is important because mixing `now`'s hour with the task's minute resulted in meaningless comparisons that happened to look plausible for some times and wrong for others. The recurrence bug mattered because without checking days, a task repeats on any tasks past its scheduled time would show as overdue indefinitely, regardless of where today was actually one of its scheduled days which defeats the purpose of having a recurrence schedule.
- **Commit:** https://github.com/EjMndoza0330/Routine-Reminder/commit/adfa9c503c3ad1d06c935f8887cf41b2f86dd729
  
## 2. Where the AI got it wrong

Three cases. Be specific. If you write that the AI was never wrong, this section
scores zero.

### Case 1 - 

- **What it gave me:**
  > Invalid Class Name: The cardTheme parameter within ThemeData requires a CardTheme object, but the code attempts to use CardThemeData, which does not exist in the Flutter framework.
- **What was wrong with it:** This is backwards. Per Flutter's own breaking-changes documentation (docs.flutter.dev/release/breaking-changes/material-theme-system-updates), `ThemeData.cardTheme` was migrated to require `CardThemeData` specifically, landing in Flutter 3.31 and stable as of 3.32. My project's SDK constraint (`sdk: ^3.8.0` in pubspec.yaml) ships with Flutter 3.32+, meaning `CardThemeData` is the correct, required type for my project, not an invalid one. The old `CardTheme` class is what's now considered legacy/migrated-away-from.
- **What I did instead:**
  > Kept `CardThemeData` as originally written, verified against Flutter's official migration guide rather than general web search.
- **Commit:** https://github.com/EjMndoza0330/Routine-Reminder/commit/b9b0d71538d6d03686282a20f8c86d8ec294f842

### Case 2 - 

- **What it gave me:**
  ```
  bool get isOverdue {
  final now = TimeOfDay.now();
  final nowMinutes = now.hour * 60 + now.minute;
  final taskMinutes = now.hour * 60 + time.minute; // ← my bug: now.hour, not time.hour
  return !isCompleted && nowMinutes > taskMinutes;
  }
  ```
- **What was wrong with it:**
  > This was `Claude`'s own output when first building out the `Task` model. Two separate problems: `taskMinutes` got mixed with `now`'s hour with the task's own minute instead of using `time.hour`, producing a comparison that didn't actually represent the task's scheduled time. Separately, the getter never referenced `recurrence` at all, so a task scheduled for only one day of the week would show as overdue every day past its time, not just its scheduled day. Both bugs shipped silently and weren't caught until I tested the overdue badge and it behaved incorrectly.
-  **What I did instead:**
  > I Flagged the behavior ("Overdue is not working") with the context of what the recurrence days represented, which led to identifying both bugs. Fixed the time math to `time.hour * 60 + time.minute`, and added a check against `recurrence[now.weekday % 7]` (converting Dart's Monday-first weekday numbering to my Sunday-first array) before evaluating time at all.
- **Commit:**
  > Time Comparison Fix: https://github.com/EjMndoza0330/Routine-Reminder/commit/05cd94c61cc6bca0fe572519b7dda06093cacd82
  > Recurrence Fix: https://github.com/EjMndoza0330/Routine-Reminder/commit/adfa9c503c3ad1d06c935f8887cf41b2f86dd729


### Case 3 - 

- **What it gave me:**
    > When I first reported the circles in `DaySelector` looking too small, Claude diagnosed it as a `padding: EdgeInsets.zero` issue on the `FilterChip` starving the label of room, and gave a fix: increase the outer `SizedBox` to 44×44, add `padding: EdgeInsets.all(4)`, and reduce the label's text style from `labelLarge` to `bodyMedium`.
```dart
  SizedBox(
    width: 44,
    height: 44,
    child: FilterChip(
      padding: const EdgeInsets.all(4),
      // ...
    ),
  )
```
- **What was wrong with it:**
  > After applying the fix exactly as given, the letters were still clipping outside the circles . The padding adjustment had no effect. When I reported this and tried increasing the size further to 50, it overflowed instead of fixing the clipping. This revealed the real problem. `FilterChip` has an internal Material minimum size that doesn't shrink regardless of the outer `SizedBox` or padding overrides. The padding fix was treating the wrong layer of the problem, since the chip's own internal layout, not my outer constraints, was what was forcing the oversized content.
-  **What I did instead:**
  > Rather than continuing to fight `FilterChip`'s internal sizing, I replaced it entirely with a custom widget. A `GestureDetector` wrapping a `Container` with `BoxShape.circle`, `alignment: Alignment.center`, and manually controlled `width`/`height`. This removed the internal-minimum conflict completely, since a plain `Container` genuinely is whatever size it's given, with no hidden layout logic to fight. 
- **Commit:** https://github.com/EjMndoza0330/Routine-Reminder/commit/05cd94c61cc6bca0fe572519b7dda06093cacd82
  
---

## 3. Who wrote what

At least a fifth of this project is code you wrote yourself. Name it, and explain
it in your own words.

### Written by me
- **File:** `progress_bar.dart` 
- **Commit:** https://github.com/EjMndoza0330/Routine-Reminder/commit/978f466a2d39f35cf84aa7b82f110dd661ec55ae
- **What it does and why it is built this way:**
  > **What it does:** A custom progress bar with a `Stack` with two `Container`s (a faded "track" background and a solid "fill" on top sized to the current progress) plus a percentage label centered over both.
  > **Why I built it this way:** I used two stacked `Container`s instead of Flutter's built-in `LinearProgressIndicator` because I wanted full control over the colors, rounded corners, and the ability to show a percentage label directly on the bar, which the built-in widget doesn't support out of the box. `Stack` lets the fill and the label layer on top of the track without affecting the overall widget's size.
**Note:**  Note: the original fill-width calculation (`width * progress`) and clamping were later revised with AI assistance after I hit an overflow/sizing bug. See Section 1, Week 2, for that fix.

- **File:** `dashboard.dart` — Task list structure
- **Commit:** https://github.com/EjMndoza0330/Routine-Reminder/commit/978f466a2d39f35cf84aa7b82f110dd661ec55ae
- **What it does and why it is built this way:**
  > I built the original Dashboard layout. `Card()` containing the streak `row`, progress section, `TASKS` heading, and the `task list`. Structured as a `Column` with the task list in a `ListView.builder` so each task renders from the tasks list rather than being hardcoded per-row. I chose a `ListView.builder` specifically because it only builds visible rows, which matters once the task list grows. The scrolling bug I hit (see Section 1, Week 1) was a consequence of nesting it inside a Column without `Expanded()`. My original structural choice was right, the specific fix for the symptom came from Gemini.

- **File:** `apptheme.dart`
- **Commit:** https://github.com/EjMndoza0330/Routine-Reminder/commit/b9b0d71538d6d03686282a20f8c86d8ec294f842
- **What it does and why I built it this way:**
  > **What it does:** Defines the app's color scheme, spacing constants (AppSpacing), text theme (Google Fonts), and shared component theming (card margins, filled button styling) used across every screen.
  > **Why I built it this way:** Centralizing colors and spacing in one file means every screen pulls from the same source instead of hardcoding values repeatedly. Changing the primary color or base spacing updates the whole app from one place. I used named constants in `AppSpacing` (base/edge/standard) instead of raw numbers so spacing stays consistent and readable throughout the codebase.

- **File:** success.dart — screen structure
- **Commit:** https://github.com/EjMndoza0330/Routine-Reminder/commit/31573e106a30a86889219df41d848c495a1b9d10
- **What it does and why I built it this way:**
  > **What it does:** The success screen shown after completing all daily tasks — congratulations banner, celebration icon, updated streak display, progress bar, and a button back to the dashboard.
  > **Why I built it this way:** I composed it as a single scrollable `Column` matching the visual rhythm of the Dashboard screen (same card/spacing conventions from `apptheme.dart`), so the two screens feel like one consistent app rather than two different designs.
  > **Note:** the layout overflow issues (missing `SingleChildScrollView`, the streak Row needing Expanded, the oversized celebration icon) were caught and fixed with AI assistance — see Section 1, "Success screen layout overflow." The original composition and content choices (what to show, in what order) were mine.

- **File:** dashboard.dart — overall screen structure
- **Commit:** https://github.com/EjMndoza0330/Routine-Reminder/commit/adfa9c503c3ad1d06c935f8887cf41b2f86dd729
- **What it does and why I built it this way:**
  > **What it does:** The Dashboard screen's layout — a `Card` containing the streak/icon row, the progress bar section, the `TASKS` heading, a `ListView.builder` rendering each task as a row with checkbox/edit/delete, and the Add Task button at the bottom.
  > **Why I built it this way:** I structured it as a single `Column` inside a `Card` so each section (streak, progress, tasks, add button) reads top-to-bottom in the order a user would want to check their day. I chose `ListView.builder` specifically over a plain `Column` of tasks because it only builds visible rows, which matters as the task list grows.
  > **Note:** the commit linked is the current, fixed state. Several specific bugs in this file (the ListView not scrolling, the checkbox TypeError, the streak-locking logic) were found and fixed with AI assistance over the course of the project, see Section 1 for each of those individually. The structural layout and composition decisions described above were mine from the start.

### The AI-written part I understand best

- **File:** `storage.dart`
- **Commit:** https://github.com/EjMndoza0330/Routine-Reminder/commit/adfa9c503c3ad1d06c935f8887cf41b2f86dd729
- **What it does and why I kept it:**
  > **What it does:** A dedicated class handling all `shared_preferences` reads/writes. Separate save/load methods for `tasks`, `streak`, `last accessed date`, and the `streak-counted-today` flag. Tasks are serialized to `JSON strings` via `Task.toMap()/fromMap()` since `shared_preferences` only stores primitives. Every method wraps its `SharedPreferences` call in `try/catch` so a failed read or write can't crash the app. It just fails silently and the in-memory state stays intact.
  > **Why I kept it:** I wanted the storage logic separated from `dashboard.dart` entirely, so Dashboard only decides when to save/load, not how. The actual `shared_preferences API` calls, `JSON encoding`, and error handling live in one place. The `try/catch` on every method matters specifically because I wanted the app to stay stable even if a save fails for some reason (disk issue, platform quirk, etc.), the user's current session keeps working, it just might not persist that one change, rather than the whole app crashing.
