part of 'task_bloc.dart';

class TaskState extends Equatable {
  final List<Task> tasks;
  final Task? task;
  final AppStatus status;

  const TaskState({this.tasks = const [], this.task, this.status = const Initial()});

  @override
  List<Object?> get props => [tasks, task, status];

  TaskState copyWith({List<Task>? tasks, Task? task, AppStatus? status}) {
    return TaskState(tasks: tasks ?? this.tasks, task: task ?? this.task, status: status ?? this.status);
  }
}
