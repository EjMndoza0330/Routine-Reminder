# Demo video

**File:** [`demo.mp4`](https://youtu.be/KYD1N71wjQ8) 
**Length:** 6 min 42 sec
**Recorded on:** Laptop

## What it shows

A short list, in order, so a viewer can skip to what they need:

- 0:00 what the app is: the dashboard with the streak counter, progress bar and task list
- 0:25 the overdue badge, and why `isOverdue` is a getter on the Task model
- 0:45 the custom progress bar and why I built it with a Stack
- 1:05 how the streak works: once per day, locks at 100% until the next day
- 1:35 adding a task: name, scheduled days, time, and the modal handing the result back to the dashboard
- 2:10 editing a task with the pre-filled modal
- 2:20 a gap I noticed while recording: days aren't shown on the task rows (fixed after recording)
- 2:35 the success screen and return to the dashboard
- 2:55 locked checkboxes and saving data with shared_preferences through `TaskStorage`
- 3:20 how I used AI: Gemini first, then Claude from the second week
- 3:40 AI example 1: the two bugs in `isOverdue`
- 4:35 AI example 2: the day selector chips clipping, and rebuilding it
- 5:15 what I wrote myself: the theme, colour scheme, spacing and text styles
- 5:50 the part I understand best: `storage.dart` and why it's separate from the dashboard
