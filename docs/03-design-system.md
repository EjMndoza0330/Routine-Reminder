# Design system


![Design system](assets/Design_System_(Visual).png)

[Design system (PDF)](assets/Design_System_(Visual).pdf)


## Palette
| Role | Hex | Used for |
| --- | --- | --- |
| primary | #561F0F | ADD TASK and SAVE TASK buttons, Progress Bar fill, active checkboxes |
| onPrimary | #E6D3BA | Edit icons, scheduled days in modal, secondary buttons | 
| secondary | #442A22 | Edit icons, scheduled days in task configure, secondary buttons | 
| onSecondary | #E6D3BA | Text or icons placed on secondary background elements, such as weekday selectors | 
| surface | #1A110F | Main Dashboard, Success Screen, and Add Edit Task backgrounds | 
| onSurface | #E6D3BA | Task names, section headers (e.g., TASKS), date labels | 
| error | #690005 | OVERDUE passive notification highlight, Delete icons | 
| onError | #FFFFFF | Text placed directly on error highlights |

## Type scale
| Your Style | Flutter slot | Size | Weight | Used for |
| ---------- | ------------ | ---- | ------ | -------- |
|  Heading   | ``` headlineSmall ``` | 24 | Regular | Screen titles (ROUTINE REMINDER, CONGRATULATIONS!) |
| Body | ``` bodyMedium ``` | 16 | Regular | Normal Text, lists, text field inputs |
| Button | ``` labelLarge ``` | 14 | Regular | Primary button text (SAVE TASK, ADD TASK) |
| Caption | ``` labelSmall ``` | 12 | Regular | Timestamps, hints, weekday labels (S, M, T) |

## Spacing
- Base unit: 8px
- Edge padding: ``` AppSpacing.edge ``` (16px)
- Gap between list items: ``` AppSpacing.tight ``` (8px)
- Gap between sections: ``` AppSpacing.standard ``` (24px)
  
## Components
These components map directly to the provided mockup screens.

| Component | File | Constructor parameters | Appears on | 
| ---------- | ------------ | ---- | ------ | 
|PrimaryButton|lib/widgets/primary_button.dart|String label, VoidCallback? onPressed|Dashboard, Task Modal, Success Screen|          
|ProgressBar|lib/widgets/progress_bar.dart|double percentage|Dashboard, Success Screen|         
|DaySelector|lib/widgets/day_selector.dart|List<bool> recurrence, ValueChanged<List<bool>> onChanged|Task Modal|

## Changes since the last version
- The type scale has been modified to use specific font sizes at Regular weight. The darker color scheme used #E6D3BA and #FFFFFF was coded. In order to clarify, and make the components more reusable, actual widget file paths and constructor parameters are now included in the components section.
