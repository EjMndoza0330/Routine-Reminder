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
- **Commit:** https://github.com/YOUR-USERNAME/YOUR-REPO/commit/SHA

## 3. Who wrote what

At least a fifth of this project is code you wrote yourself. Name it, and explain
it in your own words.

### Written by me

- **File:** progress_bar.dart
- **Commit:** https://github.com/EjMndoza0330/Routine-Reminder/commit/978f466a2d39f35cf84aa7b82f110dd661ec55ae#diff-35a6fe6fe9fa0492b4ade31fe99944cc541ffbf5b1542b70f167baa06524f0ad
- **What it does and why it is built this way:**
  >

### The AI-written part I understand best

- **File:**
- **Commit:**
- **What it does and why we kept it:**
