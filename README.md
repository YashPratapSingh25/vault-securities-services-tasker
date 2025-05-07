# Tasker Vault Securities Services Assignment

A Flutter-based ToDo application that integrates Firebase Authentication and Firestore for user and task management. The app demonstrates best practices in authentication, state management using Provider, Firestore CRUD operations, error handling, and clean UI with input validation and loading states.

## Features

### Firebase Authentication
- Sign Up and Login functionality
- Session persistence using Firebase Auth (auto-login across restarts)
- Secure logout feature

### Firestore Integration
- Stores tasks and tags in separate Firestore collections
- Supports CRUD operations for tasks and tags

### State Management
- Uses the `Provider` package for managing authentication, tasks, and tag states across the app

### UI & Navigation
- Drawer-based navigation between:
    - Home (Task List)
    - Manage Tags (Tags List)
    - Profile (Dummy screen)
    - Settings (Dummy screen)
- Responsive and clean UI
- Loading indicators for async operations
- Input validations for forms (e.g., task name, tag name, due date)


