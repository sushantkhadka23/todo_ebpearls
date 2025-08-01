import 'package:todo_ebpearls/domain/entity/task.dart';
import 'package:todo_ebpearls/domain/entity/enums.dart';

class TaskModel {
  final String id;
  final String title;
  final String? description;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime? dueDate;
  final Priority priority;

  const TaskModel({
    required this.id,
    required this.title,
    this.description,
    this.isCompleted = false,
    required this.createdAt,
    this.dueDate,
    required this.priority,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      isCompleted: json['isCompleted'] == 1,
      createdAt: DateTime.parse(json['createdAt'] as String),
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate'] as String) : null,
      priority: _priorityFromString(json['priority'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
      'createdAt': createdAt.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
      'priority': _priorityToString(priority),
    };
  }

  factory TaskModel.fromDomain(Task task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      isCompleted: task.isCompleted,
      createdAt: task.createdAt,
      dueDate: task.dueDate,
      priority: task.priority,
    );
  }

  Task toDomain() {
    return Task(
      id: id,
      title: title,
      description: description,
      isCompleted: isCompleted,
      createdAt: createdAt,
      dueDate: dueDate,
      priority: priority,
    );
  }

  static Priority _priorityFromString(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Priority.high;
      case 'medium':
        return Priority.medium;
      case 'low':
        return Priority.low;
      default:
        return Priority.low;
    }
  }

  static String _priorityToString(Priority priority) {
    switch (priority) {
      case Priority.high:
        return 'high';
      case Priority.medium:
        return 'medium';
      case Priority.low:
        return 'low';
    }
  }
}
