# TODO App

A simple Flutter TODO application built with Clean Architecture, `flutter_bloc`, `sqflite`, `get_it`, and `go_router`.

---
## Architecture

- **Presentation Layer:**  
  Flutter widgets and `go_router` for navigation.

- **Domain Layer:**  
  Task entity and repository interface.

- **Data Layer:**  
  Sqflite for local storage and implmentation (impl).


---

## Features

- View, add, edit, and delete tasks.
- Mark tasks as completed/incomplete.
- Filter tasks by status (All, Active, Completed).
- Assign priority (High, Medium, Low) and due date.
- Sort tasks by due date.
- Persistent storage with Sqflite.

---

## Design Decisions

- Sqflite for local storage,
- go_router for navigation,
- flutter_bloc for state management,
- get_it for service locator,
- and Clean Architecture for structuring the app.

---

