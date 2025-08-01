class TaskNotFoundException implements Exception {
  final String message;
  TaskNotFoundException([this.message = 'Task not found']);

  @override
  String toString() => message;
}

class DatabaseException implements Exception {
  final String message;
  DatabaseException([this.message = 'Database error']);

  @override
  String toString() => message;
}
