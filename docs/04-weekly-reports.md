# Weekly reports

---

## Week 1 (2026 / 09 / 21 to 2026 / 09 / 23)

**Done this week**
- AppTheme created
- Dashboard UI completed
- Progress Bar created
- Task List created
- Primary Button created, not yet functional, I have yet to make the Task Configuration Modal

**In progress**

- **Task Configuration Modal**
- **Success Screen UI**
- **Lazy Alarm System, DateTime logic, Overdue Tags and midnight reset**
- **Connecting ADD TASK to the configuration modal**

**Blocked or stuck on**

- **Layout Structures**
   - I had a hard time visualizing how each layout widget worked and how they would appear on screen. i got stuck on watching YouTube tutorials and trial-and-error to see how they appeared on screen. which took most of my time.
- **Text Wrapping**
   - The screen overflows when the Task name is too long. I placed the ```Text()``` in a ```Expanded()``` on the ```ListTile```
- **List Scrolling**
   - When there were more Tasks in the List and the screen overflows. I placed the ```ListView.builder``` in a ```Expanded()``` to make it scrollable
- **Compiler State**
   - Encountered an undefined property error on the web compiler after adding the ```List<Task> tasks```. I just did a Hot restart and it was fixed

**Decisions made, and why**
- Custom Progress Bar: I built my own progress bar from scratch instead of using Flutter's built-in LinearProgressIndicator because it was easier to match my exact design.
- Layout Fixes: I chose the Expanded widget to handle text wrapping and list scrolling issues. It was the simplest way to force my custom rows and columns to fit the screen properly.

**Hours spent, roughly:**
- 2026 / 09 / 21 : 1 hour
- 2026 / 09 / 23 : 6 hours

**Next week I will:**
- Finish Task Configuration modal, and Success Screen Route
- Finish Checkbox Button

---
