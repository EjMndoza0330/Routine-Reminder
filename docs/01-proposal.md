# Proposal
## The problem, in one sentence
- College students and busy individuals fail to maintain daily health routines, like consistent hydration, because scattered system alarms are easy to dismiss and do not visualize daily progress or consistency.

## Who it is for
- College students managing heavy academic workloads and individuals prone to being forgetful due to erratic daily schedules.
- They juggle these habits from memory or rely on scattered system alarms that get easily ignored or swiped away without tracking the actual habit completion.

## Core features
| # | Feature | Still in MVP? | Flutter pieces it needs | Honest estimate |
| - | --- | --- | --- | --- |
| 1 |Main Dashboard (Task list & Progress)| keep | ListView.builder, Checkbox, LinearProgressIndicator | 2 hours |
| 2 |Task Configuration| Keep | showDialog, TextField, DropdownButton | 2 hours | 
| 3 |Lazy Alarm System (Midnight Reset & Overdue tags) | Keep | DateTime logic, State Management (e.g., Provider) | 5 hours |
| 4 | Success Screen | Keep | Navigator.push, Card, custom icons | 3 hours |

## Out of scope, and why
1. Currency and Cosmetic Shop: get 20 points for hitting 100% on the progress bar. Build a cosmetic shop to spend the points tp unlock visiual cosmetics, like new UI color themes, special completion animations etc.
2. Streak Multiplier: gives a 5% multiplier to the points gained.
3. System push notifications (cut from MVP in favor of the in-app Lazy Alarm).
4. Detailed weekly/monthly statistics and historical graphs.

## Data the app remembers, and where it is saved
> I am using 'shared_preferences' to store my task list as a JSON-encoded 'List<String>' under a single key, alongside integers for my global streak and last accessed date. Since my habit tracker is strictly single-user, offline, and holds under 20 records a week, setting up a cloud server like Firebase would introduce unnecessary setup time with no payoff. I will attempt a one-hour spike to save and load a dummy task list to confirm this approach before fully implementing it.

## Risks
- The risk I named last time (Midnight reset and native notifications): Is it still a risk? Yes, but it is significantly smaller now. By officially cutting native background notifications and adopting the "Lazy Alarm" approach, the complexity is reduced to checking the system time only when the user opens the app.
  - First step to reduce it: I will write and test the 'DateTime' logic that compares the current date to the last accessed date to trigger the midnight reset by September 24, 2026.

- A new risk I did not see before: Managing state across the modal overlay and the main screen. Saving a task inside the Task Configuration Modal must instantly recalculate the daily progress bar and update the task list on the Main Dashboard without causing UI lag.
  - First step to reduce it: I will build a throwaway prototype to test passing data between a 'showDialog modal' and a 'LinearProgressIndicator' using a state management solution by September 28, 2026.
  
## Changes since the last version

- In the previous version, the purpose and audience were described as “people who forget things like myself.” This was revised to focus on college students with heavy workloads who struggle to maintain health routines, such as consistent hydration, based on instructor feedback.
- The state and content plan originally included only two data items. It was expanded to include Task Name, Scheduled Time, Recurrence, Completion Status, and Global Streak Count to address the instructor’s feedback and meet the updated template’s requirements.
- The sections were renamed from Main Dashboard Screen, Task Configuration Screen, and Success Screen to Main Dashboard Route, Task Configuration Modal, and - Success Route to better match the wireframe and clarify that task configuration uses a modal overlay.
- The original risks were native push notifications and the midnight reset. The “Lazy Alarm” fallback reduced the notification risk, while state management was added as a new risk, particularly the challenge of updating the dashboard after changes in the modal.
