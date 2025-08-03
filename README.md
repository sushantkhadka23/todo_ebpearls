# TODO App - EB Pearls Flutter Assignment

## Overview
This is a Flutter-based TODO mobile application developed for the EB Pearls Traineeship Program. The app allows users to manage tasks with features like adding, editing, deleting, marking tasks as completed, filtering tasks by status (All, Active, Completed), assigning priorities (High, Medium, Low), and setting due dates. The app also supports theme switching (Light, Dark, System) and color customization.

The project follows Clean Architecture principles, uses flutter_bloc for state management, sqflite for local storage, and go_router for navigation, ensuring a modular, maintainable, and responsive codebase.

## Project Architecture
The app adheres to Clean Architecture, dividing the codebase into three layers:

### Presentation Layer:
- Contains UI components (widgets) and BLoC classes for state management.
- Uses flutter_bloc to manage task list, filters, and theme settings.
- Screens: Welcome Screen, Task List Screen, Add Task Screen, Edit Task Screen, Settings Screen.
- Responsive UI adapts to different screen sizes using Flutter's layout system.

### Domain Layer:
- Defines business logic through use cases (e.g., AddTask, EditTask, DeleteTask, FilterTasks).
- Includes task models with fields:
  - id (String)
  - title (String, required)
  - description (String, optional)
  - isCompleted (boolean)
  - priority (enum: High, Medium, Low)
  - dueDate (DateTime)
  - createdAt (DateTime)
- Uses dartz for functional programming (handling errors with Either).
- Models are immutable and leverage equatable for efficient state comparison.

### Data Layer:
- Manages data operations using the Repository pattern.
- Stores tasks locally using sqflite for persistent storage.
- Implements a service locator with get_it to provide repository instances to use cases.

## Key Dependencies
- **flutter_bloc**: Manages state for tasks, filters, and theme toggling.
- **sqflite**: Handles local storage of tasks.
- **go_router**: Facilitates navigation between screens (Welcome → Task List → Add Task → Edit Task → Settings).
- **get_it**: Service locator for dependency injection.
- **shared_preferences**: Stores theme settings (Light, Dark, System) and color preferences.
- **intl**: Formats dates for due date display and sorting.
- **uuid**: Generates unique IDs for tasks.
- **font_awesome_flutter**: Provides icons for priorities and actions.
- **dartz**: Enables functional error handling.
- **path**: Assists with file path operations for sqflite.
- **flutter_svg**: Supports SVG assets for enhanced visuals.
- **equatable**: Simplifies state comparison in BLoC.

## Features

### Welcome Screen:
- Entry point for the app, navigates to the Task List Screen.

### Task List Screen:
- Displays a list of tasks with details (title, priority, due date, completion status).
- Supports filtering tasks by status: All, Active, Completed.
- Allows sorting by due date.
- Users can edit, delete, or mark tasks as completed/incomplete.
- Includes a Floating Action Button (FAB) to navigate to the Add Task Screen.

### Add Task Screen:
- Provides a form for users to input a new task's title, description, priority (High, Medium, Low), and due date.
- Validates required fields (e.g., title).
- On submission, adds the new task to the task list.

### Edit Task Screen:
- Allows users to modify an existing task's details: title, description, priority, and due date.
- Populates fields with the current task data for editing.
- Validates inputs before saving changes to the task list.

### Settings Screen:
- Allows toggling between Light, Dark, and System themes, stored using shared_preferences.
- Supports color customization for the app's UI.
- Includes a button to delete all tasks (with confirmation).

### Responsive UI:
- Adapts to various screen sizes using Flutter's responsive design principles.

### Local Storage:
- Tasks are persisted using sqflite, ensuring data retention across app sessions.

## How to Run the TODO App

### 1. Check Dart and Flutter Versions
dart --version
flutter --version

### 2. Clone the Repository

git clone https://github.com/sushantkhadka23/todo_ebpearls.git
cd todo_ebpearls

### 3. Install Dependencies

flutter pub get

### 4. Run the App

- Connect a device or start an emulator.
- Run:
  flutter run
---

### Notes

- Use `flutter devices` to verify connected devices.
- Use your IDE (VS Code, Android Studio) to run/debug if preferred.

## Notable Design Decisions

### State Management with flutter_bloc:
- Chosen for its predictable state management and separation of concerns.
- BLoC handles task operations, filtering, and theme switching, ensuring a reactive UI.

### Local Storage with sqflite:
- Selected over Hive (mentioned in the assignment) due to familiarity and robust SQL-based querying for task filtering and sorting.
- Tasks are stored in a single table with columns mapping to the Task model.

### Navigation with go_router:
- Provides type-safe routing and supports deep linking for future scalability.
- Routes: `/welcome`, `/tasks`, `/add-task`, `/edit-task/:id`, `/settings`.

### Theme Management:
- Uses shared_preferences to persist theme and color settings.
- Supports dynamic color changes for a personalized user experience.

### Responsive Design:
- Leverages Flutter's MediaQuery and LayoutBuilder for adaptive layouts.
- Ensures usability on both small and large screens.

### Error Handling:
- Uses dartz for functional error handling in the domain layer (e.g., Either<Failure, Success>).
- Displays user-friendly error messages in the UI for storage or validation issues.

### Code Quality:
- Follows OOP principles (encapsulation, single responsibility).
- Uses immutable models with equatable for efficient state updates.
- Includes meaningful comments and modular code structure.

## Demo (Video):
https://github.com/user-attachments/assets/862a0c54-2023-4a12-8cca-5cd575c9b5c6


